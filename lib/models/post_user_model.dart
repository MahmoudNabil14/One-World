class PostUserModel {
  late String name;
  late String uId;
  late String profileImage;
  late String postImage;
  late String dateTime;
  late String postText;

  PostUserModel({
    required this.name,
    required this.uId,
    required this.profileImage,
    required this.postImage,
    required this.dateTime,
    required this.postText,
  });

  PostUserModel.fromJson(Map<String, dynamic> json){
    name= json['name'];
    uId= json['uId'];
    profileImage= json['profileImage'];
    postImage= json['postImage'];
    dateTime= json['dateTime'];
    postText= json['postText'];
  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'uId':uId,
      'profileImage':profileImage,
      'postImage':postImage,
      'dateTime':dateTime,
      'postText':postText,
    };
  }

}
