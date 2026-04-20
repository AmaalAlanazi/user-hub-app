import 'package:user_hub_app/model/address_model.dart';
import 'package:user_hub_app/model/company_model.dart';

class UserModel {
  
  final int id;
  final String name;
  final String username;
  final String email;
  final AddressModel address;
  final String phone;
  final String website;
  final CompanyModel company;



  UserModel({required this.name,required this.id,required this.address, required this.company,required this.email,required this.phone, required this.username,required this.website});
  factory UserModel.fromMap(Map<String,dynamic> json){
    return UserModel(
      id: json["id"],
      name: json["name"],
     username: json["username"],
     email: json["email"],
     address: AddressModel.fromMap(json["address"]),
     phone: json["phone"],
     website: json["website"],
     company: CompanyModel.fromMap(json["company"])
    );
  }
}
