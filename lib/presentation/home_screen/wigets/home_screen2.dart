// Pages with dynamic content
import 'package:flutter/material.dart';

import '../../../widgets/custom_build_dashboard_view.dart';

class HomeWidget2 extends StatelessWidget {
  const HomeWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          CustomBuildDashboardView(icon:Icons.people, title:'Manage Members'),
          CustomBuildDashboardView(icon:Icons.photo, title:'Manage Gallery'),
          CustomBuildDashboardView(icon:Icons.assignment, title:'Manage Report'),
        ],
      ),
    );
  }

}