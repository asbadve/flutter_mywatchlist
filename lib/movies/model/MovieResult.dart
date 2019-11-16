import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mywatchlist/movies/model/Movie.dart';

import '../../const.dart' as Constant;

class MovieResult {
  int _page;
  int _totalResults;
  int _totalPages;
  List<Movie> _results;

  MovieResult(
      {int page, int totalResults, int totalPages, List<Movie> results}) {
    this._page = page;
    this._totalResults = totalResults;
    this._totalPages = totalPages;
    this._results = results;
  }

  int get page => _page;

  set page(int page) => _page = page;

  int get totalResults => _totalResults;

  set totalResults(int totalResults) => _totalResults = totalResults;

  int get totalPages => _totalPages;

  set totalPages(int totalPages) => _totalPages = totalPages;

  List<Movie> get results => _results;

  set results(List<Movie> results) => _results = results;

  MovieResult.fromJson(Map<String, dynamic> json, String mediaType) {
    try {
      _page = json['page'];
      _totalResults = json['total_results'];
      _totalPages = json['total_pages'];
      var list = json['results'] as List;

      for (var m in list) {
        Movie movie;
        if (mediaType == Constant.PERSON) {
          movie = Movie(
              title: m["name"],
              overview: m['overview'],
              posterPath: m["profile_path"],
              releaseDate: "",
              id: m["id"]);
        } else {
          movie = Movie(
              title: mediaType == Constant.MEDIA_MOVIE ? m["title"] : m["name"],
              overview: m["overview"],
              posterPath: m["poster_path"],
              releaseDate: mediaType == Constant.MEDIA_MOVIE
                  ? m["release_date"]
                  : m["first_air_date"],
              voteAverage: m["vote_average"].toString(),
              id: m["id"]);
        }

        print("pojo " + movie.toString());
        if (_results == null) {
          _results = List<Movie>();
        }
        _results.add(movie);
      }
    } on Exception catch (x) {
      if (x is JsonUnsupportedObjectError) {
        debugPrint('JsonUnsupportedObjectError error caught: $x');
      } else {
        debugPrint('generic while parsing error caught: $x');
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this._page;
    data['total_results'] = this._totalResults;
    data['total_pages'] = this._totalPages;
    data['_results'] = this._results;
    return data;
  }
}
