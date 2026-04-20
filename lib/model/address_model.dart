import 'package:user_hub_app/model/geo_model.dart';

class AddressModel {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoModel geo;
AddressModel({required this.street,required this.suite,required this.city,required this.zipcode,required this.geo});
factory AddressModel.fromMap(Map<String, dynamic> json){
  return AddressModel(
    street: json["street"],
    suite: json["suite"],
    city: json["city"],
    zipcode: json["zipcode"],
    geo: GeoModel.fromMap(json["geo"])

  );
}
}
