import 'package:flutter_bloc/flutter_bloc.dart';

import 'generic_data_state.dart';

import '/core/usecase/usecase.dart';

class GenericDataCubit extends Cubit<GenericDataState> {
  GenericDataCubit() : super(DataLoading());

  void getData<T>(UseCase usecase, {dynamic params}) async {
    var returnedData = await usecase.call(params: params);
    returnedData.fold((error) {
      emit(FailureLoadData(errorMessage: error));
    }, (data) {
      emit(DataLoaded<T>(data: data));
    });
  }
}
