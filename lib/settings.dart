import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:webclient/h.dart';

//https://www.fluttertemplates.dev/widgets/must_haves/settings_page#settings_page_2

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

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
              style: TextStyle(fontSize: 17, color: ColorPallette.fontColor())),
        ),
        body: Center(
            child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: ListView(children: [
                  _SingleSection(
                    title: "General",
                    children: [
                      _CustomListTile(
                          title: "Light/Dark Mode",
                          icon: CupertinoIcons.moon,
                          trailing: Switch(
                              value: Tools.themeDark,
                              onChanged: (value) {
                                if (mounted) {
                                  setState(() {
                                    localStorage.setItem("themeIsDark",
                                        (!Tools.themeDark).toString());
                                  });
                                }
                              }),
                          onclick: () {})
                    ],
                  ),
                  const Divider(),
                  Text(
                    "Made for COCO HAIR SIGNATURE, LLC",
                    style: TextStyle(color: ColorPallette.fontColor()),
                  ),
                  const Divider(),
                  _SingleSection(children: [
                    _CustomListTile(
                        title: "Sign out",
                        icon: Icons.exit_to_app_rounded,
                        onclick: () {
                          Tools.logout(context);
                        })
                  ])
                ]))));
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final void Function() onclick;
  const _CustomListTile({
    required this.title,
    required this.icon,
    this.trailing,
    required this.onclick,
  });

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
    this.title,
    required this.children,
  });

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
