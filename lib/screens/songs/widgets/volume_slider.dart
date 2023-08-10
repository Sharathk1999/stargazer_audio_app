import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class VolumeSlider extends StatefulWidget {
  final AssetsAudioPlayer audioPlayer;

  const VolumeSlider({super.key, required this.audioPlayer});

  @override
  // ignore: library_private_types_in_public_api
  _VolumeSliderState createState() => _VolumeSliderState();
}

class _VolumeSliderState extends State<VolumeSlider> {
  double _currentVolume = 0.5; // Initial volume value

  @override
  void initState() {
    super.initState();
    _currentVolume =
        widget.audioPlayer.volume.value; // Set initial volume value
  }

  void _setVolume(double value) {
    setState(() {
      _currentVolume = value;
    });
    // Update audio player volume
    widget.audioPlayer.setVolume(value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.42,
      height: MediaQuery.of(context).size.height * 0.03,
      child: Slider(
        divisions: null,
        min: 0.0,
        max: 1.0,
        value: _currentVolume,
        onChanged: _setVolume,
        activeColor: const Color.fromARGB(221, 136, 136, 136),
        inactiveColor: Colors.black26,
        thumbColor: Colors.black54,
        label: '🎶',
      ),
    );
  }
}
