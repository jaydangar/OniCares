import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final Widget leadingWidget;
  final String title;
  final List<Widget> actions;
  AppBarWidget({this.leadingWidget, this.title, this.actions});

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    String _showntitle = widget.title;
    return AppBar(
      actions: widget.actions,
      leading: widget.leadingWidget,
      title: Text(_showntitle ??= 'snapik'),
    );
  }
}
