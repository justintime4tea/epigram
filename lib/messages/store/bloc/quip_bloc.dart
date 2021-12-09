import 'dart:collection';
import 'dart:convert';

import 'package:epigram/app/models.dart';
import 'package:epigram/messages/models.dart';
import 'package:epigram/messages/store/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:redux/redux.dart';

class QuipReceivedAction {
  final Quip quip;

  const QuipReceivedAction(this.quip);
}

class QuipBloc implements Disposable {
  final EventChannel _rsocketEvents = const EventChannel('tech.jgross.epigram/rsocket');
  final Store<AppState> store;

  QuipBloc(this.store) {
    _rsocketEvents.receiveBroadcastStream().listen(_rsocketEventHandler);
  }

  List<Quip> get quips => store.state.quips;

  void _rsocketEventHandler(q) {
    debugPrint('We have a quip!');
    Map<String, dynamic> quip = json.decode(q);
    store.dispatch(
      QuipReceivedAction(
        Quip(quip['id'], quip['userId'], quip['username'], quip['message'], quip['timestamp']),
      ),
    );
  }

  @override
  void dispose() {}
}
