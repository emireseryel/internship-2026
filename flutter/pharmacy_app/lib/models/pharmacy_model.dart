class Pharmacy {
  final String name;
  final String dist;
  final String address;
  final String phone;
  final String loc;

  Pharmacy(this.name,this.dist,this.address,this.phone,this.loc);

  factory Pharmacy.fromJson(Map<String, dynamic> json){
    var name = json['name'] ?? '';
    var dist = json['dist'] ?? '';
    var address = json['address'] ?? '';
    var phone = json['phone'] ?? '';
    var loc = json['loc'] ?? '';

    return Pharmacy(name, dist, address, phone, loc);
  }
}