import 'package:carl_coind_dashboard/domain/linea_dashboard/entities/linea_dashboard.dart';

import '/domain/legami/entities/legame.dart';
import '/domain/linee/entities/linea.dart';
import '/domain/macchine/entities/macchina.dart';
import '/domain/wo/entities/wo.dart';

abstract class DatiDashboardState {}

class DataLoading extends DatiDashboardState {
  DataLoading();
}

class DataLoaded extends DatiDashboardState {
  final List<LineaEntity> linee;
  final List<LegameEntity> legami;
  final List<MacchinaEntity> macchine;
  final List<WOEntity> wo;
  final List<LineaDashboardEntity> datiDashboard;
  final DateTime dataRefreshed;
  final bool dataRefreshing;
  DataLoaded({
    required this.linee,
    required this.legami,
    required this.macchine,
    required this.wo,
    required this.datiDashboard,
    required this.dataRefreshed,
    this.dataRefreshing = false,
  });

  DataLoaded copyWith({
    List<LineaEntity>? linee,
    List<LegameEntity>? legami,
    List<MacchinaEntity>? macchine,
    List<WOEntity>? wo,
    List<LineaDashboardEntity>? datiDashboard,
    DateTime? dataRefreshed,
    bool? dataRefreshing,
  }) {
    return DataLoaded(
      linee: linee ?? this.linee,
      legami: legami ?? this.legami,
      macchine: macchine ?? this.macchine,
      wo: wo ?? this.wo,
      datiDashboard: datiDashboard ?? this.datiDashboard,
      dataRefreshed: dataRefreshed ?? this.dataRefreshed,
      dataRefreshing: dataRefreshing ?? this.dataRefreshing,
    );
  }
}

class FailureLoadData extends DatiDashboardState {
  final String errorMessage;
  FailureLoadData({required this.errorMessage});
}

class NotAutenticated extends DatiDashboardState {
  NotAutenticated();
}
