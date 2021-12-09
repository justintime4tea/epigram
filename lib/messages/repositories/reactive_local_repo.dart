import 'dart:async';
import 'dart:core';

import 'package:epigram/messages/entities.dart';
import 'package:epigram/messages/repositories.dart';
import 'package:rxdart/subjects.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Quips and Persist quips.
class ReactiveLocalRepo implements ReactiveQuipRepo {
  final QuipRepo _repository;
  final BehaviorSubject<List<QuipEntity>> _subject;
  bool _loaded = false;

  ReactiveLocalRepo({
    required QuipRepo repository,
    List<QuipEntity>? seedValue,
  })  : _repository = repository,
        _subject = seedValue != null
            ? BehaviorSubject<List<QuipEntity>>.seeded(seedValue)
            : BehaviorSubject<List<QuipEntity>>();

  @override
  Future<void> createNewQuip(QuipEntity quip) async {
    _subject.add([..._subject.value, quip]);

    await _repository.createQuip(quip);
  }

  @override
  Future<void> deleteQuip(List<String> idList) async {
    _subject.add(
      List<QuipEntity>.unmodifiable(_subject.value.fold<List<QuipEntity>>(
        <QuipEntity>[],
        (prev, entity) {
          return idList.contains(entity.id) ? prev : (prev..add(entity));
        },
      )),
    );

    await _repository.hydrateQuips(_subject.value);
  }

  @override
  Stream<List<QuipEntity>> getQuips() {
    if (!_loaded) _getQuips();

    return _subject.stream;
  }

  void _getQuips() {
    _loaded = true;

    _repository.getQuips().then((entities) {
      _subject.add(List<QuipEntity>.unmodifiable(
        [if (_subject.value != null) ..._subject.value, ...entities],
      ));
    });
  }

  @override
  Future<void> updateQuip(QuipEntity update) async {
    _subject.add(
      List<QuipEntity>.unmodifiable(_subject.value.fold<List<QuipEntity>>(
        <QuipEntity>[],
        (prev, entity) => prev..add(entity.id == update.id ? update : entity),
      )),
    );

    await _repository.hydrateQuips(_subject.value);
  }
}
