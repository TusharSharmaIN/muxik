import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/song/data/models/song_model.dart';
import '../../features/song/presentation/pages/song_details_page.dart';
import '../../features/song/presentation/pages/song_home_page.dart';
import '../../features/song/presentation/pages/song_search_page.dart';
import '../common/pages/root_page.dart';

class AppRoutes {
  static const String root = "/";
  static const String login = "/log_in";
  static const String signup = "/sign_up";
  static const String songHome = "/song_home";
  static const String songDetails = "/song_details";
  static const String songSearch = "/song_search";
}

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.root,
        builder: (context, state) => const RootPage(),
        // builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: AppRoutes.songHome,
        builder: (context, state) {
          final name = state.extra as String;
          return SongHomePage(
            userFullName: name,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.songDetails,
        builder: (context, state) {
          final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
          return SongDetailsPage(
            song: data['songs'],
            isFavorite: data['isFavorite'] ?? false,
            onFavorite: data['onFavorite'] ?? () {},
          );
        },
      ),
      GoRoute(
        path: AppRoutes.songSearch,
        builder: (context, state) {
          final List<SongModel> songs = state.extra as List<SongModel>;
          return SongSearchPage(songs: songs);
        },
      ),
    ],
  );
}
