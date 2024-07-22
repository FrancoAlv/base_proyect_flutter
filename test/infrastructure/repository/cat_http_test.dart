import 'package:approach_to_charge/domain/entity/cat.dart';
import 'package:approach_to_charge/domain/repository/error/cat_error.dart';
import 'package:approach_to_charge/infrastructure/repository/cat_http.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';

void main() {
  group('CatHttp', () {
    test('returns a list of cats if the http call completes successfully', () async {
      final client = MockClient((request) async {
        final response = [
          {
            "weight": {"imperial": "7 - 10", "metric": "3 - 5"},
            "id": "abys",
            "name": "Abyssinian",
            "cfa_url": "",
            "vetstreet_url": "http://www.vetstreet.com/cats/abyssinian",
            "vcahospitals_url": "https://vcahospitals.com/know-your-pet/cat-breeds/abyssinian",
            "temperament": "Active, Energetic, Independent, Intelligent, Gentle",
            "origin": "Egypt",
            "country_codes": "EG",
            "country_code": "EG",
            "description": "T",
            "life_span": "14 - 15",
            "indoor": 0,
            "lap": 1,
            "alt_names": "",
            "adaptability": 5,
            "affection_level": 5,
            "child_friendly": 3,
            "dog_friendly": 4,
            "energy_level": 5,
            "grooming": 1,
            "health_issues": 2,
            "intelligence": 5,
            "shedding_level": 2,
            "social_needs": 5,
            "stranger_friendly": 5,
            "vocalisation": 1,
            "experimental": 0,
            "hairless": 0,
            "natural": 1,
            "rare": 0,
            "rex": 0,
            "suppressed_tail": 0,
            "short_legs": 0,
            "wikipedia_url": "",
            "hypoallergenic": 0,
            "reference_image_id": "0XYvRd7oD"
          }
        ];
        return Response(jsonEncode(response), 200, headers: {'content-type': 'application/json'});
      });

      final catHttp = CatHttp(client);
      final result = await catHttp.getCatListByEither(limit: 10, page: 1);

      expect(result.isRight, true);
      result.fold(
            (left) => fail('Expected Right but got Left'),
            (right) {
          expect(right, isA<List<Cat>>());
          expect(right.length, 1);
          expect(right.first.name, 'Abyssinian');
        },
      );
    });

    test('returns a CatErrorHttp if the http call completes with an error', () async {
      final client = MockClient((request) async {
        return Response('Not Found', 404);
      });

      final catHttp = CatHttp(client);
      final result = await catHttp.getCatListByEither(limit: 10, page: 1);

      expect(result.isLeft, true);
      result.fold(
            (left) {
          expect(left, isA<CatErrorHttp>());
          expect((left as CatErrorHttp).code, 404);
        },
            (right) => fail('Expected Left but got Right'),
      );
    });

    test('returns a CatErrorWithoutBody if the http call returns an empty body', () async {
      final client = MockClient((request) async {
        return Response('', 200);
      });

      final catHttp = CatHttp(client);
      final result = await catHttp.getCatListByEither(limit: 10, page: 1);

      expect(result.isLeft, true);
      result.fold(
            (left) => expect(left, isA<CatErrorWithoutBody>()),
            (right) => fail('Expected Left but got Right'),
      );
    });
  });
}
