class AdminModel{
  final String uid;
  final String name;
  final  String profilePic;
  AdminModel({
    required  this.uid,
    required   this.name,
    required  this.profilePic,
  });

  factory AdminModel.fromJson(Map<String,dynamic>json)=>AdminModel(
      uid: json["uid"],
      name: json["name"],
      profilePic: json["profilePic"],
  );
  Map<String,dynamic>toJson()=>{
    "uid" : uid,
    "name" : name,
    "profilePic" : profilePic,
  };
  AdminModel copyWith({
    String?uid,
    String?name,
    String?profilePic,
  })
  {
    return AdminModel(
        uid: uid??this.uid,
        name: name??this.name,
        profilePic: profilePic??this.profilePic
    );
  }
}
