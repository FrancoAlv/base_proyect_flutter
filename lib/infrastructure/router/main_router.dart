import 'package:approach_to_charge/domain/entity/cat.dart';
import 'package:approach_to_charge/infrastructure/view/details_screen.dart';
import 'package:approach_to_charge/infrastructure/view/home/home_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
part 'home_router.dart';
part 'details_router.dart';

sealed class MainRouter {

  abstract  String path;

  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'details',
            builder: (BuildContext context, GoRouterState state) {
              final catData = state.extra as Cat;
              return  DetailsScreen(catData: catData,);
            },
          ),
        ],
      ),
    ],
  );

}



