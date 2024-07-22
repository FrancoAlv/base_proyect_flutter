import 'package:approach_to_charge/domain/entity/cat.dart';
import 'package:approach_to_charge/domain/repository/cat_repository.dart';
import 'package:approach_to_charge/domain/repository/error/cat_error.dart';
import 'package:either_dart/src/either.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart';

class CatHttp extends CatRepository {
  static const String _heard ="ve_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr";

  Client _client;

  CatHttp(this._client);

  @override
  Future<Either<CatError, List<Cat>>> getCatListByEither(
      {int limit = 10, required int page}) async {
  try {

    final response = await this
        ._client
        .get(Uri.https("api.thecatapi.com", "/v1/breeds",  {"limit": "$limit", "page": "$page"}), headers: {
      "x-api-key": _heard});

    if (response.body == "" || response.body == null) {
      return Left(CatErrorWithoutBody());
    }

    if (response.statusCode != 200) {
      return Left(CatErrorHttp(
          code: response.statusCode,
          message: response.reasonPhrase ?? "Not Found"));
    }
    final jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
    final listCat = jsonResponse.map((e) => Cat.fromJson(e)).toList();
    return Right(listCat);
  } catch (e){
    return Left(CatErrorHttp(
        code: 500,
        message:  "Not Found"));
  }
  }


}
