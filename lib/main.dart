import 'package:flutter/material.dart';

void main() {
  runApp(RealWorldApp());
}



class RealWorldApp extends StatefulWidget {
  const RealWorldApp({Key? key}) : super(key: key);

  @override
  _RealWorldAppState createState() => _RealWorldAppState();
}

class _RealWorldAppState extends State<RealWorldApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title:  new Text("REAL WORLD APP"),
          actions: <Widget>[
            new IconButton( icon: new Icon(Icons.refresh), onPressed:  (){
              print("Reloading...");
            })
          ],

        ),

        body: new Center(
          child: CircularProgressIndicator(),
        ),
      ),

      debugShowCheckedModeBanner: false,
    );


  }
}
