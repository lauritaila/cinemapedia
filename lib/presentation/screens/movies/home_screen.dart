import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);

    final slideShowMovies = ref.watch(moviesSlideshowProvider);

    // if(nowPlayingMovies.isEmpty) return const Center(child: CircularProgressIndicator(strokeWidth: 2,));

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          titleSpacing: 0,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(0),
              centerTitle: false, title: CustomAppbar()),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(childCount: 1, (context, index) {
            return Column(
              children: [
                SizedBox(height: 10),
                MoviesSlideshow(movies: slideShowMovies),
                MoviesHorizontalListview(
                  movies: nowPlayingMovies,
                  label: 'In theaters',
                  subTitle: 'Monday 20',
                  loadNextPage:() =>ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                ),
                MoviesHorizontalListview(
                  movies: upcomingMovies,
                  label: 'Soon in theaters',
                  // subTitle: '',
                  loadNextPage:() =>ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),
                MoviesHorizontalListview(
                  movies: popularMovies,
                  label: 'Popular',
                  loadNextPage:() =>ref.read(popularMoviesProvider.notifier).loadNextPage(),
                ),
                MoviesHorizontalListview(
                  movies: topRatedMovies,
                  label: 'Best rating',
                  // subTitle: 'Monday 20',
                  loadNextPage:() =>ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
                ),
                SizedBox(height: 20),
              ],
            );
          }),
        ),
      ],
    );
  }
}
