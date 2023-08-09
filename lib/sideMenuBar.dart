import 'package:botai/colors.dart';
import 'package:flutter/material.dart';
class sideMenu extends StatefulWidget {
  @override
  State<sideMenu> createState() => _sideMenuState();
}

class _sideMenuState extends State<sideMenu> {
 
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Container(
          height: 400,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                margin: const EdgeInsets.all(13),
                child: Row(
                  children: [
                    Text(
                      "Open",
                      style: TextStyle(
                          fontSize: 23,
                          color: white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "AI",
                      style: TextStyle(fontSize: 23, color: white),
                    )
                  ],
                )),
            Notes(),
            Archive(),
            Settings()
          ]),
        ),
      ),
    );
  }
}

Widget Notes() {
  return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.orangeAccent.withOpacity(0.22),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), bottomRight: Radius.circular(24))),
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomRight: Radius.circular(24))))),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.mic,
                color: white.withOpacity(0.7),
                size: 30,
              ),
            ),
            Text(
              "ChatBot",
              style: TextStyle(fontSize: 18, color: white.withOpacity(0.7)),
            )
          ],
        ),
      ));
}

Widget Archive() {
  return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), bottomRight: Radius.circular(24))),
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomRight: Radius.circular(24))))),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.history,
                color: white.withOpacity(0.7),
                size: 30,
              ),
            ),
            Text(
              "History",
              style: TextStyle(fontSize: 18, color: white.withOpacity(0.7)),
            )
          ],
        ),
      ));
}

Widget Settings() {
  return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(24), bottomRight: Radius.circular(24))),
      child: TextButton(
        onPressed: () {},
        style: ButtonStyle(
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        bottomRight: Radius.circular(24))))),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 12),
              child: Icon(
                Icons.settings_outlined,
                color: white.withOpacity(0.7),
                size: 30,
              ),
            ),
            Text(
              "Settings",
              style: TextStyle(fontSize: 18, color: white.withOpacity(0.7)),
            )
          ],
        ),
      ));
}
