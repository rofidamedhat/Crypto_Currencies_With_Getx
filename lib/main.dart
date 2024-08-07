import 'package:crypto_currencies_with_getx/pages/home_page.dart';
import 'package:crypto_currencies_with_getx/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  await registerDio();
  await registerAssetController();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) =>  HomePage(),
      },
    );
  }
}
