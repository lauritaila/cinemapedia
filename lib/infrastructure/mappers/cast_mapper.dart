import 'package:cinemapedia/domain/entities/cast.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_credits.dart';

class CastMapper {
  static Cast castToEntity(CastInfo cast)=> 
  Cast(
    id: cast.id, 
    name: cast.name, 
    profilePath: cast.profilePath != null ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}':'https://painrehabproducts.com/wp-content/uploads/2014/10/facebook-default-no-profile-pic.jpg', 
    character: cast.character);
}
