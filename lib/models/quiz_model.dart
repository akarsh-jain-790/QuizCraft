class QuizModel {
  final String question;
  final String optionOne;
  final String optionTwo;
  final String optionThree;
  final String optionFour;
  final String correctOption;

  QuizModel(
    this.question,
    this.optionOne,
    this.optionTwo,
    this.optionThree,
    this.optionFour,
    this.correctOption,
  );

  QuizModel copyWith({
    String? question,
    String? optionOne,
    String? optionTwo,
    String? optionThree,
    String? optionFour,
    String? correctOption,
  }) {
    return QuizModel(
      question ?? this.question,
      optionOne ?? this.optionOne,
      optionTwo ?? this.optionTwo,
      optionThree ?? this.optionThree,
      optionFour ?? this.optionFour,
      correctOption ?? this.correctOption,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'question': question,
      'optionOne': optionOne,
      'optionTwo': optionTwo,
      'optionThree': optionThree,
      'optionFour': optionFour,
      'correctOption': correctOption,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      map['question'] as String,
      map['optionOne'] as String,
      map['optionTwo'] as String,
      map['optionThree'] as String,
      map['optionFour'] as String,
      map['correctOption'] as String,
    );
  }

  @override
  String toString() {
    return 'QuizModel(question: $question, optionOne: $optionOne, optionTwo: $optionTwo, optionThree: $optionThree, optionFour: $optionFour, correctOption: $correctOption)';
  }

  @override
  bool operator ==(covariant QuizModel other) {
    if (identical(this, other)) return true;

    return other.question == question &&
        other.optionOne == optionOne &&
        other.optionTwo == optionTwo &&
        other.optionThree == optionThree &&
        other.optionFour == optionFour &&
        other.correctOption == correctOption;
  }

  @override
  int get hashCode {
    return question.hashCode ^
        optionOne.hashCode ^
        optionTwo.hashCode ^
        optionThree.hashCode ^
        optionFour.hashCode ^
        correctOption.hashCode;
  }
}
