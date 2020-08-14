import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onicares/utils/utils.dart';

class UpdatePage extends StatefulWidget {
  final FirebaseUser user;

  UpdatePage({@required this.user});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  String _status;
  File _statusImage;
  final _imagePicker = ImagePicker();
  Widget statusContentWidget = StatusContentWidget(child: DefaultContent());

  Future _getImage() async {
    final pickedFile = await _imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _statusImage = File(pickedFile.path);
      statusContentWidget = Image.file(
        _statusImage,
        fit: BoxFit.cover,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryUtils _mediaQueryUtils = MediaQueryUtils(context);
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(4),
            height: _mediaQueryUtils.height * 0.1,
            width: _mediaQueryUtils.width,
            child: TextField(
              decoration: InputDecoration(
                  icon: Icon(Icons.local_post_office),
                  hintText: 'status',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Theme.of(context).accentColor))),
              onChanged: (value) {
                setState(() {
                  _status = value;
                });
              },
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => _getImage(),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).accentColor),
                ),
                margin: EdgeInsets.all(8),
                child: Center(
                  child: statusContentWidget,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              child: Center(
                child: Text(
                  'UPDATE STATUS',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () async {
                //  * First of all, Upload Image to the cloud_storage and then, get a url to save it in firestore
                if (_status != null || _statusImage != null) {
                  String downloadURL;
                  if (_statusImage != null) {
                    downloadURL = await _uploadImageAndGetURL(_statusImage);
                  }
                  Map<String, Object> status = {
                    'status': _status ??= null,
                    'statusPhotoUrl': downloadURL ??= null,
                    'uploadedBy': widget.user.displayName,
                    'uploaderId': widget.user.email,
                    'likes': 0
                  };
                  Firestore.instance.collection('onicares').add(status);
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Status Update Successful...')));
                } else {
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Add picture or status...')));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

Future<String> _uploadImageAndGetURL(File imageFile) async {
  StorageReference ref = FirebaseStorage.instance
      .ref()
      .child(DateTime.now().millisecondsSinceEpoch.toString());
  StorageUploadTask uploadTask = ref.putFile(imageFile);
  return await (await uploadTask.onComplete).ref.getDownloadURL();
}

class StatusContentWidget extends StatelessWidget {
  final Widget child;

  StatusContentWidget({@required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }
}

class DefaultContent extends StatelessWidget {
  const DefaultContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.add_a_photo,
      size: 68,
    );
  }
}
