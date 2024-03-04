import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KitchenPage extends StatefulWidget {
  @override
  _KitchenPage createState() => _KitchenPage();
}

class _KitchenPage extends State<KitchenPage> {
  static const int minBrightness = 0;
  static const int maxBrightness = 10;

  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;

  int _brightness = 4;

  List<Widget> _buildItems() {
    return [
_buildItem(
  icon: Icons.lightbulb,
  switchValue: isSwitched1,
  onChanged: (value) {
    setState(() {
      isSwitched1 = value;
    });
  },
  additionalWidget: Column(
    children: [
      Text("Brightness: $_brightness",style: TextStyle(fontSize: 20),),
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
    ],
  ),
  additionalText: "Light",
),

      _buildItem(
        icon: Icons.person,
        additionalText: "Number people\n in the room: 4",
      ),
      _buildItem(
        icon: FontAwesomeIcons.fan,
        switchValue: isSwitched3,
        onChanged: (value) {
          setState(() {
            isSwitched3 = value;
          });
        },
        additionalText: "Ventilation Fan",
      ),
    ];
  }

  Widget _buildItem({
    required IconData icon,
    bool switchValue = false,
    ValueChanged<bool>? onChanged,
    Widget? additionalWidget,
    required String additionalText,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 48,
              ),
              Spacer(),
              if (onChanged != null)
                Switch(
                  value: switchValue,
                  onChanged: onChanged,
                ),
            ],
          ),
          SizedBox(height: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (additionalWidget != null) additionalWidget,
              Text(
                additionalText,
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: _buildItems(),
    );
  }
}
