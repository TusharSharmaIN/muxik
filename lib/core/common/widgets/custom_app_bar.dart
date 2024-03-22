import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../route/app_router.dart';
import '../../theme/theme/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.pureBlack,
      elevation: 0,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.normal,
            ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthLogOut());
            context.go(AppRoutes.login);
          },
          icon: const Icon(
            Icons.logout_rounded,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
