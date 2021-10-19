class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  late bool isEmailVerified;

  SocialUserModel(
     this.name,
     this.email,
     this.phone,
     this.uId,
     this.isEmailVerified,
  );

  SocialUserModel.fromJson(Map<String, dynamic> json){
    name= json['name'];
    email= json['email'];
    phone= json['phone'];
    uId= json['uId'];
    isEmailVerified= json['isEmailVerified'];
  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
    };
  }

}
