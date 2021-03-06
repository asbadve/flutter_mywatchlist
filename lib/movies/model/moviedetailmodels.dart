import 'dart:convert';

import 'package:flutter/material.dart';

class MovieDetail {
  bool adult;
  String backdropPath;
  BelongsToCollection belongsToCollection;
  int budget;
  List<Genres> genres;
  String homepage;
  int id;
  String imdbId;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  List<ProductionCompanies> productionCompanies;
  List<ProductionCountries> productionCountries;
  String releaseDate;
  int revenue;
  int runtime;
  List<SpokenLanguages> spokenLanguages;
  String status;
  String tagline;
  String title;
  bool video;
  double voteAverage;
  int voteCount;
  Videos videos;
  Images images;
  Credits credits;
  Keywords keywords;

  MovieDetail(
      {this.adult,
        this.backdropPath,
        this.belongsToCollection,
        this.budget,
        this.genres,
        this.homepage,
        this.id,
        this.imdbId,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.productionCompanies,
        this.productionCountries,
        this.releaseDate,
        this.revenue,
        this.runtime,
        this.spokenLanguages,
        this.status,
        this.tagline,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
        this.videos,
        this.images,
        this.credits,
        this.keywords});

  MovieDetail.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    belongsToCollection =
    json['belongs_to_collection'] != null ? new BelongsToCollection.fromJson(json['belongs_to_collection']) : null;
    budget = json['budget'];
    if (json['genres'] != null) {
      genres = new List<Genres>();
      json['genres'].forEach((v) {
        genres.add(new Genres.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    if (json['production_companies'] != null) {
      productionCompanies = new List<ProductionCompanies>();
      json['production_companies'].forEach((v) {
        productionCompanies.add(new ProductionCompanies.fromJson(v));
      });
    }
    if (json['production_countries'] != null) {
      productionCountries = new List<ProductionCountries>();
      json['production_countries'].forEach((v) {
        productionCountries.add(new ProductionCountries.fromJson(v));
      });
    }
    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    if (json['spoken_languages'] != null) {
      spokenLanguages = new List<SpokenLanguages>();
      json['spoken_languages'].forEach((v) {
        spokenLanguages.add(new SpokenLanguages.fromJson(v));
      });
    }
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    videos =
    json['videos'] != null ? new Videos.fromJson(json['videos']) : null;
    images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
    credits =
    json['credits'] != null ? new Credits.fromJson(json['credits']) : null;
    keywords = json['keywords'] != null
        ? new Keywords.fromJson(json['keywords'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['belongs_to_collection'] = this.belongsToCollection;
    data['budget'] = this.budget;
    if (this.genres != null) {
      data['genres'] = this.genres.map((v) => v.toJson()).toList();
    }
    data['homepage'] = this.homepage;
    data['id'] = this.id;
    data['imdb_id'] = this.imdbId;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    if (this.productionCompanies != null) {
      data['production_companies'] =
          this.productionCompanies.map((v) => v.toJson()).toList();
    }
    if (this.productionCountries != null) {
      data['production_countries'] =
          this.productionCountries.map((v) => v.toJson()).toList();
    }
    data['release_date'] = this.releaseDate;
    data['revenue'] = this.revenue;
    data['runtime'] = this.runtime;
    if (this.spokenLanguages != null) {
      data['spoken_languages'] =
          this.spokenLanguages.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['tagline'] = this.tagline;
    data['title'] = this.title;
    data['video'] = this.video;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    if (this.videos != null) {
      data['videos'] = this.videos.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images.toJson();
    }
    if (this.credits != null) {
      data['credits'] = this.credits.toJson();
    }
    if (this.keywords != null) {
      data['keywords'] = this.keywords.toJson();
    }
    return data;
  }
}

class BelongsToCollection {
  int id;
  String name;
  String posterPath;
  String backdropPath;

  BelongsToCollection({this.id, this.name, this.posterPath, this.backdropPath});

  BelongsToCollection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['poster_path'] = this.posterPath;
    data['backdrop_path'] = this.backdropPath;
    return data;
  }
}


class Genres {
  int id;
  String name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ProductionCompanies {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo_path'] = this.logoPath;
    data['name'] = this.name;
    data['origin_country'] = this.originCountry;
    return data;
  }
}

class ProductionCountries {
  String iso31661;
  String name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_3166_1'] = this.iso31661;
    data['name'] = this.name;
    return data;
  }
}

class SpokenLanguages {
  String iso6391;
  String name;

  SpokenLanguages({this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_639_1'] = this.iso6391;
    data['name'] = this.name;
    return data;
  }
}

class Videos {
  List<Results> results;

  Videos({this.results});

  Videos.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String id;
  String iso6391;
  String iso31661;
  String key;
  String name;
  String site;
  int size;
  String type;

  Results(
      {this.id,
        this.iso6391,
        this.iso31661,
        this.key,
        this.name,
        this.site,
        this.size,
        this.type});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    key = json['key'];
    name = json['name'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['iso_639_1'] = this.iso6391;
    data['iso_3166_1'] = this.iso31661;
    data['key'] = this.key;
    data['name'] = this.name;
    data['site'] = this.site;
    data['size'] = this.size;
    data['type'] = this.type;
    return data;
  }
}

class Images {
  List<Backdrops> backdrops;
  List<Posters> posters;

  Images({this.backdrops, this.posters});

  Images.fromJson(Map<String, dynamic> json) {
    if (json['backdrops'] != null) {
      backdrops = new List<Backdrops>();
      json['backdrops'].forEach((v) {
        backdrops.add(new Backdrops.fromJson(v));
      });
    }
    if (json['posters'] != null) {
      posters = new List<Posters>();
      json['posters'].forEach((v) {
        posters.add(new Posters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.backdrops != null) {
      data['backdrops'] = this.backdrops.map((v) => v.toJson()).toList();
    }
    if (this.posters != null) {
      data['posters'] = this.posters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Posters {
  double aspectRatio;
  String filePath;
  int height;
  String iso6391;
  double voteAverage;
  int voteCount;
  int width;

  Posters(
      {this.aspectRatio,
        this.filePath,
        this.height,
        this.iso6391,
        this.voteAverage,
        this.voteCount,
        this.width});

  Posters.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    filePath = json['file_path'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aspect_ratio'] = this.aspectRatio;
    data['file_path'] = this.filePath;
    data['height'] = this.height;
    data['iso_639_1'] = this.iso6391;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['width'] = this.width;
    return data;
  }
}


class Backdrops {
  double aspectRatio;
  String filePath;
  int height;
  String iso6391;
  double voteAverage;
  int voteCount;
  int width;

  Backdrops(
      {this.aspectRatio,
        this.filePath,
        this.height,
        this.iso6391,
        this.voteAverage,
        this.voteCount,
        this.width});

  Backdrops.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'];
    filePath = json['file_path'];
    height = json['height'];
    iso6391 = json['iso_639_1'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aspect_ratio'] = this.aspectRatio;
    data['file_path'] = this.filePath;
    data['height'] = this.height;
    data['iso_639_1'] = this.iso6391;
    data['vote_average'] = this.voteAverage;
    data['vote_count'] = this.voteCount;
    data['width'] = this.width;
    return data;
  }
}

class Credits {
  List<Cast> cast;
  List<Crew> crew;

  Credits({this.cast, this.crew});

  Credits.fromJson(Map<String, dynamic> json) {
    if (json['cast'] != null) {
      cast = new List<Cast>();
      json['cast'].forEach((v) {
        cast.add(new Cast.fromJson(v));
      });
    }
    if (json['crew'] != null) {
      crew = new List<Crew>();
      json['crew'].forEach((v) {
        crew.add(new Crew.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cast != null) {
      data['cast'] = this.cast.map((v) => v.toJson()).toList();
    }
    if (this.crew != null) {
      data['crew'] = this.crew.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cast {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Cast(
      {this.castId,
        this.character,
        this.creditId,
        this.gender,
        this.id,
        this.name,
        this.order,
        this.profilePath});

  Cast.fromJson(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cast_id'] = this.castId;
    data['character'] = this.character;
    data['credit_id'] = this.creditId;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['name'] = this.name;
    data['order'] = this.order;
    data['profile_path'] = this.profilePath;
    return data;
  }
}

class Crew {
  String creditId;
  String department;
  int gender;
  int id;
  String job;
  String name;
  String profilePath;

  Crew(
      {this.creditId,
        this.department,
        this.gender,
        this.id,
        this.job,
        this.name,
        this.profilePath});

  Crew.fromJson(Map<String, dynamic> json) {
    creditId = json['credit_id'];
    department = json['department'];
    gender = json['gender'];
    id = json['id'];
    job = json['job'];
    name = json['name'];
    profilePath = json['profile_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['credit_id'] = this.creditId;
    data['department'] = this.department;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['job'] = this.job;
    data['name'] = this.name;
    data['profile_path'] = this.profilePath;
    return data;
  }
}

class Keywords {
  List<Keywords> keywords;

  Keywords({this.keywords});

  Keywords.fromJson(Map<String, dynamic> json) {
    if (json['keywords'] != null) {
      keywords = new List<Keywords>();
      json['keywords'].forEach((v) {
        keywords.add(new Keywords.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.keywords != null) {
      data['keywords'] = this.keywords.map((v) => v.toJson()).toList();
    }
    return data;
  }
}