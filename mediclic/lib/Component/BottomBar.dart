import 'package:flutter/material.dart';
import 'package:mediclic/Pages/Acceuil.dart';
import 'package:mediclic/Pages/DossierMedical.dart';
import 'package:mediclic/Pages/Profile.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class Bottombar extends StatefulWidget {
  const  Bottombar({super.key});

  @override
   BottombarState createState() =>  BottombarState();
}

class  BottombarState extends State<Bottombar> {
  int selectedIndex = 0;
  late PageController pageController;
    @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: PageView(
      physics: NeverScrollableScrollPhysics(),       
      controller: pageController,
      children: [
        Accueil(),
        DossierMedical(),
        Profile()
      ],
       
      ),
      bottomNavigationBar: WaterDropNavBar(
        backgroundColor: Colors.white,
        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          pageController.animateToPage(selectedIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad);
        },
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            filledIcon: Icons.bookmark_rounded,
            outlinedIcon: Icons.bookmark_border_rounded,
          ),
          BarItem(
              filledIcon: Icons.person,
              outlinedIcon: Icons.person_2_rounded),
          BarItem(
              filledIcon: Icons.health_and_safety,
              outlinedIcon: Icons.health_and_safety_rounded),    
        ],
      ),
    );
  }
  
  
}
