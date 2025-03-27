import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/presentation/providers/providers.dart';



class CastByMovie extends ConsumerWidget {

  final String movieId;

  const CastByMovie({
    super.key, 
    required this.movieId
  });

  @override
  Widget build(BuildContext context, ref) {

    final actorsByMovie = ref.watch( castByMovieProvider );

    //* Loading actors
    if ( actorsByMovie[movieId] == null ) {
      return Container(
        height: 100,
        margin: const EdgeInsets.only(bottom: 50),
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2)
        ),
      );
    }
    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 270,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return Container(
            padding: const EdgeInsets.all(8.0),
            width: 135,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Actor Photo
                FadeInRight(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            actor.profilePath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                );
              }
              return child;
            },
          ))
                  ),
                ),

                // Nombre
                const SizedBox(height: 5,),

                Text(actor.name, maxLines: 2 ),
                Text(actor.character ?? '', 
                  maxLines: 2,
                  style: const TextStyle( fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis ),
              ),

              ],
            ),
          );


        },
      ),
    );

  }
}