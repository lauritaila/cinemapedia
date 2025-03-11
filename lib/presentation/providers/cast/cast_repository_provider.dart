
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/infrastructure/datasources/moviedb_cast_datasources.dart';
import 'package:cinemapedia/infrastructure/repositories/cast_repository_impl.dart';

final castRepositoryProvider = Provider((ref) {
  return CastRespositoryImpl(CastMovieDBDatasources());
});