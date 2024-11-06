import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swissflix/core/utils/constants/urls.dart';
import 'package:swissflix/features/movies/data/models/movies.dart';
import 'package:swissflix/routes/router.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;

    double widthCard = kIsWeb && screenWidth > 500 ? 180 : 90;
    double heightCard = kIsWeb && screenWidth > 500 ? 300 : 150;

    return Padding(
      padding: const EdgeInsets.only(top: 28.0, left: 18, right: 18),
      child: GestureDetector(
        onTap: () {
          router.go("${NamesRoustes.movie}/${widget.movie.id}");
        },
        child: Column(
          children: [
            Container(
              width: widthCard,
              height: heightCard,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage(widget.movie.posterPath != null
                      ? "$imgurl${widget.movie.posterPath}"
                      : " "),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
