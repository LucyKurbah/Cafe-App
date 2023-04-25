class ProfileModel{
    
  int id;
  late String name, doc_image;
  late String email;

  ProfileModel({required this.name, required this.doc_image, required this.email, required this.id});

  factory ProfileModel.fromJson(Map<String, dynamic> json){
    return ProfileModel(
      id : json['id'],
      name : json['name'],
      doc_image : json['path_file'],
      email : json['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email' : email,
      'doc_image' : doc_image
    };
  }

}