import 'package:flutter/material.dart';
import 'package:webclient/calendar.dart';
import 'package:webclient/h.dart';
import 'package:webclient/index.dart';
import 'package:webclient/settings.dart';
import 'package:webclient/stats.dart';
/*
      flutter run -d chrome --web-browser-flag "--disable-web-security"
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Bar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late ScrollController scrollContreoller1 = ScrollController();
  int _selectedIndex = 0;
//
//
  @override
  void initState() {
    super.initState();
  }

//
//

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

//
//
//
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    expandedHeight: 250.0,
                    floating: false,
                    pinned: true,
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        collapseMode: CollapseMode.parallax,
                        title: Text("Welcome ${Site.domain}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16.0)),
                        background: Image.network(
                            "https://images.pexels.com/photos/1445327/pexels-photo-1445327.jpeg?auto=compress&cs=tinysrgb&w=600",
                            fit: BoxFit.cover)))
              ];
            },
            body: const IndexPage()),
        const CalendarPage(),
        const StatisticsPage(),
        const SettingsPage(),
      ].elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Availability'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats_sharp),
            label: 'Statistics'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
