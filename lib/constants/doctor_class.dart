class Doctor {
  final String firstName;
  final String lastName;
  final String doctorId;
  final String specialisation;
  final String phoneNumber;
  // final String image;
  final String qualification;

  Doctor({
    required this.firstName,
    required this.lastName,
    required this.doctorId,
    required this.specialisation,
    required this.phoneNumber,
    // this.image = "lib/assets/doctor.png",
    this.qualification = "MBBS",
  });
}