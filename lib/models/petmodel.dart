import 'package:pet_spotter/utils/constant.dart';

class Pet {
  String? name;
  String? mobile;
  String? address;
  String? image;
  String? category;
  String? breed;
  String? age;
  String? sex;
  String? color;
  String? title;
  String? info;
  String? price;
  String? id;

  Pet(
      {this.name,
      this.mobile,
      this.address,
      this.image,
      this.category,
      this.breed,
      this.age,
      this.sex,
      this.color,
      this.title,
      this.info,
      this.price});

  Pet.fromJson(Map<String, dynamic> json) {
    print(json);
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    image = Constants.BASE_URL + '../images/gallery/' + json['image'];
    category = json['category'];
    breed = json['breed'];
    age = json['age'];
    sex = json['sex'];
    color = json['color'];
    title = json['title'];
    info = json['info'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['mobile'] = mobile;
    data['address'] = address;
    data['image'] = image;
    data['category'] = category;
    data['breed'] = breed;
    data['age'] = age;
    data['sex'] = sex;
    data['color'] = color;
    data['title'] = title;
    data['info'] = info;
    data['price'] = price;
    return data;
  }
}
