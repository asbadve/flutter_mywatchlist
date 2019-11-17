import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mywatchlist/movies/block/bloc.dart';
import 'package:flutter_mywatchlist/movies/model/Movie.dart';
import 'package:flutter_mywatchlist/movies/repository/moviedetailrepository.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  int _pageNo = 1;
  bool isEnd = false;
  List<Movie> listMovie;
  String movieType;
  MovieDetailRepository movieDetailRepository;

  @override
  MovieState get initialState {
    movieDetailRepository = MovieDetailRepository();

    if (listMovie == null) {
      listMovie = List<Movie>();
    }
    return InitialMovieState();
  }

  @override
  Stream<MovieState> mapEventToState(
    MovieEvent event,
  ) async* {
    if (listMovie == null) {
      listMovie = List<Movie>();
    }
    if (!isEnd) {
      if (event is GetPopularMovies) {
        yield MovieLoaded(listMovie, isEnd, false, true);
        bool result = await DataConnectionChecker().hasConnection;
        if (result == true) {
          try {
            final movieResult =
                await movieDetailRepository.fetchMediaPagingDetails(
                    _pageNo, event.movieType, event.mediaType);

            if (_pageNo <= movieResult.totalPages) {
              if (_pageNo == movieResult.totalPages) {
                isEnd = true;
              }
              _pageNo++;
              listMovie = listMovie + movieResult.results;

              yield MovieLoaded(listMovie, isEnd, false, false);
            }
          } on Exception catch (e) {
            if (e is SocketException) {
              debugPrint('SocketException error caught: $e');
              yield MovieLoaded(listMovie, isEnd, true, false);
            } else if (e is TimeoutException) {
              debugPrint('TimeoutException error caught: $e');
              yield MovieLoaded(listMovie, isEnd, true, false);
            } else {
              debugPrint('generic error caught: $e');
              yield MovieLoaded(listMovie, isEnd, true, false);
            }
          }
        } else {
          yield MovieLoaded(listMovie, isEnd, true, false);
        }
      }
    }
  }

  void getNextListPage(String movieType, String mediaType) {
    add(GetPopularMovies(movieType, mediaType));
  }
}
