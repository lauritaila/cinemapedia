import 'package:flutter/material.dart';

class MovieRating extends StatelessWidget {

  final double voteAverage; 


  const MovieRating({
    super.key,
    required this.voteAverage
  });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return SizedBox(
      width: 150,
      child: Row(
        children: [
          Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
          const SizedBox(width: 3),
          Text('${(voteAverage * 10).toStringAsFixed(1)}%',
              style: textStyles.bodyMedium
                  ?.copyWith(color: Colors.yellow.shade800)),
          
        ],
      ),
    );
  }
}

              // Icon(Icons.star_half_rounded, color: Colors.amber[700]),
              // const SizedBox(width: 2),
              // Text(
              //   '${(movie.voteAverage * 10).toStringAsFixed(1)}%',
              //   style: textStyle.bodyMedium?.copyWith(color: Colors.amber[700]),
              // ),
              // const SizedBox(width: 10),
              // Icon(Icons.star_rate_rounded, color: Colors.black),
              // const SizedBox(width: 2),
              // Text(
              //   HumanFormats.number(movie.popularity),
              //   style: textStyle.bodySmall,
              // )