import 'dart:math';

import 'package:racler_news/backend/model/news.dart';
import 'package:racler_news/components/news_item_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../backend/backend.dart';
import 'package:flutter/material.dart';

class NewsPageWidget extends StatefulWidget {
  const NewsPageWidget({Key? key}) : super(key: key);

  @override
  NewsPageWidgetState createState() => NewsPageWidgetState();
}

class NewsPageWidgetState extends State<NewsPageWidget>
    with WidgetsBindingObserver {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  Future<String>? randomUsername;
  TextEditingController? textController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    textController = TextEditingController();

    randomUsername = prefs.then((SharedPreferences prefs) {
      if (prefs.containsKey('username')) {
        return prefs.getString('username') ?? '';
      } else {
        final newUser = getRandomName();
        prefs.setString('username', newUser);
        return newUser;
      }
    });
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      randomUsername = prefs.then((SharedPreferences prefs) {
        return prefs.getString('username') ?? getRandomName();
      });
    }
    super.didChangeAppLifecycleState(state);
  }

  String getRandomName() {
    final names = ['angel', 'bubbles', 'shimmer', 'bubbly'];
    int randomNumber = Random().nextInt(names.length);
    return names[randomNumber] + Random().nextInt(10000).toString();
  }

  @override
  Widget build(BuildContext context) {
    final isText = textController!.text.isNotEmpty;
    final backgroundColor = isText
        ? Theme.of(context).colorScheme.tertiary
        : Theme.of(context).appBarTheme.backgroundColor;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     if (isText) {
      //       await createNewsRecordData(
      //         username: await randomUsername,
      //         content: textController!.text,
      //         timeWritten: DateTime.now(),
      //       );
      //       textController!.clear();
      //     }
      //   },
      //   backgroundColor: backgroundColor,
      //   child: const Icon(Icons.add),
      // ),
      key: scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Racler News',
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FutureBuilder<String>(
                    future: randomUsername,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.headlineSmall,
                            children: <TextSpan>[
                              const TextSpan(text: 'Hallo '),
                              TextSpan(
                                  text: snapshot.data,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      );
                    }),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: textController,
                        onChanged: (val) => setState(() {}),
                        autofocus: false,
                        obscureText: false,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        decoration: InputDecoration(
                          labelText: 'Neuer Beitrag',
                          labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                          hintText: 'Dein neuer Beitrag..',
                          hintStyle: const TextStyle(color: Colors.white54),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0x00000000),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        maxLines: null,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (isText) {
                          await createNewsRecordData(
                            username: await randomUsername,
                            content: textController!.text,
                            timeWritten: DateTime.now(),
                          );
                          textController!.clear();
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: backgroundColor,
                      ),
                    )
                  ],
                ),
                Divider(color: Theme.of(context).primaryColor),
                //Beiträge
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Aktuelle Beiträge',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                StreamBuilder<List<News>>(
                  stream: queryNewsRecord(),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return const Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    List<News> listViewNewsRecordList = snapshot.data!;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: listViewNewsRecordList.length,
                      itemBuilder: (context, listViewIndex) {
                        final listViewNewsRecord =
                            listViewNewsRecordList[listViewIndex];
                        return Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: FutureBuilder<String>(
                              future: randomUsername,
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                return NewsItemWidget(
                                  key: Key('NewsItem_$listViewIndex'),
                                  news: listViewNewsRecord,
                                  currentUser: snapshot.data,
                                );
                              }),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
