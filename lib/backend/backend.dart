import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:racler_news/backend/model/news.dart';

Stream<List<News>> queryNewsRecord() => FirebaseFirestore.instance
    .collection('news')
    .orderBy('time_written', descending: true)
    .limit(10)
    .snapshots()
    .map((snap) => snap.docs.map((doc) => News.fromJson(doc.data())).toList());

Future<void> createNewsRecordData({
  String? username,
  String? content,
  DateTime? timeWritten,
}) {
  final docNews = FirebaseFirestore.instance.collection('news');

  final json = {
    'username': username,
    'content': content,
    'time_written': timeWritten,
  };

  return docNews
      .add(json)
      // ignore: avoid_print
      .then((value) => print("News Added"))
      // ignore: avoid_print
      .catchError((error) => print("Failed to add news: $error"));
}
