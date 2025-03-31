import '/data/tecnici/models/tecnico.dart';
import '../../../domain/tecnici/entities/tecnico.dart';

class TecnicoMapper {
  static TecnicoEntity toEntity(TecnicoModel tecnico) {
    return TecnicoEntity(
      id: tecnico.id,
      codice: tecnico.codice,
      nome: tecnico.nome,
      stato: tecnico.stato,
      macchinaId: tecnico.macchinaId,
    );
  }
}
