import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String paw = 'cat';
  int totalSeconds = 0;
  int bpm = 120;
  late int millisecondsPerBeat = getMillisecondsPerBeat(bpm);
  int beatsPerMeasure = 1;
  int division = 4;
  bool isRunning = false;
  int totalPomodoros = 0;
  int selectedIndex = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 3000) {
      timer.cancel();
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        totalSeconds = 0;
      });
    } else {
      setState(() {
        totalSeconds = totalSeconds + 1;
        selectedIndex = totalSeconds % division;
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
    return (60 * 1000) ~/ bpm;
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

  void onIncreaseBpmPressed() {
    setState(() {
      bpm = bpm + 1;
      millisecondsPerBeat = getMillisecondsPerBeat(bpm);
      timer.cancel();
      timer = Timer.periodic(
        Duration(milliseconds: millisecondsPerBeat),
        onTick,
      );
    });
  }

  void onDecreaseBpmPressed() {
    setState(() {
      if (bpm > 5) {
        bpm = bpm - 1;
        millisecondsPerBeat = getMillisecondsPerBeat(bpm);
        timer.cancel();
        timer = Timer.periodic(
          Duration(milliseconds: millisecondsPerBeat),
          onTick,
        );
      }
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    double containerSize = MediaQuery.of(context).size.width / (division + 1);
    double marginPercentage = 0.01; // Adjust this percentage as needed

    List<Container> paws = List.generate(
      division,
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
            flex: 3,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
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
