import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/const.dart';

class SleepTimerPage extends StatefulWidget {
  const SleepTimerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SleepTimerPageState createState() => _SleepTimerPageState();
}

class _SleepTimerPageState extends State<SleepTimerPage> {
  // Initial sleep duration in minutes
  int sleepDuration = 10; 
TextEditingController durationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    durationController.text = sleepDuration.toString();
  }

  @override
  void dispose() {
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sleep Timer',style: GoogleFonts.inconsolata(),),
        backgroundColor: bgColor,
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding:const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Select Sleep Duration (minutes)',style: GoogleFonts.inconsolata(),),
            Slider(
              value: sleepDuration.toDouble(),
              min: 1,
              max: 60,
              divisions: 59,
              onChanged: (double value) {
                setState(() {
                  sleepDuration = value.toInt();
                  durationController.text = sleepDuration.toString();
                });
              },
            ),
            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Set the Duration',
                labelStyle: GoogleFonts.inconsolata(),
              ),
              onChanged: (value) {
                setState(() {
                  sleepDuration = int.tryParse(value) ?? 1;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                startSleepTimer();
                Navigator.pop(context);
              },
              child: Text('Start Sleep Timer',style: GoogleFonts.inconsolata(),),
            ),
          ],
        ),
      ),
    );
  }

  void startSleepTimer() {
  Timer(
    Duration(minutes: sleepDuration),
    stopPlayback,
  );
}

void stopPlayback() {
  // code to stop the audio playback
  //  audioPlayer.stop()
}

}
