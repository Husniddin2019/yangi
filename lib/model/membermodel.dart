class Member{
  String? id;
  String? email;
  String? password;
  String? img_url;

  Member(this.id,this.email,this.password,this.img_url);

  Member.fromJson(Map<String,dynamic> json)
      :id = json['id'],
        email = json['email'],
        password = json ['password'],
        img_url = json ['img_url'];

  Map <String, dynamic> toJson () => {
      'id': id,
    'email': email,
    'password':password,
    'img_url': img_url,

  };
  
}