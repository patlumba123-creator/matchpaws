import 'dart:io';

List<String> zodiacList = [
  'Monkey', 'Rooster', 'Dog', 'Pig', 'Rat', 'Ox',
  'Tiger', 'Rabbit', 'Dragon', 'Snake', 'Horse', 'Goat'
];

String getZodiacSign(int year) {
  return zodiacList[year % 12];
}

String getHoroscope(String sign) {
  switch (sign) {
    case 'Rat':
      return '''
Love: You are charming and romantic. It's a good time to reconnect with loved ones.
Career: Your wit helps you solve challenges at work. A promotion could be on the horizon.
Health: Stay active and avoid stress. Mental well-being is as important as physical health.''';
    case 'Ox':
      return '''
Love: Your strength lies in your loyalty. Spend time with your significant other.
Career: Your efforts are rewarded. It's likely to be a raise or recognition.
Health: Pay attention to minor problems. Maintain your routine with discipline.''';
    case 'Tiger':
      return '''
Love: There are exciting times ahead. In romantic endeavors, take the initiative.
Career: Make audacious decisions. Opportunities for leadership may present themselves.
Health: Put your energy into hobbies or sports.''';
    case 'Rabbit':
      return '''
Love: Your relationships are defined by harmony and peace.
Career: Effective problem-solving is facilitated by a calm mind.
Health: Steer clear of excessive work. When necessary, take a break.''';
    case 'Dragon':
      return '''
Love: Intimate meetings are in store. Express your emotions honestly.
Career: You have a lot of ambition. It's time to pursue your dreams.
Health: Maintain a balanced energy level. Meditation could be beneficial.''';
    case 'Snake':
      return '''
Love: People are drawn to your enigmatic charm.
Career: You make decisions based on wisdom. Have faith in your intuition.
Health: Put your inner tranquility first. Steer clear of needless drama.''';
    case 'Horse':
      return '''
Love: You're going to have romantic adventures.
Career: You thrive in a fast-paced work environment. Remain well-organized.
Health: Take care of your diet and stay away from burnout.''';
    case 'Goat':
      return '''
Love: Your days are filled with tender and considerate moments.
Career: You succeed when you are creative.
Health: Spend some time unwinding and taking in the scenery.''';
    case 'Monkey':
      return '''
Love: You have a captivating sense of humor.
Career: Overcome obstacles by using your cunning.
Health: To keep interested, try new things.''';
    case 'Rooster':
      return '''
Love:Honesty is essential in love. Express your emotions honestly.
Career: Success comes from discipline. Remain concentrated.
Health: Sleeping early and eating healthily are beneficial.''';
    case 'Dog':
      return '''
Love:Loyalty defines who you are, love. You are valued and loved.
Career: There are benefits to teamwork.
Health: Maintain your composure. Take regular pauses.''';
    case 'Pig':
      return '''
Love: There's a sense of romance. Savor each moment.
Career: There will be prosperity soon. Keep up the good work.
Health: Maintain a healthy diet and sleep schedule.''';
    default:
      return 'No horoscope available.';
  }
}

int getValidInput(String prompt, int min, int max) {
  int? value;
  do {
    stdout.write(prompt);
    String? input = stdin.readLineSync();
    value = int.tryParse(input ?? '');
    if (value == null || value < min || value > max) {
      print("Invalid input. Please enter a number between $min and $max.");
    }
  } while (value == null || value < min || value > max);
  return value;
}

void main() {
  String? tryAgain;
  do {
    stdout.write("Enter your Name: ");
    String? name = stdin.readLineSync();

    int day = getValidInput("Enter your birth day (1–31): ", 1, 31);
    int month = getValidInput("Enter your birth month (1–12): ", 1, 12);
    int year = getValidInput("Enter your birth year: ", 1900, 2100);

    String sign = getZodiacSign(year);
    String horoscope = getHoroscope(sign);

    print("\nHello, $name!");
    print("Your Chinese Zodiac Sign is: $sign");
    print(horoscope);

    stdout.write("\nDo you want to try again? (yes/no): ");
    tryAgain = stdin.readLineSync()?.toLowerCase();
  } while (tryAgain == "yes");

  print("\nThank you for using the Chinese Zodiac Horoscope Program!");
}
