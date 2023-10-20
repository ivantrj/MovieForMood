import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_for_mood/providers/movie_provider.dart';

class MovieDetailScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMovieAsync = ref.watch(randomMovieProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Movie Details')),
      body: selectedMovieAsync.when(
        data: (selectedMovie) {
          if (selectedMovie != null) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectedMovie.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rating: ${selectedMovie.rating.toStringAsFixed(1)}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Release Date: ${selectedMovie.releaseDate}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  // const Text(
                  //   'Description:',
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  // Text(
                  //   selectedMovie.overview,
                  //   style: const TextStyle(fontSize: 16),
                  // ),
                  const SizedBox(height: 16),
                  // Display the movie poster
                  Image.network(
                    'https://image.tmdb.org/t/p/w500${selectedMovie.posterPath}',
                  ),
                ],
              ),
            );
          } else {
            // Handle the case when no movie is found
            return const Center(
              child: Text('No movie found for this mood.'),
            );
          }
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) {
          // Handle error case
          return Center(
            child: Text('Error: $error'),
          );
        },
      ),
    );
  }
}
