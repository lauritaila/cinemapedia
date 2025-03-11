import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_movie_detail.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieDBMovie moviedb) => Movie(
    adult: moviedb.adult, 
    backdropPath: moviedb.backdropPath != '' ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}' : 'https://salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png', 
    genreIds: moviedb.genreIds.map((genreId) => genreId.toString()).toList(), 
    id: moviedb.id, 
    originalLanguage: moviedb.originalLanguage, 
    originalTitle: moviedb.originalTitle, 
    overview: moviedb.overview, 
    popularity: moviedb.popularity, 
    // posterPath: moviedb.posterPath != '' ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}' : 'https://lightwidget.com/wp-content/uploads/localhost-file-not-found.jpg', 
    posterPath: moviedb.posterPath != '' ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}' : 'no-poster', 
    releaseDate: moviedb.releaseDate, 
    title: moviedb.title, 
    video: moviedb.video, 
    voteAverage: moviedb.voteAverage, 
    voteCount: moviedb.voteCount
  );

  static Movie movieDBDetailToEntity(MovieDbMovieDetail moviedb) => Movie(
    adult: moviedb.adult, 
    backdropPath: moviedb.backdropPath != '' ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}' : 'https://salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png', 
    genreIds: moviedb.genres.map((e) => e.name).toList(), 
    id: moviedb.id, 
    originalLanguage: moviedb.originalLanguage, 
    originalTitle: moviedb.originalTitle, 
    overview: moviedb.overview, 
    popularity: moviedb.popularity, 
    posterPath: moviedb.posterPath != '' ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}' : 'https://lightwidget.com/wp-content/uploads/localhost-file-not-found.jpg', 
    // posterPath: moviedb.posterPath != '' ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}' : 'no-poster', 
    releaseDate: moviedb.releaseDate, 
    title: moviedb.title, 
    video: moviedb.video, 
    voteAverage: moviedb.voteAverage, 
    voteCount: moviedb.voteCount
  );
}