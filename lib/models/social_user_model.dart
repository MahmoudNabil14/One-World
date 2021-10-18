class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;

  SocialUserModel(
      this.name,
      this.email,
      this.phone,
      this.uId
      );

  SocialUserModel.fromJson(Map<String,dynamic>json){
    name= json['name'];
    email= json['email'];
    phone= json['phone'];
    uId= json['uId'];
  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
    };
  }

}
