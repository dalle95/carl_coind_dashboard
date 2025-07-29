import 'package:flutter/material.dart';

import '/core/configs/theme/app_colors.dart';

import '/domain/linea_dashboard/entities/dettaglio_macchina.dart';

import '/presentation/dashboard/widgets/workorder_dialog.dart';

class MacchinaItem extends StatelessWidget {
  const MacchinaItem({
    super.key,
    required this.dettaglioMacchina,
  });

  final DettaglioMacchina dettaglioMacchina;

  Color getColoreMacchina() {
    switch (dettaglioMacchina.getStato()) {
      case 'Attiva':
        return Colors.green;
      case 'Parzialmente ferma':
        return Colors.yellow;
      case 'Ferma':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    const double altezzaTecnici = 40;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Avatar con badge degli interventi
        GestureDetector(
          onTap: () {
            if (dettaglioMacchina.interventi.isEmpty) return;
            showDialog(
              context: context,
              builder: (context) => WorkOrdersDialog(
                titolo: 'Guasti - ${dettaglioMacchina.macchina.descrizione}',
                workOrders: dettaglioMacchina.interventi,
              ),
            );
          },
          child: SizedBox(
            width: 40,
            child: Badge.count(
              textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              backgroundColor: AppColors.secondBackground,
              textColor: AppColors.background,
              count: dettaglioMacchina.interventi.length,
              child: MouseRegion(
                cursor: dettaglioMacchina.interventi.isNotEmpty
                    ? SystemMouseCursors.click
                    : SystemMouseCursors.basic,
                child: CircleAvatar(
                  backgroundColor: getColoreMacchina(),
                  maxRadius: 20,
                  child: Icon(
                    dettaglioMacchina.macchina.codice == 'MAC-VARIE'
                        ? Icons.warehouse_outlined
                        : Icons.precision_manufacturing_outlined,
                    size: 20,
                    color: AppColors.secondBackground,
                  ),
                ),
              ),
            ),
          ),
        ),

        SizedBox(
          width: 40,
          child: Text(
            dettaglioMacchina.macchina.codice,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Flexible(
        //   child: Center(
        //     child: Wrap(
        //       alignment: WrapAlignment.center,
        //       direction: dettaglioMacchina.tecnici.length < 3
        //           ? Axis.horizontal
        //           : Axis.vertical,
        //       children: dettaglioMacchina.tecnici.map(
        //         (tecnico) {
        //           return TecnicoSuMacchinaItem(
        //             tecnico: tecnico,
        //             dettaglio: dettaglioMacchina.tecnici.length < 3,
        //           );
        //         },
        //       ).toList(),
        //     ),
        //   ),
        // )

        // if (dettaglioMacchina.tecnici.isNotEmpty)
        //   Flexible(
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         const Icon(
        //           Icons.account_circle,
        //           color: AppColors.secondBackground,
        //           size: 15,
        //         ),
        //         Container(
        //           padding: const EdgeInsets.all(2),
        //           decoration: BoxDecoration(
        //             color: const Color(0xFF2C2B2B),
        //             borderRadius: BorderRadius.circular(6),
        //             border: Border.all(
        //               color: Theme.of(context).colorScheme.primary,
        //               width: 1,
        //             ),
        //           ),
        //           child: Column(
        //             children: dettaglioMacchina.tecnici.map(
        //               (tecnico) {
        //                 return Text(
        //                   tecnico.codice,
        //                   style: Theme.of(context)
        //                       .textTheme
        //                       .bodySmall
        //                       ?.copyWith(
        //                         fontSize: 7,
        //                         color: Theme.of(context).colorScheme.background,
        //                         fontWeight: FontWeight.w500,
        //                         overflow: TextOverflow.clip,
        //                       ),
        //                 );
        //               },
        //             ).toList(),
        //           ),
        //         ),
        //       ],
        //     ),
        //   )

        // Altezza fissa per l'area tecnici

        SizedBox(
          height: altezzaTecnici,
          child: dettaglioMacchina.tecnici.isNotEmpty
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.account_circle,
                      color: AppColors.secondBackground,
                      size: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2C2B2B),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 1,
                        ),
                      ),
                      child: SizedBox(
                        height: dettaglioMacchina.tecnici.length == 1
                            ? 10
                            : altezzaTecnici - 20 - 1,
                        width: 40,
                        child: SingleChildScrollView(
                          child: Column(
                            children: dettaglioMacchina.tecnici.map(
                              (tecnico) {
                                return Text(
                                  tecnico.codice,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontSize: 7,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        fontWeight: FontWeight.w500,
                                        overflow: TextOverflow.clip,
                                      ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : const SizedBox(), // oppure Container(height: altezzaTecnici)
        ),
      ],
    );
  }
}
