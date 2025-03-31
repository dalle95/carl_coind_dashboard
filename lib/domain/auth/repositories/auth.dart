import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '/service_locator.dart';

import '/data/auth/models/signin_params.dart';

abstract class AuthRepository {
  // Per gestire i log
  final logger = sl<Logger>();

  Future<Either> signin(SigninParams params);
  Future<bool> isLoggedIn();
  Future<Either> logout();
}
