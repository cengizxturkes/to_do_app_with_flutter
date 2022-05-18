import 'dart:async';

import 'package:flutter_application_1/domain/entities/to_do_card.dart';
import 'package:flutter_application_1/domain/repositories/to_do_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetToDoCards extends UseCase<List<ToDoCard>,void>{
  final ToDoRepository _toDoRepository;
  final StreamController<List<ToDoCard>>_controller;
  GetToDoCards(this._toDoRepository):_controller=StreamController.broadcast();
  
  @override
  Future<Stream<List<ToDoCard>?>> buildUseCaseStream(void params)async {
   try{
     _toDoRepository.toDoCards.listen((List<ToDoCard>toDoCard) {
       if (!_controller.isClosed)_controller.add(toDoCard);

      });
   }
   catch(error,stackTrace){
     print(error);
     print(stackTrace);
     _controller.addError(error,stackTrace);
   }
   return _controller.stream;
  @override
  void dispose(){
    _controller.close()
;
super.dispose();  }
  }
}