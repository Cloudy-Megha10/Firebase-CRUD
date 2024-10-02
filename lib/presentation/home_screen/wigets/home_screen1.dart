// Pages with dynamic content
import 'package:flutter/material.dart';

import '../../../widgets/custom_build_dashboard_view.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          CustomBuildDashboardView(icon: Icons.apartment, title: 'Manage Club'),
          CustomBuildDashboardView(icon:Icons.people, title:'Manage Members'),
          CustomBuildDashboardView(icon:Icons.photo, title:'Manage Gallery'),
          CustomBuildDashboardView(icon:Icons.folder, title:'Manage Resources'),
          CustomBuildDashboardView(icon:Icons.assignment, title:'Manage Report'),
        ],
      ),
    );
  }

}