import 'package:flutter/material.dart';
import '../models/meal_item.dart';

class FoodItemTile extends StatelessWidget {
  final MealItem item;
  final bool isEditing;
  final VoidCallback onDelete;

  const FoodItemTile({
    super.key,
    required this.item,
    required this.isEditing,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F5F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(item.name),

          Row(
            children: [
              Text("${item.calories} Cals"),

              const SizedBox(width: 10),

              GestureDetector(
                onTap: isEditing ? onDelete : null,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor:
                  isEditing ? Colors.red : Colors.grey.shade300,
                  child: Icon(
                    isEditing ? Icons.close : Icons.arrow_forward_ios,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      )
    );
  }
}