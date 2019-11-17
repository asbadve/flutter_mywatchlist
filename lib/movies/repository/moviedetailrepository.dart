import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mywatchlist/movies/model/MovieResult.dart';
import 'package:flutter_mywatchlist/movies/model/moviedetailmodels.dart';

import '../../tmdb_api.dart';

class MovieDetailRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<MovieDetail> fetchMovieDetails(String movieId) async {
    Map<String, String> map = {
      "append_to_response": "videos,images,credits,keywords,recommendations"
    };
    final response = await _helper.getFromPath("movie/$movieId", map);
    var movieDetail = MovieDetail();
    try {
      movieDetail = MovieDetail.fromJson(response);
    } on Exception catch (x) {
      if (x is JsonUnsupportedObjectError) {
        debugPrint('JsonUnsupportedObjectError error caught: $x');
      } else {
        debugPrint('generic while parsing error caught: $x');
      }
    }
    return movieDetail;
  }

  Future<MovieResult> fetchMediaPagingDetails(
      int pageNo, String movieType, String mediaType) async {
    var url = await getUrlBy(movieType, mediaType);
    Map<String, String> map = {"page": pageNo.toString()};
    var data = await _helper.getFromPath(url, map);
    var movieResult = MovieResult();
    try {
      movieResult = MovieResult.fromJson(data, mediaType);
    } on Exception catch (x) {
      if (x is JsonUnsupportedObjectError) {
        debugPrint('JsonUnsupportedObjectError error caught: $x');
      } else {
        debugPrint('generic while parsing error caught: $x');
      }
    }
    return movieResult;
  }

  Future<String> getUrlBy(String movieType, String mediaType) async {
    var url = mediaType + "/$movieType";
    return url;
  }
}
