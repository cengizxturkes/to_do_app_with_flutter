import 'package:flutter_application_1/domain/entities/to_do_card.dart';

abstract class ToDoRepository{
  Stream<List<ToDoCard>> get toDoCards;
  Future<void> addToDo(ToDoCard toDoCard);
  Future<void> removeToDo(String toDoId);
}