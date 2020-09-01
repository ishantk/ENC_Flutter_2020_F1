class Address{

  String adrsLine;
  String city;
  String state;
  int zipCode;
  String label;

  AddressGeoLocation location;

  Address(){

  }

  Address.init({this.adrsLine, this.city, this.state, this.zipCode, this.label, this.location});

  Map<String, dynamic> toMap(){
    return{
      "adrsLine":adrsLine,
      "city": city,
      "state":state,
      "zipCode": zipCode,
      "label":label,
      "location": location.toMap(), // location is further a map
    };
  }

}

class AddressGeoLocation{

  double latitude;
  double longitude;

  AddressGeoLocation(){

  }

  AddressGeoLocation.init({this.latitude, this.longitude});

  Map<String, dynamic> toMap(){
    return{
      "latitude":latitude,
      "longitude": longitude
    };
  }
}