import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: BorderSide.strokeAlignCenter),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(
                Icons.movie_outlined,
                color: colors.primary,
                size: 30,
              ),
              SizedBox(width: 5),
              Text(
                'Cinemapedia',
                style: textTheme.titleLarge?.copyWith(color: colors.primary), 
              ),
              Spacer(),
              IconButton(
                onPressed: () {  },
                icon: Icon(Icons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
