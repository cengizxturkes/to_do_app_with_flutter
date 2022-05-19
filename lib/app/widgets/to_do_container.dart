import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/pages/home/home_view.dart';
import 'package:flutter_application_1/app/pages/home/web/web_view.dart';

import '../../domain/entities/to_do_card.dart';
import '../constants.dart';

class ToDoContainer extends StatelessWidget {
  final ToDoCard toDo;
  final Function(String toDoId) removeToDo;
  final Function() onPressed;

  ToDoContainer({
    required this.toDo,
    required this.removeToDo,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: size.width - 40,
              height: 170,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width / 2,
                        child: Text(
                          toDo.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: kLargeTitleStyle(kBlack),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: size.width / 2,
                        child: Text(
                          toDo.content,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: kContentStyleThin(kBlack),
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              toDo.imageUrl,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: size.width - 40,
              height: 170,
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateColor.resolveWith(
                    (_) => kPrimaryColor.withOpacity(0.08),
                  ),
                ),
                child: Container(),
                onPressed: onPressed,
              ),
            ),
            Container(
              width: size.width - 40,
              height: 170,
              padding: EdgeInsets.only(bottom: 12, right: 15),
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  showCupertinoDialog(context: context, builder: createDialog);
                },
                child: Icon(
                  Icons.delete,
                  size: 32,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height / 6),
              child: Container(
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebViewBrowse(toDo)));
                      },
                      icon: Icon(Icons.web))),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget createDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text("Are You Sure?"),
      actions: [
        CupertinoDialogAction(
          child: Text("Yes"),
          onPressed: () {
            removeToDo(toDo.id);
            Navigator.pop(context);
          },
        ),
        CupertinoDialogAction(
          child: Text("No"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
