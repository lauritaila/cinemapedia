

import 'package:cinemapedia/domain/datasources/cast_datasource.dart';
import 'package:cinemapedia/domain/entities/cast.dart';
import 'package:cinemapedia/domain/repositories/cast_repository.dart';

class CastRespositoryImpl extends CastRepository{
    final CastDatasource datasource;

  CastRespositoryImpl(this.datasource);


  @override
  Future<List<Cast>> getCastByMovie(String movieId) {
    return datasource.getCastByMovie(movieId);
  }

}