import 'package:flutter/material.dart';
import 'package:flutter_mywatchlist/movies/view/AllMovies.dart';

import '../../const.dart' as Constant;

class MediaListHomePage extends StatefulWidget {
  final String mediaType;

  MediaListHomePage([this.mediaType]);

  @override
  _MediaListHomePageState createState() => _MediaListHomePageState(mediaType);
}

class _MediaListHomePageState extends State<MediaListHomePage>
    with SingleTickerProviderStateMixin {
  /*
   *-------------------- Setup Tabs ------------------*
   */
  // Create a tab controller
  TabController controller;

  //either Tv,People,Movies
  String mediaType;

  _MediaListHomePageState(this.mediaType);

  @override
  void initState() {
    super.initState();

    // Initialize the Tab Controller
    if (mediaType == Constant.PERSON) {
      controller = TabController(length: 1, vsync: this);
    } else {
      controller = TabController(length: 4, vsync: this);
    }
  }

  @override
  void dispose() {
    // Dispose of the Tab Controller
    controller.dispose();
    super.dispose();
  }

  TabBar getTabBar() {
    return TabBar(
      isScrollable: true,
      indicator: UnderlineTabIndicator(
        borderSide:
            BorderSide(color: Colors.white, width: 4, style: BorderStyle.solid),
        insets: EdgeInsets.fromLTRB(5, 0, 5, 0),
      ),
      labelPadding: EdgeInsets.all(10),
      labelStyle: TextStyle(fontSize: 15),
      unselectedLabelColor: Colors.white70,
      tabs: mediaType == Constant.PERSON
          ? <Tab>[
              Tab(
                  child: Text(
                getTabTitleByMediaTypeAndIndex(mediaType, 0),
              )),
            ]
          : <Tab>[
              Tab(child: Text(getTabTitleByMediaTypeAndIndex(mediaType, 0))),
              Tab(child: Text(getTabTitleByMediaTypeAndIndex(mediaType, 1))),
              Tab(child: Text(getTabTitleByMediaTypeAndIndex(mediaType, 2))),
              Tab(child: Text(getTabTitleByMediaTypeAndIndex(mediaType, 3))),
            ],
      // setup the controller
      controller: controller,
    );
  }

  String getTabTitleByMediaTypeAndIndex(String mediaType, int index) {
    switch (mediaType) {
      case Constant.PERSON:
        {
          return "Popular Person";
        }
        break;
      case Constant.MEDIA_MOVIE:
        {
          switch (index) {
            case 0:
              return "Popular";
              break;
            case 1:
              return "Top Rated";
              break;
            case 2:
              return "Upcoming";
              break;
            case 3:
              return "Now Playing";
              break;
          }
        }
        break;
      case Constant.MEDIA_TV:
        {
          switch (index) {
            case 0:
              return "Popular";
              break;
            case 1:
              return "Top Rated";
              break;
            case 2:
              return "On Tv";
              break;
            case 3:
              return "Airing Today";
              break;
          }
        }
        break;
    }

    return "";
  }

  TabBarView getTabBarView(var tabs) {
    return TabBarView(
      // Add tabs as widgets
      children: tabs,
      // set the controller
      controller: controller,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Appbar
        appBar: AppBar(
          title: getAppBarTitle(mediaType),
          bottom: getTabBar(),
        ),
        // Set the TabBar view as the body of the Scaffold
        body: mediaType == Constant.PERSON
            ? getTabBarView(<Widget>[
                AllMovies(
                    movieType: Constant.POPULAR_PERSON, mediaType: mediaType),
              ])
            : getTabBarView(<Widget>[
                AllMovies(
                    movieType: mediaType == Constant.MEDIA_MOVIE
                        ? Constant.POPULAR
                        : Constant.POPULAR_TV,
                    mediaType: mediaType),
                AllMovies(
                    movieType: mediaType == Constant.MEDIA_MOVIE
                        ? Constant.TOP_RATED
                        : Constant.TOP_RATED_TV,
                    mediaType: mediaType),
                AllMovies(
                    movieType: mediaType == Constant.MEDIA_MOVIE
                        ? Constant.UPCOMING
                        : Constant.ON_TV,
                    mediaType: mediaType),
                AllMovies(
                    movieType: mediaType == Constant.MEDIA_MOVIE
                        ? Constant.NOW_PLAYING
                        : Constant.AIRING_TODAY,
                    mediaType: mediaType)
              ]));

//    return Scaffold(todo if wanted only tabs instead of app bar
//      // Appbar
//        appBar: AppBar(
//          flexibleSpace: SafeArea(child: getTabBar(),
//            bottom: false,),
//        ),
//        // Set the TabBar view as the body of the Scaffold
//        body: getTabBarView(<Widget>[First(), First(), First()]));
  }

  Text getAppBarTitle(String mediaType) {
    switch (mediaType) {
      case Constant.PERSON:
        {
          return Text("Person");
        }
        break;
      case Constant.MEDIA_MOVIE:
        {
          return Text("Movies");
        }
        break;
      case Constant.MEDIA_TV:
        {
          return Text("Tv");
        }
        break;
    }

    return Text("");
  }
}
