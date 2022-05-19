import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/app/pages/home/web/web_controller.dart';
import 'package:flutter_application_1/data/repositories/data_to_do_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../domain/entities/to_do_card.dart';
import '../../../widgets/Web_view_url.dart';

class WebViewBrowse extends View {
  final ToDoCard toDoCard;
  WebViewBrowse(this.toDoCard);
  @override
  State<StatefulWidget> createState() {
    return _WebViewState(WebController());
  }
}

class _WebViewState extends ViewState<WebViewBrowse, WebController> {

  _WebViewState(
    WebController controller,
    
  ) : super(controller);
  @override
  Widget get view => Scaffold(
        key: globalKey,
        body:WebViewUrl(widget.toDoCard),
      );
}
