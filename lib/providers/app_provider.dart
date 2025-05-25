import 'package:flutter/material.dart';
import '../models/picnic_spot.dart';
import '../services/data_service.dart';

enum ViewMode { list, map }

class AppProvider with ChangeNotifier {
  final DataService _dataService = DataService();
  
  ViewMode _viewMode = ViewMode.list;
  ViewMode get viewMode => _viewMode;
  
  String _selectedFilter = '전체';
  String get selectedFilter => _selectedFilter;
  
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

  void setFilter(String filter) {
    _selectedFilter = filter;
    _applyFilters();
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
    _selectedFilter = '전체';
    _freeParking = false;
    _hasToilet = false;
    _oceanView = false;
    _nightView = false;
    _riverView = false;
    _sunsetView = false;
    _applyFilters();
  }

  void _applyFilters() {
    var filtered = _dataService.spots;

    // 선택된 필터에 따라 장소 필터링
    if (_selectedFilter != '전체') {
      filtered = filtered.where((spot) {
        switch (_selectedFilter) {
          case '바다뷰':
            return spot.hasOceanView;
          case '야경명소':
            return spot.features.contains('야경명소');
          case '강/호수뷰':
            return spot.hasRiverView;
          case '일몰명소':
            return spot.features.contains('일몰명소');
          default:
            return true;
        }
      }).toList();
    }

    // 검색어 필터링
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((spot) =>
          spot.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (spot.address?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
          spot.features.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    // 기타 필터 적용
    if (_freeParking) filtered = filtered.where((spot) => spot.hasFreeParking).toList();
    if (_hasToilet) filtered = filtered.where((spot) => spot.hasToilet).toList();
    if (_oceanView) filtered = filtered.where((spot) => spot.hasOceanView).toList();
    if (_nightView) filtered = filtered.where((spot) => spot.hasNightView).toList();
    if (_riverView) filtered = filtered.where((spot) => spot.hasRiverView).toList();
    if (_sunsetView) filtered = filtered.where((spot) => spot.hasSunsetView).toList();

    _filteredSpots = filtered;
    notifyListeners();
  }

  bool get hasActiveFilters {
    return _searchQuery.isNotEmpty ||
        _selectedFilter != '전체' ||
        _freeParking ||
        _hasToilet ||
        _oceanView ||
        _nightView ||
        _riverView ||
        _sunsetView;
  }
} 