import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

class MoviesHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? label;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MoviesHorizontalListview(
      {super.key,
      required this.movies,
      this.label,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MoviesHorizontalListview> createState() => _MoviesHorizontalListviewState();
}

class _MoviesHorizontalListviewState extends State<MoviesHorizontalListview> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener((){
      if(widget.loadNextPage == null) return;
      if(scrollController.position.pixels+200 >= scrollController.position.maxScrollExtent){
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 370,
      child: Column(
        children: [
          if (widget.label != null || widget.subTitle != null)
          _Title(title: widget.label, subTitle: widget.subTitle),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));
              },
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(movie.posterPath, fit: BoxFit.cover, width: 150, loadingBuilder: (context, child, loadingProgress) {
                if(loadingProgress != null){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  );
                }
                return FadeIn(child: child);
              },),
            ),
          ),

          SizedBox(height: 10,),

          SizedBox(
            width: 150,
            child: Text(movie.title, maxLines: 2,style:textStyle.titleSmall),
          ),

          SizedBox(height: 5),

          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_rounded, color: Colors.amber[700]),
                SizedBox(width: 3),
                Text('${movie.voteAverage}', style: textStyle.bodyMedium?.copyWith(color: Colors.amber[700])),
                SizedBox(width: 10),
                // Spacer(),
                Icon(Icons.star_rate_rounded , color: Colors.black),
                SizedBox(width: 3),
                Text(HumanFormats.number(movie.popularity), style: textStyle.bodySmall,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: textStyle.titleLarge),
          Spacer(),
          if (subTitle != null)
            FilledButton(
                onPressed: () {},
                style: const ButtonStyle(
                  visualDensity: VisualDensity.compact,
                ),
                child: Text(subTitle!))
        ],
      ),
    );
  }
}
