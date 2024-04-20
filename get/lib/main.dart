import 'package:flutter/material.dart';
import 'package:get_api/screen/post_apis_view.dart';
import './screen/user_api_view.dart';
import './screen/fetch_api_without_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: FetchApiWithoutModel(),
    );
  }
}
