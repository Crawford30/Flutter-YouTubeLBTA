import 'package:flutter/material.dart';

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