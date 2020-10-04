import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mywatchlist/movies/view/MediaListHomePage.dart';
import 'package:flutter_mywatchlist/movies/view/MovieDetail.dart';
import 'package:flutter_mywatchlist/mywatchlist/WatchListHomePage.dart';
import 'package:flutter_mywatchlist/tmdb_api.dart';

import 'const.dart' as Constants;

Future<void> main() async {


  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark),
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

//class LaunchScreen extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: MyApp(),
//    );
//  }
//}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        '/': (context) => MyHomePage(title: "Demo"),
        MovieDetailScreen.routeName: (context) => MovieDetailScreen(),
      },
      debugShowCheckedModeBanner: false,
      title: 'MyWatchList',
      theme: ThemeData.dark(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> _tabs = ["Movies", "Tv Shows", "Person", "MyWatchList"];
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            MediaListHomePage(Constants.MEDIA_MOVIE),
            MediaListHomePage(Constants.MEDIA_TV),
            MediaListHomePage(Constants.PERSON),
            WatchListHomePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            title: Text(_tabs.elementAt(0).toString()),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            title: Text(_tabs.elementAt(1).toString()),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text(_tabs.elementAt(2).toString()),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text(_tabs.elementAt(3).toString()),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: _onItemTapped,
        backgroundColor: Colors.black26,
      ),
    );
  }
}
