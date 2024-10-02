import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';

class CustomBuildDashboardView extends StatelessWidget {
  IconData icon;
  String title;

    CustomBuildDashboardView({
    required this.icon,
    required this.title,
  });
   @override
  Widget build(BuildContext context) {
    return _buildDashboardItem(icon,title);
  }
Widget _buildDashboardItem(IconData icon, String title) {
    return Card(
      elevation: 2,
      color: ColorConstant.whiteA700,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          // Handle navigation
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height:80,
            width: 80,
            decoration:BoxDecoration(color: Colors.redAccent.withOpacity(0.36),borderRadius: BorderRadius.all(Radius.circular(15))),child:
            Icon(
              icon,
              size: 50,
              color: Colors.red,
            ),),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}