class Result {
  String originalTitle, posterPath, overview;
  bool fav;

  Result(
      {required this.originalTitle,
      required this.posterPath,
      required this.overview,
      this.fav = false});
}
