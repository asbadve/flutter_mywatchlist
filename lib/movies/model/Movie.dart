class Movie {
  int _voteCount;
  int _id;
  bool _video;
  String _voteAverage = "0";
  String _title;
  String _popularity;
  String _posterPath;
  String _originalLanguage;
  String _originalTitle;
  List<int> _genreIds;
  String _backdropPath;
  bool _adult;
  String _overview;
  String _releaseDate;
  bool _isLoaderView = false;

  Movie(
      {int voteCount,
      int id,
      bool video,
      String voteAverage,
      String title,
      String popularity,
      String posterPath,
      String originalLanguage,
      String originalTitle,
      List<int> genreIds,
      String backdropPath,
      bool adult,
      String overview,
      String releaseDate,
      bool isLoaderView}) {
    this._voteCount = voteCount;
    this._id = id;
    this._video = video;
    this._voteAverage = voteAverage;
    this._title = title;
    this._popularity = popularity;
    this._posterPath = posterPath;
    this._originalLanguage = originalLanguage;
    this._originalTitle = originalTitle;
    this._genreIds = genreIds;
    this._backdropPath = backdropPath;
    this._adult = adult;
    this._overview = overview;
    this._releaseDate = releaseDate;
    this._isLoaderView = isLoaderView;
  }

  bool get isLoaderView => _isLoaderView;

  set loaderView(bool isLoaderView) => _isLoaderView = isLoaderView;

  int get voteCount => _voteCount;

  set voteCount(int voteCount) => _voteCount = voteCount;

  int get id => _id;

  set id(int id) => _id = id;

  bool get video => _video;

  set video(bool video) => _video = video;

  String get voteAverage => _voteAverage;

  set voteAverage(String voteAverage) => _voteAverage = voteAverage;

  String get title => _title;

  set title(String title) => _title = title;

  String get popularity => _popularity;

  set popularity(String popularity) => _popularity = popularity;

  String get posterPath => _posterPath;

  set posterPath(String posterPath) => _posterPath = posterPath;

  String get originalLanguage => _originalLanguage;

  set originalLanguage(String originalLanguage) =>
      _originalLanguage = originalLanguage;

  String get originalTitle => _originalTitle;

  set originalTitle(String originalTitle) => _originalTitle = originalTitle;

  List<int> get genreIds => _genreIds;

  set genreIds(List<int> genreIds) => _genreIds = genreIds;

  String get backdropPath => _backdropPath;

  set backdropPath(String backdropPath) => _backdropPath = backdropPath;

  bool get adult => _adult;

  set adult(bool adult) => _adult = adult;

  String get overview => _overview;

  set overview(String overview) => _overview = overview;

  String get releaseDate => _releaseDate;

  set releaseDate(String releaseDate) => _releaseDate = releaseDate;

  Movie.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _voteCount = json['vote_count'];
    _video = json['video'];
    _voteAverage = json['vote_average'];
    _title = json['title'];
    _popularity = json['popularity'];
    _posterPath = json['poster_path'];
    _originalLanguage = json['original_language'];
    _originalTitle = json['original_title'];
    _genreIds = json['genre_ids'].cast<int>();
    _backdropPath = json['backdrop_path'];
    _adult = json['adult'];
    _overview = json['overview'];
    _releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vote_count'] = this._voteCount;
    data['id'] = this._id;
    data['video'] = this._video;
    data['vote_average'] = this._voteAverage;
    data['title'] = this._title;
    data['popularity'] = this._popularity;
    data['poster_path'] = this._posterPath;
    data['original_language'] = this._originalLanguage;
    data['original_title'] = this._originalTitle;
    data['genre_ids'] = this._genreIds;
    data['backdrop_path'] = this._backdropPath;
    data['adult'] = this._adult;
    data['overview'] = this._overview;
    data['release_date'] = this._releaseDate;
    return data;
  }
}
