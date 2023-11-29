import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rest_api/api_provider.dart';
import 'package:rest_api/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApiProvider(),
      child: MyApp(),
    ),
  );//This is a callback function that creates an instance of ProviderAdd
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}


