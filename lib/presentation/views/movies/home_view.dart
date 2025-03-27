import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> with AutomaticKeepAliveClientMixin {
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
    super.build(context);

    final initialLoading = ref.watch(initialLoadingProvider);
    if(initialLoading) return FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    final slideShowMovies = ref.watch(moviesSlideshowProvider);

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
                MovieHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'In theaters',
                  subTitle: 'Monday 20',
                  loadNextPage:() =>ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: upcomingMovies,
                  title: 'Soon in theaters',
                  // subTitle: '',
                  loadNextPage:() =>ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListview(
                  movies: topRatedMovies,
                  title: 'Best rating',
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

  @override
  bool get wantKeepAlive => true;
}
