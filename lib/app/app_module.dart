import 'package:epigram/messages/store/bloc/quip_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    // ChildRoute(Modular.initialRoute, child: (_, __) => SearchPage()),
    // ChildRoute('/details', child: (_, args) => DetailsPage(result: args.data), guards: [GuardT()]),
  ];
}
