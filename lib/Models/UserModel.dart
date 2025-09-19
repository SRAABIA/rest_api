/// id : 1
/// name : "Leanne Graham"
/// username : "Bret"
/// email : "Sincere@april.biz"
/// address : {"street":"Kulas Light","suite":"Apt. 556","city":"Gwenborough","zipcode":"92998-3874","geo":{"lat":"-37.3159","lng":"81.1496"}}
/// phone : "1-770-736-8031 x56442"
/// website : "hildegard.org"
/// company : {"name":"Romaguera-Crona","catchPhrase":"Multi-layered client-server neural-net","bs":"harness real-time e-markets"}

class UserModel {
  UserModel({
    required num id,
    required String name,
    required String username,
    required String email,
    Address? address, // nullable
    required String phone,
    required String website,
    Company? company, // nullable
  })  : _id = id,
        _name = name,
        _username = username,
        _email = email,
        _address = address,
        _phone = phone,
        _website = website,
        _company = company;

  UserModel.fromJson(dynamic json)
      : _id = json['id'],
        _name = json['name'],
        _username = json['username'],
        _email = json['email'],
        _address =
        json['address'] != null ? Address.fromJson(json['address']) : null,
        _phone = json['phone'],
        _website = json['website'],
        _company =
        json['company'] != null ? Company.fromJson(json['company']) : null;

  final num _id;
  final String _name;
  final String _username;
  final String _email;
  final Address? _address;
  final String _phone;
  final String _website;
  final Company? _company;

  UserModel copyWith({
    num? id,
    String? name,
    String? username,
    String? email,
    Address? address,
    String? phone,
    String? website,
    Company? company,
  }) =>
      UserModel(
        id: id ?? _id,
        name: name ?? _name,
        username: username ?? _username,
        email: email ?? _email,
        address: address ?? _address,
        phone: phone ?? _phone,
        website: website ?? _website,
        company: company ?? _company,
      );

  num get id => _id;
  String get name => _name;
  String get username => _username;
  String get email => _email;
  Address? get address => _address;
  String get phone => _phone;
  String get website => _website;
  Company? get company => _company;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['username'] = _username;
    map['email'] = _email;
    if (_address != null) {
      map['address'] = _address!.toJson();
    }
    map['phone'] = _phone;
    map['website'] = _website;
    if (_company != null) {
      map['company'] = _company!.toJson();
    }
    return map;
  }
}

/// name : "Romaguera-Crona"
/// catchPhrase : "Multi-layered client-server neural-net"
/// bs : "harness real-time e-markets"

class Company {
  Company({
    required String name,
    required String catchPhrase,
    required String bs,
  })  : _name = name,
        _catchPhrase = catchPhrase,
        _bs = bs;

  Company.fromJson(dynamic json)
      : _name = json['name'],
        _catchPhrase = json['catchPhrase'],
        _bs = json['bs'];

  final String _name;
  final String _catchPhrase;
  final String _bs;

  Company copyWith({
    String? name,
    String? catchPhrase,
    String? bs,
  }) =>
      Company(
        name: name ?? _name,
        catchPhrase: catchPhrase ?? _catchPhrase,
        bs: bs ?? _bs,
      );

  String get name => _name;
  String get catchPhrase => _catchPhrase;
  String get bs => _bs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['catchPhrase'] = _catchPhrase;
    map['bs'] = _bs;
    return map;
  }
}

/// street : "Kulas Light"
/// suite : "Apt. 556"
/// city : "Gwenborough"
/// zipcode : "92998-3874"
/// geo : {"lat":"-37.3159","lng":"81.1496"}

class Address {
  Address({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
    Geo? geo, // nullable
  })  : _street = street,
        _suite = suite,
        _city = city,
        _zipcode = zipcode,
        _geo = geo;

  Address.fromJson(dynamic json)
      : _street = json['street'],
        _suite = json['suite'],
        _city = json['city'],
        _zipcode = json['zipcode'],
        _geo = json['geo'] != null ? Geo.fromJson(json['geo']) : null;

  final String _street;
  final String _suite;
  final String _city;
  final String _zipcode;
  final Geo? _geo;

  Address copyWith({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    Geo? geo,
  }) =>
      Address(
        street: street ?? _street,
        suite: suite ?? _suite,
        city: city ?? _city,
        zipcode: zipcode ?? _zipcode,
        geo: geo ?? _geo,
      );

  String get street => _street;
  String get suite => _suite;
  String get city => _city;
  String get zipcode => _zipcode;
  Geo? get geo => _geo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['street'] = _street;
    map['suite'] = _suite;
    map['city'] = _city;
    map['zipcode'] = _zipcode;
    if (_geo != null) {
      map['geo'] = _geo!.toJson();
    }
    return map;
  }
}

/// lat : "-37.3159"
/// lng : "81.1496"

class Geo {
  Geo({
    required String lat,
    required String lng,
  })  : _lat = lat,
        _lng = lng;

  Geo.fromJson(dynamic json)
      : _lat = json['lat'],
        _lng = json['lng'];

  final String _lat;
  final String _lng;

  Geo copyWith({
    String? lat,
    String? lng,
  }) =>
      Geo(
        lat: lat ?? _lat,
        lng: lng ?? _lng,
      );

  String get lat => _lat;
  String get lng => _lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }
}
