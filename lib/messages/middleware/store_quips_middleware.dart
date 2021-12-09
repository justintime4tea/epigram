import 'package:epigram/app/models.dart';
import 'package:epigram/messages/models.dart';
import 'package:epigram/messages/repositories.dart';
import 'package:epigram/messages/store.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createQuipsStoreMiddleware(
  QuipRepo repository,
) {
  final saveQuips = _createSaveQuip(repository);
  final loadQuips = _createLoadQuips(repository);

  return [
    TypedMiddleware<AppState, LoadQuipsAction>(loadQuips),
  ];
}

Middleware<AppState> _createSaveQuip(QuipRepo repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);

    repository.hydrateQuips(
      quipSelector(store.state).map((quip) => quip.toEntity()).toList(),
    );
  };
}

Middleware<AppState> _createLoadQuips(QuipRepo repository) {
  return (Store<AppState> store, action, NextDispatcher next) {
    repository.getQuips().then(
      (quips) {
        store.dispatch(
          QuipsLoadedAction(
            quips.map(Quip.fromEntity).toList(),
          ),
        );
      },
    ).catchError((_) => store.dispatch(QuipsNotLoadedAction()));

    next(action);
  };
}
