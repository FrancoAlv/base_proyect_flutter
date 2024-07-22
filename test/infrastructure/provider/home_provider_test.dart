import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:approach_to_charge/application/usecases/call_catlist_usecase.dart';
import 'package:approach_to_charge/domain/entity/cat.dart';
import 'package:approach_to_charge/infrastructure/provider/home_provider.dart';
import 'package:approach_to_charge/application/usecases/error/get_list_cat_error.dart';
import 'package:approach_to_charge/application/usecases/error/search_cat_error.dart';
import 'package:approach_to_charge/infrastructure/provider/error/home_provider_error.dart';
import 'package:either_dart/either.dart';
import 'package:mockito/annotations.dart';
import 'home_provider_test.mocks.dart';

@GenerateMocks([CallCatListUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  provideDummy<Either<GetListCatError, List<Cat>>>( Right([]));
  provideDummy<Either<SearchCatError, List<Cat>>>(Right([]));

  late HomeProvider homeProvider;
  late MockCallCatListUseCase mockCallCatListUseCase;

  setUp(() {
    mockCallCatListUseCase = MockCallCatListUseCase();
    homeProvider = HomeProvider(mockCallCatListUseCase);
  });

  group('HomeProvider', () {
    test('initial state', () {
      expect(homeProvider.cats, []);
      expect(homeProvider.loading, false);
      expect(homeProvider.errortype, isA<None>());
      expect(homeProvider.hasMore, true);
    });



    test('loadMoreCats error', () async {
      when(mockCallCatListUseCase.getListCat(limit: anyNamed('limit'), page: anyNamed('page')))
          .thenAnswer((_) async => Left(ErrorHttpCat()));

      await homeProvider.loadMoreCats();

      expect(homeProvider.cats, []);
      expect(homeProvider.loading, false);
      expect(homeProvider.errortype, isA<ErrorOfNetWork>());
      expect(homeProvider.hasMore, true);
    });



    test('findCatByBreed error', () async {
      final cats = [Cat(name: 'Abyssinian')];
      homeProvider.cats.addAll(cats);

      when(mockCallCatListUseCase.searchCat(breed_name: anyNamed('breed_name'), origincats: anyNamed('origincats')))
          .thenReturn(Left(BeerNameIsNullOrEmpty()));

      await homeProvider.findCatByBreed('');

      expect(homeProvider.cats, cats);
      expect(homeProvider.loading, false);
      expect(homeProvider.errortype, isA<None>());
      expect(homeProvider.hasMore, true);
    });


  });
}
