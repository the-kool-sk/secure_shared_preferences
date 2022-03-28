extension BooleanParsing on String {
  bool parseBool() {
    return toLowerCase() == 'true';
  }
}
