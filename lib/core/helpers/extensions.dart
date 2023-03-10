extension ExtensionList on List {
  List<T> uniqueById<T>() {
    var set = <String>{};
    final newData = List<T>.from(where((data) => set.add(data.id)));
    return newData;
  }
}

extension ExtensionString on String? {
  String ifNull(String value) {
    if (this == null || this!.isEmpty) {
      return value;
    }

    return this!;
  }

  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  bool isNotNullOrEmpty() {
    return this != null && this!.isNotEmpty;
  }
}
