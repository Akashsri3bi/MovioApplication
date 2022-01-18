import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies/pages/movie_detail.dart';
import 'package:movies/pages/movie_list.dart';
import 'package:provider/provider.dart';

import '../auth_service.dart';
import '../movie.dart';
import '../webservice.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Use this controller to get what user is typing
  final _textController = TextEditingController();
  String userInput = "";
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies("batman");
  }

  void _loadMovies(String key) async {
    final results = await Webservice().loadGeneral(key);
    setState(() {
      movies = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color secondaryColor = Color(0xff232c51);
    final authService = Provider.of<AuthService>(context);
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: secondaryColor,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: Text("Movio",
                        style: GoogleFonts.pacifico(
                            fontWeight: FontWeight.bold,
                            fontSize: 26.0,
                            color: Colors.white))),
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Home"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.refresh),
                  title: const Text("Refresh"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: secondaryColor,
                statusBarBrightness: Brightness.light),
            elevation: 0.0,
            backgroundColor: secondaryColor,
            title: Text(
              'Movio',
              style: GoogleFonts.pacifico(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                  color: Colors.white),
            ),
            actions: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () async {
                      await authService.signOut();
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.logout,
                      color: Colors.white,
                      size: 26.0,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 8.0,
                ),
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                      fillColor: Colors.grey,
                      filled: true,
                      hintText: "What's on your mind",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _textController.clear();
                          },
                          icon: const Icon(Icons.clear))),
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      userInput = _textController.text;
                    });

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MovieList(keyValue: userInput)));
                  },
                  color: Colors.blue,
                  child: const Text('Search',
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: movies.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetail(movie: movies[index])));
                        },
                        child: Expanded(
                          child: Column(
                            children: [
                              Hero(
                                  tag: "heroAnimation",
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Image.network(
                                      movies[index].poster,
                                      fit: BoxFit.fill,
                                    ),
                                  )),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text(movies[index].title,
                                  style: GoogleFonts.pacifico(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
