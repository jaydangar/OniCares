import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:onicares/utils/utils.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final firestoreInstance = Firestore.instance.collection('onicares');
  String queryUser = '';
  Stream<QuerySnapshot> data;
  @override
  Widget build(BuildContext context) {
    if (queryUser.isEmpty) {
      data = firestoreInstance.snapshots();
    }
    return ListView(
      addSemanticIndexes: true,
      semanticChildCount: 2,
      children: [
        Container(
          child: TextField(
            decoration: InputDecoration(
                hintText: 'user name', prefixIcon: Icon(Icons.person)),
            onSubmitted: (value) {
              setState(() {
                queryUser = value;
                data = firestoreInstance
                    .where('uploadedBy', isEqualTo: queryUser)
                    .snapshots();
              });
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.documents[index];
                    return IndividualFeedWidget(
                      snapshot: data,
                      reference: data.reference,
                    );
                  },
                );
              }
              return CircularProgressIndicator();
            },
            stream: data,
          ),
        ),
      ],
    );
  }
}

class IndividualFeedWidget extends StatefulWidget {
  final DocumentSnapshot snapshot;
  final DocumentReference reference;

  IndividualFeedWidget({@required this.snapshot, @required this.reference});

  @override
  _IndividualFeedWidgetState createState() => _IndividualFeedWidgetState();
}

class _IndividualFeedWidgetState extends State<IndividualFeedWidget> {
  bool visibilityStatus = false, visibilityImage = false;
  int likes = 0;

  @override
  void initState() {
    likes = widget.snapshot.data['likes'];
    if (widget.snapshot.data['status'] != null) {
      setState(() {
        visibilityStatus = true;
      });
    }

    if (widget.snapshot.data['statusPhotoUrl'] != null) {
      setState(() {
        visibilityImage = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryUtils _mediaQueryUtils = MediaQueryUtils(context);
    return Card(
      borderOnForeground: true,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        children: [
          Container(
            width: _mediaQueryUtils.width,
            color: Colors.black12,
            padding: EdgeInsets.all(4),
            child: Text(
              widget.snapshot.data['uploadedBy'] ??= '',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: Theme.of(context).textTheme.bodyText2.fontSize),
            ),
          ),
          Visibility(
            visible: visibilityStatus,
            child: Container(
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.all(4),
              child: Text(widget.snapshot.data['status'] ??= ''),
            ),
          ),
          Visibility(
            visible: visibilityImage,
            child: Container(
              height: _mediaQueryUtils.height * 0.2,
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.all(4),
              child: InkWell(
                onTap: () => Navigator.pushNamed(
                    context, Routing.ViewImagePageRoute,
                    arguments: widget.snapshot.data['statusPhotoUrl']),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  image: widget.snapshot.data['statusPhotoUrl'] ??= '',
                  placeholder: 'asset/icons/app_icon.webp',
                ),
              ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton.icon(
                          onPressed: () {
                            setState(() {
                              widget.reference.updateData({
                                'likes': ++likes,
                              });
                            });
                          },
                          icon: Icon(Icons.thumb_up),
                          label: Text(likes.toString()))
                    ],
                  ),
                )),
                Expanded(child: Container())
              ],
            ),
          )
        ],
      ),
    );
  }
}
