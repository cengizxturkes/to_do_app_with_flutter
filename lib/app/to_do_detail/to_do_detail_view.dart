import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/constants.dart';
import 'package:flutter_application_1/app/texts.dart';
import 'package:flutter_application_1/app/to_do_detail/to_do_detail_controller.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../domain/entities/to_do_card.dart';
import '../widgets/default_app_bar.dart';
class ToDoDetailView extends View {
  final ToDoCard toDo;

  ToDoDetailView(this.toDo);
  @override
  State<StatefulWidget> createState() {
    return _ToDoDetailViewState(ToDoDetailController());
  }
}

class _ToDoDetailViewState
    extends ViewState<ToDoDetailView, ToDoDetailController> {
  _ToDoDetailViewState(ToDoDetailController controller) : super(controller);

  @override
  // TODO: implement view
  Widget get view {
    return Scaffold(
      key: globalKey,
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              children: [
                DefaultAppBar(
                  text: SquamobiTexts.squamobi,
                  isPopAvailable: true,
                ),
                SizedBox(height: 20),
                _ToDoDetailContainer(widget.toDo),
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class _ToDoDetailContainer extends StatelessWidget {
  final ToDoCard toDoCard;

  _ToDoDetailContainer(this.toDoCard);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width - 40,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width - 40,
            child: Image(
              image: NetworkImage(
                toDoCard.imageUrl,
              ),
            ),
          ),
          SizedBox(height: 15),
          Text(
            toDoCard.title,
            style: kLargeTitleStyle(kBlack),
          ),
          SizedBox(height: 15),
          Text(
            toDoCard.content,
            style: kContentStyleThin(kBlack),
          ),
        ],
      ),
    );
  }
}