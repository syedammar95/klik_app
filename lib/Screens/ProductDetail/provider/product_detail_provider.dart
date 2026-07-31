import 'package:flutter/material.dart';

/// Product Detail Provider
/// Manages state for the product detail screen including:
/// - Image carousel navigation
/// - Description expansion state
/// - Tab synchronization
class ProductDetailProvider extends ChangeNotifier {
  // Image carousel state
  int _currentImageIndex = 0;
  int get currentImageIndex => _currentImageIndex;

  // Description expansion state
  bool _isDescriptionExpanded = false;
  bool get isDescriptionExpanded => _isDescriptionExpanded;

  // Tab synchronization state
  bool _isScrolling = false;
  bool get isScrolling => _isScrolling;

  // Current active tab index
  int _currentTabIndex = 0;
  int get currentTabIndex => _currentTabIndex;

  // Section positions for scroll synchronization
  final Map<String, double> _sectionPositions = {};
  Map<String, double> get sectionPositions =>
      Map.unmodifiable(_sectionPositions);

  /// Update current image index
  void updateImageIndex(int index) {
    if (_currentImageIndex != index) {
      _currentImageIndex = index;
      notifyListeners();
    }
  }

  /// Toggle description expansion state
  void toggleDescriptionExpansion() {
    _isDescriptionExpanded = !_isDescriptionExpanded;
    notifyListeners();
  }

  /// Set description expansion state
  void setDescriptionExpansion(bool isExpanded) {
    if (_isDescriptionExpanded != isExpanded) {
      _isDescriptionExpanded = isExpanded;
      notifyListeners();
    }
  }

  /// Set scrolling state for tab synchronization
  void setScrolling(bool isScrolling) {
    if (_isScrolling != isScrolling) {
      _isScrolling = isScrolling;
      notifyListeners();
    }
  }

  /// Update current tab index
  void updateTabIndex(int index) {
    if (_currentTabIndex != index) {
      _currentTabIndex = index;
      notifyListeners();
    }
  }

  /// Update section position for scroll synchronization
  void updateSectionPosition(String sectionName, double position) {
    _sectionPositions[sectionName] = position;
  }

  /// Get the correct tab index based on scroll position
  int getTabIndexForScrollPosition(double scrollOffset) {
    // Define section order: Overview (0), Product Details (1), Ratings & Reviews (2)
    const sectionOrder = ['overview', 'productDetails', 'ratings'];

    for (int i = sectionOrder.length - 1; i >= 0; i--) {
      final sectionName = sectionOrder[i];
      final position = _sectionPositions[sectionName];
      if (position != null && scrollOffset >= position - 100) {
        // 100px threshold
        return i;
      }
    }
    return 0; // Default to first tab
  }

  /// Reset all states
  void resetStates() {
    _currentImageIndex = 0;
    _isDescriptionExpanded = false;
    _isScrolling = false;
    _currentTabIndex = 0;
    _sectionPositions.clear();
    notifyListeners();
  }
}
