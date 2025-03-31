import 'package:dartz/dartz.dart';

abstract class TecniciOfficinaRepository {
  Future<Either> getDati();
}
