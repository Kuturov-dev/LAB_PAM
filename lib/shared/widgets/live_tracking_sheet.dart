import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class LiveTrackingSheet extends StatefulWidget {
  final int currentKm;
  final int totalGoalKm;
  final ValueChanged<int> onProgressUpdated;

  const LiveTrackingSheet({
    super.key,
    required this.currentKm,
    required this.totalGoalKm,
    required this.onProgressUpdated,
  });

  @override
  State<LiveTrackingSheet> createState() => _LiveTrackingSheetState();
}

class _LiveTrackingSheetState extends State<LiveTrackingSheet> {
  late double _distanceKm;
  late int _steps;
  int _secondsElapsed = 0;
  bool _isRunning = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _distanceKm = widget.currentKm.toDouble();
    _steps = (widget.currentKm * 1350); // ~1350 steps per km
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toggleTracking() {
    if (_isRunning) {
      _timer?.cancel();
      setState(() {
        _isRunning = false;
      });
    } else {
      setState(() {
        _isRunning = true;
      });
      _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        setState(() {
          _secondsElapsed++;
          _steps += 12; // Simulate ~24 steps per second
          _distanceKm += 0.015; // Simulate ~0.03 km per second

          if (_distanceKm >= widget.totalGoalKm) {
            _distanceKm = widget.totalGoalKm.toDouble();
            _timer?.cancel();
            _isRunning = false;
          }
        });
      });
    }
  }

  String _formatTime(int totalSeconds) {
    final mins = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final secs = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final calories = (_steps * 0.045).round();
    final progress = (_distanceKm / widget.totalGoalKm).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Live Running Session',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kInk,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Real-time Pedometer & GPS Simulator',
                    style: TextStyle(fontSize: 12, color: kGrey),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  widget.onProgressUpdated(_distanceKm.round());
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MetricTile(
                icon: Icons.timer_outlined,
                label: 'Duration',
                value: _formatTime(_secondsElapsed),
              ),
              _MetricTile(
                icon: Icons.directions_walk,
                label: 'Steps',
                value: '$_steps',
              ),
              _MetricTile(
                icon: Icons.local_fire_department_outlined,
                label: 'Calories',
                value: '$calories kcal',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 10,
                  backgroundColor: kLine,
                  valueColor: const AlwaysStoppedAnimation<Color>(kGreen),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _distanceKm.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: kInk,
                    ),
                  ),
                  Text(
                    'of ${widget.totalGoalKm} km',
                    style: const TextStyle(fontSize: 13, color: kGrey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _toggleTracking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isRunning ? const Color(0xFFED475B) : kGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(
                    _isRunning ? 'Pause Session' : 'Start Running Session',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _MetricTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: kGreen, size: 22),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: kInk)),
        Text(label, style: const TextStyle(fontSize: 12, color: kGrey)),
      ],
    );
  }
}
