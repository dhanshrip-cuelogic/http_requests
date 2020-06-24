import 'package:flutter/material.dart';
import 'package:httprequests/FetchData.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FetchData(),
    );
  }
}
