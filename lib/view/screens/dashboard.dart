import 'package:flutter/material.dart';
import 'package:moniepoint_flutter_test/data/enum/nav_enum.dart';
import 'package:moniepoint_flutter_test/view/screens/home_screen.dart';
import 'package:moniepoint_flutter_test/view/screens/search_screen.dart';
import 'package:moniepoint_flutter_test/view/widgets/custom_nav_item.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late final Animation<Offset> _slideAnimation;

  NavEnum _selectedItem = NavEnum.home;

  Widget _displayedScreen(NavEnum value) {
    if (value.isHome) {
      return const HomeScreen();
    }

    if (value.isSearch) {
      return const MapScreen();
    }

    return Container(
      color: const Color(0xffA5957E),
    );
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.88,
          1.0,
          curve: Curves.easeInSine,
        ),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _displayedScreen(_selectedItem),
      bottomNavigationBar: SlideTransition(
        position: _slideAnimation,
        child: Container(
          margin: const EdgeInsets.only(
            left: 48,
            bottom: 20,
            right: 48,
          ),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          height: 65,
          decoration: const BoxDecoration(
            color: Color(0xff2B2B2B),
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...NavEnum.values.map(
                (item) => SizedBox(
                  width: 50,
                  height: 50,
                  child: CustomNavItem(
                    icon: item.icon,
                    isActive: item == _selectedItem,
                    onTap: () {
                      setState(() => _selectedItem = item);
                    },
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
