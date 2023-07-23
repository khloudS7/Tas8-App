import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );//end MaterialApp
  }//end bulid
}//end class MyApp
