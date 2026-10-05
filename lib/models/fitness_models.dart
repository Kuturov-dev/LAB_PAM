class HeaderData {
  final String date;
  final String greeting;
  final bool hasUnreadNotification;
  final String notificationIconUrl;

  const HeaderData({
    required this.date,
    required this.greeting,
    required this.hasUnreadNotification,
    required this.notificationIconUrl,
  });

  factory HeaderData.fromJson(Map<String, dynamic> json) {
    final notif = json['notification'] as Map<String, dynamic>? ?? {};
    return HeaderData(
      date: json['date'] as String? ?? '',
      greeting: json['greeting'] as String? ?? '',
      hasUnreadNotification: notif['hasUnread'] as bool? ?? false,
      notificationIconUrl: notif['iconUrl'] as String? ?? '',
    );
  }
}

class TodaysChallengeData {
  final String title;
  final String activity;
  final int completed;
  final int total;
  final double progress;
  final String iconUrl;

  const TodaysChallengeData({
    required this.title,
    required this.activity,
    required this.completed,
    required this.total,
    required this.progress,
    required this.iconUrl,
  });

  factory TodaysChallengeData.fromJson(Map<String, dynamic> json) {
    return TodaysChallengeData(
      title: json['title'] as String? ?? '',
      activity: json['activity'] as String? ?? '',
      completed: (json['completed'] as num?)?.toInt() ?? 0,
      total: (json['total'] as num?)?.toInt() ?? 0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      iconUrl: json['iconUrl'] as String? ?? '',
    );
  }

  TodaysChallengeData copyWith({int? completed, double? progress}) {
    return TodaysChallengeData(
      title: title,
      activity: activity,
      completed: completed ?? this.completed,
      total: total,
      progress: progress ?? this.progress,
      iconUrl: iconUrl,
    );
  }
}

class FeaturedPlanItem {
  final String id;
  final String title;
  final String duration;
  final String frequency;
  final String actionLabel;
  final String imageUrl;
  final String durationIconUrl;
  final String frequencyIconUrl;

  const FeaturedPlanItem({
    required this.id,
    required this.title,
    required this.duration,
    required this.frequency,
    required this.actionLabel,
    required this.imageUrl,
    required this.durationIconUrl,
    required this.frequencyIconUrl,
  });

  factory FeaturedPlanItem.fromJson(Map<String, dynamic> json) {
    final meta = json['metaIcons'] as Map<String, dynamic>? ?? {};
    return FeaturedPlanItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      frequency: json['frequency'] as String? ?? '',
      actionLabel: json['actionLabel'] as String? ?? 'Start Now',
      imageUrl: json['imageUrl'] as String? ?? '',
      durationIconUrl: meta['durationIconUrl'] as String? ?? '',
      frequencyIconUrl: meta['frequencyIconUrl'] as String? ?? '',
    );
  }
}

class FilterItem {
  final String id;
  final String name;
  final bool selected;

  const FilterItem({
    required this.id,
    required this.name,
    required this.selected,
  });

  factory FilterItem.fromJson(Map<String, dynamic> json) {
    return FilterItem(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      selected: json['selected'] as bool? ?? false,
    );
  }
}

class WorkoutProgramItem {
  final String id;
  final String title;
  final int calories;
  final int durationMinutes;
  final bool isPro;
  final String imageUrl;
  final String caloriesIconUrl;
  final String durationIconUrl;
  final String? proIconUrl;
  final bool isFavorite;

  const WorkoutProgramItem({
    required this.id,
    required this.title,
    required this.calories,
    required this.durationMinutes,
    required this.isPro,
    required this.imageUrl,
    required this.caloriesIconUrl,
    required this.durationIconUrl,
    this.proIconUrl,
    this.isFavorite = false,
  });

