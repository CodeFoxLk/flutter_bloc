void main() {
  print('foooBar'.inverse());
}

extension StringExtension on String{
  String  inverse() {
  
    String inversedString = '';
    for (var i = length; i > 0; i--) {
      inversedString += this[i-1];
    }
    return inversedString;
  }
}