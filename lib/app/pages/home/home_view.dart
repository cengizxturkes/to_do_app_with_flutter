import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app/pages/home/home_controller.dart';
import 'package:flutter_application_1/app/to_do_detail/to_do_detail_view.dart';
import 'package:flutter_application_1/data/repositories/data_to_do_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../widgets/defalt_dialog.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/default_progress_indicator.dart';
import '../../widgets/to_do_container.dart';
class HomeView extends View {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState(HomeController(DataToDoRepository()));
  }
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  _HomeViewState(HomeController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      floatingActionButton: ControlledWidgetBuilder<HomeController>(
        builder: (context, controller) {
          return FloatingActionButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return DefaultDialog(controller.addToDo);
                  });
            },
          );
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              child: Column(
                children: [
                  DefaultAppBar(
                    text: "Squamobi",
                  ),
                  SizedBox(height: 20),
                  ControlledWidgetBuilder<HomeController>(
                    builder: (context, controller) {
                      return controller.toDos != null
                          ? Column(
                              children: [
                                for (int i = 0;
                                    i < controller.toDos!.length;
                                    i++)
                                  ToDoContainer(
                                    toDo: controller.toDos![i],
                                    removeToDo: controller.removeToDo,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                          builder: (context) => ToDoDetailView(
                                            controller.toDos![i],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                              ],
                            )
                          : DefaultProgressIndicator();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}