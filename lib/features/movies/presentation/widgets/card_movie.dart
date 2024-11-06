import 'package:flutter/material.dart';
import 'package:swissflix/core/utils/constants/urls.dart';
import 'package:swissflix/features/movies/data/models/movies.dart';
import 'package:swissflix/routes/router.dart';
import 'package:swissflix/styles/custom_colors.dart';
import 'package:swissflix/styles/custom_text_styles.dart';

class CardMovie extends StatefulWidget {
  final Movie movie;

  const CardMovie({
    super.key,
    required this.movie,
  });

  @override
  State<CardMovie> createState() => _CardMovieState();
}

class _CardMovieState extends State<CardMovie> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0, left: 18, right: 18),
      child: GestureDetector(
        onTap: () {
          router.go("${NamesRoustes.movie}/${widget.movie.id}");
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: CustomColors.primary,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.movie.title ?? "",
                        style: CustomTextStyle.title(Colors.black)),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  color: CustomColors.primary,
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(widget.movie.backdropPath != null
                        ? "$imgurl${widget.movie.posterPath}"
                        : " "),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
