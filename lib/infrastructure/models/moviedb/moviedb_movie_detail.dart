class MovieDbMovieDetail {
  final bool adult;
  final String backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final DateTime releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDbMovieDetail({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDbMovieDetail.fromJson(
    Map<String, dynamic> json,
  ) => MovieDbMovieDetail(
    adult: json["adult"] ?? false,
    backdropPath: json["backdrop_path"] ?? "", // Asegurar que sea String
    belongsToCollection:
        json["belongs_to_collection"] != null
            ? BelongsToCollection.fromJson(json["belongs_to_collection"])
            : null,
    budget: json["budget"] ?? 0,
    genres:
        json["genres"] != null
            ? List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x)))
            : [],
    homepage: json["homepage"] ?? "",
    id: json["id"] ?? 0,
    imdbId: json["imdb_id"] ?? "",
    originCountry:
        json["origin_country"] != null
            ? List<String>.from(json["origin_country"].map((x) => x.toString()))
            : [],
    originalLanguage: json["original_language"] ?? "",
    originalTitle: json["original_title"] ?? "",
    overview: json["overview"] ?? "",
    popularity: (json["popularity"] ?? 0).toDouble(),
    posterPath: json["poster_path"] ?? "",
    productionCompanies:
        json["production_companies"] != null
            ? List<ProductionCompany>.from(
              json["production_companies"].map(
                (x) => ProductionCompany.fromJson(x),
              ),
            )
            : [],
    productionCountries:
        json["production_countries"] != null
            ? List<ProductionCountry>.from(
              json["production_countries"].map(
                (x) => ProductionCountry.fromJson(x),
              ),
            )
            : [],
    releaseDate:
        json["release_date"] != null &&
                json["release_date"].toString().isNotEmpty
            ? DateTime.tryParse(json["release_date"]) ?? DateTime(2000, 1, 1)
            : DateTime(2000, 1, 1),
    revenue: json["revenue"] ?? 0,
    runtime: json["runtime"] ?? 0,
    spokenLanguages:
        json["spoken_languages"] != null
            ? List<SpokenLanguage>.from(
              json["spoken_languages"].map((x) => SpokenLanguage.fromJson(x)),
            )
            : [],
    status: json["status"] ?? "",
    tagline: json["tagline"] ?? "",
    title: json["title"] ?? "",
    video: json["video"] ?? false,
    voteAverage: (json["vote_average"] ?? 0).toDouble(),
    voteCount: json["vote_count"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "belongs_to_collection": '',
    "budget": budget,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "homepage": homepage,
    "id": id,
    "imdb_id": imdbId,
    "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies": List<dynamic>.from(
      productionCompanies.map((x) => x.toJson()),
    ),
    "production_countries": List<dynamic>.from(
      productionCountries.map((x) => x.toJson()),
    ),
    "release_date":
        "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "revenue": revenue,
    "runtime": runtime,
    "spoken_languages": List<dynamic>.from(
      spokenLanguages.map((x) => x.toJson()),
    ),
    "status": status,
    "tagline": tagline,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}

class BelongsToCollection {
    final int id;
    final String name;
    final String? posterPath;  // <- Ahora permite valores nulos
    final String? backdropPath; // <- Ahora permite valores nulos

    BelongsToCollection({
        required this.id,
        required this.name,
        this.posterPath,  // <- Opcional
        this.backdropPath, // <- Opcional
    });

    factory BelongsToCollection.fromJson(Map<String, dynamic> json) => BelongsToCollection(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        posterPath: json["poster_path"] ?? "",  // <- Si es null, asigna ""
        backdropPath: json["backdrop_path"] ?? "", // <- Si es null, asigna ""
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "poster_path": posterPath ?? "",  // <- Evitar null al convertir a JSON
        "backdrop_path": backdropPath ?? "", // <- Evitar null al convertir a JSON
    };
}



class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json["id"], name: json["name"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}

class ProductionCompany {
    final int id;
    final String? logoPath; // <- Ahora permite null
    final String name;
    final String originCountry;

    ProductionCompany({
        required this.id,
        this.logoPath,  // <- Opcional
        required this.name,
        required this.originCountry,
    });

    factory ProductionCompany.fromJson(Map<String, dynamic> json) => ProductionCompany(
        id: json["id"] ?? 0,
        logoPath: json["logo_path"] ?? "",  // <- Puede ser null
        name: json["name"] ?? "",
        originCountry: json["origin_country"] ?? "",
    );

  Map<String, dynamic> toJson() => {
    "id": id,
    "logo_path": logoPath ?? "",
    "name": name,
    "origin_country": originCountry,
  };
}

class ProductionCountry {
  final String iso31661;
  final String name;

  ProductionCountry({required this.iso31661, required this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(iso31661: json["iso_3166_1"], name: json["name"]);

  Map<String, dynamic> toJson() => {"iso_3166_1": iso31661, "name": name};
}

class SpokenLanguage {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    englishName: json["english_name"],
    iso6391: json["iso_639_1"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "english_name": englishName,
    "iso_639_1": iso6391,
    "name": name,
  };
}
