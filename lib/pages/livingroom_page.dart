import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LivingRoomPage extends StatefulWidget {
  @override
  _LivingRoomPage createState() => _LivingRoomPage();
}

class _LivingRoomPage extends State<LivingRoomPage> {
  bool isSwitched1 = false;
  bool isSwitched2 = false;
  bool isSwitched3 = false;
  final _database = FirebaseDatabase.instance.ref();

  int _temperature = 0;
  int _humidity = 0;

  @override
  void initState() {
    super.initState();
    monitorTemperatureChanges();
    monitorHumidityChanges();
    _loadFanStatus();
    _loadLEDStatus();
    _loadNOTIFIStatus();
  }

  void _loadFanStatus() async {
    DataSnapshot snapshot = await _database.child('FAN_STATUS').get();
    if (snapshot.value != null) {
      setState(() {
        isSwitched3 = snapshot.value as bool;
      });
    }
  }

  void _loadLEDStatus() async {
    DataSnapshot snapshot = await _database.child('LED_STATUS').get();
    if (snapshot.value != null) {
      setState(() {
        isSwitched1 = snapshot.value as bool;
      });
    }
  }

  void _loadNOTIFIStatus() async {
    DataSnapshot snapshot = await _database.child('NOTIFI').get();
    if (snapshot.value != null) {
      setState(() {
        isSwitched2 = snapshot.value as bool;
      });
    }
  }

  void monitorTemperatureChanges() {
    _database.child('temperature').onValue.listen((event) {
      setState(() {
        _temperature = event.snapshot.value as int;
      });
    });
  }

  void monitorHumidityChanges() {
    _database.child('humidity').onValue.listen((event) {
      setState(() {
        _humidity = event.snapshot.value as int;
      });
    });
  }

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
        icon: Icons.cloud,
        color: Colors.blue,
        additionalText: "Temperature:   " +
            _temperature.toString() +
            "°C\nHumidity:         " +
            _humidity.toString() +
            "%",
      ),
      _buildItem(
        icon: Icons.lightbulb,
        color: const Color.fromARGB(255, 255, 230, 2),
        switchValue: isSwitched1,
        onChanged: (value) {
          setState(() {
            isSwitched1 = value;
            _database.child('LED_STATUS').set(isSwitched1);
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
            _database.child('FAN_STATUS').set(isSwitched3);
          });
        },
        additionalText: "Ceiling Fan",
      ),
      _buildItem(
        icon: FontAwesomeIcons.triangleExclamation,
        color: Colors.red,
        switchValue: isSwitched2,
        onChanged: (value) {
          setState(() {
            isSwitched2 = value;
            _database.child('NOTIFI').set(isSwitched2);
          });
        },
        additionalText: "Alert Notification",
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
}
