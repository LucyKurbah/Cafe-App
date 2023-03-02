class TableModel{
    
    int id;
    late String table_name, image;
    late double price;
    int  table_seats;

    TableModel({required this.table_name, required this.image, required this.price, required this.id, required this.table_seats});

  factory TableModel.fromJson(Map<String, dynamic> json){

    return TableModel(
      id : json['id'],
      table_name : json['table_name'],
      image : json['table_img_loc'],
      price : double.parse(json['table_price']),
      table_seats : int.parse(json['table_seats']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'table_name': table_name,
      'table_seats' : table_seats,
      'price' : price,
      'image' :image
    };
  }

}
