import 'dart:async';

import 'package:epigram/messages/entities.dart';
import 'package:epigram/messages/repositories.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Todos to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class QuipRemoteRepo implements QuipRepo {
  const QuipRemoteRepo();

  /// Mock that "fetches" some Todos from a "web service" after a short delay
  @override
  Future<List<QuipEntity>> getQuips() async {
    return Future.value([
      const QuipEntity(
        "id",
        "userId",
        "username",
        "message",
        "timestamp",
      ),
      const QuipEntity(
        "id",
        "userId",
        "username",
        "message",
        "timestamp",
      ),
      const QuipEntity(
        "id",
        "userId",
        "username",
        "message",
        "timestamp",
      ),
      const QuipEntity(
        "id",
        "userId",
        "username",
        "message",
        "timestamp",
      ),
      const QuipEntity(
        "id",
        "userId",
        "username",
        "message",
        "timestamp",
      ),
      const QuipEntity(
        "id",
        "userId",
        "username",
        "message",
        "timestamp",
      ),
      const QuipEntity(
        "id",
        "userId",
        "username",
        "message",
        "timestamp",
      ),
      const QuipEntity(
        "id",
        "userId",
        "username",
        "message",
        "timestamp",
      ),
      const QuipEntity(
        "id",
        "userId",
        "username",
        "message",
        "timestamp",
      ),
      const QuipEntity(
        "id",
        "userId",
        "username",
        "message",
        "timestamp",
      ),
      const QuipEntity(
        "id",
        "userId",
        "username",
        "message",
        "timestamp",
      ),
    ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  @override
  Future<bool> createQuip(QuipEntity quip) async {
    return Future.value(true);
  }

  @override
  Future<void> hydrateQuips(List<QuipEntity> quips) {
    return Future.value();
  }

  @override
  Future<void> updateQuip(QuipEntity quip) {
    return Future.value();
  }
}
