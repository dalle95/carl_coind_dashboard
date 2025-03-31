import '/data/legami/models/legame.dart';
import '/domain/legami/entities/legame.dart';

class LegameMapper {
  static LegameEntity toEntity(LegameModel legame) {
    return LegameEntity(
      id: legame.id,
      lineaId: legame.lineaId,
      macchinaId: legame.macchinaId,
      ordine: legame.ordine,
    );
  }
}
