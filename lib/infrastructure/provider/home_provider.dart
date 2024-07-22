

import 'dart:async';

import 'package:approach_to_charge/application/usecases/call_catlist_usecase.dart';
import 'package:approach_to_charge/application/usecases/error/get_list_cat_error.dart';
import 'package:approach_to_charge/application/usecases/error/search_cat_error.dart';
import 'package:approach_to_charge/domain/entity/cat.dart';
import 'package:approach_to_charge/infrastructure/provider/error/home_provider_error.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier{

  final CallCatListUseCase _callCatListUseCase;
  final List<Cat> _cats = [];
  final List<Cat> _origincats = [];
  bool _loading = false;
  bool _hasMore = true;
  HomeProviderError _errortype =None();
  int _page = 0;
  String? _breed;

  List<Cat> get cats => _cats;
  bool get loading => _loading;
  HomeProviderError get errortype => _errortype;
  bool get hasMore => _hasMore;

  late ScrollController _scrollController;

  Timer? _debounce;

  ScrollController get scrollController => _scrollController;

  HomeProvider(this._callCatListUseCase){
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadMoreCats();
    });
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 500) {
      loadMoreCats();
    }
  }

  Future<void> loadListCatRefresh() async {
    _page=0;
    _hasMore=true;
    _origincats.clear();
    notifyListeners();
    await loadMoreCats(limit: 30);
  }


  Future<void> loadMoreCats({int limit = 10}) async{
    if (_loading || !_hasMore) return;
    _loading = true;
    notifyListeners();
    final response= await  _callCatListUseCase.getListCat(limit: limit, page: _page);
    _loading = false;

    response.fold((left) {
      switch (left){
        case ErrorHttpCat():
          _hasMore =false;
          _errortype = ErrorOfNetWork();
          break;
        default:
          _errortype = ErrorRules();
      }
      notifyListeners();


    }, (catList) {
      if (catList.isEmpty) {
        _hasMore = false;
      } else {
        _page++;
        _origincats.addAll(catList);
        _findCatByBreedSave();
      }
    });
    notifyListeners();
  }



  Future<void> findCatByBreed(String breed) async{
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _breed=breed;
      _findCatByBreedSave();
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _findCatByBreedSave() {
    _cats.clear();
     _callCatListUseCase.searchCat(breed_name: _breed, origincats: _origincats).fold((left) {
       switch(left){
         case BeerNameIsNullOrEmpty():
           _cats.addAll(_origincats);
           _hasMore = true;
       }
     }, (right) {
       _cats.addAll(right);
       _hasMore = false;
     });

  }

  void changetoNone() {
    _errortype = None();
    notifyListeners();
  }


}