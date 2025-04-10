import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/helper/navigation/app_navigation.dart';
import '/common/widgets/flutter_toast.dart';

import '/core/configs/theme/app_colors.dart';

import '/presentation/dashboard/pages/homepage.dart';
import '/presentation/auth/bloc/auth_cubit.dart';
import '/presentation/auth/bloc/auth_state.dart';
import '/presentation/auth/widgets/auth_widgets.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(),
      child: Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.errorMessage != null) {
              // Display errore
              toastInfo(
                context: context,
                msg: state.errorMessage!,
                backgroundColor: AppColors.accent,
                textColor: AppColors.secondBackground,
              );
            } else if (state.isSuccess) {
              // Navigazione alla homepage
              AppNavigator.pushAndRemove(context, const HomePage());
            }
          },
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: _buildView(context),
          ),
        ),
      ),
    );
  }

  /// Builds the main view for desktop and tablet with logo, form, and buttons.
  ///
  /// The view includes:
  /// - Logo at the top
  /// - Email and password form fields
  /// - Sign in button
  /// - Register text link
  SafeArea _buildView(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 800,
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildLogo(context: context),
            const SizedBox(height: 30),
            SizedBox(
              width: 350,
              child: buildForm(
                context: context,
                emailController: _usernameController,
                passwordController: _passwordController,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 350,
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return buildPulsante(
                    context: context,
                    lable: state.isLoading ? 'Caricamento...' : 'Accedi',
                    onPress: state.isLoading
                        ? null
                        : () {
                            context.read<AuthCubit>().signIn(
                                  _usernameController.text,
                                  _passwordController.text,
                                );
                          },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
