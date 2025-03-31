import 'package:flutter/material.dart';

import '/common/widgets/card_custom.dart';

import '/domain/linea_dashboard/entities/dettaglio_macchina.dart';
import '/domain/linee/entities/linea.dart';

import '/presentation/dashboard/widgets/macchina_item.dart';

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
    return CardCustom(
      titolo: linea.descrizione,
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
