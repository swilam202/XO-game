import 'package:flutter/material.dart';
import 'home screen.dart';

void main()=> runApp(Myapp());


class Myapp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(10, 2, 35, 1.0),
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
