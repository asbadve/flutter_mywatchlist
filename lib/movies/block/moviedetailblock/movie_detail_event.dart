import 'package:equatable/equatable.dart';
import 'package:flutter_mywatchlist/movies/model/moviedetailmodels.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent([List props = const []]) : super(props);

//  const MovieDetailEvent();
}

class GetMovieDetail extends MovieDetailEvent {
  final String movieId;

  GetMovieDetail(this.movieId) : super([movieId]);
}


