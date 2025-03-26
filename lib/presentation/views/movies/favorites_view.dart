import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:go_router/go_router.dart';

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
    if (isLoading || isLastPage) return;
    isLoading = true;
    final movies =
        await ref.read(favoriteMovieProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) isLastPage = true;
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> movies = ref.watch(favoriteMovieProvider).values.toList();

    if (movies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_rounded,
              color: colors.primary,
              size: 60,
            ),
            SizedBox(height: 2),
            Text( 'Ohhh no!! ',style: TextStyle(color: colors.primary, fontSize: 30)),
            SizedBox(height: 3),
            Text( 'You don\'t have favorite movies ',style: TextStyle(color: Colors.black45, fontSize: 20)),
            SizedBox(height: 20),
            FilledButton.tonal(onPressed: ()=> context.go('home/0/'), child: const Text('Go to Home'))
          ],
        ),
      );
    }

    return Scaffold(
      body: MovieMasonry(movies: movies, loadNextPage: loadNextPage),
    );
  }
}
