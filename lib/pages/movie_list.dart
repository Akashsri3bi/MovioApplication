import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../movie.dart';
import '../webservice.dart';
import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  final String keyValue;

  const MovieList({required this.keyValue, Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<Movie> _movies = [];
  @override
  void initState() {
    super.initState();
    _loadMovies(widget.keyValue);
  }

  void _loadMovies(String key) async {
    final results = await Webservice().loadMovies(key);
    setState(() {
      _movies = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xff18203d);
    return Material(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            backgroundColor: primaryColor,
            title: Text(
              "Details",
              style: GoogleFonts.pacifico(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                  color: Colors.white),
            )),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.of(context).pop();
            return false;
          },
          child: Material(
            color: primaryColor,
            child: Hero(
              tag: 'heroAnimation',
              child: SafeArea(
                child: _movies.isEmpty
                    ? const Center(
                        child: Text(
                          "Nothing to Show",
                          style: TextStyle(color: Colors.red, fontSize: 24.0),
                        ),
                      )
                    : ListView.separated(
                        itemCount: _movies.length,
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 0.5,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image.network(_movies[index].poster),
                              title: Text(
                                _movies[index].title,
                                style: const TextStyle(color: Colors.white),
                              ),
                              onTap: () => {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        MovieDetail(movie: _movies[index]))),
                              },
                            ),
                          );
                        }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
