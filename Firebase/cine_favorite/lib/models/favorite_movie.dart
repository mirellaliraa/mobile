// classe de modelagem de dados para Movies

class FavoriteMovie {
  //atributos
  final int id; // Id do TMDB
  final String title; // título do filme no TMDB
  final String posterPath;
  double rating; // nota que o usuário do APP dará para o filme

  // constructor
  FavoriteMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    this.rating = 0,
  });

  // métodos de conversão de OBJ <=> Json

  // toMap
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "posterPath": posterPath,
      "rating": rating,
    };
  }

  // fromMap
  factory FavoriteMovie.fromMap(Map<String, dynamic> map) {
    return FavoriteMovie(
      id: map["id"],
      title: map["title"],
      posterPath: map["posterPath"],
      rating: (map["rating"] as num?)?.toDouble() ?? 0,
    );
  }
}
