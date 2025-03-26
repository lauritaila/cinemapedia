import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/cast_datasource.dart';
import 'package:cinemapedia/domain/entities/cast.dart';
import 'package:cinemapedia/infrastructure/mappers/cast_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_credits.dart';
import 'package:dio/dio.dart';

class CastMovieDBDatasources extends CastDatasource{

    final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDBApiKey,
    }
  ));


  @override
  Future<List<Cast>> getCastByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');
    if(response.statusCode != 200) throw Exception('Movie with id:$movieId not found');
    final movieDbResponse = CreditsResponse.fromJson(response.data);
    List<Cast> cast =  movieDbResponse.cast.map((cast)=> CastMapper.castToEntity(cast)).toList();
    return cast;
  }

}