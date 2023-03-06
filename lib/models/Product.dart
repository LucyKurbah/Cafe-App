class Product{
    
    int? id;
    late String title, image, desc;
    late double price;

    Product({required this.title, required this.image, required this.price, required this.id, required this.desc});

  factory Product.fromJson(Map<String, dynamic> json){
  
    return Product(
      id : json['id'],
      title : json['food_name'],
      image : json['path_file'],
      price : double.parse(json['price']),
      desc : json['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'desc' : desc,
      'price' : price,
      'image' :image
    };
  }

}

List<Product> demo_products = [
  Product(title: "Food 1", image : "Assets/food/one.jpg",id:1,price:1.00, desc:"Test"),
  Product(title: "Food 2", image : "Assets/food/two.jpg",id:2,price:1.00, desc:"Test"),
  Product(title: "Food 3", image : "Assets/food/three.jpg",id:3,price:1.00, desc:"Test"),
  Product(title: "Food 4", image : "Assets/food/four.jpg",id:4,price:1.00, desc:"Test"),
  Product(title: "Food 5", image : "Assets/food/one.jpg",id:5,price:1.00, desc:"Test"),
  Product(title: "Food 6", image : "Assets/food/two.jpg",id:6,price:1.00, desc:"Test"),
  Product(title: "Food 7", image : "Assets/food/three.jpg",id:7,price:1.00, desc:"Test"),
  Product(title: "Food 8", image : "Assets/food/four.jpg",id:8,price:1.00, desc:"Test"),
];
