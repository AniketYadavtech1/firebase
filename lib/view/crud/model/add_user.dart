class StudentModel {
  final String studentName;
  final String studentID;
  final String rollNumber;
  final String studentCGPA;

  StudentModel({
    required this.studentName,
    required this.studentID,
    required this.rollNumber,
    required this.studentCGPA,
  });

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      studentName: map['studentName'] ?? '',
      studentID: map['studentID'] ?? '',
      rollNumber: map['rollNumber'] ?? '',
      studentCGPA: map['studentCGPA'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentName': studentName,
      'studentID': studentID,
      'rollNumber': rollNumber,
      'studentCGPA': studentCGPA,
    };
  }
}
