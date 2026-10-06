import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/fitness_cubit.dart';
import '../../bloc/fitness_state.dart';
import '../../core/constants/app_colors.dart';
import '../../models/fitness_models.dart';
import 'widgets/amenities_grid.dart';
import 'widgets/expandable_description.dart';
import 'widgets/reserve_bottom_bar.dart';

class GymDetailsPage extends StatelessWidget {
  const GymDetailsPage({super.key});

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
        body: BlocBuilder<FitnessCubit, FitnessState>(
          builder: (context, state) {
            GymDetailsJsonModel gymDetails;

            if (state is FitnessSuccess) {
              gymDetails = state.data.gymDetails;
            } else {
              gymDetails = const GymDetailsJsonModel(
                id: 'gym001',
                name: 'Mid City Gym Training',
                location: 'California, New York',
                heroImageUrl:
                    'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?auto=format&fit=crop&w=1200&q=90',
                rating: 4.5,
                reviewCount: 1232,
                description:
                    'Lorem ipsum dolor sit amet consectetur. Blandit vitae aliquet eros laoreet quam sollicitudin. Duis non euhabitant id vel nisi eget amet tellus...',
                descriptionExpanded: false,
                amenities: [
                  GymAmenity(
                      id: 'showers',
                      name: 'Showers',
                      iconUrl:
                          'https://api.iconify.design/mdi/shower-head.svg?color=%23808A9B&width=28'),
                  GymAmenity(
                      id: 'lockers',
                      name: 'Lockers',
                      iconUrl:
                          'https://api.iconify.design/mdi/locker-multiple.svg?color=%23808A9B&width=28'),
                ],
                priceAmount: 69.0,
                priceCurrency: 'USD',
                pricePeriod: 'week',
                priceFormatted: '\$69.00 /week',
              );
            }

            return Stack(
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
                            Image.network(
                              gymDetails.heroImageUrl,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                              errorBuilder: (_, __, ___) => Image.asset(
                                'assets/images/gym.jpg',
                                fit: BoxFit.cover,
                              ),
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
                              gymDetails.name,
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
                    price: gymDetails.priceAmount,
                    period: '/${gymDetails.pricePeriod}',
                    onReserveTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Reservation requested!')),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
