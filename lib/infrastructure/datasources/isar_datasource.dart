

import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:isar/isar.dart';

class IsarDatasource implements LocalStorageDatasource {

  late Future<Isar> _db;

  IsarDatasource(){
    _db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if(Isar.instanceNames.isEmpty){
      return await Isar.open([MovieSchema], inspector: true , directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }


  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await _db;
    final Movie? isFavoriteMovie = await isar.movies.where().filter().idEqualTo(movieId).findFirst();
    return isFavoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await _db;
    final movies = await isar.movies.where().offset(offset).limit(limit).findAll();
    return movies;
  }

  @override
  Future<bool> toggleFavorite(Movie movie) async {
    final isar = await _db;
    final favoriteMovie = await isar.movies.where().filter().idEqualTo(movie.id).findFirst();
    if(favoriteMovie != null) {
      isar.writeTxnSync(() => isar.movies.deleteSync(favoriteMovie.idIsar!));
      return false;
    } else {
      isar.writeTxnSync(() => isar.movies.putSync(movie));
      return true;
    }
  }
}