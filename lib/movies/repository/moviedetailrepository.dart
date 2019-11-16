import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_mywatchlist/movies/model/moviedetailmodels.dart';

import '../../tmdb_api.dart';

class MovieDetailRepository {
  final String _apiKey = "b7cd3340a794e5a2f35e3abb820b497f";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<MovieDetail> fetchMovieDetails(String movieId) async {
    final response = await _helper.get(
        "movie/$movieId?api_key=$_apiKey&append_to_response=videos,images,credits,keywords,recommendations");
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
}
