class UserModel{
  final String uid;
  final String name;
  final int age;
  final  String phone;
  final  String image;
  UserModel({
    required this.uid,
    required this.name,
    required this.age,
    required this.phone,
    required this.image,
  });

  factory UserModel.fromJson(Map<String,dynamic>json)=>UserModel(
    uid: json["uid"],
    name: json["name"],
    age: json["age"],
    phone: json["phone"],
    image: json["image"],
  );
  Map<String,dynamic>toJson()=>{
    "uid" : uid,
    "name" : name,
    "age" : age,
    "phone" : phone,
    "image" : image,
  };
  UserModel copyWith({
    String?uid,
    String?name,
    int?age,
    String?phone,
    String?image,
  })
  {
    return UserModel(
        uid: uid??this.uid,
        name: name??this.name,
        age: age??this.age,
        phone: phone??this.phone,
        image: image??this.image
    );
  }
}
