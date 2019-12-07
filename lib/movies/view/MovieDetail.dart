import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mywatchlist/movies/block/moviedetailblock/movie_detail_bloc.dart';
import 'package:flutter_mywatchlist/movies/block/moviedetailblock/movie_detail_event.dart';
import 'package:flutter_mywatchlist/movies/block/moviedetailblock/movie_detail_state.dart';
import 'package:flutter_mywatchlist/movies/model/Movie.dart';
import 'package:flutter_mywatchlist/movies/model/MovieDetailScreenArgs.dart';
import 'package:flutter_mywatchlist/movies/model/moviedetailmodels.dart';
import 'package:flutter_mywatchlist/movies/view/card_view.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
      body: BlocBuilder(
        bloc: _movieDetailBloc,
        builder: (context, MovieDetailState state) {
          if (state is Retry) {
            return Center(child: _buildRetryItem());
          } else if (state is Progress) {
            return Center(child: CircularProgressIndicator());
          } else if (state is MovieDetailLoaded) {
            return Container(
              child: CustomScrollView(slivers: <Widget>[
//                SliverAppBar(
//                  automaticallyImplyLeading: false,
//                  title: Text(state.movieDetail.title),
//                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      CachedNetworkImage(
                        alignment: Alignment.topCenter,
                        placeholder: (context, url) => Container(
                          child: SpinKitPulse(size: 200.0, color: Colors.white),
                        ),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                        imageUrl: "https://image.tmdb.org/t/p/w500/" +
                            state.movieDetail.backdropPath,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            CachedNetworkImage(
                              alignment: Alignment.topLeft,
                              imageUrl: "https://image.tmdb.org/t/p/w300/" +
                                  state.movieDetail.posterPath,
                              placeholder: (context, url) =>
                                  SpinKitPulse(color: Colors.white),
                              errorWidget: (context, url, error) =>
                                  new Icon(Icons.error),
                              height: 155,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: 155,
                                alignment: Alignment.topLeft,
                                child: Column(
                                  verticalDirection: VerticalDirection.down,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 0,
                                          bottom: 0),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        state.movieDetail.title,
                                        maxLines: 2,
                                        style:
                                            Theme.of(context).textTheme.title,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 4,
                                          bottom: 4),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        state.movieDetail.originalTitle,
                                        maxLines: 2,
                                        style:
                                            Theme.of(context).textTheme.body1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 16.0,
                                          top: 0,
                                          bottom: 0,
                                          right: 0),
                                      alignment: Alignment.topLeft,
                                      child: RatingBar(
                                        initialRating: state
                                                    .movieDetail.voteAverage ==
                                                null
                                            ? 0
                                            : ((state.movieDetail.voteAverage *
                                                    5) /
                                                10),
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemSize: 18.0,
                                        ignoreGestures: true,
                                        itemCount: 5,
                                        tapOnlyMode: true,
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.pink[800],
                                        ),
                                        onRatingUpdate: null,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 16, bottom: 4, top: 1),
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.date_range,
                                            size: 21.0,
                                          ),
                                          Text(
                                            " " + state.movieDetail.releaseDate,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        color: Colors.white24,
                        height: 0.5,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 0, left: 16.0, right: 16.0, bottom: 16.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Overview",
                                style: Theme.of(context).textTheme.subhead,
                                textScaleFactor: 1.2,
                                textAlign: TextAlign.start,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.0),
                              child: Text(
                                state.movieDetail.overview,
                                maxLines: 8,
                                overflow: TextOverflow.ellipsis,
                              ),
                              alignment: Alignment.topLeft,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0),
                        color: Colors.white24,
                        height: 0.5,
                      ), //space
                      Container(
                        margin: EdgeInsets.only(
                            top: 0, left: 16.0, right: 16.0, bottom: 16.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Facts",
                                style: Theme.of(context).textTheme.subhead,
                                textScaleFactor: 1.2,
                                textAlign: TextAlign.start,
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Status",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subhead,
                                          textScaleFactor: 1.0,
                                          textAlign: TextAlign.start,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 0.8, bottom: 0.8),
                                          child: Text(
                                            state.movieDetail.status,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            "Orignal Language",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead,
                                            textScaleFactor: 1.0,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 0.8, bottom: 0.8),
                                          child: Text(
                                            state.movieDetail.originalLanguage,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 8.0),
                                          child: Text(
                                            "Runtime",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subhead,
                                            textScaleFactor: 1.0,
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 0.8, bottom: 0.8),
                                          child: Text(
                                            state.movieDetail.runtime
                                                .toString(),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Budget",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subhead,
                                                textScaleFactor: 1.0,
                                                textAlign: TextAlign.start,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 0.8, bottom: 0.8),
                                                child: Text(
                                                  state.movieDetail.budget
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 8.0),
                                                child: Text(
                                                  "Revenue",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subhead,
                                                  textScaleFactor: 1.0,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 0.8, bottom: 0.8),
                                                child: Text(
                                                  state.movieDetail.revenue
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 8.0),
                                                child: Text(
                                                  "Release Information",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subhead,
                                                  textScaleFactor: 1.0,
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 0.8, bottom: 0.8),
                                                child: Text(
                                                  state.movieDetail.releaseDate
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ],
                                          )))
                                ],
                              ),
                              alignment: Alignment.topLeft,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Homepage",
                                style: Theme.of(context).textTheme.subhead,
                                textScaleFactor: 1.0,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 4.0),
                              child:
                                  Text(state.movieDetail.homepage.toString()),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0, top: 16.0),
                        color: Colors.white24,
                        height: 0.5,
                      ), //space
                      Container(
                        margin: EdgeInsets.only(left: 16.0, bottom: 8.0),
                        child: Text(
                          "Genres",
                          style: Theme.of(context).textTheme.subhead,
                          textScaleFactor: 1.2,
                          textAlign: TextAlign.start,
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.0, right: 16.0),
                        child: buildGenres(state.movieDetail.genres),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0, top: 16.0),
                        color: Colors.white24,
                        height: 0.5,
                      ), //space
                      Container(
                        margin: EdgeInsets.only(left: 16.0, bottom: 8.0),
                        child: Text(
                          "Keywords",
                          style: Theme.of(context).textTheme.subhead,
                          textScaleFactor: 1.2,
                          textAlign: TextAlign.start,
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 16.0, right: 16.0),
                        child:
                            buildKeywords(state.movieDetail.keywords.keywords),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0, top: 16.0),
                        color: Colors.white24,
                        height: 0.5,
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 16.0, bottom: 8.0),
                            child: Text(
                              "Top Billed Cast",
                              style: Theme.of(context).textTheme.subhead,
                              textScaleFactor: 1.2,
                              textAlign: TextAlign.start,
                            ),
                            alignment: Alignment.topLeft,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: new SliverChildListDelegate([
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: Row(
                        children:
                            _buildTopCastList(state.movieDetail.credits.cast),
                      ),
                    ),
                  ]),
                ),

                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        margin: EdgeInsets.only(bottom: 16.0, top: 16.0),
                        color: Colors.white24,
                        height: 0.5,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 16.0, bottom: 8.0),
                            child: Text(
                              "Recommendation",
                              style: Theme.of(context).textTheme.subhead,
                              textScaleFactor: 1.2,
                              textAlign: TextAlign.start,
                            ),
                            alignment: Alignment.topLeft,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: new SliverChildListDelegate([
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: Row(
                        children: _buildRecommendationsList(
                            state.movieDetail.recommendations.results),
                      ),
                    ),
                  ]),
                )
              ]),
            );
          }
          return Container();
        },
      ),
    );
  }

  Wrap buildGenres(List<Genres> genres) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < genres.length; i++) {
      list.add(Chip(
        label: Text(genres[i].name.toString()),
      ));
    }
    return Wrap(
      spacing: 8.0,
      children: list,
    );
  }

  Wrap buildKeywords(List<Keyword> keywords) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < keywords.length; i++) {
      list.add(Chip(
        label: Text(keywords[i].name),
      ));
    }
    return Wrap(
      spacing: 8.0,
      children: list,
    );
  }

  Widget _buildRetryItem() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Center(
        child: RaisedButton(
          onPressed: () {
            _movieDetailBloc.add(GetMovieDetail(args.id));
          },
          child: Text('Retry'),
        ),
      ),
    );
  }

  List<Widget> _buildTopCastList(List<Cast> cast) {
    List<Widget> listItems = List();
    for (int i = 0; i < cast.length; i++) {
      listItems.add(_buildTopCastItem(cast[i]));
    }
    return listItems;
  }

  List<Widget> _buildRecommendationsList(List<Movie> movies) {
    List<Widget> listItems = List();
    for (int i = 0; i < movies.length; i++) {
      String networkPosterPath = movies[i].posterPath;
      listItems.add(RecommendationCardView(
        title: movies[i].title,
        imagePath: "https://image.tmdb.org/t/p/w300/$networkPosterPath",
        onPress: () {
          Navigator.pushNamed(
            context,
            MovieDetailScreen.routeName,
            arguments:
                MovieDetailScreenArgs(movies[i].id.toString(), movies[i].title),
          );
        },
      ));
    }
    return listItems;
  }

  Widget _buildRecomCastItem(Movie cast) {
    return Card(
        child: Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(14.0),
            height: 120,
            width: 120,
            child: CachedNetworkImage(
              imageUrl: cast.backdropPath == null
                  ? ""
                  : "https://image.tmdb.org/t/p/w300/" + cast.backdropPath,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle),
              ),
              placeholder: (context, url) => SpinKitPulse(
                color: Colors.white,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          Container(margin: EdgeInsets.all(14.0), child: Text(cast.title)),
        ],
      ),
    ));
  }

  Widget _buildTopCastItem(Cast cast) {
    return Card(
        child: Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(14.0),
            height: 120,
            width: 120,
            child: CachedNetworkImage(
              imageUrl: cast.profilePath == null
                  ? ""
                  : "https://image.tmdb.org/t/p/w300/" + cast.profilePath,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle),
              ),
              placeholder: (context, url) => SpinKitPulse(
                color: Colors.white,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          Container(margin: EdgeInsets.all(14.0), child: Text(cast.name)),
        ],
      ),
    ));
  }
}
