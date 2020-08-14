import 'package:flutter/material.dart';
import 'package:onicares/widgets/widgets.dart';

class ViewImagePage extends StatelessWidget {
  final String imageUrl;

  ViewImagePage({@required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 50, 0, 50),
        child: Image.network(
          this.imageUrl,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
