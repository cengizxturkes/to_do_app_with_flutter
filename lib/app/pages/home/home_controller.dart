import '../../../domain/entities/to_do_card.dart';
import '../../../domain/repositories/to_do_repository.dart';
import 'home_presenter.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;

  HomeController(ToDoRepository toDoRepository)
      : _presenter = HomePresenter(toDoRepository);

  List<ToDoCard>? toDos;

  @override
  void onInitState() {
    _presenter.getToDoCards();
    super.onInitState();
  }

  @override
  void initListeners() {
    _presenter.getToDoCardsOnNext = (List<ToDoCard>? response) {
      if (response != null) {
        toDos = response;
        refreshUI();
      }
    };

    _presenter.getToDoCardsOnError = (e) {};

    _presenter.removeToDoCardOnComplete = () {};

    _presenter.removeToDoCardOnError = (e) {
      print(e);
    };

    _presenter.addToDoCardOnComplete = () {};

    _presenter..addToDoCardOnError = (e) {};
  }

  void addToDo(ToDoCard toDo) {
    _presenter.addToDo(toDo);
    refreshUI();
  }

  void removeToDo(String toDoId) {
    _presenter.removeToDo(toDoId);
    refreshUI();
  }
}