import 'package:go_router/go_router.dart';
import 'package:water_tracker/features/profile/presentation/pages/all_user_page.dart';
import 'package:water_tracker/features/profile/presentation/pages/detail_user.dart';

class MyRouter {
  get router => GoRouter(initialLocation: "/", routes: [
        GoRoute(
            path: "/",
            name: "all_user",
            pageBuilder: (context, state) =>
                NoTransitionPage(child: AllUserPage()),
            //sub routes
            routes: [
              GoRoute(
                path: "detail-user",
                name: "detail_user",
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: DetailUserPage(state.extra as int)),
              )
            ])
      ]);
}
