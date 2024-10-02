import 'package:demo_app/core/utils/color_constant.dart';
import 'package:demo_app/presentation/home_screen/controller/home_controller.dart';
import 'package:demo_app/presentation/home_screen/wigets/home_screen2.dart';
import 'package:demo_app/presentation/home_screen/wigets/home_screen3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'wigets/home_screen1.dart';

class HomeScreen extends StatelessWidget {
   final HomeController homeController = Get.put(HomeController()); // Initialize the controller

   @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(
      init: NavigationController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: 
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 40,
                  ), 
                  const SizedBox(width: 16),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       Obx(() =>Text(
                        // 'Username',
                        homeController.userName.value,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       )
                    ],
            ),
              ]),
            backgroundColor: Colors.white,
            foregroundColor: Colors.red,
            elevation: 0,
          ),
          drawer: SideDrawer(),
          body: controller.getSelectedPage(),
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildBottomNavItem(
                  icon: Icons.chat_bubble_outline,
                  label: 'Chat',
                  index: 0,
                  controller: controller,
                ),
                _buildBottomNavItem(
                  icon: Icons.group_outlined,
                  label: 'Members',
                  index: 1,
                  controller: controller,
                ),
                _buildBottomNavItem(
                  icon: Icons.home_outlined,
                  label: 'Home',
                  index: 2,
                  isSelected: true, // Highlighted item
                  controller: controller,
                ),
                _buildBottomNavItem(
                  icon: Icons.folder,
                  label: 'Resources',
                  index: 3,
                  controller: controller,
                ),
                _buildBottomNavItem(
                  icon: Icons.photo_outlined,
                  label: 'Gallery',
                  index: 4,
                  controller: controller,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

Widget _buildBottomNavItem({
  required IconData icon,
  required String label,
  required int index,
  bool isSelected = false,
  required NavigationController controller,
}) {
  bool selected = controller.selectedIndex == index;

  return GestureDetector(
    onTap: () {
      controller.updateIndex(index);
    },
    child: Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: selected ? Colors.red : Colors.transparent,
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
}

class NavigationController extends GetxController {
   final HomeController controller = Get.put(HomeController()); // Initialize the controller
  int selectedIndex = 2;

  void updateIndex(int index) {
    selectedIndex = index;
    update();
  }

  Widget getSelectedPage() {
    switch (selectedIndex) {
      case 0:
        return ChatPage();
      case 1:
        return MembersPage();
      case 2:
      return Obx(() {
      if (controller.userRole.value == "Director") {
        return DashboardPage();
        }
        else if(controller.userRole.value == "Secretary" || controller.userRole.value == "President"){
        return HomeWidget2();  
        }else if(controller.userRole.value == "President Elect" || controller.userRole.value == "Treasurer" || controller.userRole.value == "Vice President"){
          return HomeWidget3();
        }else{
          return DashboardPage();
        }});
      case 3:
        return ResourcesPage();
      case 4:
        return GalleryPage();
      default:
      return Obx(() {
       if (controller.userRole.value == "Director") {
        return DashboardPage();
        }
        else if(controller.userRole.value == "Secretary" || controller.userRole.value == "President"){
        return HomeWidget2();  
        }else if(controller.userRole.value == "President Elect" || controller.userRole.value == "Treasurer" || controller.userRole.value == "Vice President"){
          return HomeWidget3();
         }else{
          return DashboardPage();
        }
      });
    }
  }
}

class SideDrawer extends StatelessWidget {
  final HomeController controller = Get.put(HomeController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.red, // Background color of the drawer
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Drawer Header
            Container(
              padding: EdgeInsets.only(top: 50, left: 16, bottom: 20),
              child: Container(
                height: 60,
                width: 270,
                decoration: BoxDecoration(color: ColorConstant.whiteA700,borderRadius: BorderRadius.circular(15)),
                child:
              Row(
                children: [
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 50,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                       Text(
                        //'Username',
                        controller.userName.value,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),),
            SizedBox(height: 20),
            // Drawer Items
            _buildDrawerItem(
              icon: Icons.home,
              label: 'Home',
              index: 0, // Assign unique index to each item
              onTap: () {
                controller.updateSelectedIndex(0); // Update selected index
                Navigator.pop(context); // Close the drawer
              },
            ),
            _buildDrawerItem(
              icon: Icons.info_outline,
              label: 'About Us',
              index: 1,
              onTap: () {
                controller.updateSelectedIndex(1);
                // Navigate to About Us page
              },
            ),
            _buildDrawerItem(
              icon: Icons.lock_outline,
              label: 'Change Password',
              index: 2,
              onTap: () {
                controller.updateSelectedIndex(2);
                // Navigate to Change Password page
              },
            ),
            _buildDrawerItem(
              icon: Icons.description_outlined,
              label: 'Terms and Conditions',
              index: 3,
              onTap: () {
                controller.updateSelectedIndex(3);
                // Navigate to Terms and Conditions page
              },
            ),
            _buildDrawerItem(
              icon: Icons.privacy_tip_outlined,
              label: 'Privacy Policy',
              index: 4,
              onTap: () {
                controller.updateSelectedIndex(4);
                // Navigate to Privacy Policy page
              },
            ),
            _buildDrawerItem(
              icon: Icons.logout,
              label: 'Logout',
              index: 5,
              onTap: () {
                controller.updateSelectedIndex(5);
                // Handle logout
                controller.removeAll();
              },
            ),
          ],
        ),
      ),
    );
  }

   // Helper function to create drawer items
  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required int index,
    required GestureTapCallback onTap,
  }) {
    return Obx(() {
      // Observe the selectedIndex from the controller
      bool isSelected = controller.selectedIndex.value == index;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: InkWell(
          onTap: onTap, // Handle tap action
          child: Container(
            decoration: isSelected
                ? BoxDecoration(
                    color: Colors.white.withOpacity(0.36), // Highlight background when selected
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  )
                : null, // No decoration for unselected items
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 13.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white, // Icon color
                  size: 35,
                ),
                SizedBox(width: 10),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white, // Text color
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

// Placeholder pages for the navigation
class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Chat Page'));
  }
}

class MembersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Members Page'));
  }
}

class ResourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Resources Page'));
  }
}

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Gallery Page'));
  }
}

class HomeDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Home Page Dashboard'));
  }
}