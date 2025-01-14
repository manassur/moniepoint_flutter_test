import 'package:flutter/material.dart';
import 'package:moniepoint_flutter_test/view/widgets/buy_ui.dart';
import 'package:moniepoint_flutter_test/view/widgets/home_image_widget.dart';
import 'package:moniepoint_flutter_test/view/widgets/rent_ui.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  // Animation for the appbar with entails the location and profile avatar
  late final Animation<double> _appbarAnimation;
  late final Animation<double> _appbarOpacity;

  // Animation for the name
  late final Animation<double> _nameOpacityAnimation;

  late final Animation<double> _firstContentAnimation;
  late final Animation<double> _secondContentAnimation;

  late final Animation<double> _buyAndRentAnimation;

  late final Animation<Offset> _slideAnimation;

  late final Animation<double> _kitchenAnimation;
  late final Animation<double> _windowAnimation;

  late final Animation<double> _bottomImageAnimation;

  late final ScrollController _scrollController;

  double scrollOffset = 0.0;
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );

    _appbarAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.0,
          0.15,
          curve: Curves.easeIn,
        ),
      ),
    );

    _appbarOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.13,
          0.15,
          curve: Curves.easeIn,
        ),
      ),
    );

    _nameOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.15,
          0.18,
          curve: Curves.easeIn,
        ),
      ),
    );

    _firstContentAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.18,
          0.24,
          curve: Curves.easeIn,
        ),
      ),
    );

    _secondContentAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.22,
          0.28,
          curve: Curves.easeIn,
        ),
      ),
    );

    _buyAndRentAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.18,
          0.32,
          curve: Curves.easeOutCirc,
          // curve: Curves.easeOutQuint,
        ),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.32,
          0.40,
          curve: Curves.decelerate,
        ),
      ),
    );

    _kitchenAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.40,
          0.50,
          curve: Curves.decelerate,
        ),
      ),
    );

    _windowAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.55,
          0.65,
          curve: Curves.easeIn,
        ),
      ),
    );

    _bottomImageAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(
          0.55,
          0.75,
          curve: Curves.easeIn,
        ),
      ),
    );

    // Start the animation
    _animationController.forward();
  }

  void _scrollListener() {
    setState(() {
      scrollOffset = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffF8F7F6),
                Color(0xffF8F7F6),
                Color(0xfff6e6d5),
                Color(0xffefdcc8),
                Color(0xfff3dec5),
                Color(0xfff3d9bc),
              ],
            ),
          ),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: false,
                title: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  height: 42,
                  width: _appbarAnimation.value * 170,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Opacity(
                    opacity: _appbarOpacity.value,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Color(0xffA5957E),
                          size: 16,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Flexible(
                          child: Text(
                            "Saint Petersburg",
                            style: TextStyle(
                              color: Color(0xffA5957E),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  Transform.scale(
                    scale: _appbarAnimation.value,
                    alignment: Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color(0xffFC9E12),
                        backgroundImage:
                            AssetImage('assets/images/profile.jpg'),
                      ),
                    ),
                  ),
                ],
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Opacity(
                            opacity: _nameOpacityAnimation.value,
                            child: const Text(
                              'Hi, Marina',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
                                color: Color(0xffA5957E),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          height: 96,
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: _firstContentAnimation.value * 48,
                                color: Colors.transparent,
                                child: const Text(
                                  "let's select your",
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Color(0xff232220),
                                    height: 1,
                                  ),
                                ),
                              ),
                              Container(
                                height: _secondContentAnimation.value * 48,
                                color: Colors.transparent,
                                child: const Text(
                                  "perfect place",
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Color(0xff232220),
                                    height: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Transform.scale(
                                  scale: _buyAndRentAnimation.value,
                                  child: BuyUi(
                                    value: _buyAndRentAnimation.value * 1034,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Expanded(
                                flex: 1,
                                child: Transform.scale(
                                  scale: _buyAndRentAnimation.value,
                                  child: RentUi(
                                    value: _buyAndRentAnimation.value * 2212,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                      ],
                    ),
                    Positioned.fill(
                      left: 0,
                      right: 0,
                      top: 185,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(25),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              // Top Container
                              ImageCard(
                                assetPath: 'assets/images/kitchen.jpg',
                                sliderText: "Gladkova St., 25",
                                textOpacity: _kitchenAnimation.value == 1
                                    ? _kitchenAnimation.value
                                    : 0,
                                sliderTextAlignment: Alignment.center,
                                sliderWidth: _kitchenAnimation.value *
                                    MediaQuery.of(context).size.width,
                                sliderHeight: 56,
                                height: 208,
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              // Bottom Containers
                              Expanded(
                                child: Row(
                                  children: [
                                    // Left Container
                                    Expanded(
                                      child: ImageCard(
                                        assetPath:
                                            'assets/images/chair_on_rug.jpg',
                                        sliderText: "Gubina St., 11",
                                        textOpacity:
                                            _bottomImageAnimation.value == 1
                                                ? _bottomImageAnimation.value
                                                : 0,
                                        sliderWidth: _bottomImageAnimation
                                                .value *
                                            MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    // Right Containers
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ImageCard(
                                              assetPath:
                                                  'assets/images/window.jpg',
                                              sliderText: "Trefoleva St.",
                                              textOpacity:
                                                  _windowAnimation.value == 1
                                                      ? _windowAnimation.value
                                                      : 0,
                                              sliderWidth:
                                                  _windowAnimation.value *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Expanded(
                                            child: ImageCard(
                                              assetPath:
                                                  'assets/images/sitting_room.jpg',
                                              sliderText: "Sedova St., 22",
                                              textOpacity: _bottomImageAnimation
                                                          .value ==
                                                      1
                                                  ? _bottomImageAnimation.value
                                                  : 0,
                                              sliderWidth:
                                                  _bottomImageAnimation.value *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
