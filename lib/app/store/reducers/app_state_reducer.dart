import 'package:epigram/app/models.dart';
import 'package:epigram/app/store.dart';
import 'package:epigram/messages/store.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    quips: quipsReducer(state.quips, action),
    // activeFilter: visibilityReducer(state.activeFilter, action),
    activeTab: tabsReducer(state.activeTab, action),
  );
}
