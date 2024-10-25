
import 'package:demo_app/presentation/home_screen/controller/home_controller.dart';
import 'package:demo_app/presentation/home_screen/wigets/add_new_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'wigets/home_screen1.dart';

class HomeScreen extends StatelessWidget {
    final HomeController controller = Get.put(HomeController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return   Obx(()=>Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade700,
        title: Text(
          'Firebase Operations',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddNewData();
          }));
        },
      ),
      body: 
      getSelectedPage(),
      //allUserDataList(),
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
    ));
  }

Widget _buildBottomNavItem({
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

Widget getSelectedPage() {
    switch (controller.selectedIndex.value) {
      case 0:
        return ChatPage();
      case 1:
        return MembersPage();
      case 2:
      return  DashboardPage();
      case 3:
        return ResourcesPage();
      case 4:
        return GalleryPage();
      default:
      return DashboardPage();
        }
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
