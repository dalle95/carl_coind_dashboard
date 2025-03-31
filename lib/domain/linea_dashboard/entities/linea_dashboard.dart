import 'dettaglio_macchina.dart';
import '/domain/linee/entities/linea.dart';

class LineaDashboardEntity {
  final LineaEntity linea;
  final List<DettaglioMacchina> listaMacchine;

  const LineaDashboardEntity({
    required this.linea,
    required this.listaMacchine,
  });

  LineaDashboardEntity copyWith({
    LineaEntity? linea,
    List<DettaglioMacchina>? listaMacchine,
  }) {
    return LineaDashboardEntity(
      linea: linea ?? this.linea,
      listaMacchine: listaMacchine ?? this.listaMacchine,
    );
  }

  bool hasWO() {
    return listaMacchine.any((macchina) => macchina.interventi.isNotEmpty);
  }

  String getStato() {
    var woBloccanti = listaMacchine
        .expand((macchina) => macchina.interventi)
        .where((wo) => wo.statoMacchina == "Bloccante");
    var woNonBloccanti = listaMacchine
        .expand((macchina) => macchina.interventi)
        .where((wo) => wo.statoMacchina != "Bloccante");

    if (woBloccanti.isNotEmpty) {
      return "Bloccata";
    } else if (woNonBloccanti.isNotEmpty) {
      return "Non bloccata";
    } else {
      return "Attiva";
    }
  }
}
