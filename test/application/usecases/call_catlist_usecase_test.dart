import 'package:approach_to_charge/application/usecases/error/get_list_cat_error.dart';
import 'package:approach_to_charge/application/usecases/error/search_cat_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:approach_to_charge/domain/repository/cat_repository.dart';
import 'package:approach_to_charge/domain/repository/error/cat_error.dart';
import 'package:approach_to_charge/application/usecases/call_catlist_usecase.dart';
import 'package:approach_to_charge/domain/entity/cat.dart';
import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'call_catlist_usecase_test.mocks.dart';

@GenerateMocks([CatRepository])
void main() {
  late CallCatListUseCase useCase;
  late MockCatRepository mockCatRepository;

  setUp(() {
    mockCatRepository = MockCatRepository();
    useCase = CallCatListUseCase(mockCatRepository);
  });

  provideDummy<Either<CatError, List<Cat>>>(Right([]));

  group('getListCat', () {
    test('returns Left(LimitCannotBeLessZero) if limit is less than or equal to 0', () async {
      final result = await useCase.getListCat(limit: 0, page: 1);
      expect(result.isLeft, true);
      result.fold(
            (error) => expect(error, isA<LimitCannotBeLessZero>()),
            (cats) => fail('Expected Left but got Right'),
      );
    });

    test('returns Left(PageCannotBeLessZero) if page is less than 0', () async {
      final result = await useCase.getListCat(limit: 10, page: -1);
      expect(result.isLeft, true);
      result.fold(
            (error) => expect(error, isA<PageCannotBeLessZero>()),
            (cats) => fail('Expected Left but got Right'),
      );
    });

    test('returns Left(ErrorHttpCat) if repository returns an error', () async {
      when(mockCatRepository.getCatListByEither(limit: 10, page: 1))
          .thenAnswer((_) async => Left(CatErrorHttp(code: 500, message: 'Internal Server Error')));

      final result = await useCase.getListCat(limit: 10, page: 1);
      expect(result.isLeft, true);
      result.fold(
            (error) => expect(error, isA<ErrorHttpCat>()),
            (cats) => fail('Expected Left but got Right'),
      );
    });

    test('returns Left(ArrayWithoutElements) if repository returns an empty list', () async {
      when(mockCatRepository.getCatListByEither(limit: 10, page: 1))
          .thenAnswer((_) async => Right([]));

      final result = await useCase.getListCat(limit: 10, page: 1);
      expect(result.isLeft, true);
      result.fold(
            (error) => expect(error, isA<ArrayWithoutElements>()),
            (cats) => fail('Expected Left but got Right'),
      );
    });

    test('returns Right with list of cats if repository call is successful', () async {
      final cats = [Cat(name: 'Abyssinian')];
      when(mockCatRepository.getCatListByEither(limit: 10, page: 1))
          .thenAnswer((_) async => Right(cats));

      final result = await useCase.getListCat(limit: 10, page: 1);
      expect(result.isRight, true);
      result.fold(
            (error) => fail('Expected Right but got Left'),
            (cats) => expect(cats, isA<List<Cat>>()),
      );
    });
  });

  group('searchCat', () {
    final cats = [
      Cat(name: 'Abyssinian'),
      Cat(name: 'Bengal'),
      Cat(name: 'Siamese')
    ];

    test('returns Left(BeerNameIsNullOrEmpty) if breed_name is null or empty', () {
      final result = useCase.searchCat(breed_name: '', origincats: cats);
      expect(result.isLeft, true);
      result.fold(
            (error) => expect(error, isA<BeerNameIsNullOrEmpty>()),
            (cats) => fail('Expected Left but got Right'),
      );

      final result2 = useCase.searchCat(breed_name: null, origincats: cats);
      expect(result2.isLeft, true);
      result2.fold(
            (error) => expect(error, isA<BeerNameIsNullOrEmpty>()),
            (cats) => fail('Expected Left but got Right'),
      );
    });

    test('returns Right with list of cats matching breed_name', () {
      final result = useCase.searchCat(breed_name: 'sia', origincats: cats);
      expect(result.isRight, true);
      result.fold(
            (error) => fail('Expected Right but got Left'),
            (filteredCats) {
          expect(filteredCats.length, 1);
          expect(filteredCats.first.name, 'Siamese');
        },
      );
    });

    test('returns Right with empty list if no cats match breed_name', () {
      final result = useCase.searchCat(breed_name: 'nonexistent', origincats: cats);
      expect(result.isRight, true);
      result.fold(
            (error) => fail('Expected Right but got Left'),
            (filteredCats) => expect(filteredCats.length, 0),
      );
    });
  });
}
