import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entities/to_do_card.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewUrl extends StatelessWidget {
  final ToDoCard toDoCard;
  WebViewUrl(this.toDoCard);
  @override
  Widget build(BuildContext context) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: "https://www.google.com.tr/search?q=" + toDoCard.title,
    );
  }
}
