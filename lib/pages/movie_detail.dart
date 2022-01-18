import 'package:flutter/material.dart';

import '../movie.dart';

class MovieDetail extends StatefulWidget {
  Movie movie;
  MovieDetail({required this.movie, Key? key}) : super(key: key);
  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MovieDetails'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          return false;
        },
        child: Material(
          child: SafeArea(
            child: Column(
              children: [
                Hero(
                    tag: "heroAnimation",
                    child: Image.network(widget.movie.poster)),
                const SizedBox(
                  height: 8.0,
                ),
                Center(
                    child: Text(widget.movie.title,
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
