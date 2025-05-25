import 'package:flutter/material.dart';
import '../models/picnic_spot.dart';
import '../services/data_service.dart';

enum ViewMode { list, map }

class AppProvider with ChangeNotifier {
  final DataService _dataService = DataService();
  
  ViewMode _viewMode = ViewMode.list;
  ViewMode get viewMode => _viewMode;
  
  List<PicnicSpot> _filteredSpots = [];
  List<PicnicSpot> get filteredSpots => _filteredSpots;
  
  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  
  bool _freeParking = false;
  bool get freeParking => _freeParking;
  
  bool _hasToilet = false;
  bool get hasToilet => _hasToilet;
  
  bool _oceanView = false;
  bool get oceanView => _oceanView;
  
  bool _nightView = false;
  bool get nightView => _nightView;
  
  bool _riverView = false;
  bool get riverView => _riverView;
  
  bool _sunsetView = false;
  bool get sunsetView => _sunsetView;
  
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();
    
    await _dataService.loadSpots();
    _filteredSpots = _dataService.spots;
    
    _isLoading = false;
    notifyListeners();
  }

  void setViewMode(ViewMode mode) {
    _viewMode = mode;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void toggleFreeParking() {
    _freeParking = !_freeParking;
    _applyFilters();
  }

  void toggleHasToilet() {
    _hasToilet = !_hasToilet;
    _applyFilters();
  }

  void toggleOceanView() {
    _oceanView = !_oceanView;
    _applyFilters();
  }

  void toggleNightView() {
    _nightView = !_nightView;
    _applyFilters();
  }

  void toggleRiverView() {
    _riverView = !_riverView;
    _applyFilters();
  }

  void toggleSunsetView() {
    _sunsetView = !_sunsetView;
    _applyFilters();
  }

  void clearFilters() {
    _searchQuery = '';
    _freeParking = false;
    _hasToilet = false;
    _oceanView = false;
    _nightView = false;
    _riverView = false;
    _sunsetView = false;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredSpots = _dataService.filterSpots(
      searchQuery: _searchQuery.isEmpty ? null : _searchQuery,
      freeParking: _freeParking ? true : null,
      hasToilet: _hasToilet ? true : null,
      oceanView: _oceanView ? true : null,
      nightView: _nightView ? true : null,
      riverView: _riverView ? true : null,
      sunsetView: _sunsetView ? true : null,
    );
    notifyListeners();
  }

  bool get hasActiveFilters {
    return _searchQuery.isNotEmpty ||
        _freeParking ||
        _hasToilet ||
        _oceanView ||
        _nightView ||
        _riverView ||
        _sunsetView;
  }
} 