class Address {
  String? street;
  String? apartment;
  String? city;
  String? country;
  String? postalCode;

  Address({
    this.street,
    this.apartment,
    this.city,
    this.country,
    this.postalCode,
  });

  // Convert Address to Map
  Map<String, dynamic> toMap() => {
    'street': street,
    'apartment': apartment,
    'city': city,
    'country': country,
    'postalCode': postalCode,
  };

  // Convert Map to Address
  factory Address.fromMap(Map<String, dynamic> map) => Address(
    street: map['street'],
    apartment: map['apartment'],
    city: map['city'],
    country: map['country'],
    postalCode: map['postalCode'],
  );
  // Factory method to create an Address instance from JSON
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'].toString(),
      apartment: json['apartment'].toString(),
      city: json['city'].toString(),
      country: json['country'].toString(),
      postalCode: json['postalCode'].toString(),
    );
  }

  // Method to convert an Address instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'apartment': apartment,
      'city': city,
      'country': country,
      'postalCode': postalCode,
    };
  }
}
