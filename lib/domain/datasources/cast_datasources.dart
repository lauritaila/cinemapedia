import 'package:cinemapedia/domain/entities/cast.dart';

abstract class CastDatasources{
  Future<List<Cast>> getCastByMovie(String movieId);
}