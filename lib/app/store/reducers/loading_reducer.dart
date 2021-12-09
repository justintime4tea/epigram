import 'package:epigram/messages/store.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadQuipsAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}
