import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../models/gym_details.dart';
import 'widgets/amenities_grid.dart';
import 'widgets/expandable_description.dart';
import 'widgets/reserve_bottom_bar.dart';

class GymDetailsPage extends StatelessWidget {
  final GymDetailsModel gymDetails;

  const GymDetailsPage({
    super.key,
    this.gymDetails = GymDetailsModel.sampleDetails,
  });

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.paddingOf(context).top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 350 + statusBarHeight,
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          gymDetails.imagePath,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                        Positioned(
                          top: statusBarHeight + 17,
                          left: 24,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                color: Color(0xADFFFFFF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: statusBarHeight + 17,
                          right: 22,
                          child: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 17,
                              color: Color(0xFFFFB23F),
                            ),
                            const SizedBox(width: 7),
                            Text(
                              gymDetails.rating.toString(),
                              style: const TextStyle(
                                color: kInk,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              '(${gymDetails.reviewCount} reviews)',
                              style: const TextStyle(
                                fontSize: 13,
                                color: kGrey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          gymDetails.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: kInk,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          gymDetails.location,
                          style: const TextStyle(fontSize: 14, color: kGrey),
                        ),
                        const SizedBox(height: 16),
                        const Divider(color: kLine, height: 1),
                        const SizedBox(height: 21),
                        ExpandableDescription(text: gymDetails.description),
                        const SizedBox(height: 20),
                        const Text(
                          'Amenities',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: kInk,
                          ),
                        ),
                        const SizedBox(height: 16),
                        AmenitiesGrid(amenities: gymDetails.amenities),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: ReserveBottomBar(
                price: gymDetails.pricePerWeek,
                onReserveTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reservation requested!')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
