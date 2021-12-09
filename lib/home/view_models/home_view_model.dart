import 'package:epigram/app/models.dart';
import 'package:epigram/messages/models.dart';
import 'package:epigram/messages/store.dart';
import 'package:redux/redux.dart';

class HomeViewModel {
  final List<Quip> quips;
  final bool loading;

  final Function(Quip, bool) onEmoteChanged;
  final Function(Quip) onRemove;
  final Function(Quip) onUndoRemove;
  // final QuipBloc qbloc;

  HomeViewModel({
    required this.quips,
    required this.loading,
    required this.onEmoteChanged,
    required this.onRemove,
    required this.onUndoRemove,
    // required this.qbloc,
  });

  static HomeViewModel fromStore(Store<AppState> store) {
    return HomeViewModel(
      quips: quipSelector(store.state),
      // filteredquipsSelector(
      //   quipsSelector(store.state),
      //   activeFilterSelector(store.state),
      // ),
      loading: store.state.isLoading,
      onEmoteChanged: (quip, complete) {
        store.dispatch(const ExpressEmoteForQuip("heart"));
      },
      onRemove: (quip) {
        store.dispatch(const ExpressEmoteForQuip("heart"));
      },
      onUndoRemove: (quip) {
        store.dispatch(const ExpressEmoteForQuip("heart"));
      },
    );
  }
}
