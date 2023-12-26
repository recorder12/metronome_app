import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String paw = 'cat';
  int totalTicks = 0;
  int bpm = 120;
  int beatsPerMeasure = 4;
  bool isRunning = false;
  int selectedIndex = 0;
  late int millisecondsPerBeat = getMillisecondsPerBeat(bpm);
  late Timer timer;
  late AudioPlayer audioPlayer;

  void onTick(Timer timer) {
    if (totalTicks < 0) {
      timer.cancel();
      setState(() {
        isRunning = false;
        totalTicks = 0;
      });
    } else {
      setState(() {
        totalTicks = totalTicks + 1;
        selectedIndex = totalTicks % beatsPerMeasure;
      });
    }
  }

  void onCatPawChangePressed() {
    setState(() {
      if (paw != 'cat') {
        paw = 'cat';
      }
    });
  }

  void onDogPawChangePressed() {
    setState(() {
      if (paw != 'dog') {
        paw = 'dog';
      }
    });
  }

  void onHorsePawChangePressed() {
    setState(() {
      if (paw != 'horse') {
        paw = 'horse';
      }
    });
  }

  int getMillisecondsPerBeat(int bpm) {
    return ((60 * 1000) ~/ bpm);
  }

  void onStartPressed() {
    timer = Timer.periodic(
      Duration(milliseconds: millisecondsPerBeat),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      selectedIndex = 0;
    });
  }

  void restState() {
    setState(() {
      selectedIndex = 0;
      totalTicks = 0;
      timer.cancel();
      timer = Timer.periodic(
        Duration(milliseconds: millisecondsPerBeat),
        onTick,
      );
    });
  }

  void onIncreaseBpmPressed() {
    setState(() {
      if (bpm < 300) {
        bpm = bpm + 1;
        millisecondsPerBeat = getMillisecondsPerBeat(bpm);
        restState();
      }
    });
  }

  void onDecreaseBpmPressed() {
    setState(() {
      if (bpm > 5) {
        bpm = bpm - 1;
        millisecondsPerBeat = getMillisecondsPerBeat(bpm);
        restState();
      }
    });
  }

  void onIncreaseBeatPressed() {
    setState(() {
      if (beatsPerMeasure < 8) {
        beatsPerMeasure = beatsPerMeasure + 1;
        restState();
      }
    });
  }

  void onDecreaseBeatPressed() {
    setState(() {
      if (beatsPerMeasure > 2) {
        beatsPerMeasure = beatsPerMeasure - 1;
        restState();
      }
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    double containerSize =
        MediaQuery.of(context).size.width / (beatsPerMeasure + 1);
    double marginPercentage = 0.01; // Adjust this percentage as needed

    List<Container> paws = List.generate(
      beatsPerMeasure,
      (index) => Container(
        alignment: index % 2 == 0 ? Alignment.center : Alignment.bottomCenter,
        margin: EdgeInsets.all(containerSize * marginPercentage),
        child: Visibility(
          visible: index == selectedIndex,
          maintainSize: true,
          maintainSemantics: true,
          maintainState: true,
          maintainAnimation: true,
          child: Image.asset(
            'assets/$paw-paw.png',
            width: containerSize,
            height: containerSize,
            color: paw == 'cat'
                ? Theme.of(context).colorScheme.primary
                : paw == 'dog'
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            // paws part
            flex: 4,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...paws,
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: IconButton(
                          onPressed: onCatPawChangePressed,
                          icon: FaIcon(
                            FontAwesomeIcons.cat,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          iconSize: 40,
                        ),
                      ),
                      Center(
                        child: IconButton(
                          onPressed: onDogPawChangePressed,
                          icon: FaIcon(
                            FontAwesomeIcons.dog,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          iconSize: 40,
                        ),
                      ),
                      Center(
                        child: IconButton(
                          onPressed: onHorsePawChangePressed,
                          icon: FaIcon(
                            FontAwesomeIcons.horse,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          iconSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: IconButton(
                                iconSize: 80,
                                color: Theme.of(context).cardColor,
                                onPressed: onDecreaseBpmPressed,
                                icon: const Icon(Icons.arrow_left_rounded),
                              ),
                            ),
                            Text(
                              bpm.toString(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              '(BPM)',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Center(
                              child: IconButton(
                                iconSize: 80,
                                color: Theme.of(context).cardColor,
                                onPressed: onIncreaseBpmPressed,
                                icon: const Icon(Icons.arrow_right_rounded),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: IconButton(
                                iconSize: 80,
                                color: Theme.of(context).cardColor,
                                onPressed: onDecreaseBeatPressed,
                                icon: const Icon(Icons.arrow_left_rounded),
                              ),
                            ),
                            Text(
                              beatsPerMeasure.toString(),
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              '(Beat)',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Center(
                              child: IconButton(
                                iconSize: 80,
                                color: Theme.of(context).cardColor,
                                onPressed: onIncreaseBeatPressed,
                                icon: const Icon(Icons.arrow_right_rounded),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Center(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //       Center(
                      //         child: IconButton(
                      //           iconSize: 80,
                      //           color: Theme.of(context).cardColor,
                      //           onPressed: onDecreaseBpmPressed,
                      //           icon: const Icon(Icons.arrow_left_rounded),
                      //         ),
                      //       ),
                      //       Text(
                      //         bpm.toString(),
                      //         style: Theme.of(context).textTheme.displaySmall,
                      //       ),
                      //       Text(
                      //         '(BPM)',
                      //         style: Theme.of(context).textTheme.headlineSmall,
                      //       ),
                      //       Center(
                      //         child: IconButton(
                      //           iconSize: 80,
                      //           color: Theme.of(context).cardColor,
                      //           onPressed: onIncreaseBpmPressed,
                      //           icon: const Icon(Icons.arrow_right_rounded),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            // start button part
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: IconButton(
                    iconSize: 80,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: Icon(isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline),
                  ),
                ),
                Center(
                  child: IconButton(
                    iconSize: 80,
                    color: Theme.of(context).cardColor,
                    onPressed: onResetPressed,
                    icon: const Icon(Icons.restore_rounded),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
