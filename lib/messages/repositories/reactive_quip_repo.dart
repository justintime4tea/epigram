import 'dart:async';
import 'dart:core';

import 'package:epigram/messages/entities.dart';

/// This class emits a Stream of QuipEntities.
abstract class ReactiveQuipRepo {
  Future<void> createNewQuip(QuipEntity todo);
  Future<void> deleteQuip(List<String> idList);
  Stream<List<QuipEntity>> getQuips();
  Future<void> updateQuip(QuipEntity todo);
}
