import 'package:dartz/dartz.dart';

abstract class WORepository {
  Future<Either> getInterventi();
}
