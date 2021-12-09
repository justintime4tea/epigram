import 'dart:async';
import 'dart:core';

import 'package:epigram/messages/entities.dart';

/// A class that Loads and Persists quips. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as quips_repository_simple or quips_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class QuipRepo {
  /// Loads quips first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  Future<List<QuipEntity>> getQuips();

  // Hydrate the repo with quips
  Future<void> hydrateQuips(List<QuipEntity> quips);

  // Create a quip
  Future<void> createQuip(QuipEntity quip);

  // Update a quip
  Future<void> updateQuip(QuipEntity quip);
}
