import 'package:approach_to_charge/application/usecases/error/get_list_cat_error.dart';
import 'package:approach_to_charge/application/usecases/error/search_cat_error.dart';
import 'package:approach_to_charge/domain/entity/cat.dart';
import 'package:approach_to_charge/domain/repository/cat_repository.dart';
import 'package:approach_to_charge/domain/repository/error/cat_error.dart';
import 'package:either_dart/either.dart';

class CallCatListUseCase {
  CatRepository _catRepository;

  CallCatListUseCase(this._catRepository);

  Future<Either<GetListCatError, List<Cat>>> getListCat(
      {int limit = 10, int page = 0}) async {
    if (limit <= 0) return Left(LimitCannotBeLessZero());
    if (page < 0) return Left(PageCannotBeLessZero());

    final response =
        await _catRepository.getCatListByEither(limit: limit, page: page);
    switch (response) {
      case Left<CatError, List<Cat>>():
        return Left(ErrorHttpCat());
      case Right<CatError, List<Cat>>():
        if (response.value.isEmpty) return Left(ArrayWithoutElements());
        return Right(response.value);
    }
  }

  Either<SearchCatError, List<Cat>> searchCat({required String? breed_name ,required List<Cat> origincats})  {
    if (breed_name==null || breed_name=="") {
      return Left(BeerNameIsNullOrEmpty());
    }
    return Right(origincats.where((element) => element.name?.toLowerCase().contains(breed_name.toLowerCase()) ?? false ).toList());
  }
}
