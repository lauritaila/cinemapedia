import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/domain/entities/cast.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';

final castByMovieProvider = StateNotifierProvider<CastByMovieNotifier, Map<String, List<Cast>>>((ref){
  return CastByMovieNotifier(getCast: ref.watch(castRepositoryProvider).getCastByMovie);
});


typedef GetCastCallback = Future<List<Cast>>Function(String movieId);


class CastByMovieNotifier extends StateNotifier<Map<String,List<Cast>>>{

  final GetCastCallback getCast;

  CastByMovieNotifier({required this.getCast}) : super({});

  Future<void> loadCast(String movieId) async {
    if(state[movieId] != null ) return;
    final List<Cast> cast = await getCast(movieId);
    state = {... state, movieId: cast};
  }


}