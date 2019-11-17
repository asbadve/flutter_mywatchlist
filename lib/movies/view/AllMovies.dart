import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mywatchlist/movies/block/movie_event.dart';
import 'package:flutter_mywatchlist/movies/model/MovieDetailScreenArgs.dart';
import 'package:flutter_mywatchlist/movies/view/MovieDetail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const.dart' as Constants;
import '../block/bloc.dart';
import '../block/movie_bloc.dart';
import '../model/Movie.dart';
import 'card_view.dart';

class AllMovies extends StatefulWidget {
  final String movieType;
  final String mediaType;

  @override
  _AllMoviesState createState() => _AllMoviesState(movieType, mediaType);

  AllMovies({this.movieType, this.mediaType});
}

class _AllMoviesState extends State<AllMovies>
    with AutomaticKeepAliveClientMixin<AllMovies> {
  var movieBloc = MovieBloc();
  ScrollController _controller;

  String movieType;
  String mediaType;

  _AllMoviesState(this.movieType, this.mediaType);

  @override
  void initState() {
    _controller = ScrollController();
    movieBloc.add(GetPopularMovies(movieType, mediaType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        child: BlocBuilder(
      bloc: movieBloc,
      builder: (context, MovieState state) {
        if (state is MovieLoaded) {
          return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification &&
                    _controller.position.extentAfter == 0) {
                  movieBloc.getNextListPage(movieType, mediaType);
                }
                return false;
              },
              child: mediaType == Constants.PERSON
                  ? GridView.builder(
                      itemCount: _calculateListItemCount(state),
                      controller: _controller,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.70, crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return (index >= state.movieResult.length)
                            ? (state.loading)
                                ? _buildLoaderItem()
                                : (state.noInternet
                                    ? _buildRetryItem()
                                    : _buildLoaderItem())
                            : (buildPersonDataListItem(
                                state.movieResult[index]));
                      },
                    )
                  : ListView.builder(
                      itemCount: _calculateListItemCount(state),
                      controller: _controller,
                      itemBuilder: (context, index) {
                        return (index >= state.movieResult.length)
                            ? (state.loading)
                                ? _buildLoaderItem()
                                : (state.noInternet
                                    ? _buildRetryItem()
                                    : _buildLoaderItem())
                            : (buildDataListItem(state.movieResult[index]));
                      },
                    ));
        }

        return Container();
      },
    ));
  }

  @override
  void dispose() {
    movieBloc.close();
    super.dispose();
  }

  Widget _buildLoaderItem() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildRetryItem() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Center(
        child: RaisedButton(
          onPressed: () {
            movieBloc.add(GetPopularMovies(movieType, mediaType));
          },
          child: Text('Retry'),
        ),
      ),
    );
  }

  Widget buildDataListItem(Movie movie) {
    String networkPosterPath = movie.posterPath;
    return MovieCardView(
      title: movie.title,
      imagePath: "https://image.tmdb.org/t/p/w300/$networkPosterPath",
      overview: movie.overview,
      releaseDate: movie.releaseDate,
      voteAverage: movie.voteAverage,
      onPress: () {
        Navigator.pushNamed(
          context,
          MovieDetailScreen.routeName,
          arguments: MovieDetailScreenArgs(movie.id.toString(), movie.title),
        );
      },
    );
  }

  Widget buildPersonDataListItem(Movie movie) {
    String networkPosterPath = movie.posterPath;
    return PersonCardView(
      title: movie.title,
      imagePath: "https://image.tmdb.org/t/p/w300/$networkPosterPath",
      onPress: null,
    );
  }

  @override
  bool get wantKeepAlive => true;

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _controller.position.extentAfter == 0) {
      movieBloc.getNextListPage(movieType, mediaType);
    }
    return false;
  }

  _calculateListItemCount(MovieLoaded state) {
    if (state.hasReachedEndOfResult) {
      return state.movieResult.length;
    } else {
      return state.movieResult.length + 1;
    }
  }
}
