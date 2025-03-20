import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary, size: 30),
              SizedBox(width: 5),
              Text(
                'Cinemapedia',
                style: textTheme.titleLarge?.copyWith(color: colors.primary),
              ),
              Spacer(),
              IconButton(
                onPressed: () {

                  final searchedMovies = ref.read(searchMoviesProvider);
                  final searchQueryRepository = ref.read(searchQueryProvider);

                  showSearch<Movie?>(
                    query: searchQueryRepository ,
                    context: context,
                    delegate: SearchMovieDelegate(
                      initialMovies: searchedMovies,
                      searchMovie: ref.read(searchMoviesProvider.notifier).searchMoviesByQuery,
                    ),
                  ).then((movie) {
                    if (movie == null) return;
                    if (context.mounted) {
                      GoRouter.of(context).push('/home/0/movie/${movie.id}');
                    }
                  });
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
