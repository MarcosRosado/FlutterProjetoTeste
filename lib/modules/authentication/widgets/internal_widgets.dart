import 'package:flutter/material.dart';

/// In this folder the widgets that are used only in the authentication module are stored;
/// you cant further separate the widgets into folders that are more specific to the module.
///
/// These widgets are not used as views, an thus don't show up in the routes file.
/// They are used as internal components of the views, and are not meant to be used outside of the authentication module.
///
/// For example, a component loaded from a bottom sheet, a dialog, or a widget that is used in multiple views.
///
/// this can also be used to store the widgets used in scaffold with steps.
///
/// An example on how to use widgets on a scaffold with steps:
///
///

int currentPageIndex = 0;

void changePage(int index) {
  setState(() {
    currentPageIndex = index;
  });
}

void setState(Null Function() param0) {}

/// This is a simple example of a widget that changes the page based on the current index.
/// the notation [currentPageIndex] on a Widget array will change the current page based on the index.
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: <Widget>[
      const Text("Teste1"),
      const Text("Teste2"),
      const Text("Teste3"),
    ][currentPageIndex],
  );
}
