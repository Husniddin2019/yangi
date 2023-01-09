class EmplResponse{
  String? status;
  List<Employee>? data;
  String? massage;

  EmplResponse({this.status,this.data,this.massage});


  factory EmplResponse.fromJson(Map<String,dynamic> json)=>EmplResponse(
      status: json["status"],
    data:List<Employee>.from(json["data"].map((x)=>Employee.fromJson(x))),
    massage: json["massage"],
  );


  Map<String, dynamic> toJson()=>{
    "status":status,
    "massage":massage,
    "data":List<dynamic>.from(data!.map((x) => x.toJson())),

  };




}
class Employee{
  int ? id;
  String? employeName;
  int? employeSalary;
  int? employeAge;
  String? profilImage;

  Employee({this.id,this.employeAge,this.employeSalary,this.employeName,this.profilImage});
  factory Employee.fromJson(Map<String, dynamic> json)=>
      Employee(
          id: json["id"],
          employeName: json["employeName"],
          employeAge: json["employeAge"],
          profilImage: json["profilImage"],
          employeSalary:json["employeSalary"]
  );

  Map<String, dynamic> toJson()=>{
    "id":id,
    "employeName":employeName,
    "employeAge":employeAge,
    "profilImage":profilImage,
    "employeSalary":employeSalary,
  };


}