import 'package:dartz/dartz.dart';

abstract class LineaDashboardRepository {
  Future<Either> getDati();
}
