import 'package:flutter/material.dart';
import 'package:onicares/utils/utils.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key key,
    @required this.mediaQueryUtils,
    @required this.imagePath,
    @required this.labelText,
    @required this.onPressedAction,
  }) : super(key: key);

  final MediaQueryUtils mediaQueryUtils;
  final String imagePath, labelText;
  final VoidCallback onPressedAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaQueryUtils.width,
      margin: EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: RaisedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              alignment: Alignment.centerLeft,
              height: 30,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  labelText.toUpperCase(),
                ),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
        onPressed: onPressedAction,
      ),
    );
  }
}
