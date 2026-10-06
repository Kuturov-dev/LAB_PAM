import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/fitness_cubit.dart';
import '../../bloc/fitness_state.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/widgets/state_widgets.dart';
import '../../shared/widgets/svg_icon.dart';
import '../details/gym_details_page.dart';

class AllProgramsPage extends StatelessWidget {
  const AllProgramsPage({super.key});

  void _showSortDialog(BuildContext context) {
    final cubit = context.read<FitnessCubit>();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Sort Programs'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Default Order'),
                onTap: () {
                  cubit.setSortOption(SortOption.none);
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                title: const Text('Duration: Low to High'),
                onTap: () {
                  cubit.setSortOption(SortOption.durationAsc);
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                title: const Text('Duration: High to Low'),
                onTap: () {
                  cubit.setSortOption(SortOption.durationDesc);
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                title: const Text('Calories: Low to High'),
                onTap: () {
                  cubit.setSortOption(SortOption.caloriesAsc);
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                title: const Text('Calories: High to Low'),
                onTap: () {
                  cubit.setSortOption(SortOption.caloriesDesc);
                  Navigator.pop(ctx);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImage(String url) {
    if (url.startsWith('assets/')) {
      return Image.asset(url, fit: BoxFit.cover);
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => Image.asset(
        'assets/images/yoga.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FitnessCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Workout Programs',
          style: TextStyle(color: kInk, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: kInk),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            tooltip: 'Sort Options',
            onPressed: () => _showSortDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<FitnessCubit, FitnessState>(
        builder: (context, state) {
          if (state is FitnessLoading || state is FitnessInitial) {
            return const LoadingStateWidget();
          }

          if (state is FitnessError) {
            return ErrorStateWidget(
              errorMessage: state.errorMessage,
              onRetry: () => cubit.loadData(),
            );
          }

          final searchQuery = (state is FitnessSuccess) ? state.searchQuery : '';

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: TextEditingController(text: searchQuery)
                    ..selection = TextSelection.collapsed(offset: searchQuery.length),
                  onChanged: (val) => cubit.updateSearchQuery(val),
                  decoration: InputDecoration(
                    hintText: 'Search workout programs...',
                    prefixIcon: const Icon(Icons.search, color: kGrey),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: kGrey),
                            onPressed: () => cubit.updateSearchQuery(''),
                          )
                        : null,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: kLine),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: kLine),
                    ),
                  ),
                ),
              ),
              if (state is FitnessSuccess) ...[
                SizedBox(
                  height: 38,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: state.data.filters.length,
                    itemBuilder: (context, index) {
                      final filter = state.data.filters[index];
                      final isSelected = filter.id == state.selectedFilterId;
                      return GestureDetector(
                        onTap: () => cubit.selectFilter(filter.id),
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? kGreen : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: isSelected ? null : Border.all(color: kLine),
                          ),
                          child: Text(
                            filter.name,
                            style: TextStyle(
                              color: isSelected ? Colors.white : kGrey,
                              fontWeight:
                                  isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],
              Expanded(
                child: Builder(
                  builder: (_) {
                    if (state is FitnessEmpty) {
                      return EmptyStateWidget(
                        message: state.message,
                        onResetTap: () {
                          cubit.selectFilter('all');
                          cubit.updateSearchQuery('');
                        },
                      );
                    }

                    if (state is FitnessSuccess) {
                      final programs = state.filteredPrograms;
                      if (programs.isEmpty) {
                        return EmptyStateWidget(
                          message: 'No programs matching current criteria.',
                          onResetTap: () {
                            cubit.selectFilter('all');
                            cubit.updateSearchQuery('');
                          },
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.85,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: programs.length,
                        itemBuilder: (context, index) {
                          final program = programs[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => GymDetailsPage(
                                    title: program.title,
                                    imageUrl: program.imageUrl,
                                    subtitle: '${program.calories} kcal • ${program.durationMinutes} min',
                                    description:
                                        'Comprehensive workout program for ${program.title}. Includes step-by-step guidance and calorie tracking.',
                                    price: 29.00,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  _buildImage(program.imageUrl),
                                  const DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Color(0xD9000000)
                                        ],
                                        stops: [0.38, 1],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    left: 8,
                                    child: GestureDetector(
                                      onTap: () =>
                                          cubit.toggleFavorite(program.id),
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Colors.black38,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          program.isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 18,
                                          color: program.isFavorite
                                              ? const Color(0xFFED475B)
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (program.isPro)
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFE7FFF1),
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                        child: const Row(
                                          children: [
                                            Icon(
                                                Icons
                                                    .workspace_premium_outlined,
                                                size: 12,
                                                color: kGreen),
                                            SizedBox(width: 3),
                                            Text('Pro',
                                                style: TextStyle(
                                                    color: kGreen,
                                                    fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  Positioned(
                                    bottom: 12,
                                    left: 12,
                                    right: 12,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          program.title,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            AppSvgIcon(
                                              url: program.caloriesIconUrl,
                                              size: 11,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              '${program.calories} kcal',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                            const Spacer(),
                                            AppSvgIcon(
                                              url: program.durationIconUrl,
                                              size: 11,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(width: 2),
                                            Text(
                                              '${program.durationMinutes}m',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
