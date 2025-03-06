import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  return MoviesNotifier(fetchMoreMovies: ref.watch(movieRepositoryProvider).getNowPlaying);
});
final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  return MoviesNotifier(fetchMoreMovies: ref.watch(movieRepositoryProvider).getPopular);
});
final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  return MoviesNotifier(fetchMoreMovies: ref.watch(movieRepositoryProvider).getTopRated);
});
final upcomingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  return MoviesNotifier(fetchMoreMovies: ref.watch(movieRepositoryProvider).getUpcoming);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if(isLoading) return;
    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    print(movies.length);
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
    state = [...state, ...movies];
  }

}