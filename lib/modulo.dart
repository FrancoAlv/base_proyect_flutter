


import 'package:approach_to_charge/application/usecases/call_catlist_usecase.dart';
import 'package:approach_to_charge/domain/repository/cat_repository.dart';
import 'package:approach_to_charge/infrastructure/provider/home_provider.dart';
import 'package:approach_to_charge/infrastructure/repository/cat_http.dart';
import 'package:http/http.dart';
import 'package:injector/injector.dart';

Future<void> module() async{
  final injector=Injector.appInstance;
  Client client=Client();
  injector.registerSingleton<CatRepository>(() => CatHttp(client),);
  injector.registerSingleton(() => CallCatListUseCase(injector.get()),);
  injector.registerSingleton(() => HomeProvider(injector.get()),);

}