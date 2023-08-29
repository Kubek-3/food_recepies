import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_recepies/data/dummy_data.dart';

final mealsProvider = Provider((fer) {
  return dummyMeals;
});
