import 'package:bloc_streams/cities_stream.dart';

abstract class AppEvents{

}

class FetchingCitiesEvent extends AppEvents{
  final CitiesStream citiesStream;

  FetchingCitiesEvent(this.citiesStream);
}

class OnFetchingDoneEvent extends AppEvents{
  
}