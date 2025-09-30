import 'package:cine_favorite/controllers/favorite_movie_controller.dart';
import 'package:cine_favorite/services/tmdb_service.dart';
import 'package:flutter/material.dart';

class SearchMovieView extends StatefulWidget {
  const SearchMovieView({super.key});

  @override
  State<SearchMovieView> createState() => _SearchMovieViewState();
}

class _SearchMovieViewState extends State<SearchMovieView> {
  final _favMovieController = FavoriteMovieController();
  final _searchField = TextEditingController();

  List<Map<String, dynamic>> _movies = [];

  bool _isLoading = false;

  // método para listar filmes a partir da procura
  void _searchMovies() async {
    // pegar o texto que será inserido na api
    final termo = _searchField.text.trim();
    if (termo.isEmpty) return;

    setState(() {
      _isLoading = true;
    });
    // buscar o termo na API
    try {
      final result = await TmdbService.searchMovie(termo);
      setState(() {
        _movies = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _movies = [];
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buscar filmes")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchField,
              decoration: InputDecoration(
                labelText: "Nome do filme",
                border: OutlineInputBorder(),
                suffix: IconButton(
                  onPressed: _searchMovies,
                  icon: Icon(Icons.search),
                ),
              ),
            ),
            // listar os filmes encontrados na API
            SizedBox(height: 10),
            // operador ternário
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _movies.isEmpty
                ? Text("Nenhum filme encontrado")
                : Expanded(
                    child: ListView.builder(
                      itemCount: _movies.length,
                      itemBuilder: (context, index) {
                        final movie = _movies[index];
                        return ListTile(
                          leading: Image.network(
                            "https://image.tmdb.org/t/p/w500${movie["poster_path"]}",
                            height: 50,
                          ),
                          title: Text(movie["title"]),
                          subtitle: Text(movie["release_date"]),
                          trailing: IconButton(
                            onPressed: () async {
                              _favMovieController.addFavorite(movie);
                              // mensagem
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "${movie["title"]} adicionado com sucesso",
                                  ),
                                ),
                              );
                              Navigator.pop(context); // volto para a tela de favoritos
                            },
                            icon: Icon(Icons.add),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
