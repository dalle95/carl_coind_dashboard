import 'package:flutter/material.dart';

import '/common/widgets/card_custom.dart';

import '/core/configs/theme/app_colors.dart';

import '/domain/linea_dashboard/entities/dettaglio_macchina.dart';
import '/domain/linee/entities/linea.dart';
import '/domain/wo/entities/wo.dart';

import '/presentation/dashboard/widgets/macchina_item.dart';
import '/presentation/dashboard/widgets/workorder_dialog.dart';

class LineaDettaglioItem extends StatelessWidget {
  const LineaDettaglioItem({
    super.key,
    required this.linea,
    required this.macchine,
  });

  final LineaEntity linea;
  final List<DettaglioMacchina> macchine;

  @override
  Widget build(BuildContext context) {
    // bool cambioFormatoInProgress =
    //     linea.woCambioStato.any((element) => element.tecnici.isNotEmpty);

    Color getTitoloBackgroundColor(List<WOEntity> workOrders) {
      final today = DateTime.now();

      bool hasTecnici = workOrders.any((wo) => wo.tecnici.isNotEmpty);
      if (hasTecnici) {
        return Colors.blue;
      }

      bool hasPassedWO = workOrders.any((wo) =>
          wo.dataInizio != null &&
          DateUtils.dateOnly(wo.dataInizio!)
              .isBefore(DateUtils.dateOnly(today)));
      if (hasPassedWO) {
        return Colors.orange;
      }

      bool hasTodayWO = workOrders.any((wo) =>
          wo.dataInizio != null &&
          DateUtils.dateOnly(wo.dataInizio!) == DateUtils.dateOnly(today));
      if (hasTodayWO) {
        return Colors.yellow;
      }

      return AppColors.primary; // default
    }

    return CardCustom(
      titolo: linea.descrizione,
      titoloBackgroundColor: getTitoloBackgroundColor(linea.woCambioStato),
      onTitleTap: () {
        showDialog(
          context: context,
          builder: (context) => WorkOrdersDialog(
            titolo: 'Cambio Formato - ${linea.descrizione}',
            workOrders: linea.woCambioStato,
          ),
        );
      },
      // widgetTitolo: linea.woCambioStato.isNotEmpty
      //     ? TextButton(
      //         style: TextButton.styleFrom(
      //           padding: EdgeInsets.zero,
      //           minimumSize: Size.zero,
      //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //           // backgroundColor: Colors.white,
      //         ),
      //         onPressed: () {
      //           showDialog(
      //             context: context,
      //             builder: (context) => WorkOrdersDialog(
      //               titolo: 'Cambio Formato - ${linea.descrizione}',
      //               workOrders: linea.woCambioStato,
      //             ),
      //           );
      //         },
      //         child: SizedBox(
      //           width: 20,
      //           height: 20,
      //           child: ClipRRect(
      //             child: Image.asset(
      //               cambioFormatoInProgress
      //                   ? AppImages.cambiaFormatoInCorso
      //                   : AppImages.cambiaFormatoAttesa,
      //               fit: BoxFit.contain,
      //               filterQuality: FilterQuality.high,
      //               isAntiAlias: true,
      //             ),
      //           ),
      //         ),
      //       )
      //     : null,
      contenuto: Container(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: macchine.asMap().entries.map((entry) {
            final index = entry.key;
            final macchina = entry.value;

            // Macchina successiva e precedente
            final macchinaSuccessiva =
                (index < macchine.length - 1) ? macchine[index + 1] : null;
            final macchinaPrecedente = (index > 0) ? macchine[index - 1] : null;

            // Determina se la macchina è collegata con la successiva o precedente
            final isCollegataConSuccessiva = macchinaSuccessiva != null &&
                macchina.ordine == macchinaSuccessiva.ordine;
            final isCollegataConPrecedente = macchinaPrecedente != null &&
                macchina.ordine == macchinaPrecedente.ordine;

            // Prima e ultima della connessione
            final bool isFirstInConnection = !isCollegataConPrecedente;
            final bool isLastInConnection = !isCollegataConSuccessiva;

            return Stack(
              alignment: Alignment.center,
              children: [
                // Raggruppamento macchina
                if (isCollegataConSuccessiva || isCollegataConPrecedente)
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: (isCollegataConSuccessiva ||
                                    isCollegataConPrecedente)
                                ? const BorderSide(
                                    color: Colors.grey, width: 1.0)
                                : BorderSide.none,
                            bottom: (isCollegataConSuccessiva ||
                                    isCollegataConPrecedente)
                                ? const BorderSide(
                                    color: Colors.grey, width: 1.0)
                                : BorderSide.none,
                            left: isFirstInConnection
                                ? const BorderSide(
                                    color: Colors.grey, width: 1.0)
                                : BorderSide.none,
                            right: isLastInConnection
                                ? const BorderSide(
                                    color: Colors.grey, width: 1.0)
                                : BorderSide.none,
                          ),
                          borderRadius: BorderRadius.horizontal(
                            left: isFirstInConnection
                                ? const Radius.circular(8.0)
                                : Radius.zero,
                            right: isLastInConnection
                                ? const Radius.circular(8.0)
                                : Radius.zero,
                          ),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                // Macchina
                Container(
                  padding: const EdgeInsets.all(4.0),
                  child: MacchinaItem(
                    dettaglioMacchina: macchina,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
