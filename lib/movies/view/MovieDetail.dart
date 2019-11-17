import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mywatchlist/movies/block/moviedetailblock/movie_detail_bloc.dart';
import 'package:flutter_mywatchlist/movies/block/moviedetailblock/movie_detail_event.dart';
import 'package:flutter_mywatchlist/movies/block/moviedetailblock/movie_detail_state.dart';
import 'package:flutter_mywatchlist/movies/model/MovieDetailScreenArgs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MovieDetailScreen extends StatefulWidget {
  static const routeName = "/moviedetail";

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();

  MovieDetailScreen();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  MovieDetailScreenArgs args;
  var _movieDetailBloc = MovieDetailBloc();

  _MovieDetailScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _movieDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context).settings.arguments;
    _movieDetailBloc.add(GetMovieDetail(args.id));
    return Scaffold(
//      appBar: AppBar(
//        automaticallyImplyLeading: false,
//        title: Text(args.title),
//      ),
      body: BlocBuilder(
        bloc: _movieDetailBloc,
        builder: (context, MovieDetailState state) {
          if (state is Progress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailLoaded) {
            return NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    // This widget takes the overlapping behavior of the SliverAppBar,
                    // and redirects it to the SliverOverlapInjector below. If it is
                    // missing, then it is possible for the nested "inner" scroll view
                    // below to end up under the SliverAppBar even when the inner
                    // scroll view thinks it has not been scrolled.
                    // This is not necessary if the "headerSliverBuilder" only builds
                    // widgets that do not overlap the next sliver.
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    child: SliverAppBar(
                      title: const Text('Books'),
                      // This is the title in the app bar.
                      pinned: true,
                      expandedHeight: 150.0,
                      // The "forceElevated" property causes the SliverAppBar to show
                      // a shadow. The "innerBoxIsScrolled" parameter is true when the
                      // inner scroll view is scrolled beyond its "zero" point, i.e.
                      // when it appears to be scrolled below the SliverAppBar.
                      // Without this, there are cases where the shadow would appear
                      // or not appear inappropriately, because the SliverAppBar is
                      // not actually aware of the precise position of the inner
                      // scroll views.
                      forceElevated: innerBoxIsScrolled,
                    ),
                  ),
                ];
              },
              body: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: CachedNetworkImage(
                        alignment: Alignment.topCenter,
                        placeholder: (context, url) =>
                            SpinKitPulse(color: Colors.white),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                        imageUrl: "https://image.tmdb.org/t/p/w500/" +
                            state.movieDetail.backdropPath,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: CachedNetworkImage(
                        imageUrl: "https://image.tmdb.org/t/p/w300/" +
                            state.movieDetail.posterPath,
                        placeholder: (context, url) =>
                            SpinKitPulse(color: Colors.white),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                        height: 300,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
