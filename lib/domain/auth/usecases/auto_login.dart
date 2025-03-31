import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import '/service_locator.dart';

import '/core/usecase/usecase.dart';

import '/data/auth/models/signin_params.dart';
import '/data/auth/models/utente.dart';

import '/domain/auth/repositories/auth.dart';

class AutoLoginUseCase extends UseCase<Either, void> {
  @override
  Future<Either> call({void params}) async {
    Logger().d('AutoLoginUseCase | Funzione: call');

    try {
      final data = await sl<FlutterSecureStorage>().read(key: 'utente');

      if (data == null) {
        return const Left('No stored user data found');
      }

      final utente = Utente.fromJson(json.decode(data));

      if (utente.username == null || utente.password == null) {
        return const Left('Invalid stored user data');
      }

      final credenziali = SigninParams(
        username: utente.username!,
        password: utente.password!,
      );

      return await sl<AuthRepository>().signin(credenziali);
    } on FormatException {
      return const Left('Invalid stored data format');
    } catch (e) {
      return Left('AutoLogin error: ${e.toString()}');
    }
  }
}
