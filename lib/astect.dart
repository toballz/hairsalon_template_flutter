import 'package:flutter/material.dart';
import 'package:webclient/h.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
  }
//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(Site.domain)),
        body: Center(
            child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: const SingleChildScrollView(
            padding: EdgeInsets.all(12),
            child: Column(children: [
              Text("About"),
            ]),
          ),
        )));
  }
}

//
//
//
//
//
//
//
//
//
//
//
//
//
//
///
///
class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  HelpPageState createState() => HelpPageState();
}

class HelpPageState extends State<HelpPage> {
  @override
  void initState() {
    super.initState();
  }
//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(Site.domain)),
        body: Center(
            child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: const SingleChildScrollView(
            padding: EdgeInsets.all(12),
            child: Column(children: [
              Text("Help"),
            ]),
          ),
        )));
  }
}
