import 'package:cloud_firestore/cloud_firestore.dart';
class Record {
  final String url;
  final String kind;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['url'] != null),
        assert(map['kind'] != null),
        url = map['url'],
        kind = map['kind'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<$url$kind>";
}