import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onicares/feed/screens/feed_page.dart';
import 'package:onicares/utils/mediaquery.dart';
import 'package:onicares/widgets/appbar.dart';
import 'package:onicares/updates/screens/update_page.dart';
import 'package:onicares/utils/routes.dart';

class HomePage extends StatefulWidget {
  final FirebaseUser user;

  HomePage({@required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _body = FeedPage();

  @override
  Widget build(BuildContext context) {
    MediaQueryUtils _mediaQueryUtils = MediaQueryUtils(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(
        actions: [
          IconButton(
              icon: Icon(Icons.lock_open),
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routing.LogInPageRoute);
              })
        ],
      ),
      body: _body,
      drawer: Container(
        width: _mediaQueryUtils.width * 0.7,
        child: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(widget.user.displayName),
                accountEmail: Text(widget.user.email),
                currentAccountPicture: Image.network(
                  widget.user.photoUrl,
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                leading: Icon(Icons.rss_feed),
                title: Text('feeds'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _body = FeedPage();
                  });
                },
              ),
              ListTile(
                leading: Icon(Icons.file_upload),
                title: Text('post updates'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _body = UpdatePage(
                      user: widget.user,
                    );
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
