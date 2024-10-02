// Pages with dynamic content
import 'package:flutter/material.dart';

import '../../../widgets/custom_build_dashboard_view.dart';

class HomeWidget3 extends StatelessWidget {
  const HomeWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          CustomBuildDashboardView(icon:Icons.chat, title:'Chat'),
          CustomBuildDashboardView(icon:Icons.people, title:'Manage Members'),
          CustomBuildDashboardView(icon:Icons.photo, title:'Manage Gallery'),
          CustomBuildDashboardView(icon:Icons.folder, title:'Manage Resources'),
        ],
      ),
    );
  }

}