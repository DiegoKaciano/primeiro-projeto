class BoolAdapter {
  bool intToBool(int value) {
    return value != 0;
  }

  int boolToInt(bool value) {
    return value ? 1 : 0;
  }
}
