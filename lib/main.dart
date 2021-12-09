import 'package:epigram/app.dart';
import 'package:epigram/app/models.dart';
import 'package:epigram/app/store.dart';
import 'package:epigram/messages/middleware.dart';
import 'package:epigram/messages/repositories.dart';
import 'package:epigram/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:redux/redux.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ModularApp(
      module: AppModule(),
      child: App(
        store: Store<AppState>(
          appReducer,
          initialState: AppState.loading(),
          middleware: createQuipsStoreMiddleware(
            const QuipStaticRepo(),
          ),
        ),
      )));
}
