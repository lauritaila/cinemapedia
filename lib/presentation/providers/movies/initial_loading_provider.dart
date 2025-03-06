import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final upcomingMovies = ref.watch(upcomingMoviesProvider).isEmpty;
  final topRatedMovies = ref.watch(topRatedMoviesProvider).isEmpty;
  final popularMovies = ref.watch(popularMoviesProvider).isEmpty;

  if(nowPlayingMovies || upcomingMovies || topRatedMovies || popularMovies) return true;

  return false;
});