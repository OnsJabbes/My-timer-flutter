import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './timer.dart';
import './timermodel.dart';
import 'settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CountDownTimer timer = CountDownTimer();

  MyApp() {
    timer.startWork(); // Start the timer when the app loads
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Work Timer',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: TimerHomePage(timer: timer),
    );
  }
}

class TimerHomePage extends StatelessWidget {
  final CountDownTimer timer;

  TimerHomePage({required this.timer});

  // Method to navigate to the SettingsScreen
  void goToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Settings()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = <PopupMenuItem<String>>[];
    menuItems.add(
      PopupMenuItem(
        value: 'Settings',
        child: Text('Settings'),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('My Work Timer'),
        actions: [
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (s) {
              if (s == 'Settings') {
                goToSettings(context);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(padding: EdgeInsets.all(defaultPadding)),
              Expanded(
                child: ProductivityButton(
                  color: Color(0xff009688),
                  text: "Work",
                  onPressed: () => timer.startWork(),
                  size: 100.0, // Add the size parameter
                ),
              ),
              Padding(padding: EdgeInsets.all(defaultPadding)),
              Expanded(
                child: ProductivityButton(
                  color: Color(0xff607D8B),
                  text: "Short Break",
                  onPressed: () => timer.startBreak(true),
                  size: 120.0, // Add the size parameter
                ),
              ),
              Padding(padding: EdgeInsets.all(defaultPadding)),
              Expanded(
                child: ProductivityButton(
                  color: Color(0xff455A64),
                  text: "Long Break",
                  onPressed: () => timer.startBreak(false),
                  size: 120.0, // Add the size parameter
                ),
              ),
              Padding(padding: EdgeInsets.all(defaultPadding)),
            ],
          ),
          StreamBuilder(
            initialData: '00:00',
            stream: timer.stream(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              final timerModel = snapshot.data == '00:00'
                  ? TimerModel('00:00', 0)
                  : snapshot.data;
              return Expanded(
                child: CircularPercentIndicator(
                  radius: MediaQuery.of(context).size.width / 2,
                  lineWidth: 10.0,
                  percent: timerModel.percent,
                  center: Text(
                    timerModel.time,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  progressColor: Color(0xff009688),
                ),
              );
            },
          ),
          Row(
            children: [
              Padding(padding: EdgeInsets.all(defaultPadding)),
              Expanded(
                child: ProductivityButton(
                  color: Color(0xff212121),
                  text: 'Stop',
                  onPressed: () {
                    timer.stopTimer();
                  },
                  size: 100.0,
                ),
              ),
              Padding(padding: EdgeInsets.all(defaultPadding)),
              Expanded(
                child: ProductivityButton(
                  color: Color(0xff009688),
                  text: 'Restart',
                  onPressed: () {
                    timer.startTimer();
                  },
                  size: 100.0,
                ),
              ),
              Padding(padding: EdgeInsets.all(defaultPadding)),
            ],
          )
        ],
      ),
    );
  }
}

const double defaultPadding = 5.0;

class ProductivityButton extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final VoidCallback onPressed;

  ProductivityButton({
    required this.color,
    required this.text,
    required this.onPressed,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        this.text,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: this.onPressed,
      color: this.color,
      minWidth: this.size,
    );
  }
}
