class UserModel{
  final String uid;
  final String name;
  final  String profilePic;
  UserModel({
    required  this.uid,
    required   this.name,
    required  this.profilePic,
  });

  factory UserModel.fromJson(Map<String,dynamic>json)=>UserModel(
      uid: json["uid"],
      name: json["name"],
      profilePic: json["profilePic"],
  );
  Map<String,dynamic>toJson()=>{
    "uid" : uid,
    "name" : name,
    "profilePic" : profilePic,
  };
  UserModel copyWith({
    String?uid,
    String?name,
    String?profilePic,
  })
  {
    return UserModel(
        uid: uid??this.uid,
        name: name??this.name,
        profilePic: profilePic??this.profilePic
    );
  }
}
