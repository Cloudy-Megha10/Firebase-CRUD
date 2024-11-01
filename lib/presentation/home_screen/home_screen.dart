import 'package:demo_app/presentation/home_screen/controller/home_controller.dart';
import 'package:demo_app/presentation/home_screen/wigets/add_new_user.dart';
import 'package:demo_app/presentation/home_screen/wigets/build_bottom_nav_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'wigets/edit_delete_user.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller =
      Get.put(HomeController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple.shade700,
            title: Text(
              "lbl_firebase_operations".tr,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          body: getSelectedPage(),
          //allUserDataList(),
          bottomNavigationBar: BottomAppBar(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildBottomNavItem(
                  icon: Icons.chat_bubble_outline,
                  label: "lbl_chat".tr,
                  index: 0,
                  controller: controller,
                ),
                buildBottomNavItem(
                  icon: Icons.group_outlined,
                  label: 'lbl_members'.tr,
                  index: 1,
                  controller: controller,
                ),
                buildBottomNavItem(
                  icon: Icons.home_outlined,
                  label: 'lbl_home'.tr,
                  index: 2,
                  isSelected: true, // Highlighted item
                  controller: controller,
                ),
                buildBottomNavItem(
                  icon: Icons.folder,
                  label: 'lbl_resource'.tr,
                  index: 3,
                  controller: controller,
                ),
                buildBottomNavItem(
                  icon: Icons.photo_outlined,
                  label: 'lbl_gallery'.tr,
                  index: 4,
                  controller: controller,
                ),
              ],
            ),
          ),
        ));
  }

  Widget getSelectedPage() {
    switch (controller.selectedIndex.value) {
      case 0:
        return ChatPage();
      case 1:
        return MembersPage();
      case 2:
        return DashboardPage();
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
