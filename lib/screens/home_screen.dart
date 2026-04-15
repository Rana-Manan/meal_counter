import 'package:flutter/material.dart';
import '../models/meal_item.dart';
import '../widgets/meal_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<List<MealItem>> meals = List.generate(6, (_) => []);
  List<bool> isEditing = List.generate(6, (_) => false);

  //  Meal Names
  List<String> mealNames = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Snacks",
    "Evening",
    "Night",
  ];

  //  Meal Icons
  List<IconData> mealIcons = [
    Icons.wb_sunny,        // Breakfast
    Icons.lunch_dining,    // Lunch
    Icons.dinner_dining,   // Dinner
    Icons.fastfood,        // Snacks
    Icons.wb_twilight,     // Evening
    Icons.nightlight_round // Night
  ];

  void addItem(int index) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController calController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Food"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Food Name"),
              ),
              TextField(
                controller: calController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Calories"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty &&
                    calController.text.isNotEmpty) {
                  setState(() {
                    meals[index].add(
                      MealItem(
                        name: nameController.text,
                        calories: int.parse(calController.text),
                      ),
                    );
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void removeItem(int mealIndex, int itemIndex) {
    setState(() {
      meals[mealIndex].removeAt(itemIndex);
    });
  }

  int getTotalCalories(int index) {
    return meals[index].fold(0, (sum, item) => sum + item.calories);
  }

  void toggleEdit(int index) {
    setState(() {
      isEditing[index] = !isEditing[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meals"),
        actions: const [
          Icon(Icons.favorite_border),
          SizedBox(width: 10),
          Icon(Icons.more_vert),
          SizedBox(width: 10),
        ],
      ),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return MealCard(
            title: mealNames[index],   //  Updated
            icon: mealIcons[index],    //  NEW (IMPORTANT)
            items: meals[index],
            totalCalories: getTotalCalories(index),
            isEditing: isEditing[index],
            onAdd: () => addItem(index),
            onDelete: (i) => removeItem(index, i),
            onEditToggle: () => toggleEdit(index),
          );
        },
      ),
    );
  }
}