class Pharmacy {
  String id;
  String name;
  String address;

  Pharmacy({required this.id, required this.name, required this.address});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }

  Pharmacy.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        address = map['address'];
}