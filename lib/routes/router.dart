import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swissflix/features/movies/presentation/pages/movie_page.dart';
import 'package:swissflix/features/movies/presentation/pages/movies_page.dart';

part 'names_routes.dart';

GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

var router = GoRouter(
  debugLogDiagnostics: false,
  navigatorKey: rootNavigatorKey,
  initialLocation: NamesRoustes.movies,
  routes: <RouteBase>[
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: NamesRoustes.movies,
      path: NamesRoustes.movies,
      builder: (BuildContext context, GoRouterState state) {
        return const MoviesPage();
      },
    ),
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      name: NamesRoustes.movie,
      path: "${NamesRoustes.movie}/:movieId",
      builder: (BuildContext context, GoRouterState state) {
        return MoviePage(movieId: state.pathParameters["movieId"] ?? "1");
      },
    ),
  ],
);
