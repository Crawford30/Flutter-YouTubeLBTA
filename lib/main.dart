import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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

              return new Column(
                children: [
                  new Container(
                    padding: new EdgeInsets.all(16.0),
                    child: new Column(
                      children: [
                            new Image.network(video["imageUrl"]),
                            new Text(video["name"]),

                      ],
                    ),
                  ),

                  new Divider()
                ],
              );
              //return new Text("ROW: ${i}");
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