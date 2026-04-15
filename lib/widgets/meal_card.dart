import 'package:flutter/material.dart';
import '../models/meal_item.dart';
import 'food_item_tile.dart';

class MealCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<MealItem> items;
  final int totalCalories;
  final bool isEditing;
  final VoidCallback onAdd;
  final Function(int) onDelete;
  final VoidCallback onEditToggle;

  const MealCard({
    super.key,
    required this.title,
    required this.icon,
    required this.items,
    required this.totalCalories,
    required this.isEditing,
    required this.onAdd,
    required this.onDelete,
    required this.onEditToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [

          // 🔹 Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1EDE8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              Row(
                children: [
                  GestureDetector(
                    onTap: onEditToggle,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Text(isEditing ? "Save" : "Edit"),
                    ),
                  ),
                  const SizedBox(width: 10),

                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF3E2F2F),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: onAdd,
                    ),
                  )
                ],
              )
            ],
          ),

          const SizedBox(height: 10),

          // 🔹 No Items
          if (items.isEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                "No Products",
                style: TextStyle(color: Colors.grey),
              ),
            ),

          // 🔹 Items List
          ...items.asMap().entries.map((entry) {
            int index = entry.key;
            MealItem item = entry.value;

            return FoodItemTile(
              item: item,
              isEditing: isEditing,
              onDelete: () => onDelete(index),
            );
          }),

          // 🔹 Total Calories
          if (items.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "$totalCalories Cals",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}