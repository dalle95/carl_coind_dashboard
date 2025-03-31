import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/common/widgets/card_custom.dart';

import '/presentation/dashboard/widgets/linea_item.dart';
import '/presentation/dashboard/bloc/linee_dettaglio/linee_dettaglio_cubit.dart';
import '/presentation/dashboard/bloc/linee_dettaglio/linee_dettaglio_state.dart';

class SezioneLinee extends StatelessWidget {
  const SezioneLinee({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CardCustom(
      titolo: 'Linee',
      contenuto: BlocBuilder<LineeDettaglioCubit, LineeDettaglioState>(
        builder: (context, state) {
          if (state is DataLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FailureLoadData) {
            return Center(child: Text(state.errorMessage));
          }

          if (state is DataLoaded) {
            var linee = state.linee
                .where((linea) => linea.linea.codice != r'LINEA-OFFICINA\VARIE')
                .toList();

            return LayoutBuilder(
              builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: constraints.maxHeight,
                    maxWidth: constraints.maxWidth,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: linee
                        .map(
                          (linea) => LineaItem(
                            lineaDettaglio: linea,
                            maxHeight: constraints.maxHeight / linee.length,
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
    );
  }
}
