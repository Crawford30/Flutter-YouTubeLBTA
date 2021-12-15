import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'views/video_cell.dart';

void main() {
  runApp(RealWorldApp());
  HttpOverrides.global = MyHttpOverrides();
}



class RealWorldApp extends StatefulWidget {
  const RealWorldApp({Key? key}) : super(key: key);

  @override
  _RealWorldAppState createState() => _RealWorldAppState();
}

class _RealWorldAppState extends State<RealWorldApp> {
  var _isLoading = true;
  var videos;

  _fetchData() async {
    print("Attempting to print data from a network...");

    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final map =   json.decode(response.body);
       final videosJSON = (map["videos"]);

       this.videos =  videosJSON;

       // videosJSON.forEach((video) {
       //   print(video["name"]);
       // });
    }

    setState(() {
      _isLoading = false;
      // this.videos =  videosJSON;
    });



  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title:  new Text("REAL WORLD APP"),
          actions: <Widget>[
            new IconButton( icon: new Icon(Icons.refresh), onPressed:  (){
              print("Reloading...");

              setState(() {
                _isLoading = true;
              });

              _fetchData();
            })
          ],

        ),

        body: new Center(
          child: _isLoading ? new CircularProgressIndicator() :
          // new Text("Finished Loading..."),
          new ListView.builder(
            itemCount: this.videos != null ?  this.videos.length : 0,
              itemBuilder: (context, i){

              final video = this.videos[i];
              
              return new FlatButton(
               padding: new EdgeInsets.all(0.0),
                child: new VideoCell(video),
                onPressed: (){
                   print("Video cell tapped: ${i}");
                   
                   
                   Navigator.push(context, 
                   new MaterialPageRoute(builder: (context) => new DetailPage()),
                  );
                   
                   //the context property is one on the list builder
                },
              );



            
               return new VideoCell(video);
              //
              // //return new Text("ROW: ${i}");
               },
          ),
        ),
      ),

      debugShowCheckedModeBanner: false,
    );


  }
}

//https://stackoverflow.com/questions/54285172/how-to-solve-flutter-certificate-verify-failed-error-while-performing-a-post-req
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


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

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Detail Page"),
      ),

      body: new Center(
        child: new Text("CENTERED"),
      ),
    );
  }
}
