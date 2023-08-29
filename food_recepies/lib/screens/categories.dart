import 'package:flutter/material.dart';
import 'package:food_recepies/data/dummy_data.dart';
import 'package:food_recepies/screens/meals.dart';
import 'package:food_recepies/widgets/category_grid_item.dart';
import 'package:food_recepies/models/category.dart';
import 'package:food_recepies/models/meal.dart';

class CategotiesScreen extends StatefulWidget {
  const CategotiesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategotiesScreen> createState() => _CategotiesScreenState();
}

class _CategotiesScreenState extends State<CategotiesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onTapped: () {
                _selectCategory(context, category);
              },
            )
          // availableCategories.map((category) => CategoryGridItem(category: category)).toList()
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 1),
          end: const Offset(0, 0),
        ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCirc)),
        child: child,
      ),
    );
  }
}
