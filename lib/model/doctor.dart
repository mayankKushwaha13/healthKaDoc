import 'package:prescription/data/shared_preference.dart';

class Doctor {
  final String doctorID;
  final String firstName;
  final String secondName;
  final String dob;
  final String gender;
  final String phoneNumber;
  final String email;
  final String qualification;
  final String specialization;
  final String personalClinic;
  final String collegeName;
  final String yearOfPassing;
  final String experience;
  final String nmcDoctorID;
  final String profilePicture;
  final String imageURL;
  Doctor(
      {required this.doctorID,
      required this.firstName,
      required this.secondName,
      required this.dob,
      required this.gender,
      required this.phoneNumber,
      required this.email,
      required this.qualification,
      required this.specialization,
      required this.personalClinic,
      required this.collegeName,
      required this.yearOfPassing,
      required this.experience,
      required this.nmcDoctorID,
      required this.profilePicture,
      this.imageURL = ""
      });

      factory Doctor.fromMap(Map<String, dynamic> map) {
    return Doctor(
      collegeName: map['college_name'],
      dob: map['DOB'],
      doctorID: map['doctor_id'],
      email: map['email'],
      experience: map['experience'],
      firstName: map['first_name'],
      gender: map['gender'],
      specialization: map['specialization'],
      nmcDoctorID: map['NMC_doctor_id'],
      personalClinic: map['personal_clinic'].toString(),
      phoneNumber: map['phone_number'],
      profilePicture: map['profile_picture'],
      qualification: map['qualification'],
      secondName: map['second_name'],
      yearOfPassing: map['year_of_passing'],
        );
  }

  factory Doctor.fromTable(Map<String, dynamic> map) {
    return Doctor(
        collegeName: map['collegeName'],
        dob: map['dob'],
        doctorID: map['doctorID'],
        email: map['email'],
        experience: map['experience'],
        firstName: map['firstName'],
        gender: map['gender'],
        nmcDoctorID: map['nmcDoctorID'],
        personalClinic: map['personalClinic'],
        phoneNumber: map['phoneNumber'],
        profilePicture: map['profilePicture'],
        qualification: map['qualification'],
        secondName: map['secondName'],
        specialization: map['specialization'],
        yearOfPassing: map['yearOfPassing'],
        );
  }

  Map<String, dynamic> toMap() {
    return {
      'collegeName' : collegeName,
      'dob' : dob,
      'doctorID' : doctorID,
      'email' : email,
      'experience' : experience,
      'firstName' : firstName,
      'gender' : gender,
      'nmcDoctorID' : nmcDoctorID,
      'personalClinic' : personalClinic,
      'phoneNumber' : phoneNumber,
      'profilePicture' : profilePicture,
      'qualification' : qualification,
      'secondName' : secondName,
      'specialization' : specialization,
      'yearOfPassing' : yearOfPassing
    };
  }
}

class Address {
  final String addressID;
  final String houseNumber;
  final String lane;
  final String addressOne;
  final String landmark;
  final String city;
  final String state;
  final String pincode;
  final String country;
  final String doctorID;

  Address(
      {required this.addressID,
      required this.houseNumber,
      required this.lane,
      required this.addressOne,
      required this.landmark,
      required this.city,
      required this.state,
      required this.pincode,
      required this.country,
      required this.doctorID});
  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
        addressID: map['address_id'],
        addressOne: map['address_one'],
        city: map['city'],
        country: map['country'],
        doctorID: map['doctor_id'],
        houseNumber: map['house_number'],
        landmark: map['landmark'],
        lane: map['lane'],
        pincode: map['pincode'],
        state: map['state']
        );
  }

  factory Address.fromTable(Map<String, dynamic> map) {
    return Address(
        addressID: map['addressID'],
        addressOne: map['addressOne'],
        city: map['city'],
        country: map['country'],
        doctorID: map['doctorID'],
        houseNumber: map['houseNumber'],
        landmark: map['landmark'],
        lane: map['lane'],
        pincode: map['pincode'],
        state: map['state']
        );
  }

  Map<String, dynamic> toMap() {
    return {
      'addressID' : addressID,
      'addressOne' : addressOne,
      'city' : city,
      'country' : country,
      'doctorID' : doctorID,
      'houseNumber' : houseNumber,
      'landmark' : landmark,
      'lane' : lane,
      'pincode' : pincode,
      'state' : state
    };
  }
}

class Clinic{
  final String clinicID;
  final String clinicName;
  final String doctorID;
  final String workingDays;
  final String startTime;
  final String endTime;

  Clinic({
    required this.clinicID,
    required this.doctorID,
    required this.clinicName,
    required this.workingDays,
    required this.startTime,
    required this.endTime,
  });

  factory Clinic.fromMap(Map<String, dynamic> map) {
    return Clinic(
        clinicName: map["clinic_name"],
        clinicID: map["clinic_id"],
        workingDays: map["working_days"],
        startTime: map["start_time"],
        endTime: map["end_time"],
        doctorID: map["doctor_id"]);
  }

  factory Clinic.fromTable(Map<String, dynamic> map) {
    return Clinic(
        clinicName: map["clinicName"],
        clinicID: map["clinicID"],
        workingDays: map["workingDays"],
        startTime: map["startTime"],
        endTime: map["endTime"],
        doctorID: map["doctorID"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "clinicName": clinicName,
      "clinicID": clinicID,
      "workingDays": workingDays,
      "startTime": startTime,
      "endTime": endTime,
      "doctorID": doctorID,
    };
  }
}