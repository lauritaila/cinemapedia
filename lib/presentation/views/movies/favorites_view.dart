import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {

  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() async {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if(isLoading || isLastPage) return;
    isLoading = true;
    final movies = await ref.read(favoriteMovieProvider.notifier).loadNextPage();
    isLoading = false;
    if(movies.isEmpty) isLastPage = true;
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> movies = ref.watch(favoriteMovieProvider).values.toList();

    return Scaffold(
      body: MovieMasonry(movies: movies , loadNextPage: loadNextPage),
      );
  }
}