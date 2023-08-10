import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stargazer_app/constants/const.dart';
import 'package:stargazer_app/functions/playlist_function.dart';
import 'package:stargazer_app/model/playlist.dart';
import 'package:stargazer_app/model/song_model.dart';
import 'package:stargazer_app/screens/playlist/screen_playlist.dart';

class AddToPlaylist extends StatelessWidget {
  final AllSongModel addingsong;
  const AddToPlaylist({super.key, required this.addingsong});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: bgColor),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.height * 0.04,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black87,
                          size: 30,
                        ),
                      ),
                      Text(
                        'ADD TO PLAYLIST',
                        style: GoogleFonts.inconsolata(
                            color: Colors.black, fontSize: 20),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            isDismissible: true,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: showbottomsheetmodel(context),
                            ),
                          );
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.solidSquarePlus,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: playListNotifier,
                  builder: (context, value, child) {
                    return playListNotifier.value.isEmpty
                        ? playlistempty()
                        : gridcard(value, context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget playlistempty() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.my_library_music_sharp,
            color: Colors.black54,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Playlist is empty',
              style:
                  GoogleFonts.inconsolata(fontSize: 25, color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  Widget gridcard(value, ctx) {
    double paddingsize = MediaQuery.of(ctx).size.width * 0.1;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: MediaQuery.of(ctx).size.width * 0.1,
        mainAxisSpacing: MediaQuery.of(ctx).size.width * 0.1,
      ),
      itemBuilder: (context, index) => elementgridcard(context, index),
      itemCount: playListNotifier.value.length,
      padding: EdgeInsets.only(
        bottom: playListNotifier.value.length >= 8 ? paddingsize : 20,
        top: paddingsize,
        left: paddingsize,
        right: paddingsize,
      ),
    );
  }

  Widget elementgridcard(ctx, index) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 3,
      child: InkWell(
        onTap: () {
          if (!playListNotifier.value[index].container.contains(addingsong)) {
            playListNotifier.value[index].container.add(addingsong);
            addPlayListToDb(addingsong, playListNotifier.value[index].name);
            ScaffoldMessenger.of(ctx)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 800),
                  margin:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 40),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green.withAlpha(80),
                  content: Center(
                    child: Text(
                      'Song Added to ${playListNotifier.value[index].name}',
                      style:
                          GoogleFonts.inconsolata(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              );
          } else {
            ScaffoldMessenger.of(ctx)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  duration: const Duration(milliseconds: 800),
                  margin:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 40),
                  behavior: SnackBarBehavior.floating,
                  content: Center(
                    child: Text(
                      'Song already exist',
                      style:
                          GoogleFonts.inconsolata(fontWeight: FontWeight.w500),
                    ),
                  ),
                  backgroundColor: Colors.red.withAlpha(100),
                ),
              );
          }
          Navigator.pop(ctx);
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/image/mostly_img.jpg',
                width: MediaQuery.of(ctx).size.width * 0.35,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 5,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(ctx).size.width * 0.015,
                  left: MediaQuery.of(ctx).size.width * 0.05,
                ),
                child: Text(
                  playListNotifier.value[index].name,
                  style: GoogleFonts.inconsolata(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showbottomsheetmodel(context) {
    final GlobalKey<FormState> playlistformkey = GlobalKey();
    var playlistController = TextEditingController();
    double height = MediaQuery.of(context).size.height * 0.05;

    return SingleChildScrollView(
      child: Container(
        color: bgColor2,
        child: Padding(
          padding: EdgeInsets.all(height),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Create Playlist Here 😍',
                    style: GoogleFonts.inconsolata(fontSize: 23),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 70,
                  child: Form(
                    key: playlistformkey,
                    child: TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.name,
                      controller: playlistController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name is required';
                        }
                        value = value.trim();
                        for (EachPlaylist element in playListNotifier.value) {
                          if (element.name == value) {
                            return 'Name already exist';
                          }
                        }
                        return null;
                      },
                      style: GoogleFonts.inconsolata(fontSize: 18),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        filled: true,
                        hintText: 'Enter the name',
                        hintStyle: GoogleFonts.inconsolata(),
                        fillColor: Colors.white,
                      ),
                      maxLength: 12,
                      onFieldSubmitted: (value) {
                        if (playlistformkey.currentState!.validate()) {
                          createPlaylist(value);
                          Navigator.pop(context);
                          playListNotifier.notifyListeners();
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.5,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 110,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.withAlpha(100),
                    ),
                    onPressed: () {
                      String playlistName = playlistController.text.trim();
                      if (playlistformkey.currentState!.validate()) {
                        createPlaylist(playlistName);
                        Navigator.pop(context);
                        playListNotifier.notifyListeners();
                      }
                    },
                    child: Text(
                      'Create',
                      style: GoogleFonts.inconsolata(color: bgColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
