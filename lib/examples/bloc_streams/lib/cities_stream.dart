class CitiesStream {

  static final _shared = CitiesStream._();

  CitiesStream._();

  Stream<String>? _stream;
  
  factory CitiesStream(){
    return _shared;
  }


  final cities = [
    'Bangkok',
    'Beijing',
    'Cairo',
    'Delhi',
    'Guangzhou',
    'Jakarta',
    'Kolkāta',
    'Manila',
    'Mexico City',
    'Moscow',
    'Mumbai',
    'New York',
    'São Paulo',
    'Seoul',
    'Shanghai',
    'Tokyo'
  ];


  Stream<String> getCities(){
    _stream ??=  getCitiesStream();
    return _stream!; 
  }
  
  Stream<String> getCitiesStream() async* {
    for (var element in cities) {
      await Future.delayed(const Duration(milliseconds: 200));
      yield element;
    }
    _stream = null;
  }
}
