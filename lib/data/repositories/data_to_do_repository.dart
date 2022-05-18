import 'dart:async';

import 'package:flutter_application_1/data/repositories/data_locale_db_repository.dart';
import 'package:flutter_application_1/domain/repositories/locale_db_repository.dart';

import '../../domain/entities/to_do_card.dart';
import '../../domain/repositories/to_do_repository.dart';

class DataToDoRepository implements ToDoRepository {
  static final _instance = DataToDoRepository._internal();
  DataToDoRepository._internal()
      : _localeDBRepository = DataLocalDBRepository();
  factory DataToDoRepository() => _instance;

  final LocaleDbRepository _localeDBRepository;
  List<ToDoCard> _toDos = [];

  StreamController<List<ToDoCard>> _streamController =
      StreamController.broadcast();

  @override
  Future<void> addToDo(ToDoCard toDoCard) async {
    try {
      _toDos.add(toDoCard);

      await _localeDBRepository.setDatabase("toDo", toDoCard.toJson());
      _streamController.add(_toDos);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> removeToDo(String toDoId) async {
    try {
      _toDos.remove(_toDos.firstWhere((toDo) => toDo.id == toDoId));

      await _localeDBRepository.deleteRowFromDatabase(
        "toDo",
        toDoId,
      );
      _streamController.add(_toDos);
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  // TODO: implement toDoCards
  Stream<List<ToDoCard>> get toDoCards {
    try {
      _initToDos();
      return _streamController.stream;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  void _initToDos() async {
    try {
      final result = await _localeDBRepository.getDatabase("toDo");
      _toDos = result.map((json) => ToDoCard.fromJson(json)).toList();
      Future.delayed(Duration.zero).then(
        (_) => _streamController.add(_toDos),
      );
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}