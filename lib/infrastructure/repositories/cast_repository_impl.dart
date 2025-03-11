

import 'package:cinemapedia/domain/datasources/cast_datasources.dart';
import 'package:cinemapedia/domain/entities/cast.dart';
import 'package:cinemapedia/domain/repositories/cast_repository.dart';

class CastRespositoryImpl extends CastRepository{
    final CastDatasources datasource;

  CastRespositoryImpl(this.datasource);


  @override
  Future<List<Cast>> getCastByMovie(String movieId) {
    return datasource.getCastByMovie(movieId);
  }

}