class News {
  final String username;
  final String content;
  final DateTime timeWritten;

  News({
    required this.username,
    required this.content,
    required this.timeWritten,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'content': content,
        'time_written': timeWritten,
      };

  static News fromJson(Map<String, dynamic> json) => News(
      username: json['username'],
      content: json['content'],
      timeWritten: DateTime.parse(json['time_written'].toDate().toString()));
}
