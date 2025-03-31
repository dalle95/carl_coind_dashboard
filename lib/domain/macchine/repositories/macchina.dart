import 'package:dartz/dartz.dart';

abstract class MacchinaRepository {
  Future<Either> getMacchine();
}
