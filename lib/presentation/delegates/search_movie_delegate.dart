import 'package:flutter/material.dart';
import 'dart:async';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovie;
  StreamController<List<Movie>> debounceMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({required this.searchMovie});

  void clearStreams() => debounceMovies.close();

  void _onQueryChange(String query){
    if(_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if(query.isEmpty){
        debounceMovies.add([]);
        return;
      }
      final movies = await searchMovie(query);
      debounceMovies.add(movies);
    });
  }

  @override
  String? get searchFieldLabel => 'Search Movie';
  @override
  TextStyle? get searchFieldStyle => const TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      FadeIn(
        animate: query.isNotEmpty,
        child: IconButton(
          onPressed: () => query = '',
          icon: Icon(Icons.clear_rounded),
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChange(query);
    return StreamBuilder(
      // future: searchMovie(query),
      stream: debounceMovies.stream,
      initialData: [],
      builder: (context, snapshot) {
        final movies = snapshot.data ?? [];
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, index) {
            final movie = movies[index];
            return ListTile(title: _MovieItem(movie: movie, onMovieSelected: (context,movie) {
              clearStreams();
              close(context, movie);
            } ));
          },
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => onMovieSelected(context, movie),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }
                    return FadeIn(child: child);
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: textStyles.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    movie.overview,
                    maxLines: 3,
                    style: textStyles.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // (movie.overview.length > 100)
                  //     ? Text('${movie.overview.substring(0, 100)}...', style: textStyles.bodySmall)
                  //     : Text(movie.overview, style: textStyles.bodySmall),
                  const SizedBox(width: 4),
                  Row(
                    children: [
                      Icon(Icons.star_half_rounded, color: Colors.yellow[800]),
                      SizedBox(width: 2),
                      Text(
                        HumanFormats.number(movie.voteAverage),
                        style: textStyles.bodySmall?.copyWith(
                          color: Colors.yellow[900],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
