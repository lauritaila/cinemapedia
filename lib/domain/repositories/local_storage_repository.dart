import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageRespository {

  Future<bool> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
  
}