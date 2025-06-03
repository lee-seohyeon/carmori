class PicnicSpot {
  final String name;
  final String? address;
  final String features;
  final String? parkingFee;
  final String? nearbyToilet;
  final String? note;
  final String? imageUrl;

  PicnicSpot({
    required this.name,
    this.address,
    required this.features,
    this.parkingFee,
    this.nearbyToilet,
    this.note,
    this.imageUrl,
  });

  factory PicnicSpot.fromJson(Map<String, dynamic> json) {
    return PicnicSpot(
      name: json['name'] ?? '',
      address: json['address'],
      features: json['features'] ?? '',
      parkingFee: json['parking_fee'],
      nearbyToilet: json['nearby_toilet'],
      note: json['note'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'features': features,
      'parking_fee': parkingFee,
      'nearby_toilet': nearbyToilet,
      'note': note,
      'image_url': imageUrl,
    };
  }

  List<String> get featuresList {
    return features.split(', ').map((e) => e.trim()).toList();
  }

  bool get hasFreeParking {
    return parkingFee?.contains('무료') ?? false;
  }

  bool get hasToilet {
    return nearbyToilet != null && nearbyToilet!.isNotEmpty;
  }

  bool get hasOceanView {
    return features.contains('바다뷰');
  }

  bool get hasNightView {
    return features.contains('야경명소');
  }

  bool get hasRiverView {
    return features.contains('강/호수뷰');
  }

  bool get hasSunsetView {
    return features.contains('일몰명소');
  }
} 