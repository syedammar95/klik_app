import 'package:flutter/material.dart';
import '../Utils/cache/category_cache_manager.dart';

/// ✅ **Cache Status Widget**
/// Debug widget to show cache status and allow cache management
class CacheStatusWidget extends StatefulWidget {
  const CacheStatusWidget({super.key});

  @override
  State<CacheStatusWidget> createState() => _CacheStatusWidgetState();
}

class _CacheStatusWidgetState extends State<CacheStatusWidget> {
  final CategoryCacheManager _cacheManager = CategoryCacheManager();
  Map<String, dynamic> _cacheStatus = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCacheStatus();
  }

  Future<void> _loadCacheStatus() async {
    setState(() => _isLoading = true);
    try {
      final status = await _cacheManager.getCacheStatus();
      setState(() {
        _cacheStatus = status;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      debugPrint("Error loading cache status: $e");
    }
  }

  Future<void> _clearAllCache() async {
    setState(() => _isLoading = true);
    try {
      await _cacheManager.clearAllCache();
      await _loadCacheStatus();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cache cleared successfully")),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error clearing cache: $e")),
        );
      }
    }
  }

  Future<void> _clearExpiredCache() async {
    setState(() => _isLoading = true);
    try {
      await _cacheManager.clearExpiredCache();
      await _loadCacheStatus();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Expired cache cleared")),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error clearing expired cache: $e")),
        );
      }
    }
  }

  String _formatAge(int? ageInSeconds) {
    if (ageInSeconds == null || ageInSeconds < 0) return "Unknown";
    if (ageInSeconds < 60) return "${ageInSeconds}s";
    if (ageInSeconds < 3600) return "${ageInSeconds ~/ 60}m";
    return "${ageInSeconds ~/ 3600}h";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Cache Status",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: _isLoading ? null : _loadCacheStatus,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.refresh),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildStatusRow(
              "Categories",
              _cacheStatus['categories_cached'] == true,
              _formatAge(_cacheStatus['categories_cache_age']),
            ),
            _buildStatusRow(
              "Products",
              _cacheStatus['products_cached'] == true,
              _formatAge(_cacheStatus['products_cache_age']),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _clearExpiredCache,
                    icon: const Icon(Icons.cleaning_services, size: 16),
                    label: const Text("Clear Expired"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _clearAllCache,
                    icon: const Icon(Icons.clear_all, size: 16),
                    label: const Text("Clear All"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, bool isCached, String age) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Row(
            children: [
              Icon(
                isCached ? Icons.check_circle : Icons.cancel,
                color: isCached ? Colors.green : Colors.red,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                isCached ? "Cached ($age)" : "Not cached",
                style: TextStyle(
                  color: isCached ? Colors.green : Colors.red,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
