import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common/widgets/loader.dart';
import '../../../../core/route/app_router.dart';
import '../../../../core/theme/theme/app_colors.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          } else if (state is AuthSuccess) {
            // context.go(AppRoutes.songHome);
            //  TODO: uncomment this
            context.go(
              AppRoutes.login,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up.',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                AuthField(
                  hintText: 'Name',
                  controller: nameController,
                ),
                const SizedBox(height: 15),
                AuthField(
                  hintText: 'Email',
                  controller: emailController,
                ),
                const SizedBox(height: 15),
                AuthField(
                  hintText: 'Password',
                  controller: passwordController,
                  isObscureText: true,
                ),
                const SizedBox(height: 20),
                AuthGradientButton(
                  buttonText: 'Sign Up',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                        AuthSignUp(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          name: nameController.text.trim(),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => context.go(AppRoutes.login),
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            color: AppColors.gradient2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    ///
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Padding(
    //     padding: const EdgeInsets.all(24.0),
    //     child: BlocConsumer<AuthBloc, AuthState>(
    //       listener: (context, state) {
    //         if (state is AuthFailure) {
    //           showSnackBar(context, state.message);
    //         } else if (state is AuthSuccess) {
    //           context.go(AppRoutes.musicHome);
    //         }
    //       },
    //       builder: (context, state) {
    //         if (state is AuthLoading) {
    //           return const Loader();
    //         }
    //         return Form(
    //           key: formKey,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               const Text(
    //                 'Sign Up.',
    //                 style: TextStyle(
    //                   fontSize: 50,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //               const SizedBox(height: 30),
    //               AuthField(
    //                 hintText: 'Name',
    //                 controller: nameController,
    //               ),
    //               const SizedBox(height: 15),
    //               AuthField(
    //                 hintText: 'Email',
    //                 controller: emailController,
    //               ),
    //               const SizedBox(height: 15),
    //               AuthField(
    //                 hintText: 'Password',
    //                 controller: passwordController,
    //                 isObscureText: true,
    //               ),
    //               const SizedBox(height: 20),
    //               AuthGradientButton(
    //                 buttonText: 'Sign Up',
    //                 onPressed: () {
    //                   if (formKey.currentState!.validate()) {
    //                     context.read<AuthBloc>().add(
    //                           AuthSignUp(
    //                             email: emailController.text.trim(),
    //                             password: passwordController.text.trim(),
    //                             name: nameController.text.trim(),
    //                           ),
    //                         );
    //                   }
    //                 },
    //               ),
    //               const SizedBox(height: 20),
    //               GestureDetector(
    //                 onTap: () => context.go(AppRoutes.login),
    //                 child: RichText(
    //                   text: TextSpan(
    //                     text: 'Already have an account? ',
    //                     style: Theme.of(context).textTheme.titleMedium,
    //                     children: [
    //                       TextSpan(
    //                         text: 'Sign In',
    //                         style: Theme.of(context)
    //                             .textTheme
    //                             .titleMedium
    //                             ?.copyWith(
    //                               color: AppColors.gradient2,
    //                               fontWeight: FontWeight.bold,
    //                             ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}
