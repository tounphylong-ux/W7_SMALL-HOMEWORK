import 'package:flutter/material.dart';
import 'package:w7/data/repositories/songs/song_repository.dart';
import 'package:w7/model/songs/song.dart';
import 'package:w7/ui/states/player_state.dart';


class LibraryViewModel extends ChangeNotifier {
  final SongRepository _repository;
  final PlayerState _playerState;

  List<Song> _songs = [];
  bool _isLoading = true;

  LibraryViewModel({
    required SongRepository repository,
    required PlayerState playerState,
  }) : _repository = repository,
       _playerState = playerState {
    init();
  }

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    _songs = _repository.fetchSongs();

    _playerState.addListener(_onPlayerChanged);

    _isLoading = false;
    notifyListeners();
  }

  void _onPlayerChanged() {
    notifyListeners();
  }

  List<Song> get songs => _songs;
  bool get isLoading => _isLoading;

  Song? get currentSong => _playerState.currentSong;
  bool get isPlaying => _playerState.hasListeners;

  void play(Song song) {
    _playerState.start(song);
  }

  void stop() {
    _playerState.stop();
  }

  void togglePlayPause() {
    _playerState.stop();
  }

  @override
  void dispose() {
    _playerState.removeListener(_onPlayerChanged);
    super.dispose();
  }
}
