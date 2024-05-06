import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KitchenPage extends StatefulWidget {
  @override
  _KitchenPage createState() => _KitchenPage();
}

class _KitchenPage extends State<KitchenPage> {
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;

  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.blue,
        hintColor: Colors.blueAccent,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.blue,
              displayColor: Colors.blue,
            ),
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: _buildItems(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildItems() {
    return [
      _buildItem(
        icon: Icons.person,
        color: Colors.blue,
        additionalText: "Number people\n in the room: 4",
      ),
      _buildItem(
        icon: Icons.lightbulb,
        color: const Color.fromARGB(255, 255, 230, 2),
        switchValue: isSwitched1,
        onChanged: (value) {
          setState(() {
            isSwitched1 = value;
            _updateLEDStatus();
          });
        },
        additionalText: "Light",
      ),
      _buildItem(
        icon: FontAwesomeIcons.fan,
        color: Colors.green,
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
    Color color = Colors.black,
    bool switchValue = false,
    ValueChanged<bool>? onChanged,
    required String additionalText,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  size: 48,
                  color: color,
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
                Text(
                  additionalText,
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _updateLEDStatus() {
    String status = isSwitched1 ? 'on' : 'off';
    _databaseReference.child('LED_STATUS').set(status);
  }
}
