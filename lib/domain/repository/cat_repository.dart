import 'package:approach_to_charge/domain/entity/cat.dart';
import 'package:approach_to_charge/domain/repository/error/cat_error.dart';
import 'package:either_dart/either.dart';

abstract class CatRepository{

  Future<Either<CatError,List<Cat>>> getCatListByEither({int limit = 10, required int page});



}