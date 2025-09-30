import 'dart:io';

import 'package:cine_favorite/controllers/favorite_movie_controller.dart';
import 'package:cine_favorite/models/favorite_movie.dart';
import 'package:cine_favorite/views/search_movie_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final _favMovieController = FavoriteMovieController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus filmes favoritos"),
        actions: [
          IconButton(
            onPressed: FirebaseAuth.instance.signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<FavoriteMovie>>(
        stream: _favMovieController.getFavoriteMovies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar a lista de favoritos"));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return Center(child: Text("Nenhum filme adicionado aos favoritos"));
          }
          final favoriteMovies = snapshot.data!;
          return GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final movie = favoriteMovies[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onLongPress: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Remover favorito'),
                              content: Text(
                                'Deseja remover "${movie.title}" dos favoritos?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: Text('Remover'),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            _favMovieController.removeFavoriteMovie(movie.id);
                          }
                        },
                        child: Image.file(
                          File(movie.posterPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Center(child: Text(movie.title)),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        children: [
                          Text(
                            "Nota do filme: ${movie.rating.toStringAsFixed(1)}",
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (star) {
                              return IconButton(
                                icon: Icon(
                                  star < movie.rating.round()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                ),
                                onPressed: () {
                                  _favMovieController.updateMovieRating(
                                    movie.id,
                                    star + 1.0,
                                  );
                                },
                              );
                            }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchMovieView()),
        ),
        child: Icon(Icons.search),
      ),
    );
  }
}
