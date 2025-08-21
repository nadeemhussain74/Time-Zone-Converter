//import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CityTime {
  final String city;
  final String country;
  final double offset;

  CityTime(this.city, this.country, this.offset);
}

class TimezoneHelper {
  static final List<CityTime> cities = [
    CityTime('Austin', 'USA', -5),
    CityTime('New York', 'USA', -4),
    CityTime('Los Angeles', 'USA', -7),
    CityTime('Toronto', 'Canada', -4),
    CityTime('Mexico City', 'Mexico', -6),
    CityTime('Buenos Aires', 'Argentina', -3),
    CityTime('São Paulo', 'Brazil', -3),
    CityTime('London', 'United Kingdom', 1),
    CityTime('Paris', 'France', 2),
    CityTime('Berlin', 'Germany', 2),
    CityTime('Madrid', 'Spain', 2),
    CityTime('Rome', 'Italy', 2),
    CityTime('Cairo', 'Egypt', 2),
    CityTime('Moscow', 'Russia', 3),
    CityTime('Istanbul', 'Turkey', 3),
    CityTime('Athens', 'Greece', 3),
    CityTime('Kiev', 'Ukraine', 3),
    CityTime('Jerusalem', 'Israel', 3),
    CityTime('Dubai', 'UAE', 4),
    CityTime('Tehran', 'Iran', 3.5),
    CityTime('Karachi', 'Pakistan', 5),
    CityTime('Mumbai', 'India', 5.5),
    CityTime('Dhaka', 'Bangladesh', 6),
    CityTime('Bangkok', 'Thailand', 7),
    CityTime('Jakarta', 'Indonesia', 7),
    CityTime('Beijing', 'China', 8),
    CityTime('Singapore', 'Singapore', 8),
    CityTime('Kuala Lumpur', 'Malaysia', 8),
    CityTime('Tokyo', 'Japan', 9),
    CityTime('Seoul', 'South Korea', 9),
    CityTime('Sydney', 'Australia', 10),
    CityTime('Auckland', 'New Zealand', 12),
    CityTime('Cape Town', 'South Africa', 2),
    CityTime('Nairobi', 'Kenya', 3),
    CityTime('Lagos', 'Nigeria', 1),
    CityTime('Casablanca', 'Morocco', 1),
    CityTime('Reykjavik', 'Iceland', 0),
    CityTime('Oslo', 'Norway', 2),
    CityTime('Stockholm', 'Sweden', 2),
    CityTime('Helsinki', 'Finland', 3),
    CityTime('Lisbon', 'Portugal', 1),
    CityTime('Warsaw', 'Poland', 2),
    CityTime('Prague', 'Czech Republic', 2),
    CityTime('Vienna', 'Austria', 2),
    CityTime('Budapest', 'Hungary', 2),
    CityTime('Zurich', 'Switzerland', 2),
    CityTime('Brussels', 'Belgium', 2),
    CityTime('Amsterdam', 'Netherlands', 2),
    CityTime('Bucharest', 'Romania', 3),
    CityTime('Belgrade', 'Serbia', 2),
    CityTime('Sofia', 'Bulgaria', 3),
    CityTime('Hanoi', 'Vietnam', 7),
    CityTime('Manila', 'Philippines', 8),
    CityTime('Yangon', 'Myanmar', 6.5),
    CityTime('Kathmandu', 'Nepal', 5.75),
    CityTime('Colombo', 'Sri Lanka', 5.5),
    CityTime('Tashkent', 'Uzbekistan', 5),
    CityTime('Riyadh', 'Saudi Arabia', 3),
    CityTime('Baghdad', 'Iraq', 3),
    CityTime('Doha', 'Qatar', 3),
    CityTime('Kuwait City', 'Kuwait', 3),
    CityTime('Amman', 'Jordan', 3),
    CityTime('Damascus', 'Syria', 3),
    CityTime('Beirut', 'Lebanon', 3),
    CityTime('Addis Ababa', 'Ethiopia', 3),
    CityTime('Algiers', 'Algeria', 1),
    CityTime('Caracas', 'Venezuela', -4),
    CityTime('Santiago', 'Chile', -4),
    CityTime('Lima', 'Peru', -5),
    CityTime('Bogotá', 'Colombia', -5),
    CityTime('Quito', 'Ecuador', -5),
    CityTime('Honolulu', 'Hawaii (USA)', -10),
    CityTime('Anchorage', 'Alaska (USA)', -8),
  ];
  static DateTime getTime(DateTime baseUtcTime, double offsetHours) {
    int hours = offsetHours.truncate();
    int minutes = ((offsetHours - hours) * 60).round();
    return baseUtcTime.add(Duration(hours: hours, minutes: minutes));
  }

  // static DateTime getTime(DateTime baseUtcTime, double offsetHours) {
  //   return baseUtcTime.add(Duration(hours: offsetHours));
  // }

  static String formatTime(DateTime dateTime, {bool is24HourFormat = false}) {
    return is24HourFormat
        ? DateFormat.Hm().format(dateTime)
        : DateFormat.jm().format(dateTime);
  }
}
