import 'package:prescription/data/shared_preference.dart';

class User {
  final String user;
  final DoctorData doctorData;
  final ClinicAddress clinicAddress;
  final ClinicData clinicData;
  final String imageURL;
  final List<dynamic> clinicNameWithID;

  User({
    required this.user,
    required this.doctorData,
    required this.clinicAddress,
    required this.clinicData,
    required this.imageURL,
    required this.clinicNameWithID,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        user: map["user"],
        doctorData: DoctorData.fromMap(map["doctorData"].first),
        clinicAddress: ClinicAddress.fromMap(map["clinicAddress"].first),
        clinicData: ClinicData.fromMap(map["clinicData"].first),
        imageURL: map["image_url"],
        clinicNameWithID: map["clinicNameWithID"]["data"]);
  }

  Map<String, dynamic> toDoctorInfo() {
    return {
      "user": user,
      "firstName": doctorData.firstName,
      "secondName": doctorData.secondName,
      "email": doctorData.email,
      "phoneNumber": doctorData.phoneNumber,
      "qualification": doctorData.qualification,
      "specialization": doctorData.specialization,
    };
  }

  Map<String, dynamic> toClinicAddress() {
    return {
      "addressID": clinicAddress.addressID,
      "houseNumber": clinicAddress.houseNumber,
      "lane": clinicAddress.lane,
      "addressOne": clinicAddress.addressOne,
      "landmark": clinicAddress.landmark,
      "city": clinicAddress.city,
      "state": clinicAddress.state,
      "pincode": clinicAddress.pincode,
      "country": clinicAddress.country,
      "clinicID": clinicAddress.clinicID
    };
  }

  Map<String, dynamic> toClinicData() {
    return {
      "clinicID" : clinicNameWithID.first['clinic_id'],
      "user" : user,
      "clinicName": clinicData.clinicName,
      "clinicPhoneNumber": clinicData.clinicPhoneNumber,
      "workingDays": clinicData.workingDays,
      "startTime": clinicData.startTime,
      "endTime": clinicData.endTime,
      "profilePicture": clinicData.profilePicture,
      "imageURL": imageURL,
    };
  }
}

class DoctorData {
  final String user;
  final String firstName;
  final String secondName;
  final String email;
  final String phoneNumber;
  final String qualification;
  final String specialization;

  DoctorData({
    this.user = "",
    required this.firstName,
    required this.secondName,
    required this.email,
    required this.phoneNumber,
    required this.qualification,
    required this.specialization,
  });

  factory DoctorData.fromMap(Map<String, dynamic> map) {
    return DoctorData(
        firstName: map["first_name"],
        secondName: map["second_name"],
        email: map["email"],
        phoneNumber: map["phone_number"],
        qualification: map["qualification"],
        specialization: map["specialization"]);
  }

  factory DoctorData.fromTable(Map<String, dynamic> map) {
    return DoctorData(
        user: map["user"],
        firstName: map["firstName"],
        secondName: map["secondName"],
        email: map["email"],
        phoneNumber: map["phoneNumber"],
        qualification: map["qualification"],
        specialization: map["specialization"]);
  }
}

class ClinicAddress {
  final String addressID;
  final String houseNumber;
  final String lane;
  final String addressOne;
  final String landmark;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final String clinicID;

  ClinicAddress(
      {required this.addressID,
      required this.houseNumber,
      required this.lane,
      required this.addressOne,
      required this.landmark,
      required this.city,
      required this.state,
      required this.pincode,
      required this.country,
      required this.clinicID});

  factory ClinicAddress.fromMap(Map<String, dynamic> map) {
    return ClinicAddress(
      addressID: map["address_id"],
      houseNumber: map["house_number"],
      lane: map["lane"],
      addressOne: map["address_one"],
      landmark: map["landmark"],
      city: map["city"],
      state: map["state"],
      pincode: map["pincode"],
      country: map["country"],
      clinicID: map["clinic_id"],
    );
  }

  factory ClinicAddress.fromTable(Map<String, dynamic> map) {
    return ClinicAddress(
      addressID: map["addressID"],
      houseNumber: map["houseNumber"],
      lane: map["lane"],
      addressOne: map["addressOne"],
      landmark: map["landmark"],
      city: map["city"],
      state: map["state"],
      pincode: map["pincode"],
      country: map["country"],
      clinicID: map["clinicID"],
    );
  }
}

class ClinicData {
  final String clinicName;
  final String clinicPhoneNumber;
  final String workingDays;
  final String startTime;
  final String endTime;
  final String profilePicture;
  final String imageURL;

  ClinicData({
    required this.clinicName,
    required this.clinicPhoneNumber,
    required this.workingDays,
    required this.startTime,
    required this.endTime,
    required this.profilePicture,
    this.imageURL = "",
  });

  factory ClinicData.fromMap(Map<String, dynamic> map) {
    return ClinicData(
        clinicName: map["clinic_name"],
        clinicPhoneNumber: map["clinic_phone_number"],
        workingDays: map["working_days"],
        startTime: map["start_time"],
        endTime: map["end_time"],
        profilePicture: map["profile_picture"]);
  }

  factory ClinicData.fromTable(Map<String, dynamic> map) {
    return ClinicData(
        imageURL: map["imageURL"],
        clinicName: map["clinicName"],
        clinicPhoneNumber: map["clinicPhoneNumber"],
        workingDays: map["workingDays"],
        startTime: map["startTime"],
        endTime: map["endTime"],
        profilePicture: map["profilePicture"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "user" : SP.sp!.getString(SP.user),
      "clinicName": clinicName,
      "clinicPhoneNumber": clinicPhoneNumber,
      "workingDays": workingDays,
      "startTime": startTime,
      "endTime": endTime,
      "profilePicture": profilePicture,
      "imageURL": imageURL,
    };
  }
}

class ClinicNameWithID {
  final String user;
  final String clinicName;
  final String clinicID;

  ClinicNameWithID({
    required this.user,
    required this.clinicName,
    required this.clinicID,
  });

  factory ClinicNameWithID.fromMap(Map<String, dynamic> map) {
    return ClinicNameWithID(
        user: map['user'],
        clinicName: map['clinicName'],
        clinicID: map['clinicID']);
  }
}
