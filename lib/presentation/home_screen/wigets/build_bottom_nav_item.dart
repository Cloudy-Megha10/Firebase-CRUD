import 'package:demo_app/presentation/home_screen/controller/home_controller.dart';
import 'package:flutter/material.dart';

Widget buildBottomNavItem({
  required IconData icon,
  required String label,
  required int index,
  bool isSelected = false,
  required HomeController controller,
}) {
  bool selected = controller.selectedIndex.value == index;

  return GestureDetector(
    onTap: () {
      controller.updateIndex(index);
    },
    child: Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: selected ? Colors.purple.shade700 : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 40, // Ensure this width is enough to avoid overflow
        height: 40, // Ensure this height is enough to avoid overflow
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : Colors.black,
              size: 24, // Adjust icon size to fit within the box
            ),
            SizedBox(height: 4), // Spacing between icon and label
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  label,
                  textAlign: TextAlign.center, // Center the text
                  style: TextStyle(
                    color: selected ? Colors.white : Colors.black,
                    fontSize: 9, // Adjust font size
                  ),
                  //overflow: TextOverflow.ellipsis, // Handle overflow
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
