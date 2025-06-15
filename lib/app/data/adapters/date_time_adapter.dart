class DateTimeAdapter {
  int dateTimeToInt(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  DateTime intToDateTime(int value) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }
}
