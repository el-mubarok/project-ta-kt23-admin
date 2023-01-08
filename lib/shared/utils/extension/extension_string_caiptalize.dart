extension UtilsExtensionString on String {
  String toCapitalizeEachWordCase() {
    String str = this;
    if (str.isEmpty) {
      return this;
    }

    if (str.length <= 1) {
      return str.toUpperCase();
    }

    final List<String> words = str.split(' ');

    final capitalizeWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);
        return '$firstLetter$remainingLetters';
      }
      return '';
    });

    return capitalizeWords.join(' ');
  }

  String toCapitalize() {
    String str = this;

    if (str.isNotEmpty) {
      final String firstLetter = str.trim().substring(0, 1).toUpperCase();
      final String remainingLetters = str.trim().substring(1);
      return '$firstLetter$remainingLetters';
    }

    return '';
  }
}
