import 'package:epigram/app/models.dart';
import 'package:epigram/messages/store.dart';
import 'package:redux/redux.dart';

class BottomNavViewModel {
  final BottomNavTab activeTab;
  final Function(int) onTabSelected;

  BottomNavViewModel({
    required this.activeTab,
    required this.onTabSelected,
  });

  static BottomNavViewModel fromStore(Store<AppState> store) {
    return BottomNavViewModel(
      activeTab: store.state.activeTab,
      onTabSelected: (index) {
        store.dispatch(UpdateTabAction((BottomNavTab.values[index])));
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BottomNavViewModel && runtimeType == other.runtimeType && activeTab == other.activeTab;

  @override
  int get hashCode => activeTab.hashCode;
}
