import '/domain/legami/entities/legame.dart';
import '/domain/macchine/entities/macchina.dart';
import '/domain/wo/entities/wo.dart';

import '/domain/linee/entities/linea.dart';

class DatiDashboardModel {
  final List<LineaEntity> linee;
  final List<LegameEntity> legami;
  final List<MacchinaEntity> macchine;
  final List<WOEntity> wo;

  const DatiDashboardModel({
    required this.linee,
    required this.legami,
    required this.macchine,
    required this.wo,
  });

  DatiDashboardModel copyWith({
    List<LineaEntity>? linee,
    List<LegameEntity>? legami,
    List<MacchinaEntity>? macchine,
    List<WOEntity>? wo,
  }) {
    return DatiDashboardModel(
      linee: linee ?? this.linee,
      legami: legami ?? this.legami,
      macchine: macchine ?? this.macchine,
      wo: wo ?? this.wo,
    );
  }
}
