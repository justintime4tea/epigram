import 'package:epigram/app/models.dart';
import 'package:epigram/colors.dart';
import 'package:epigram/home/widgets.dart';
import 'package:epigram/messages/store.dart';
import 'package:epigram/messages/widgets.dart';
import 'package:epigram/notifications/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'search_body.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Epigram",
      theme: ThemeData(
        primarySwatch: black,
      ),
      home: HomeLayoutState(
        title: "Epigram",
        onInit: () {
          StoreProvider.of<AppState>(context).dispatch(LoadQuipsAction());
        },
      ),
    );
  }
}

class HomeLayoutState extends StatefulWidget {
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  final void Function() onInit;

  const HomeLayoutState({Key? key, required this.title, required this.onInit}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomeLayoutState> createState() => _HomeLayoutStateState();
}

class _HomeLayoutStateState extends State<HomeLayoutState> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ActiveTab(
      key: const Key("_home_activity"),
      builder: (BuildContext context, BottomNavTab activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: <Widget>[
                const Icon(Icons.person),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24,
                  ),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              // FilterSelector(visible: activeTab == BottomNavState.messages),
              // ExtraActionsContainer(),
            ],
            elevation: 1,
            toolbarHeight: 52,
          ),
          backgroundColor: black,
          body: Column(
            children: [
              const Divider(
                height: 2,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Colors.white30,
              ),
              Expanded(
                child: body(activeTab),
              ),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(
              right: 14,
              bottom: 14,
            ),
            child: FloatingActionButton(
              key: const Key("_home_fab"),
              onPressed: () {
                Navigator.pushNamed(context, "/");
              },
              backgroundColor: Colors.pink,
              child: const Icon(
                Icons.mode_edit,
              ),
              mini: false,
              tooltip: "Add",
            ),
          ),
          bottomNavigationBar: const BottomNav(),
        );
      },
    );
  }

  Widget body(BottomNavTab tab) {
    switch (tab) {
      case BottomNavTab.home:
        return const HomeBody();
      case BottomNavTab.search:
        return const SearchBody();
      case BottomNavTab.notifications:
        return const NotificationsBody();
      case BottomNavTab.messages:
        return const MessagesBody();
    }
  }
}
