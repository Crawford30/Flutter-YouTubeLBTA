import 'package:flutter/material.dart';



class VideoCell extends StatelessWidget{
  //always when we extend a widget, we have to always provide a build method for the class

  final video;
  //Constructor(Helps to initialize)
  VideoCell(this.video);

  @override
  Widget build(BuildContext context) {

    return new Column(
      children: [
        new Container(
          padding: new EdgeInsets.all(16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Image.network(video["imageUrl"]),
              new Container(height: 8.0,),
              new Text(video["name"],
                style: new TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),),
            ],
          ),
        ),

        new Divider()
      ],
    );
    // return new Text("This is a video..");
  }




}