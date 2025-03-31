import '/data/macchine/models/macchina.dart';
import '/domain/macchine/entities/macchina.dart';

class MacchinaMapper {
  static MacchinaEntity toEntity(MacchinaModel macchina) {
    return MacchinaEntity(
      id: macchina.id,
      codice: macchina.codice,
      descrizione: macchina.descrizione,
      stato: macchina.stato,
      lineaId: macchina.lineaId,
    );
  }
}
