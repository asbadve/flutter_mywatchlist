import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/foundation.dart';
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
      bool result = await DataConnectionChecker().hasConnection;
      if (result == true) {
        try {
          MovieDetail movieDetail =
              await movieDetailRepository.fetchMovieDetails(event.movieId);
          yield MovieDetailLoaded(movieDetail);
        } on Exception catch (e) {
          if (e is SocketException) {
            debugPrint('SocketException error caught: $e');
            yield Retry();
          } else if (e is TimeoutException) {
            debugPrint('TimeoutException error caught: $e');
            yield Retry();
          } else {
            debugPrint('generic error caught: $e');
            yield Retry();
          }
        }
      } else {
        yield Retry();
      }
    }
  }
}
