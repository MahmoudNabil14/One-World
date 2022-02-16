class MessageModel {
  late String dateTime;
  late String receiverId;
  late String senderId;
  late String text;

  MessageModel({
    required this.dateTime,
    required this.receiverId,
    required this.senderId,
    required this.text
  });

  MessageModel.fromJson(Map<String, dynamic> json){
    dateTime = json['dateTime'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    text = json['text'];
  }

  Map<String, dynamic> toMap(){
    return{
      "dateTime":dateTime,
      'receiverId':receiverId,
      'senderId':senderId,
      'text':text,
    };
  }
}