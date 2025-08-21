import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/timezone_helper.dart';

enum DayPeriod { morning, midday, evening, night }

DayPeriod getDayPeriod(DateTime time) {
  final hour = time.hour;
  if (hour >= 5 && hour < 12) {
    return DayPeriod.morning;
  } else if (hour >= 12 && hour < 17) {
    return DayPeriod.midday;
  } else if (hour >= 17 && hour < 20) {
    return DayPeriod.evening;
  } else {
    return DayPeriod.night;
  }
}

String getBackgroundImage(DayPeriod period) {
  switch (period) {
    case DayPeriod.morning:
      return 'assets/images/morning.jpg';
    case DayPeriod.midday:
      return 'assets/images/midday.jpg';
    case DayPeriod.evening:
      return 'assets/images/evening.jpg';
    case DayPeriod.night:
    default:
      return 'assets/images/night.jpg';
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Timer _timer;
  DateTime currentUtcTime = DateTime.now().toUtc();
  bool use24HourFormat = false;
  bool showWeather = false;

  late String userTimezone;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> filteredCities = [];

  @override
  void initState() {
    super.initState();
    userTimezone = DateTime.now().timeZoneName;
    filteredCities = List.from(TimezoneHelper.cities);
    _searchController.addListener(_filterCities);

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        currentUtcTime = DateTime.now().toUtc();
      });
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCities);
    _searchController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _filterCities() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredCities = List.from(TimezoneHelper.cities);
      } else {
        filteredCities = TimezoneHelper.cities.where((city) {
          return city.city.toLowerCase().contains(query) ||
              city.country.toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top bar with search
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                color: Colors.pinkAccent.withOpacity(0.8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Search city...',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                        textInputAction: TextInputAction.search,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      userTimezone,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              // Toggle switches
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Use 24-hour format"),
                        Switch(
                          value: use24HourFormat,
                          onChanged: (value) {
                            setState(() => use24HourFormat = value);
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Show weather"),
                        Switch(
                          value: showWeather,
                          onChanged: (value) {
                            setState(() => showWeather = value);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // City cards (filtered)
              Expanded(
                child: ListView.builder(
                  itemCount: filteredCities.length,
                  itemBuilder: (context, index) {
                    var city = filteredCities[index];
                    DateTime time =
                        TimezoneHelper.getTime(currentUtcTime, city.offset);

                    // DateTime time = TimezoneHelper.getTime(
                    //   currentUtcTime,
                    //   city.offset,

                    DayPeriod period = getDayPeriod(time);
                    String bgImage = getBackgroundImage(period);

                    return buildTimeCard(
                      city: city.city,
                      country: city.country,
                      time: time,
                      backgroundImage: bgImage,
                      is24Hour: use24HourFormat,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTimeCard({
    required String city,
    required String country,
    required DateTime time,
    required String backgroundImage,
    required bool is24Hour,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          is24Hour
              ? Text(
                  DateFormat('HH:mm:ss').format(time),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              : Row(
                  children: [
                    Text(
                      DateFormat('hh:mm:ss').format(time),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      DateFormat('a').format(time), // AM or PM
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),

          const SizedBox(height: 4),

          // FULL DATE
          Text(
            DateFormat('EEEE, d MMMM yyyy').format(time),
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 8),

          // CITY NAME
          Text(
            city,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          // Text(
          //   TimezoneHelper.formatTime(time, is24HourFormat: is24Hour),
          //   style: const TextStyle(
          //     fontSize: 32,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.white,
          //   ),
          // ),
          // const SizedBox(height: 4),
          // Text(
          //   DateFormat('EEEE, d MMMM, yyyy ').format(time),
          //   style: const TextStyle(color: Colors.white70),
          // ),
          // const SizedBox(height: 8),
          // Text(
          //   city,
          //   style: const TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.w500,
          //     color: Colors.white,
          //   ),
          // ),
        ],
      ),
    );
  }
}
