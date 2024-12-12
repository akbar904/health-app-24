class Validators {
  static String? validateTodoTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title cannot be empty';
    }
    if (value.length < 3) {
      return 'Title must be at least 3 characters long';
    }
    if (value.length > 50) {
      return 'Title cannot be longer than 50 characters';
    }
    return null;
  }

  static String? validateTodoDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description cannot be empty';
    }
    if (value.length > 500) {
      return 'Description cannot be longer than 500 characters';
    }
    return null;
  }
}
