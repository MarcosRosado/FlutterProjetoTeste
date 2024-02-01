import 'package:flutter/material.dart';


/// This is an example of a widget that could used in multiple views.
/// this widget uses two important properties, it can receive parameters and it can also call a callback function.
/// To use this callback you could call the widget like
/// Counter(callback: myCallback)
/// and then you could use the callback to update the state of the parent widget.
///
/// The custom parameters can be anything, from a simple string to a complex object, a function to callback
/// or even another widget to take in as a child.
class Counter extends StatefulWidget {

  final Function(int) callback;
  Counter({required this.callback});

  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<Counter> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    widget.callback(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _incrementCounter,
      child: Text('Increment $_counter'),
    );
  }
}