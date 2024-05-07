import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webclient/astect.dart';
import 'package:webclient/h.dart';
import 'package:webclient/messages_notifications.dart';
import 'package:webclient/profileedit.dart';

//https://www.fluttertemplates.dev/widgets/must_haves/settings_page#settings_page_2

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  bool notifications = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color? bgColor = ColorPallette.backgroundColor();

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
            backgroundColor: ColorPallette.backgroundColor(),
            title: Text(Site.getCurrentUserDomain,
                style:
                    TextStyle(fontSize: 17, color: ColorPallette.fontColor())),
            actions: [
              Stack(children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MessagesNotification(),
                          ));
                    },
                    icon: Icon(Icons.message_outlined,
                        size: 32,
                        color: ColorPallette.fontColor())), // Your icon
                Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        child: const Text('5', // Your number
                            style:
                                TextStyle(color: Colors.white, fontSize: 12))))
              ])
            ]),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                _SingleSection(
                  title: "General",
                  children: [
                    _CustomListTile(
                        title: "Notifications",
                        icon: Icons.notifications_active_outlined,
                        trailing: Switch(
                            value: notifications,
                            onChanged: (value) {
                              if (mounted) {
                                setState(() {
                                  notifications = !notifications;
                                });
                              }
                            }),
                        onclick: () {}),
                    _CustomListTile(
                        title: "Light/Dark Mode",
                        icon: CupertinoIcons.moon,
                        trailing: Switch(
                            value: Tools.themeDark,
                            onChanged: (value) {
                              if (mounted) {
                                setState(() {
                                  Tools.themeDark = !Tools.themeDark;
                                });
                              }
                            }),
                        onclick: () {})
                  ],
                ),
                const Divider(),
                _SingleSection(
                  title: "Personal",
                  children: [
                    _CustomListTile(
                        title: "Profile",
                        icon: Icons.person_outline_rounded,
                        onclick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileEditPage(),
                              ));
                        })
                  ],
                ),
                const Divider(),
                _SingleSection(
                  children: [
                    _CustomListTile(
                        title: "About",
                        icon: Icons.info_outline_rounded,
                        onclick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutPage(),
                              ));
                        }),
                    _CustomListTile(
                        title: "Sign out",
                        icon: Icons.exit_to_app_rounded,
                        onclick: () {
                          Tools.logout(context);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final void Function() onclick;
  const _CustomListTile({
    Key? key,
    required this.title,
    required this.icon,
    this.trailing,
    required this.onclick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(color: ColorPallette.fontColor())),
      leading: Icon(icon, color: ColorPallette.fontColor()),
      trailing: trailing,
      onTap: onclick,
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title!,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorPallette.fontColor()),
              )),
        Column(children: children),
      ],
    );
  }
}
