import 'package:epigram/app/models.dart';
import 'package:epigram/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BottomNavViewModel>(
      distinct: true,
      converter: BottomNavViewModel.fromStore,
      builder: (context, vm) {
        return Container(
          decoration: const BoxDecoration(
            color: black,
            border: Border(
              top: BorderSide(
                color: Colors.white24,
                width: 2.0,
              ),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: black,
            ),
            child: BottomNavigationBar(
              key: const Key("_nav_tabs"),
              type: BottomNavigationBarType.fixed,
              currentIndex: BottomNavTab.values.indexOf(vm.activeTab),
              backgroundColor: black,
              selectedItemColor: Colors.pinkAccent,
              unselectedItemColor: Colors.white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: vm.onTabSelected,
              items: BottomNavTab.values.map((tab) {
                switch (tab) {
                  case BottomNavTab.home:
                    return const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.house,
                        key: Key("_feed_tab"),
                      ),
                      label: "Feed",
                    );
                  case BottomNavTab.search:
                    return const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.search,
                        key: Key("_search_tab"),
                      ),
                      label: "Search",
                    );
                  case BottomNavTab.notifications:
                    return const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.notifications,
                        key: Key("_notifications_tab"),
                      ),
                      label: "Notifications",
                    );
                  case BottomNavTab.messages:
                    return const BottomNavigationBarItem(
                      icon: Icon(
                        Icons.message,
                        key: Key("_messages_tab"),
                      ),
                      label: "Messages",
                    );
                }
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
