import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AutomationPage extends StatefulWidget {
  @override
  _AutomationPageState createState() => _AutomationPageState();
}

class _AutomationPageState extends State<AutomationPage> {
  TimeOfDay selectedStartTime = TimeOfDay(hour: 10, minute: 0);
  TimeOfDay selectedEndTime = TimeOfDay(hour: 11, minute: 0);
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();
  bool isFunctionEnabled = true; // Trạng thái của chức năng

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (!isFunctionEnabled) return; // Kiểm tra chức năng có được kích hoạt hay không
      final now = TimeOfDay.now();
      if ((now.hour == selectedStartTime.hour && now.minute == selectedStartTime.minute) ||
          (now.hour == selectedEndTime.hour && now.minute == selectedEndTime.minute)) {
        _scheduleLightOn();
        print("changeeeeeeeeeeeeeeeeeee Ledddddddddddddd");
        timer.cancel(); // Dừng Timer sau khi đã cập nhật LED_STATUS
      }
    });
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
    );
    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    );
    if (picked != null && picked != selectedEndTime) {
      setState(() {
        selectedEndTime = picked;
      });
    }
  }

  void _scheduleLightOn() {
    _databaseReference.child('SENSOR_STATUS').set('true');
  }

  void _toggleFunction() {
    setState(() {
      isFunctionEnabled = !isFunctionEnabled; // Đảo ngược trạng thái của chức năng
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _toggleFunction(); // Kích hoạt hoặc vô hiệu hóa chức năng
              },
              child: Text(isFunctionEnabled ? 'Disable Function' : 'Enable Function'), // Hiển thị nút tương ứng với trạng thái chức năng
            ),
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Start Time",
                      style: TextStyle(fontSize: 22, color: Colors.blue),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        _selectStartTime(context);
                      },
                      child: Text(selectedStartTime.format(context)),
                      // Vô hiệu hóa nút khi chức năng bị vô hiệu hóa
                      style: isFunctionEnabled ? null : ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                        foregroundColor: MaterialStateProperty.all(Colors.black),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      "End Time",
                      style: TextStyle(fontSize: 22, color: Colors.blue),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        _selectEndTime(context);
                      },
                      child: Text(selectedEndTime.format(context)),
                      // Vô hiệu hóa nút khi chức năng bị vô hiệu hóa
                      style: isFunctionEnabled ? null : ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                        foregroundColor: MaterialStateProperty.all(Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 80),
            Text('Number of People',style: TextStyle(fontSize: 28, color: Colors.blue),),
            Text('in House: 0',style: TextStyle(fontSize: 28, color: Colors.blue),),
          ],
        ),
      ),
    );
  }
}
