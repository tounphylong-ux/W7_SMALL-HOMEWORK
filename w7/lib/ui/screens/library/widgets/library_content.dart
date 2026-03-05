import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w7/ui/screens/library/view_model/library_view_model.dart';
import 'package:w7/ui/states/settings_state.dart';

class LibraryContent extends StatelessWidget {
  const LibraryContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LibraryViewModel>();
    final settings = context.watch<AppSettingsState>();

    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: viewModel.songs.length,
      itemBuilder: (context, index) {
        final song = viewModel.songs[index];
        final isCurrent = song == viewModel.currentSong;

        return ListTile(
          title: Text(
            song.title,
            style: TextStyle(
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          subtitle: Text(song.artist),
          trailing: isCurrent && viewModel.isPlaying
              ? const Icon(Icons.pause)
              : const Icon(Icons.play_arrow),
          onTap: () => viewModel.play(song),
        );
      },
    );
  }
}
