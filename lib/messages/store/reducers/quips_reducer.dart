import 'package:epigram/messages/models.dart';
import 'package:epigram/messages/store.dart';
import 'package:redux/redux.dart';

final quipsReducer = combineReducers<List<Quip>>([
  TypedReducer<List<Quip>, QuipsLoadedAction>(_onQuipsLoaded),
  TypedReducer<List<Quip>, QuipReceivedAction>(_onQuipReceived),
]);

List<Quip> _onQuipsLoaded(List<Quip> quips, QuipsLoadedAction action) {
  return [...action.quips];
}

List<Quip> _onQuipReceived(List<Quip> quips, QuipReceivedAction action) {
  return [...quips, action.quip];
}
