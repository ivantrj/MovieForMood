import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_for_mood/providers/movie_provider.dart';
import 'package:movie_for_mood/screens/movie_details.dart';
import 'package:movie_for_mood/screens/widgets/mood_option.dart';

class MoodSelectionScreen extends ConsumerStatefulWidget {
  const MoodSelectionScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoodSelectionScreenState();
}

class _MoodSelectionScreenState extends ConsumerState<MoodSelectionScreen> {
  void _selectMovie(BuildContext context, String mood) async {
    ref.read(randomMovieProvider);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MovieForMood')),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2, // Two columns
          children: [
            MoodOption(
              moodName: 'Happy',
              emoji: '😄',
              onTap: () {
                _selectMovie(context, 'Happy');
              },
            ),
            MoodOption(
              moodName: 'Tense',
              emoji: '😬',
              onTap: () {
                _selectMovie(context, 'Tense');
              },
            ),
            // Add more mood options as needed
          ],
        ),
      ),
    );
  }
}
