import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'home/view/HomeView.dart';

void main() {
  initializeDateFormatting('it_IT', null).then((_) => runApp(App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'unweather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "AvenirNext"
      ),
      home: HomeView(),
    );
  }
}
