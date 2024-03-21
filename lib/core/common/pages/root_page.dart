import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/song/presentation/pages/song_home_page.dart';
import '../cubit/app_user_cubit.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AppUserCubit, AppUserState, bool>(
      selector: (state) {
        return state is AppUserLoggedIn;
      },
      builder: (context, isUserLoggedIn) {
        if (isUserLoggedIn) {
          return const SongHomePage();
        }
        return const LoginPage();
      },
    );
  }
}
