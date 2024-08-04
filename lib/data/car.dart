class Car {
  final String id;
  final String title;
  final String imageUrl;
  final int price;
  final int fuel;
  final int topSpeed;
  final String year;
  final String capacity;

  Car({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.fuel,
    required this.topSpeed,
    required this.year,
    required this.capacity,
  });

  factory Car.fromFirestore(Map<String, dynamic> data) {
    print('Creating Car from data: $data');
    return Car(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] ?? 0) as int,
      fuel: (data['fuel'] ?? 0) as int,
      topSpeed: (data['topSpeed'] ?? 0) as int,
      year: data['year'] ?? '',
      capacity: data['capacity'] ?? '',
    );
  }
}
