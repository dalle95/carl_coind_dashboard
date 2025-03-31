import '/data/linee/models/linea.dart';

import '/domain/linee/entities/linea.dart';

class LineaMapper {
  static LineaEntity toEntity(LineaModel linea) {
    return LineaEntity(
      id: linea.id,
      codice: linea.codice,
      descrizione: linea.descrizione,
      stato: linea.stato,
    );
  }
}
