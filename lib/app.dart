export 'app/app_module.dart';

import 'package:epigram/app/models.dart';
import 'package:epigram/colors.dart';
import 'package:epigram/home/layout.dart';
import 'package:epigram/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'messages/store.dart';

class App extends StatelessWidget {
  final Store<AppState> store;
  final QuipBloc qbloc;
  App({
    Key? key,
    required this.store,
    QuipBloc? qbloc,
  })  : qbloc = QuipBloc(store),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (ctx) => "Epigram",
        theme: ThemeData(
          primarySwatch: black,
          fontFamily: "Breeze",
        ),
        routes: {
          AppRoutes.home: (ctx) {
            return const HomeLayout();
          }
        },
      ),
    );
  }
}
