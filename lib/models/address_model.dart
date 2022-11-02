const String COLLECTION_ADDRESS_MODEL = 'Address';
const String ADDRESS_FIELD_ADDRESS_LINE1 = 'address_line1';
const String ADDRESS_FIELD_ADDRESS_LINE2 = 'address_line2';
const String ADDRESS_FIELD_CITY = 'address_city';
const String ADDRESS_FIELD_ZIP_CODE = 'address_zipcode';

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
      ADDRESS_FIELD_ADDRESS_LINE1: addressLine1,
      ADDRESS_FIELD_ADDRESS_LINE2: addressLine2,
      ADDRESS_FIELD_CITY: city,
      ADDRESS_FIELD_ZIP_CODE: zipCode,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      addressLine1: map[ADDRESS_FIELD_ADDRESS_LINE1],
      addressLine2: map[ADDRESS_FIELD_ADDRESS_LINE2],
      city: map[ADDRESS_FIELD_ADDRESS_LINE2],
      zipCode: map[ADDRESS_FIELD_ZIP_CODE],
    );
  }
}
