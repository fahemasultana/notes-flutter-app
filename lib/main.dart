import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:my_notes/data/entity/note_entity.dart';
import 'package:my_notes/data/repository/notes_repository.dart';
import 'package:my_notes/ui/create_note/create_note_page.dart';
import 'package:my_notes/ui/home/home_page.dart';
import 'package:floor/floor.dart';

import 'data/database/app_database.dart';

class Routes {
  static const String home = "/";
  static const String createNote = "/create-note";
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: Routes.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: Routes.createNote,
      builder: (BuildContext context, GoRouterState state) {
        return CreateNotePage(noteEntity: state.extra as NoteEntity?);
      },
    ),
  ],
);

late final AppDatabase appDatabase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingleton(NotesRepository());

  appDatabase =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              primary: Colors.deepPurple,
              background: Colors.white,
              secondary: Colors.deepPurple,
              seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _router);
  }
}
