import 'package:flutter/material.dart';

class WatchListHomePage extends StatefulWidget {
  @override
  _WatchListHomePageState createState() => _WatchListHomePageState();
}

class _WatchListHomePageState extends State<WatchListHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyWatchList"),
      ),
    );
  }
}
