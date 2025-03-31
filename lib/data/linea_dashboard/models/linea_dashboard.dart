import '/domain/linea_dashboard/entities/dettaglio_macchina.dart';
import '/domain/linee/entities/linea.dart';

class LineaDashboardModel {
  final LineaEntity linea;
  final List<DettaglioMacchina> listaMacchine;

  const LineaDashboardModel({
    required this.linea,
    required this.listaMacchine,
  });

  LineaDashboardModel copyWith({
    LineaEntity? linea,
    List<DettaglioMacchina>? listaMacchine,
  }) {
    return LineaDashboardModel(
      linea: linea ?? this.linea,
      listaMacchine: listaMacchine ?? this.listaMacchine,
    );
  }
}
