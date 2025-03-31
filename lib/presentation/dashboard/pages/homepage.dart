import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '/core/configs/assets/app_images.dart';
import '/core/configs/theme/app_colors.dart';
import '/core/configs/assets/app_vectors.dart';

import '/common/helper/navigation/app_navigation.dart';

import '/presentation/auth/pages/signin.dart';
import '/presentation/dashboard/bloc/logout_cubit.dart';
import '/presentation/dashboard/bloc/dati_dashboard/dati_dashboard_cubit.dart';
import '/presentation/dashboard/bloc/dati_dashboard/dati_dashboard_state.dart';
import '/presentation/dashboard/widgets/sezione_linee_dettaglio.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatiDashboardCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SizedBox(
                height: 50,
                child: Image.asset(fit: BoxFit.contain, AppImages.logo),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Dashboard Linee di Produzione',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.secondBackground,
                      letterSpacing: 1.2,
                    ),
              ),
              Expanded(child: Container()),
              BlocBuilder<DatiDashboardCubit, DatiDashboardState>(
                builder: (context, state) {
                  if (state is DataLoaded) {
                    return Row(
                      children: [
                        if (state.dataRefreshing)
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            width: 50,
                            child: Image.asset(AppVectors.loadingBean),
                          ),
                        Text(
                          'Ultimo aggiornamento: ${DateFormat('HH:mm:ss').format(state.dataRefreshed)}',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.secondBackground,
                                    letterSpacing: 1.2,
                                  ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          actions: [
            SizedBox(
              height: 50,
              width: 50,
              child: BlocProvider(
                create: (_) => LogoutCubit(),
                child: BlocListener<LogoutCubit, bool>(
                  listener: (context, state) {
                    if (state == true) {
                      AppNavigator.pushReplacement(context, SigninPage());
                    }
                  },
                  child: Builder(
                    builder: (context) {
                      return IconButton(
                        onPressed: () {
                          context.read<LogoutCubit>().logout();
                        },
                        icon: const Icon(Icons.logout),
                        color: AppColors.accent,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        body: const SezioneLineeDettaglio(),
      ),
    );
  }
}
