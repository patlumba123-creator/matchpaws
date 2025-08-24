import 'dart:io';

void main() {
  String again = '';

  while (again.toLowerCase() != 'q') {
    print('\nEnter Your Birthdate:');

    stdout.write('Enter Day: ');
    String day = stdin.readLineSync() ?? '';
    int dday = int.tryParse(day) ?? 0;

    stdout.write('Enter Month: ');
    String mn = stdin.readLineSync() ?? '';
    int mm = int.tryParse(mn) ?? 1;

    stdout.write('Enter Year: ');
    String yr = stdin.readLineSync() ?? '';
    int yyr = int.tryParse(yr) ?? 0;

    int newDay = getDay(dday);
    print('Your new Day is: $newDay');

    DateTime birthDate = DateTime(yyr, mm, dday);
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    print('You are $age years old.');

    int category = getCategory(age);

    String Iam = '';

    switch (category) {
      case 0:
        Iam = 'Baby';
        print('You are a $Iam');
        print('and you need to drink milk!');
        break;
      case 1:
        Iam = 'Child';
        print('You are a $Iam');
        print('and you need to eat fruits!');
        break;
      case 2:
        Iam = 'Teenager';
        print('You are a $Iam');
        print('and you need to eat rice!');
        break;
      case 3:
        Iam = 'Adult';
        print('You are a $Iam');
        print('and you need to eat vegetables!');
        break;
      case 4:
        Iam = 'Senior';
        print('You are a $Iam')
      default:
        print('Not yet implemented!');
    }

    stdout.write('\nEnter another birthday? (q to quit): ');
    again = stdin.readLineSync() ?? '';
  }

  print('\nGoodbye!');
}

int getDay(int dd) {
  print('Day is: $dd');
  dd = dd + 1;
  return dd;
}

int getCategory(int age) {
  if (age <= 2) return 0;
  else if (age <= 12) return 1;
  else if (age <= 19) return 2;
  else if (age <= 59) return 3;
  else return 4;
}
