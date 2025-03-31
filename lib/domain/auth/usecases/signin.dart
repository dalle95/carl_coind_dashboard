import 'package:dartz/dartz.dart';
import '/service_locator.dart';

import '/core/usecase/usecase.dart';

import '/data/auth/models/signin_params.dart';

import '/domain/auth/repositories/auth.dart';

class SigninUseCase extends UseCase<Either, SigninParams> {
  @override
  Future<Either> call({SigninParams? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }
}
