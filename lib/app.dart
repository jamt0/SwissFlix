import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swissflix/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:swissflix/routes/router.dart';
import 'package:swissflix/styles/custom_colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  //TODO: Inyeccion de dependencias
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MoviesBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'SwissFlix',
        theme: ThemeData(
          primaryColor: CustomColors.primary,
        ),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
