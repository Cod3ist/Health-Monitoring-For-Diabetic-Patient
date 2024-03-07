import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:healthcare_monitoring_diabetic_patients/ui/application/bloodGlucoseLevel/sugarMonitorScreen.dart';
import 'package:iconsax/iconsax.dart';

import '../ui/application/homeScreen.dart';
import '../ui/application/nutrition/nutritionScreen.dart';

class NavigationMenu extends StatelessWidget {
  final String user;
  const NavigationMenu({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController(user: user));
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          selectedIndex: controller.selectedIndex.value,
          elevation: 0,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home',),
            NavigationDestination(icon: Icon(Iconsax.note), label: 'BGL',),
            NavigationDestination(icon: Icon(Icons.fastfood_outlined), label: 'Nutrition',),
            NavigationDestination(icon: Icon(Icons.chat), label: 'Chat',)
          ],
        ),
      ),
      body: Obx(()=>controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final String user;
  final Rx<int> selectedIndex = 0.obs;

  NavigationController({required this.user});

  get screens => [HomeScreen(user: user), SugarMonitorScreen(user: user), NutritionScreen()];

}
