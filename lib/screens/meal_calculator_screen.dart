import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class MealCalculatorScreen extends StatefulWidget {
  const MealCalculatorScreen({super.key});

  @override
  State<MealCalculatorScreen> createState() => _MealCalculatorScreenState();
}

class _MealCalculatorScreenState extends State<MealCalculatorScreen> {
  String _selectedFuelType = '휘발유';
  int _calculationMode = 0; // 0: 금액→거리, 1: 거리→금액
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();

  // 연료별 기본 정보
  final Map<String, Map<String, dynamic>> _fuelData = {
    '휘발유': {
      'price': 1650, // 원/L
      'efficiency': 12.0, // km/L
      'unit': 'L',
      'icon': HeroIcons.fire,
      'color': Color(0xFF007AFF),
    },
    '경유': {
      'price': 1450, // 원/L
      'efficiency': 15.0, // km/L
      'unit': 'L',
      'icon': HeroIcons.fire,
      'color': Color(0xFF34C759),
    },
    'LPG': {
      'price': 950, // 원/L
      'efficiency': 9.0, // km/L
      'unit': 'L',
      'icon': HeroIcons.fire,
      'color': Color(0xFFFF9500),
    },
    '전기': {
      'price': 300, // 원/kWh
      'efficiency': 5.0, // km/kWh
      'unit': 'kWh',
      'icon': HeroIcons.bolt,
      'color': Color(0xFF30D158),
    },
  };

  double get fuelPrice => _fuelData[_selectedFuelType]!['price'].toDouble();
  double get fuelEfficiency => _fuelData[_selectedFuelType]!['efficiency'].toDouble();
  String get fuelUnit => _fuelData[_selectedFuelType]!['unit'];

  // 계산 결과
  double get calculatedDistance {
    if (_calculationMode == 0 && _amountController.text.isNotEmpty) {
      final amount = double.tryParse(_amountController.text) ?? 0.0;
      final fuelAmount = amount / fuelPrice;
      return fuelAmount * fuelEfficiency;
    }
    return 0.0;
  }

  double get calculatedAmount {
    if (_calculationMode == 1 && _distanceController.text.isNotEmpty) {
      final distance = double.tryParse(_distanceController.text) ?? 0.0;
      final fuelAmount = distance / fuelEfficiency;
      return fuelAmount * fuelPrice;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  const Text(
                    '밥 계산기',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1C1C1E),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '🍚',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 차량 유종 선택
                      _buildFuelTypeSection(),
                      const SizedBox(height: 32),
                      
                      // 계산 모드 선택
                      _buildCalculationModeSection(),
                      const SizedBox(height: 24),
                      
                      // 입력 필드
                      _buildInputSection(),
                      const SizedBox(height: 32),
                      
                      // 계산 결과
                      _buildResultSection(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFuelTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '우리 차는 뭘 먹어요?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: _fuelData.keys.map((fuelType) {
            final isSelected = _selectedFuelType == fuelType;
            final fuelInfo = _fuelData[fuelType]!;
            
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedFuelType = fuelType;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? fuelInfo['color'] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? fuelInfo['color'] : Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      HeroIcon(
                        fuelInfo['icon'],
                        style: HeroIconStyle.outline,
                        size: 28,
                        color: isSelected ? Colors.white : Colors.grey[600],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        fuelType,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCalculationModeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '무엇을 알고 싶나요?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _calculationMode = 0;
                      _distanceController.clear();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _calculationMode == 0 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: _calculationMode == 0 ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ] : null,
                    ),
                    child: Text(
                      '💰 → 📏\n밥값으로 얼마나 갈까?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: _calculationMode == 0 ? FontWeight.w600 : FontWeight.w400,
                        color: _calculationMode == 0 ? Colors.black : Colors.grey[600],
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _calculationMode = 1;
                      _amountController.clear();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _calculationMode == 1 ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: _calculationMode == 1 ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ] : null,
                    ),
                    child: Text(
                      '📏 → 💰\n이 거리는 밥값이 얼마?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: _calculationMode == 1 ? FontWeight.w600 : FontWeight.w400,
                        color: _calculationMode == 1 ? Colors.black : Colors.grey[600],
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInputSection() {
    if (_calculationMode == 0) {
      return _buildInputField(
        controller: _amountController,
        label: '밥값 얼마 줄까요?',
        hint: '금액을 입력하세요',
        suffix: '원',
        icon: HeroIcons.currencyDollar,
      );
    } else {
      return _buildInputField(
        controller: _distanceController,
        label: '얼마나 가고 싶나요?',
        hint: '거리를 입력하세요',
        suffix: 'km',
        icon: HeroIcons.mapPin,
      );
    }
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required String suffix,
    required HeroIcons icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            onChanged: (_) => setState(() {}),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(16),
                child: HeroIcon(
                  icon,
                  style: HeroIconStyle.outline,
                  size: 24,
                  color: _fuelData[_selectedFuelType]!['color'],
                ),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  suffix,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultSection() {
    final hasResult = (_calculationMode == 0 && calculatedDistance > 0) ||
                     (_calculationMode == 1 && calculatedAmount > 0);

    if (!hasResult) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Center(
          child: Column(
            children: [
              const Text(
                '🍚',
                style: TextStyle(fontSize: 48),
              ),
              const SizedBox(height: 16),
              Text(
                '위에 값을 입력하면\n결과가 나타나요!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _fuelData[_selectedFuelType]!['color'],
            (_fuelData[_selectedFuelType]!['color'] as Color).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _fuelData[_selectedFuelType]!['color'].withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                '🍚',
                style: TextStyle(fontSize: 32),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _calculationMode == 0 ? '이만큼 갈 수 있어요!' : '이만큼 밥을 줘야 해요!',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Text(
                  _calculationMode == 0 
                    ? '${calculatedDistance.toStringAsFixed(1)} km'
                    : '${calculatedAmount.toStringAsFixed(0)} 원',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _calculationMode == 0 
                    ? '주행 가능 거리'
                    : '필요한 밥값',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 상세 정보
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildDetailRow('연료 종류', _selectedFuelType),
                const SizedBox(height: 8),
                _buildDetailRow('연비/전비', '${fuelEfficiency}km/$fuelUnit'),
                const SizedBox(height: 8),
                _buildDetailRow('$_selectedFuelType 가격', '${fuelPrice.toStringAsFixed(0)}원/$fuelUnit'),
                if (_calculationMode == 0) ...[
                  const SizedBox(height: 8),
                  _buildDetailRow('필요한 ${_selectedFuelType}', 
                    '${(double.parse(_amountController.text.isEmpty ? '0' : _amountController.text) / fuelPrice).toStringAsFixed(1)}$fuelUnit'),
                ] else ...[
                  const SizedBox(height: 8),
                  _buildDetailRow('필요한 ${_selectedFuelType}', 
                    '${(double.parse(_distanceController.text.isEmpty ? '0' : _distanceController.text) / fuelEfficiency).toStringAsFixed(1)}$fuelUnit'),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _distanceController.dispose();
    super.dispose();
  }
} 