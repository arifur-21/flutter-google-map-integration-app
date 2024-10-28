import 'package:flutter/material.dart';
import 'package:flutter_googel_map_app/data/repository/google_map_repository_impl.dart';
import 'package:flutter_googel_map_app/domain/repository/google_map_repository.dart';
import 'package:flutter_googel_map_app/domain/use_case/get_marker_use_case.dart';
import 'package:flutter_googel_map_app/presentation/bloc/google_map_bloc.dart';
import 'package:get_it/get_it.dart';

import 'presentation/pages/home_screen.dart';
final GetIt getIt = GetIt.instance;
void setup(){
  getIt.registerLazySingleton<GoogleMapRepository>(()=>GoogleMapRepositoryImpl());
  getIt.registerLazySingleton<GetMarkerUseCase>(() => GetMarkerUseCase(getIt()));
  getIt.registerFactory<GoogleMapBloc>(()=> GoogleMapBloc( getMarkersUseCase: getIt()));
}
void main() {
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}


