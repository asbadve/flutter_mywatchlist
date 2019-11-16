import 'package:equatable/equatable.dart';
import 'package:flutter_mywatchlist/movies/model/Movie.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MovieState extends Equatable {
  MovieState([List props = const []]) : super(props);
}

class InitialMovieState extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movieResult;
  final bool hasReachedEndOfResult;
  final bool noInternet;
  final bool loading;



  MovieLoaded(this.movieResult, this.hasReachedEndOfResult, this.noInternet,this.loading)
      : super([movieResult, hasReachedEndOfResult,noInternet,loading]);
}
