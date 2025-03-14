import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchMoviesProvider = StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref) {
  return SearchMoviesNotifier(ref, searchMovies: ref.watch(movieRepositoryProvider).getSearchMovies);
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMoviesNotifier extends StateNotifier<List<Movie>>{
  final SearchMoviesCallback searchMovies;
  final Ref _ref;

  SearchMoviesNotifier(this._ref, {required this.searchMovies}) : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    _ref.read(searchQueryProvider.notifier).update((state) => query);
    state = movies;
    return movies;
  } 
}