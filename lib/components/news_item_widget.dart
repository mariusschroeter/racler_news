import 'package:racler_news/backend/model/news.dart';
import 'package:racler_news/utils.dart';

import 'package:flutter/material.dart';

class NewsItemWidget extends StatefulWidget {
  const NewsItemWidget({
    Key? key,
    this.news,
    this.currentUser,
  }) : super(key: key);

  final News? news;
  final String? currentUser;

  @override
  NewsItemWidgetState createState() => NewsItemWidgetState();
}

class NewsItemWidgetState extends State<NewsItemWidget> {
  @override
  Widget build(BuildContext context) {
    final itemBackgroundColor = widget.currentUser == widget.news!.username
        ? Theme.of(context).colorScheme.tertiary
        : Theme.of(context).colorScheme.secondary;
    return GridPaper(
      interval: 400,
      divisions: 2,
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 100.0,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
              // image: const DecorationImage(
              //   image: AssetImage("assets/images/bulb.jpg"),
              //   fit: BoxFit.cover,
              // ),
              color: itemBackgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(8.0))),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Von: ${widget.news!.username}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.8)),
                      ),
                    ),
                    Text(
                      dateTimeFormat(
                        'd/M H:mm',
                        widget.news!.timeWritten,
                      ),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.8)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.news!.content,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
