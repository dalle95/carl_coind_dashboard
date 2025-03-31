import '/domain/tecnici/entities/tecnico.dart';

abstract class TecniciOfficinaState {}

class DataLoading extends TecniciOfficinaState {}

class DataLoaded extends TecniciOfficinaState {
  final List<TecnicoEntity> tecnici;
  DataLoaded({required this.tecnici});
}

class FailureLoadData extends TecniciOfficinaState {
  final String errorMessage;
  FailureLoadData({required this.errorMessage});
}
