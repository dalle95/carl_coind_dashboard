import 'package:carl_coind_dashboard/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/widgets/card_custom.dart';

import '../bloc/tecnici_officina/tecnici_officina_cubit.dart';
import '../bloc/tecnici_officina/tecnici_officina_state.dart';
import '/presentation/dashboard/widgets/tecnico_item.dart';

class SezioneTecnici extends StatelessWidget {
  const SezioneTecnici({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CardCustom(
      titolo: 'Officina',
      contenuto: BlocProvider(
        create: (context) => TecniciOfficinaCubit()..getData(),
        child: BlocBuilder<TecniciOfficinaCubit, TecniciOfficinaState>(
          builder: (context, state) {
            if (state is DataLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FailureLoadData) {
              return Center(child: Text(state.errorMessage));
            }

            if (state is DataLoaded) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight,
                      maxWidth: constraints.maxWidth,
                    ),
                    child: state.tecnici.isEmpty
                        ? const Center(
                            child: Text(
                              'Nessun tecnico',
                              style: TextStyle(
                                color: AppColors.secondBackground,
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: state.tecnici
                                .map(
                                  (linea) => TecnicoItem(
                                    tecnico: linea,
                                    maxHeight: constraints.maxHeight /
                                                state.tecnici.length >
                                            25
                                        ? 25
                                        : constraints.maxHeight /
                                            state.tecnici.length,
                                  ),
                                )
                                .toList(),
                          ),
                  );
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