  factory WorkoutProgramItem.fromJson(Map<String, dynamic> json) {
    final icons = json['icons'] as Map<String, dynamic>? ?? {};
    return WorkoutProgramItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      calories: (json['calories'] as num?)?.toInt() ?? 0,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 0,
      isPro: json['isPro'] as bool? ?? false,
      imageUrl: json['imageUrl'] as String? ?? '',
      caloriesIconUrl: icons['caloriesIconUrl'] as String? ?? '',
      durationIconUrl: icons['durationIconUrl'] as String? ?? '',
      proIconUrl: icons['proIconUrl'] as String?,
    );
  }

  WorkoutProgramItem copyWith({bool? isFavorite}) {
    return WorkoutProgramItem(
      id: id,
      title: title,
      calories: calories,
      durationMinutes: durationMinutes,
      isPro: isPro,
      imageUrl: imageUrl,
      caloriesIconUrl: caloriesIconUrl,
      durationIconUrl: durationIconUrl,
      proIconUrl: proIconUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class GymAmenity {
  final String id;
  final String name;
  final String iconUrl;

  const GymAmenity({
    required this.id,
    required this.name,
    required this.iconUrl,
  });

  factory GymAmenity.fromJson(Map<String, dynamic> json) {
    return GymAmenity(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      iconUrl: json['iconUrl'] as String? ?? '',
    );
  }
}

class GymDetailsJsonModel {
  final String id;
  final String name;
  final String location;
  final String heroImageUrl;
  final double rating;
  final int reviewCount;
  final String description;
  final bool descriptionExpanded;
  final List<GymAmenity> amenities;
  final double priceAmount;
  final String priceCurrency;
  final String pricePeriod;
  final String priceFormatted;

  const GymDetailsJsonModel({
    required this.id,
    required this.name,
    required this.location,
    required this.heroImageUrl,
    required this.rating,
    required this.reviewCount,
    required this.description,
    required this.descriptionExpanded,
    required this.amenities,
    required this.priceAmount,
    required this.priceCurrency,
    required this.pricePeriod,
    required this.priceFormatted,
  });

  factory GymDetailsJsonModel.fromJson(Map<String, dynamic> json) {
    final gym = json['gym'] as Map<String, dynamic>? ?? {};
    final pricing = gym['pricing'] as Map<String, dynamic>? ?? {};
    final amenitiesList = (gym['amenities'] as List<dynamic>?)
            ?.map((e) => GymAmenity.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    return GymDetailsJsonModel(
      id: gym['id'] as String? ?? '',
      name: gym['name'] as String? ?? '',
      location: gym['location'] as String? ?? '',
      heroImageUrl: gym['heroImageUrl'] as String? ?? '',
      rating: (gym['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (gym['reviewCount'] as num?)?.toInt() ?? 0,
      description: gym['description'] as String? ?? '',
      descriptionExpanded: gym['descriptionExpanded'] as bool? ?? false,
      amenities: amenitiesList,
      priceAmount: (pricing['amount'] as num?)?.toDouble() ?? 0.0,
      priceCurrency: pricing['currency'] as String? ?? 'USD',
      pricePeriod: pricing['period'] as String? ?? 'week',
      priceFormatted: pricing['formatted'] as String? ?? '',
    );
  }
}

class FitnessAppData {
  final HeaderData header;
  final TodaysChallengeData todaysChallenge;
  final List<FeaturedPlanItem> featuredPlans;
  final List<FilterItem> filters;
  final Map<String, String> filterIconUrls;
  final List<WorkoutProgramItem> workoutPrograms;
  final GymDetailsJsonModel gymDetails;

  const FitnessAppData({
    required this.header,
    required this.todaysChallenge,
    required this.featuredPlans,
    required this.filters,
    required this.filterIconUrls,
    required this.workoutPrograms,
    required this.gymDetails,
  });

  factory FitnessAppData.fromJson(Map<String, dynamic> json) {
    final homePage = json['fitnessHomePage'] as Map<String, dynamic>? ?? {};
    final header = HeaderData.fromJson(homePage['header'] as Map<String, dynamic>? ?? {});
    final todaysChallenge = TodaysChallengeData.fromJson(
        homePage['todaysChallenge'] as Map<String, dynamic>? ?? {});

    final featuredPlansList = (homePage['featuredPlans'] as List<dynamic>?)
            ?.map((e) => FeaturedPlanItem.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    final workoutProgramsObj = homePage['workoutPrograms'] as Map<String, dynamic>? ?? {};
    final filtersList = (workoutProgramsObj['filters'] as List<dynamic>?)
            ?.map((e) => FilterItem.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    final filterIconUrlsObj =
        (workoutProgramsObj['filterIconUrls'] as Map<String, dynamic>?)?.map(
              (k, v) => MapEntry(k, v.toString()),
            ) ??
            {};

    final itemsList = (workoutProgramsObj['items'] as List<dynamic>?)
            ?.map((e) => WorkoutProgramItem.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    final gymDetailsObj =
        GymDetailsJsonModel.fromJson(json['fitnessGymDetailsPage'] as Map<String, dynamic>? ?? {});

    return FitnessAppData(
      header: header,
      todaysChallenge: todaysChallenge,
      featuredPlans: featuredPlansList,
      filters: filtersList,
      filterIconUrls: filterIconUrlsObj,
      workoutPrograms: itemsList,
      gymDetails: gymDetailsObj,
    );
  }
}
