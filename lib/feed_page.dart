import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'record.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() {
    return _FeedPageState();
  }
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Feed de imagenes')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('archives').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context,  List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return Padding(

      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        child: Image.network(
          record.url,
          height: 150,
          loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
      child: CircularProgressIndicator(
      value: loadingProgress.expectedTotalBytes != null
      ? loadingProgress.cumulativeBytesLoaded /
      loadingProgress.expectedTotalBytes
          : null,
      ),
      );
      },
        )
      ),
    );

  }
}

