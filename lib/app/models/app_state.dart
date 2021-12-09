import 'package:epigram/messages/models.dart';
import 'package:epigram/app/models/bottom_nav_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final bool isLoading;
  final List<Quip> quips;
  final BottomNavTab activeTab;

  const AppState({
    this.isLoading = false,
    this.quips = const [],
    this.activeTab = BottomNavTab.home,
  });

  factory AppState.loading() => const AppState(isLoading: true);

  AppState copyWith({
    bool? isLoading,
    List<Quip>? quips,
    BottomNavTab? activeTab,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      quips: quips ?? this.quips,
      activeTab: activeTab ?? this.activeTab,
    );
  }

  @override
  int get hashCode => isLoading.hashCode ^ quips.hashCode ^ activeTab.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          quips == other.quips &&
          activeTab == other.activeTab;

  @override
  String toString() {
    return 'AppState{isLoading: $isLoading, messages: $quips, activeTab: $activeTab}';
  }
}
