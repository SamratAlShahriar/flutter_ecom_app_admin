const String collectionAddressModel = 'Address';
const String addressFieldAddressLine1 = 'address_line1';
const String addressFieldAddressLine2 = 'address_line2';
const String addressFieldCity = 'address_city';
const String addressFieldZipCode = 'address_zipcode';

class AddressModel {
  String addressLine1;
  String? addressLine2;
  String city;
  String zipCode;

  AddressModel({
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.zipCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      addressFieldAddressLine1: addressLine1,
      addressFieldAddressLine2: addressLine2,
      addressFieldCity: city,
      addressFieldZipCode: zipCode,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      addressLine1: map[addressFieldAddressLine1],
      addressLine2: map[addressFieldAddressLine2],
      city: map[addressFieldAddressLine2],
      zipCode: map[addressFieldZipCode],
    );
  }
}
