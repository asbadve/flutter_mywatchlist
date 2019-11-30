import 'package:equatable/equatable.dart';
import 'package:flutter_mywatchlist/movies/model/moviedetailmodels.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
}

class InitialMovieDetailState extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class Progress extends InitialMovieDetailState {}
class Retry extends InitialMovieDetailState {}

class MovieDetailLoaded extends InitialMovieDetailState {
  final MovieDetail movieDetail;

  MovieDetailLoaded(this.movieDetail);
}
