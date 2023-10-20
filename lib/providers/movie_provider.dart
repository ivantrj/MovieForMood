import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_for_mood/model/movie.dart';

const apiKey = ''; // Replace with your TMDb API key

final tmdbBaseURL = Uri.parse('https://api.themoviedb.org/3');
final tmdbImageBaseURL = Uri.parse('https://image.tmdb.org/t/p/w500');

final selectedMoodProvider = StateProvider<String>((ref) => '');

final movieListProvider = FutureProvider<List<Movie>>((ref) async {
  final selectedMood = ref.watch(selectedMoodProvider.notifier).state;
  final response = await http.get(
    tmdbBaseURL.replace(
      path: '/discover/movie',
      queryParameters: {
        'api_key': apiKey,
        'with_genres': getGenreIdForMood(selectedMood), // Define this function
        'sort_by': 'popularity.desc',
      },
    ),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['results'];
    final List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
    return movies;
  } else {
    throw Exception('Failed to load movies');
  }
});

final randomMovieProvider = FutureProvider<Movie?>((ref) async {
  final selectedMood = ref.watch(selectedMoodProvider.notifier).state;
  final genreId = getGenreIdForMood(selectedMood);

  final response = await http.get(
    tmdbBaseURL.replace(
      path: '/discover/movie',
      queryParameters: {
        'api_key': apiKey,
        'with_genres': genreId.toString(),
        'sort_by': 'popularity.desc',
      },
    ),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['results'];
    if (data.isNotEmpty) {
      final movieData = data[0]; // Select the first movie from the list
      return Movie.fromMap(movieData);
    }
  }

  // If no movies were found, return null or handle the case accordingly
  return null;
});

int getGenreIdForMood(String mood) {
  // Define a mapping of moods to TMDb genre IDs here
  // Example: 'Tense' maps to the genre ID for thriller movies
  // You can find TMDb genre IDs in their documentation
  return 0;
}
