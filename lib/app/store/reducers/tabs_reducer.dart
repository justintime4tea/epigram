import 'package:epigram/app/models/bottom_nav_state.dart';
import 'package:epigram/messages/store.dart';
import 'package:redux/redux.dart';

final tabsReducer = combineReducers<BottomNavTab>([
  TypedReducer<BottomNavTab, UpdateTabAction>(_activeTabReducer),
]);

BottomNavTab _activeTabReducer(BottomNavTab activeTab, UpdateTabAction action) {
  return action.newTab;
}
