
import 'package:intl/intl.dart';

class HumanFormats{
  static String number(double number){
  int numberRevised = int.parse(number.toString().replaceAll('.', ''));
    final formatterNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: "",
      locale: 'en'
    ).format(numberRevised);
    return formatterNumber;
  }

    static String shortDate( DateTime date ) {    
    final format = DateFormat.yMMMEd('es');
    return format.format(date);
  }
  
}