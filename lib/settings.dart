import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './widgets.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextStyle textStyle = TextStyle(fontSize: 24);
  late TextEditingController txtWork;
  late TextEditingController txtShort;
  late TextEditingController txtLong;
  late SharedPreferences prefs;
  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";

  @override
  void initState() {
    txtWork = TextEditingController();
    txtShort = TextEditingController();
    txtLong = TextEditingController();
    readSettings();
    super.initState();
  }

  readSettings() async {
    prefs = await SharedPreferences.getInstance();

    int workTime = prefs.getInt(WORKTIME) ?? 30;
    int shortBreak = prefs.getInt(SHORTBREAK) ?? 5;
    int longBreak = prefs.getInt(LONGBREAK) ?? 20;

    setState(() {
      txtWork.text = workTime.toString();
      txtShort.text = shortBreak.toString();
      txtLong.text = longBreak.toString();
    });
  }

  void updateSetting(String key, int value) {
    switch (key) {
      case WORKTIME:
        {
          int? workTime = prefs.getInt(WORKTIME);
          workTime = (workTime ?? 0) + value;
          if (workTime >= 1 && workTime <= 180) {
            prefs.setInt(WORKTIME, workTime);
            setState(() {
              txtWork.text = workTime.toString();
            });
          }
        }
        break;
      case SHORTBREAK:
        {
          int? short = prefs.getInt(SHORTBREAK);
          short = (short ?? 0) + value;
          if (short >= 1 && short <= 120) {
            prefs.setInt(SHORTBREAK, short);
            setState(() {
              txtShort.text = short.toString();
            });
          }
        }
        break;
      case LONGBREAK:
        {
          int? long = prefs.getInt(LONGBREAK);
          long = (long ?? 0) + value;
          if (long >= 1 && long <= 180) {
            prefs.setInt(LONGBREAK, long);
            setState(() {
              txtLong.text = long.toString();
            });
          }
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double buttonSize = 80.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: GridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 3,
        childAspectRatio: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: <Widget>[
          Text("Work", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(
            color: Color(0xff455A64), // Provide the required 'color' argument
            text: "-",
            value: -1,
            onPressed: (key, value) => updateSetting(WORKTIME, value),
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtWork,
          ),
          SettingsButton(
            color: Color(0xff009688), // Provide the required 'color' argument
            text: "+",
            value: 1,
            onPressed: (key, value) => updateSetting(WORKTIME, value),
          ),
          Text("Short", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(
            color: Color(0xff455A64), // Provide the required 'color' argument
            text: "-",
            value: -1,
            onPressed: (key, value) => updateSetting(SHORTBREAK, value),
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtShort,
          ),
          SettingsButton(
            color: Color(0xff009688), // Provide the required 'color' argument
            text: "+",
            value: 1,
            onPressed: (key, value) => updateSetting(SHORTBREAK, value),
          ),
          Text("Long", style: textStyle),
          Text(""),
          Text(""),
          SettingsButton(
            color: Color(0xff455A64), // Provide the required 'color' argument
            text: "-",
            value: -1,
            onPressed: (key, value) => updateSetting(LONGBREAK, value),
          ),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txtLong,
          ),
          SettingsButton(
            color: Color(0xff009688), // Provide the required 'color' argument
            text: "+",
            value: 1,
            onPressed: (key, value) => updateSetting(LONGBREAK, value),
          ),
        ],
        padding: const EdgeInsets.all(20.0),
      ),
    );
  }
}
