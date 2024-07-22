
import 'package:approach_to_charge/infrastructure/provider/home_provider.dart';
import 'package:approach_to_charge/infrastructure/router/main_router.dart';
import 'package:approach_to_charge/modulo.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await module();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Injector.appInstance.get<HomeProvider>(),
        )
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE0F7FA)),
          useMaterial3: true,
        ),
        routerConfig: MainRouter.router,
      ),
    );
  }
}
