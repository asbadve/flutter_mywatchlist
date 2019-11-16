import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MovieEvent extends Equatable {
  MovieEvent([List props = const []]) : super(props);
}

class GetPopularMovies extends MovieEvent {
  final String movieType;
  final String mediaType;

  GetPopularMovies(this.movieType, this.mediaType) : super([movieType,mediaType]);
}
