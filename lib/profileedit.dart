import 'package:flutter/material.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ProfileEditPageState createState() => ProfileEditPageState();
}

class ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  void initState() {
    super.initState();
    emailController.text = "Tfydhgj@yfhg.hjg";
    phoneController.text = "435849786";
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFF26CBE6),
            Color(0xFF26CBC0),
          ], begin: Alignment.topCenter, end: Alignment.center)),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text("Account"),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined)),
          ),
          body: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(top: height / 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: const NetworkImage(
                            'https://cdn-sfo.socy.cloud/PRAS/v3/SSFC/st50x50x26021976_100_100/https://files.socy.cloud/_20/202403/upload/generado_1710179131_dp48w7zjcmwkbnz984tcn6l42cqpct.jpg'),
                        radius: height / 10,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Sadiq Mehdi',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: height / 2.6),
                  child: Container(color: Colors.white)),
              Padding(
                padding: EdgeInsets.only(
                    top: height / 2.9, left: width / 20, right: width / 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45,
                                blurRadius: 2.0,
                                offset: Offset(0.0, 2.0))
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              headerChild('Photos', 114),
                              headerChild('Followers', 1205),
                              headerChild('Following', 360),
                            ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height / 20),
                      child: Column(
                        children: <Widget>[
                          infoChild(Icons.email_outlined, emailController),
                          const SizedBox(height: 10),
                          infoChild(Icons.call, phoneController),
                          const SizedBox(height: 22),
                          ElevatedButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.all(12)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green)),
                            onPressed: () {},
                            child: const Center(
                              child: Text('Save Info',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget headerChild(String header, int value) => Expanded(
          child: Column(children: <Widget>[
        Text(header),
        const SizedBox(height: 8.0),
        Text('$value',
            style: const TextStyle(
                fontSize: 14.0,
                color: Color(0xFF26CBE6),
                fontWeight: FontWeight.bold))
      ]));

  Widget infoChild(IconData icon, TextEditingController? ttxCtrler) =>
      Row(children: <Widget>[
        Icon(icon, color: const Color(0xFF26CBE6), size: 26.0),
        const SizedBox(width: 10),
        Expanded(child: TextField(controller: ttxCtrler))
      ]);
}
