import 'package:flutter/material.dart';

class AmenityItem {
  final IconData icon;
  final String name;

  const AmenityItem({required this.icon, required this.name});
}

class GymDetailsModel {
  final String title;
  final String imagePath;
  final double rating;
  final int reviewCount;
  final String location;
  final String description;
  final double pricePerWeek;
  final List<AmenityItem> amenities;

  const GymDetailsModel({
    required this.title,
    required this.imagePath,
    required this.rating,
    required this.reviewCount,
    required this.location,
    required this.description,
    required this.pricePerWeek,
    required this.amenities,
  });

  static const sampleDetails = GymDetailsModel(
    title: 'Mid City Gym Training',
    imagePath: 'assets/images/gym.jpg',
    rating: 4.5,
    reviewCount: 1232,
    location: 'California, New York',
    description:
        'Lorem ipsum dolor sit amet consectetur. Blandit vitae aliquet eros laoreet quam sollicitudin. Duis non eu habitant id vel nisi eget amet tellus. Integer nec egestas eros. Sed vulputate nisl in est interdum elementum.',
    pricePerWeek: 69.00,
    amenities: [
      AmenityItem(icon: Icons.shower, name: 'Showers'),
      AmenityItem(icon: Icons.lock_outline, name: 'Lockers'),
      AmenityItem(icon: Icons.wifi, name: 'Free Wi-fi'),
      AmenityItem(icon: Icons.local_parking, name: 'Parking'),
    ],
  );
}
