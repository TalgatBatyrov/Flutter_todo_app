// Общее сотояние
abstract class TodoState {}

class ThemeisChanged extends TodoState {
  bool value;
  ThemeisChanged({required this.value});
}

// Состояние когда нет юзеров
class TodoEmptyState extends TodoState {}

// Состояние когда идет процесс загрузки
class TodoLoadingState extends TodoState {}

// Состояние когда данные успешно загружены
class TodoLoadedState extends TodoState {
  List<dynamic> loadedTodo;
  TodoLoadedState({required this.loadedTodo});
}

// Когда при загрузке данных произошла ошибка
class TodoErrorState extends TodoState {}

extension TodoStateUnion on TodoState {
  T map<T>({
    required T Function(TodoEmptyState) todoEmptyState,
    required T Function(TodoLoadingState) todoLoadingState,
    required T Function(TodoLoadedState) todoLoadedState,
    required T Function(TodoErrorState) todoErrorState,
  }) {
    if (this is TodoEmptyState) {
      return todoEmptyState(this as TodoEmptyState);
    }
    if (this is TodoLoadingState) {
      return todoLoadingState(this as TodoLoadingState);
    }
    if (this is TodoLoadedState) {
      return todoLoadedState(this as TodoLoadedState);
    }
    if (this is TodoErrorState) {
      return todoErrorState(this as TodoErrorState);
    }
    throw AssertionError('Union does not match any possible values');
  }
}
