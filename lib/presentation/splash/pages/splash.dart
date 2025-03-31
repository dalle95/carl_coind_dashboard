import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/helper/navigation/app_navigation.dart';

import '/core/configs/theme/app_colors.dart';
import '/core/configs/assets/app_images.dart';

import '/presentation/auth/pages/signin.dart';
import '/presentation/splash/bloc/splash_cubit.dart';
import '/presentation/splash/bloc/splash_state.dart';
import '/presentation/dashboard/pages/homepage.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => SplashCubit()..appStarted(),
        child: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              AppNavigator.pushReplacement(context, SigninPage());
            }

            if (state is Authenticated) {
              AppNavigator.pushReplacement(context, const HomePage());
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.asset(
                  AppImages.logo,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Carl Coind Dashboard',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 40,
                        letterSpacing: 1.2,
                        color: AppColors.secondBackground,
                      ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
