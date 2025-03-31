import '/domain/linea_dashboard/entities/linea_dashboard.dart';

abstract class LineeDettaglioState {}

class DataLoading extends LineeDettaglioState {
  DataLoading();
}

class DataLoaded extends LineeDettaglioState {
  final List<LineaDashboardEntity> linee;
  final DateTime dataRefreshed;
  final bool dataRefreshing;
  DataLoaded({
    required this.linee,
    required this.dataRefreshed,
    this.dataRefreshing = false,
  });

  DataLoaded copyWith({
    List<LineaDashboardEntity>? linee,
    DateTime? dataRefreshed,
    bool? dataRefreshing,
  }) {
    return DataLoaded(
      linee: linee ?? this.linee,
      dataRefreshed: dataRefreshed ?? this.dataRefreshed,
      dataRefreshing: dataRefreshing ?? this.dataRefreshing,
    );
  }
}

class FailureLoadData extends LineeDettaglioState {
  final String errorMessage;
  FailureLoadData({required this.errorMessage});
}

class NotAutenticated extends LineeDettaglioState {
  NotAutenticated();
}
