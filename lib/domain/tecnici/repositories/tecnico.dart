import 'package:dartz/dartz.dart';

abstract class TecnicoRepository {
  Future<Either> getTecnici();
}
