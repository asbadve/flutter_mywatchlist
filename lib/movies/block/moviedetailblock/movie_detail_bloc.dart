import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_mywatchlist/movies/model/moviedetailmodels.dart';
import 'package:flutter_mywatchlist/movies/repository/moviedetailrepository.dart';

import './bloc.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailRepository movieDetailRepository;

  @override
  MovieDetailState get initialState {
    movieDetailRepository = MovieDetailRepository();
    return InitialMovieDetailState();
  }

  @override
  Stream<MovieDetailState> mapEventToState(
    MovieDetailEvent event,
  ) async* {
    if (event is GetMovieDetail) {
      yield Progress();
      MovieDetail movieDetail =
          await movieDetailRepository.fetchMovieDetails(event.movieId);
      yield MovieDetailLoaded(movieDetail);
    }
  }
}
