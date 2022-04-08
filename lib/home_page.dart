import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:textfield_search/textfield_search.dart';
import 'package:intl/intl.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  TextEditingController fromController = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    fromController.dispose();
    super.dispose();
  }

  String from = "Vivo";
  final dummyList = [
    'Vivo',
    'Student Union',
    'Palmer Hall',
    'Snyder',
    'Booman'
  ];
  String warningText = "";
  int timeLeft = 0;
  final snackBar = SnackBar(
    backgroundColor: Color.fromARGB(255, 128, 26, 19),
    content: const Text("This is the last bus! No bus for another 30 minutes"),
  );

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _displayTime() {
    int _currentHour = int.parse(DateFormat.H().format(DateTime.now()));
    int _currentMinute = int.parse(DateFormat.m().format(DateTime.now()));
    void _getTime(int startTime) {
      if (_currentMinute >= startTime && _currentMinute < (startTime + 15)) {
        setState(() {
          timeLeft = (startTime + 15) - _currentMinute;
        });
      } else if (_currentMinute >= (startTime + 15) &&
          _currentMinute < (startTime + 30)) {
        setState(() {
          timeLeft = (startTime + 30) - _currentMinute;
        });
      } else if (_currentMinute >= (startTime + 30) &&
          _currentMinute < (startTime + 45)) {
        print(_currentMinute);
        setState(() {
          timeLeft = (startTime + 45) - _currentMinute;
        });
      } else if (_currentMinute >= (startTime + 45)) {
        setState(() {
          timeLeft = 60 - _currentMinute + startTime;
        });
      } else {
        setState(() {
          timeLeft = startTime - _currentMinute;
        });
      }
    }

    switch (from) {
      case "Vivo":
        if ((_currentHour == 12 && _currentMinute >= 52) ||
            (_currentHour == 13 && _currentMinute < 22) ||
            (_currentHour == 15 && _currentMinute >= 52) ||
            (_currentHour == 16 && _currentMinute < 22)) {
          if (_currentMinute >= 52) {
            setState(() {
              timeLeft = 60 - _currentMinute + 22;
            });
          } else {
            setState(() {
              timeLeft = 22 - _currentMinute;
            });
          }
        } else {
          if ((_currentHour == 12 || _currentHour == 15) &&
              (_currentMinute >= 37 || _currentMinute < 52)) {
            _showSnackBar();
          }
          _getTime(07);
        }
        break;
      case "Student Union":
        if ((_currentHour == 13 || _currentHour == 16) &&
            (_currentMinute >= 02 && _currentMinute < 32)) {
          setState(() {
            timeLeft = 32 - _currentMinute;
          });
        } else {
          if ((_currentHour == 12 && _currentMinute >= 47) ||
              (_currentHour == 13 && _currentMinute < 02) ||
              (_currentHour == 15 && _currentMinute >= 47) ||
              (_currentHour == 16 && _currentMinute < 02)) {
            _showSnackBar();
          }
          print("object");
          _getTime(02);
        }
        break;
      case "Palmer Hall":
        if ((_currentHour == 13 || _currentHour == 16) &&
            (_currentMinute >= 07 && _currentMinute < 37)) {
          setState(() {
            timeLeft = 37 - _currentMinute;
          });
        } else {
          if ((_currentHour == 12 && _currentMinute >= 52) ||
              (_currentHour == 13 && _currentMinute < 07) ||
              (_currentHour == 15 && _currentMinute >= 52) ||
              (_currentHour == 16 && _currentMinute < 07)) {
            _showSnackBar();
          }
          _getTime(07);
        }
        break;
      case "Snyder":
        if ((_currentHour == 13 || _currentHour == 16) &&
            (_currentMinute >= 13 && _currentMinute < 43)) {
          setState(() {
            timeLeft = 43 - _currentMinute;
          });
        } else {
          if ((_currentHour == 12 && _currentMinute >= 58) ||
              (_currentHour == 13 && _currentMinute < 13) ||
              (_currentHour == 15 && _currentMinute >= 58) ||
              (_currentHour == 16 && _currentMinute < 13)) {
            _showSnackBar();
          }
          _getTime(13);
        }
        break;
      case "Booman":
        if ((_currentHour == 12 ||
                _currentHour == 13 ||
                _currentHour == 15 ||
                _currentHour == 16) &&
            (_currentMinute >= 55 || _currentMinute < 25)) {
          if (_currentMinute >= 55) {
            setState(() {
              timeLeft = 60 - _currentMinute + 25;
            });
          } else {
            setState(() {
              timeLeft = 25 - _currentMinute;
            });
          }
        } else {
          if ((_currentHour == 12 || _currentHour == 15) &&
              (_currentMinute >= 40 || _currentMinute < 55)) {
            _showSnackBar();
          }
          _getTime(10);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bus Time Finder")),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              child: DropdownButtonFormField<String>(
                value: from,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                onChanged: (String? newValue) {
                  setState(() {
                    from = newValue!;
                  });
                },
                items: dummyList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: _displayTime, child: Text("Get Time")),
            ),
            Container(
                margin: EdgeInsets.all(15),
                width: double.infinity,
                child: Text(
                  "Time Left: ${timeLeft.toString()} minutes",
                  style: Theme.of(context).textTheme.titleLarge,
                )),
          ],
        ),
      ),
    );
  }
}
