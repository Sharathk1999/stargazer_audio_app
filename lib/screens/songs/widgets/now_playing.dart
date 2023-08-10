import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:stargazer_app/functions/mostly_played.dart';
import 'package:stargazer_app/functions/recently_function.dart';
import 'package:stargazer_app/functions/song_fetch.dart';
import 'package:stargazer_app/screens/search/screen_search.dart';
import 'package:stargazer_app/screens/settings/screen_settings.dart';
import 'package:stargazer_app/screens/songs/widgets/stargazer_custom_snackbar.dart';
import 'package:stargazer_app/screens/widgets/fav_icon.dart';

import '../../../constants/const.dart';
import '../../../functions/fav_functions.dart';
import '../../../model/song_model.dart';
import 'volume_slider.dart';

class ScreenNowPlaying extends StatefulWidget {
  const ScreenNowPlaying({
    Key? key,
    required this.index,
    required this.context,
    required this.allSongsList,
  }) : super(key: key);

  final int index;
  final BuildContext context;
  final List<AllSongModel> allSongsList;

  @override
  State<ScreenNowPlaying> createState() => _ScreenNowPlayingState();
}

class _ScreenNowPlayingState extends State<ScreenNowPlaying>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  bool _isPlaying = false;
  bool _isRepeatEnabled = false;
  bool _isShuffledEnabled = false;

  Duration _duration = const Duration();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    playAudio(widget.allSongsList, widget.index);

    _isPlaying = true;

    debugPrint(
        'This is the total lenght of the song${allsongsList.length.toString()}');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(FontAwesomeIcons.chevronLeft),
        ),
        title: Text(
          'Now Playing',
          style: GoogleFonts.inconsolata(),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'Settings',
                    child: Text(
                      'Settings',
                      style: GoogleFonts.inconsolata(),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Search',
                    child: Text(
                      'Search',
                      style: GoogleFonts.inconsolata(),
                    ),
                  ),
                ];
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23),
              ),
              color: bgColor,
              child: const Icon(
                FontAwesomeIcons.ellipsisVertical,
                color: Colors.black87,
              ),
              onSelected: (value) {
                if (value == 'Settings') {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ScreenSettings(),
                  ));
                }
                if (value == 'Search') {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ScreenSearchSong(),
                  ));
                }
              },
            ),
          )
        ],
        backgroundColor: bgColor,
      ),
      body: assetsAudioPlayer.builderCurrent(
        builder: (context, playing) {
          int id = int.parse(playing.audio.audio.metas.id!);
          currentPlayingfinder(id);
          addMostlyPlayedSongToDb(id);
          final audio = assetsAudioPlayer.current.value?.audio;
          if (audio != null) {
            _duration = audio.duration;
          }
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(55),
                      topRight: Radius.circular(55),
                      bottomLeft: Radius.circular(55),
                      bottomRight: Radius.circular(55),
                    ),
                    color: bgColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                      )
                    ],
                    border: Border.all(
                      color: const Color.fromRGBO(0, 0, 0, 1),
                      width: 4,
                    ),
                  ),
                  child: QueryArtworkWidget(
                    id: id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 242, 208, 196),
                      backgroundImage:
                          AssetImage('assets/image/music_qimg.jpg'),
                    ),
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    artworkFit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        addToFavorite(allsongsList[playing.index]);
                      },
                      child: FavIcon(
                          currentSong: allsongsList[widget.index],
                          isFavorite: false),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            assetsAudioPlayer.getCurrentAudioTitle,
                            style: GoogleFonts.inconsolata(fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            assetsAudioPlayer.getCurrentAudioArtist ==
                                    "<unknown>"
                                ? "Unknown Artist"
                                : assetsAudioPlayer.getCurrentAudioArtist,
                            style: GoogleFonts.inconsolata(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                FontAwesomeIcons.minus,
                                size: 15,
                              ),
                              VolumeSlider(audioPlayer: assetsAudioPlayer),
                              const Icon(
                                FontAwesomeIcons.plus,
                                size: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.playlist_add),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: PlayerBuilder.currentPosition(
                        player: assetsAudioPlayer,
                        builder: (context, position) {
                          return ProgressBar(
                            progress: position,
                            total: _duration,
                            progressBarColor: Colors.black54,
                            baseBarColor: Colors.black26,
                            bufferedBarColor: Colors.deepOrange,
                            thumbColor: Colors.black87,
                            barHeight: 2.0,
                            thumbGlowRadius: 3.0,
                            timeLabelTextStyle:
                                GoogleFonts.inconsolata(color: Colors.black87),
                            onSeek: (value) {
                              setState(() {
                                position = value;
                                assetsAudioPlayer.seek(value);
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_isRepeatEnabled) {
                          assetsAudioPlayer.setLoopMode(LoopMode.none);
                          _isRepeatEnabled = false;
                        } else {
                          assetsAudioPlayer.setLoopMode(LoopMode.single);
                          _isRepeatEnabled = true;
                        }
                      });
                    },
                    icon: Icon(
                      FontAwesomeIcons.repeat,
                      color: _isRepeatEnabled ? Colors.blue : Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      assetsAudioPlayer.previous(keepLoopMode: false);
                    },
                    icon: const Icon(
                      FontAwesomeIcons.circleChevronLeft,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_isPlaying) {
                          assetsAudioPlayer.pause();
                        } else {
                          assetsAudioPlayer.play();
                        }
                        _isPlaying = !_isPlaying;
                      });
                    },
                    icon: _isPlaying
                        ? RotationTransition(
                            turns: _controller,
                            child: const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/image/cd_bg_img.png'),
                              radius: 30,
                            ),
                          )
                        : const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/image/pause.png'),
                            radius: 30,
                          ),
                  ),
                  IconButton(
                    onPressed: () {
                      assetsAudioPlayer.next();
                    },
                    icon: const Icon(
                      FontAwesomeIcons.circleChevronRight,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _isShuffledEnabled = !_isShuffledEnabled;
                      if (_isShuffledEnabled) {
                        assetsAudioPlayer.toggleShuffle();
                      } else {
                        assetsAudioPlayer.setLoopMode(LoopMode.none);
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.shuffle,
                      color: _isShuffledEnabled
                          ? Colors.blueAccent
                          : Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    assetsAudioPlayer.seek(duration);
  }

  void showCustomSnackBar(String songName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: StarGazerCustomSnackBar(songName: songName),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
