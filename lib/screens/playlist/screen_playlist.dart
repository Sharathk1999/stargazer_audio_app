import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stargazer_app/constants/const.dart';
import 'package:stargazer_app/functions/playlist_function.dart';
import 'package:stargazer_app/model/playlist.dart';
import 'package:stargazer_app/screens/playlist/widgets/playlist_inside_screen0.dart';

ValueNotifier<List<EachPlaylist>> playListNotifier = ValueNotifier([]);

class ScreenPlaylist extends StatelessWidget {
  const ScreenPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey rebuildkey = GlobalKey();
    return Scaffold(
      backgroundColor: bgColor2,
      body: Container(
        key: rebuildkey,
        decoration: const BoxDecoration(
          color: bgColor,
        ),
        child: ValueListenableBuilder(
          valueListenable: playListNotifier,
          builder: (context, value, child) {
            return playListNotifier.value.isEmpty
                ? playlistempty()
                : gridcard(value, context, rebuildkey);
          },
        ),
      ),
    );
  }

  Widget playlistempty() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.music_note,
            color: Colors.redAccent.withAlpha(150),
          ),
          Padding(
            padding:const EdgeInsets.only(left: 8.0),
            child: Text(
              'Playlist is empty',
              style: GoogleFonts.inconsolata(
                  fontSize: 25, color: Colors.redAccent.withAlpha(100)),
            ),
          )
        ],
      ),
    );
  }

  Widget gridcard(value, ctx, rebuildkey) {
    double paddingsize = MediaQuery.of(ctx).size.width * 0.1;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: MediaQuery.of(ctx).size.width * 0.1,
        mainAxisSpacing: MediaQuery.of(ctx).size.width * 0.1,
      ),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => InkWell(
        child: elementgridcard(context, index, rebuildkey),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ScreenPlaylistInside(
              currentplaylistindex: index,
            ),
          ));
        },
      ),
      itemCount: playListNotifier.value.length,
      padding: EdgeInsets.only(
          bottom: playListNotifier.value.length >= 8 ? paddingsize : 20,
          top: paddingsize,
          left: paddingsize,
          right: paddingsize),
    );
  }

  Widget elementgridcard(ctx, index, rebuildkey) {
    return Container(
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/image/mostly_img.jpg'),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 3, color: Colors.black87)),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Theme(
              data: Theme.of(ctx).copyWith(
                cardColor: const Color.fromARGB(255, 255, 237, 192),
              ),
              child: PopupMenuButton(
                onSelected: (value) {
                  value == 1
                      ? renamePlaylistFunc(ctx, index, rebuildkey)
                      : deletePlaylistFunc(index, ctx);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                itemBuilder: (
                  context,
                ) =>
                    const [
                  PopupMenuItem(
                    value: 1,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Rename',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(ctx).size.width * 0.015,
                left: MediaQuery.of(ctx).size.width * 0.05,
              ),
              child: Text(
                playListNotifier.value[index].name,
                style: GoogleFonts.inconsolata(fontSize: 18, color: bgColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void renamePlaylistFunc(
      BuildContext context, int index, GlobalKey rebuildkey) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newName = ''; 

        return AlertDialog(
          title: const Text('Rename Playlist'),
          content: TextFormField(
            onChanged: (value) {
              newName =
                  value; 
            },
            decoration: const InputDecoration(labelText: 'New Name'),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await renamePlaylist(
                    index, newName); 
                Navigator.pop(context); 
                // ignore: invalid_use_of_protected_member
                rebuildkey.currentState!.setState(() {});
              },
              child: const Text('Rename'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void deletePlaylistFunc(int index, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Playlist'),
          content: const Text('Are you sure you want to delete this playlist?'),
          actions: [
            TextButton(
              onPressed: () async {
                await deletePlaylist(
                    index); 
                // Navigator.pop(context); 
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
