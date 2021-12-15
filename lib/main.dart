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

  _fetchData() async {
    print("Attempting to print data from a network...");

    final url = "https://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      final map =   json.decode(response.body);
        print(map["videos"]);
    }



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
                _isLoading = false;
              });

              _fetchData();
            })
          ],

        ),

        body: new Center(
          child: _isLoading ? new CircularProgressIndicator() :
          new Text("Finished Loading..."),
        ),
      ),

      debugShowCheckedModeBanner: false,
    );


  }
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}