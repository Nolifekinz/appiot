import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LivingRoomPage extends StatefulWidget {
  @override
  _LivingRoomPage createState() => _LivingRoomPage();
}


class _LivingRoomPage extends State<LivingRoomPage> {
  static const int minBrightness = 0;
  static const int maxBrightness = 10;
  static const int minSound = 0;
  static const int maxSound = 100;

  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;

  int _brightness = 4;
  int _Sound = 50;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Flexible(
      child: GridView(
        padding: const EdgeInsets.all(12),
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(
                    Icons.lightbulb,
                    size: 48,
                  ),
                  Spacer(),
                  Switch(
                    value: isSwitched1,
                    onChanged: (value) {
                      setState(() {
                        isSwitched1 = value;
                      });
                    },
                  ),
                ]),
                SizedBox(height: 30),
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text("Brightness: " + '$_brightness'),
                  Slider(
                    value: _brightness.toDouble(),
                    min: minBrightness.toDouble(),
                    max: maxBrightness.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _brightness = value.round();
                        if (_brightness < minBrightness) {
                          _brightness = minBrightness;
                        } else if (_brightness > maxBrightness) {
                          _brightness = maxBrightness;
                        }
                      });
                    },
                  ),
                  Text(
                    "Light",
                    style: TextStyle(fontSize: 24),
                  )
                ]),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.person,
                  size: 48,
                ),
                SizedBox(height: 30),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Number people in the room:",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "4",
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(
                    Icons.tv,
                    size: 48,
                  ),
                  Spacer(),
                  Switch(
                    value: isSwitched2,
                    onChanged: (value) {
                      setState(() {
                        isSwitched2 = value;
                      });
                    },
                  ),
                ]),
                SizedBox(height: 30),
                Column(children: [
                  Text("Sound: " + '$_Sound'),
                  Slider(
                    value: _Sound.toDouble(),
                    min: minSound.toDouble(),
                    max: maxSound.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _Sound = value.round();
                        if (_Sound < minSound) {
                          _Sound = minSound;
                        } else if (_Sound > maxSound) {
                          _Sound = maxSound;
                        }
                      });
                    },
                  ),
                ]),
                Text(
                  "Television",
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(
                    FontAwesomeIcons.fan,
                    size: 48,
                  ),
                  Spacer(),
                  Switch(
                    value: isSwitched3,
                    onChanged: (value) {
                      setState(() {
                        isSwitched3 = value;
                      });
                    },
                  ),
                ]),
                SizedBox(height: 30),
                Text(
                  "Ceiling Fan",
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
        ],
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
