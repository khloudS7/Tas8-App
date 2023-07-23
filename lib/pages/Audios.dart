import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudiosP extends StatelessWidget {
  Widget build(BuildContext context) {
    return MusicPlayer();
  }}

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
//variabls
bool isPlaying = false;
double value=0;


  //create an instance of the music player
  final player = AudioPlayer();

  //setting the duration
  Duration? duration=Duration(seconds: 0);

  //create a function to initiate the music into the player
 void initPlayer() async{
   await player.setSource(AssetSource("music.mp3"));
   duration=await player.getDuration();

 } //end initPlayer

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Text(
            "Audios page",
            style: TextStyle(fontSize: 50),
          ),

          //add decoration
         Container(
           constraints: BoxConstraints.expand(),
           decoration: BoxDecoration(
           image: DecorationImage(
           image: AssetImage("assets/summer2.jpg"),
           fit:BoxFit.cover,
                          )
                          ),

           child: BackdropFilter(
             //add blur
             filter: ImageFilter.blur(sigmaX: 28,sigmaY: 28),
             child: Container(
               color: Colors.black54,
             ) ,
           ),
),
          
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           ClipRRect(
             borderRadius: BorderRadius.circular(30.0),
             child: Image.asset(
                 "assets/summer2.jpg",
                 width: 250.0,
               ),
           ),
           SizedBox(height: 20,),
           Text("Summer vibes",
             style: TextStyle(
                 color: Colors.white
                ,fontSize: 36.0,
                 letterSpacing: 6.0
             ),
             ),

           SizedBox(height: 50.0,),

           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               //modified when music stream
               Text(
                 "${(value /60).floor()}:${(value %60).floor()}",
                     style: TextStyle(
                     color: Colors.white
                 ),
               ),

            Slider.adaptive(
                onChanged: (v){
                  setState(() {
                    value=v;
                  });
                },
                min:0.0,
                max:duration!.inSeconds.toDouble(),
                value: value,
                onChangeEnd: (newValue) async {
                  setState(() {
                   value=newValue;
                   print(newValue);
                  });
                  player.pause();
                  await player.seek(Duration(seconds: newValue.toInt()));
                  await player.resume();
                },

                activeColor:Colors.white ,),

            // show total duration of the song
               Text("${duration!.inMinutes} : ${duration!.inSeconds %60}",
                 style: TextStyle(
                     color: Colors.white
                 ),
               ),

             ],//row children
           ),
           SizedBox(height: 30.0,),
           
           Container(
             width: 50.0,
             height: 50.0 ,
             decoration: BoxDecoration(
                 borderRadius:BorderRadius.circular(60.0),
                 color: Colors.lightGreen,
                 border: Border.all(color: Colors.white),
             ),

             child: InkWell(
               onTap: () async {
                 //play the music
                  if(isPlaying){
                    await player.pause();
                    setState(() {
                      isPlaying= false;
                    });
                  }
                  else{
                    await player.resume();
                    setState(() {
                      isPlaying= true;
                    });

                    //track the value
                    player.onPositionChanged.listen(
                          (position) {
                        setState(() {
                          value=position.inSeconds.toDouble();
                        });
                      },);
                  }


               },//end ontap

               child: Icon(
                isPlaying?Icons.pause: Icons.play_arrow,
                 color: Colors.white,
               ),
             ),
           )
         ],//end children 
            
          ),
        ],//end children
      ),//end stack
    );//end Scaffold
  }
}
