import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mywatchlist/movies/block/bloc.dart';
import 'package:flutter_mywatchlist/movies/model/Movie.dart';
import 'package:flutter_mywatchlist/movies/model/MovieResult.dart';
import 'package:http/http.dart' as http;

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  int _pageNo = 1;
  bool isEnd = false;
  List<Movie> listMovie;
  String movieType;

  @override
  MovieState get initialState {
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
            print("page no " + _pageNo.toString());
            final movieResult = await _fetchPopularMovies(
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

  Future<MovieResult> _fetchPopularMovies(
      int pageNo, String movieType, String mediaType) async {
    var url = await getUrlBy(movieType, mediaType, pageNo);
    var data = await http
        .get(url)
        .timeout(Duration(seconds: 2), onTimeout: _onTimeout);
    if (data.statusCode == 200) {
      Map movieMap = jsonDecode(data.body);
      MovieResult movieResult = MovieResult.fromJson(movieMap, mediaType);
      return movieResult;
    } else {
      throw FetchMovieException(
          "Faild to fetch movies:" + data.statusCode.toString());
    }
  }

  void getNextListPage(String movieType, String mediaType) {
    dispatch(GetPopularMovies(movieType, mediaType));
  }

  Future<String> getUrlBy(
      String movieType, String mediaType, int pageNo) async {
    String key = await loadKey();

    var url = "http://api.themoviedb.org/3/" +
        mediaType +
        "/$movieType?api_key=" +
        key +
        "&page=" +
        pageNo.toString();
    return url;
  }

  Future<String> loadKey() async {
    var asset = await loadAsset();
    String pw;
    try {
      pw = asset.toString();
    } catch (e) {
      debugPrint(e);
    }

    return jsonDecode(pw)['tmdb_key'];
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/keys.json');
  }

  FutureOr<http.Response> _onTimeout() {
    throw Exception("timeout");
  }
}

class FetchMovieException implements Exception {
  final _message;

  FetchMovieException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
