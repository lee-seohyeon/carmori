import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/picnic_spot.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  List<PicnicSpot> _spots = [];
  List<PicnicSpot> get spots => _spots;

  Future<void> loadSpots() async {
    try {
      final String jsonString = await rootBundle.loadString('src/data/picnic_spots.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      final List<dynamic> spotsJson = jsonData['spots'];
      
      _spots = spotsJson.map((json) => PicnicSpot.fromJson(json)).toList();
    } catch (e) {
      print('Error loading spots: $e');
      _spots = [];
    }
  }

  List<PicnicSpot> filterSpots({
    String? searchQuery,
    bool? freeParking,
    bool? hasToilet,
    bool? oceanView,
    bool? nightView,
    bool? riverView,
    bool? sunsetView,
  }) {
    List<PicnicSpot> filtered = List.from(_spots);

    if (searchQuery != null && searchQuery.isNotEmpty) {
      filtered = filtered.where((spot) =>
          spot.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          (spot.address?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false) ||
          spot.features.toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    if (freeParking == true) {
      filtered = filtered.where((spot) => spot.hasFreeParking).toList();
    }

    if (hasToilet == true) {
      filtered = filtered.where((spot) => spot.hasToilet).toList();
    }

    if (oceanView == true) {
      filtered = filtered.where((spot) => spot.hasOceanView).toList();
    }

    if (nightView == true) {
      filtered = filtered.where((spot) => spot.hasNightView).toList();
    }

    if (riverView == true) {
      filtered = filtered.where((spot) => spot.hasRiverView).toList();
    }

    if (sunsetView == true) {
      filtered = filtered.where((spot) => spot.hasSunsetView).toList();
    }

    return filtered;
  }

  List<String> getAllFeatures() {
    Set<String> features = {};
    for (var spot in _spots) {
      features.addAll(spot.featuresList);
    }
    return features.toList()..sort();
  }
} 