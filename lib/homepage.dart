import 'package:flutter/material.dart';
import 'package:taskk8/pages/Audios.dart';
import 'package:taskk8/pages/Videos.dart';
import 'package:taskk8/pages/home.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState()=> _HomePageState();

}//end

class _HomePageState extends State<HomePage>{
 int _selectedIndex=0;

 void _navigateBottomBar(int index){
   setState(() {
     _selectedIndex=index;
   });
 }

final List<Widget> _pages=[
  UserPage(),
  VideosP(),
  AudiosP(),

];//end final list
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_pages[_selectedIndex],

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _navigateBottomBar,
            type:BottomNavigationBarType.fixed,
            items: [
          BottomNavigationBarItem(icon:
              Icon(Icons.home),
              label: "Home",
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.ondemand_video),
              label: "Videos"),

          BottomNavigationBarItem(
              icon: Icon(Icons.audiotrack_rounded)
              ,label: "Audios"),


        ],
    ),
    ); //end Scaffold

  }//end Widget build

}//end HomePageState class