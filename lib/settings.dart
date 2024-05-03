import 'package:flutter/material.dart';
import 'package:webclient/astect.dart';
import 'package:webclient/h.dart';
import 'package:webclient/profileedit.dart';

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
    return Scaffold(
        appBar: AppBar(title: Text(Site.domain)),
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
                        onclick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ProfileEditPage()));
                        })
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
                        title: "Help & Feedback",
                        icon: Icons.help_outline_rounded,
                        onclick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HelpPage(),
                              ));
                        }),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProfileEditPage(),
                              ));
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
      title: Text(title),
      leading: Icon(icon),
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
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}
