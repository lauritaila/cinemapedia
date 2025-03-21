import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/local_storage_repository.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMovieProvider = StateNotifierProvider<FavoriteMoviesNotifier, Map<int,Movie>>((ref) {

  final localStorageRepository = ref.watch(localStorageRepositoryProvider);
  return FavoriteMoviesNotifier(localStorageRespository: localStorageRepository);
  
});

class FavoriteMoviesNotifier extends StateNotifier<Map<int,Movie>> {
  int page = 0;
  final LocalStorageRespository localStorageRespository;
  FavoriteMoviesNotifier({required this.localStorageRespository}) : super({});

  Future<void> loadNextPage() async {
    final movies = await localStorageRespository.loadMovies(limit: 10, offset: page * 10); //TODO: LIMIT 20
    page++;
    final Map<int,Movie> tempMovies = {};
    for (final movie in movies) {
      tempMovies[movie.id] = movie;
    }
    state = {...state,...tempMovies};
  }

}