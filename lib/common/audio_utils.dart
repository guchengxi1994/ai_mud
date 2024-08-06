import 'package:audioplayers/audioplayers.dart';

class AudioUtils {
  AudioUtils._();

  static final _instance = AudioUtils._();

  factory AudioUtils() => _instance;

  static const String _prefix = 'audios';

  static const String mainBgm = '$_prefix/bg.mp3';

  static AudioPlayer player = AudioPlayer()..setVolume(0.1);

  Future setloop() async {
    await player.setReleaseMode(ReleaseMode.loop);
  }

  Future playMainBgm() async {
    await player.play(AssetSource(mainBgm), mode: PlayerMode.lowLatency);
  }

  double get volume => player.volume;

  Future setVolume(double value) async {
    await player.setVolume(value);
  }
}
