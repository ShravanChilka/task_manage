enum TaskScreenEvent {
  create,
  update,
}

extension GetName on TaskScreenEvent {
  String get name {
    switch (this) {
      case TaskScreenEvent.create:
        return 'Create';
      case TaskScreenEvent.update:
        return 'Update';
    }
  }
}
