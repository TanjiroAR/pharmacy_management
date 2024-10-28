class Pharmacist {
  String id;
  String name;
  String pharmacyId; // ID of the pharmacy this pharmacist works in

  Pharmacist({required this.id, required this.name, required this.pharmacyId});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'pharmacyId': pharmacyId,
    };
  }

  Pharmacist.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        pharmacyId = map['pharmacyId'];
}
