import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:examplebloccamera/data/providers/photo_provider.dart';
import 'package:examplebloccamera/screens/screens.dart';
import 'blocs/blocs.dart';

// https://medium.com/flutter-community/flutter-taking-pictures-with-the-bloc-pattern-76e38690df28
// https://github.com/laurentP22/my_photos/blob/master/lib/main.dart

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(
    BlocProvider(
      // create: (context) => PhotosBloc(photoProvider: PhotoProvider())..add(PhotosLoaded()),
      create: (context) => PhotosBloc(photoProvider: PhotoProvider())..add(PhotosLoaded()),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Photos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomeScreen.route,
      routes: {
        HomeScreen.route: (_) => HomeScreen(),
        DetailsScreen.route: (_) => DetailsScreen(),
        AddScreen.route: (_) => AddScreen(),
      },
    );
  }
}