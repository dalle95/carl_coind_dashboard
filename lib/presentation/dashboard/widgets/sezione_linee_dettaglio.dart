import 'package:carl_coind_dashboard/presentation/dashboard/bloc/dati_dashboard/dati_dashboard_cubit.dart';
import 'package:carl_coind_dashboard/presentation/dashboard/bloc/dati_dashboard/dati_dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/service_locator.dart';

import '/common/helper/navigation/app_navigation.dart';

import '/core/configs/assets/app_vectors.dart';

import '/domain/auth/usecases/auto_login.dart';

import '/presentation/auth/pages/signin.dart';
import '/presentation/dashboard/pages/homepage.dart';

import '/presentation/dashboard/widgets/linea_dettaglio_item.dart';

class SezioneLineeDettaglio extends StatelessWidget {
  const SezioneLineeDettaglio({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<DatiDashboardCubit, DatiDashboardState>(
      listener: (context, state) async {
        if (state is FailureLoadData) {
          try {
            var data = await sl<AutoLoginUseCase>().call();
            data.fold((error) => throw Exception(error), (data) => null);
            if (context.mounted) {
              AppNavigator.pushAndRemove(context, const HomePage());
            }
          } catch (e) {
            if (context.mounted) {
              AppNavigator.pushAndRemove(context, SigninPage());
            }
          }
        }
        if (state is NotAutenticated) {
          if (context.mounted) {
            AppNavigator.pushAndRemove(context, SigninPage());
          }
        }
      },
      child: BlocBuilder<DatiDashboardCubit, DatiDashboardState>(
        builder: (context, state) {
          if (state is DataLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 250,
                    backgroundColor: const Color.fromRGBO(221, 205, 186, 1.0),
                    child: Image.asset(AppVectors.loadingScreen),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 100,
                    child: Text(
                      'Caricamento linee in corso...',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  )
                ],
              ),
            );
          }
          if (state is FailureLoadData) {
            return Center(child: Text(state.errorMessage));
          }

          if (state is DataLoaded) {
            // Per mostrare solo le linee con WO associati
            var lineeConWO = state.datiDashboard;
            // .where((LineaDashboardEntity linea) => linea.hasWO())
            // .toList();
            lineeConWO.sort((a, b) =>
                b.listaMacchine.length.compareTo(a.listaMacchine.length));

            double definisciGrandezzaDettaglio(int numMacchine) {
              if (numMacchine <= 2) {
                return 120;
              } else if (numMacchine <= 4) {
                return 240;
              } else {
                return 720;
              }
            }

            return Container(
              width: double.infinity,
              height: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Wrap(
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    direction: Axis.horizontal,
                    children: lineeConWO
                        .map(
                          (linea) => Container(
                            height: 160,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            width: definisciGrandezzaDettaglio(
                                linea.listaMacchine.length),
                            child: LineaDettaglioItem(
                              linea: linea.linea,
                              macchine: linea.listaMacchine,
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
