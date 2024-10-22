import 'package:flutter/material.dart';
import 'package:moniepoint_flutter_test/data/enum/map_menu.dart';
import 'package:moniepoint_flutter_test/view/widgets/map_bubble.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final AnimationController _animationController2;

  late final Animation<double> _scaleAnimation;
  late final Animation<double> _bubbleScaleAnimation;
  late final Animation<double> _bubbleTextOpacity;

  late final AnimationController _bubbleController;

  late final Animation<double> _bubbleWidthAnimation;
  late final Animation<double> _bubbleIconOpacityAnimation;

  late final Animation<double> _initialContainerSize;
  late final Animation<double> _initialBorderSize;

  late AnimationController _popupScaleController;
  double _bubbleWith = 70;
  bool _hasLayer = false;
  bool _isMenuOpen = false;

  MapMenu _selectedOption = MapMenu.price;
  bool _showColor = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animationController2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          setState(() {
            _showColor = true;

            Future.delayed(const Duration(milliseconds: 1125), () {
              _showColor = false;
            });
          });
        }
      });

    _initialContainerSize = Tween<double>(begin: 58, end: 40).animate(
      CurvedAnimation(
        parent: _animationController2,
        curve: const Interval(
          0.0,
          0.25,
          curve: Curves.easeIn,
        ),
      ),
    );

    _initialBorderSize = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1, end: 8),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 8, end: 1),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _animationController2,
        curve: const Interval(0.0, 0.75, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.40, curve: Curves.easeIn), // Zoom in
        reverseCurve:
            const Interval(0.60, 1.0, curve: Curves.easeOut), // Zoom out
      ),
    );

    _bubbleScaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.50, 0.80, curve: Curves.easeIn),
      ),
    );

    _bubbleTextOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.80, 1.0, curve: Curves.easeIn),
      ),
    );

    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _bubbleWidthAnimation = Tween<double>(begin: _bubbleWith, end: 48).animate(
      CurvedAnimation(
        parent: _bubbleController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
      ),
    );

    _bubbleIconOpacityAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 0.5),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.5, end: 1),
        weight: 50,
      ),
    ]).animate(
      CurvedAnimation(
        parent: _bubbleController,
        curve: const Interval(0.6, 0.8, curve: Curves.easeIn),
      ),
    );

    _popupScaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Start the main animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _bubbleController.dispose();
    _popupScaleController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _animationController,
        _bubbleController,
      ]),
      builder: (context, child) => Stack(
        children: [
          Image.asset(
            'assets/images/google_map.png',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black
                .withOpacity(0.5), // Adjust opacity to control darkness
            colorBlendMode: BlendMode.darken,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 80,
                left: 32,
                right: 32,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(32),
                          ),
                        ),
                        height: 45,
                        width: 196,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/icon/search.png',
                              width: 20,
                              color: const Color(0xff757575),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Saint Petersburg",
                              style: TextStyle(
                                  color: Color(0xff757575),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Transform.scale(
                    scale: _scaleAnimation.value,
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 23,
                      backgroundColor: Colors.white,
                      child: Image.asset(
                        'assets/icon/filter.png',
                        width: 20,
                        color: const Color(0xff757575),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.40,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned(
                    left: 72,
                    child: Transform.scale(
                      scale: _bubbleScaleAnimation.value,
                      alignment: Alignment.bottomLeft,
                      child: MapBubble(
                        mapValue: "10,3 mn P",
                        textOpacity: _bubbleTextOpacity.value,
                        bubbleWidth: _bubbleWidthAnimation.value,
                        showWithoutAnyLayer: _hasLayer,
                        iconOpacity: _bubbleIconOpacityAnimation.value,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 88,
                    top: 58,
                    child: Transform.scale(
                      scale: _bubbleScaleAnimation.value,
                      alignment: Alignment.bottomLeft,
                      child: MapBubble(
                        mapValue: "11 mn P",
                        textOpacity: _bubbleTextOpacity.value,
                        bubbleWidth: _bubbleWidthAnimation.value,
                        showWithoutAnyLayer: _hasLayer,
                        iconOpacity: _bubbleIconOpacityAnimation.value,
                      ),
                    ),
                  ),

                  Positioned(
                    right: 32,
                    top: 80,
                    child: Transform.scale(
                      scale: _bubbleScaleAnimation.value,
                      alignment: Alignment.bottomLeft,
                      child: MapBubble(
                        mapValue: "7,8 mn P",
                        textOpacity: _bubbleTextOpacity.value,
                        bubbleWidth: _bubbleWidthAnimation.value,
                        showWithoutAnyLayer: _hasLayer,
                        iconOpacity: _bubbleIconOpacityAnimation.value,
                      ),
                    ),
                  ),

                  // Bottom 3 map bubbles
                  Positioned(
                    right: 56,
                    bottom: 0,
                    child: Transform.scale(
                      scale: _bubbleScaleAnimation.value,
                      alignment: Alignment.bottomLeft,
                      child: MapBubble(
                        mapValue: "6,95 mn ",
                        textOpacity: _bubbleTextOpacity.value,
                        bubbleWidth: _bubbleWidthAnimation.value,
                        showWithoutAnyLayer: _hasLayer,
                        iconOpacity: _bubbleIconOpacityAnimation.value,
                      ),
                    ),
                  ),

                  Positioned(
                    left: 64,
                    bottom: 80,
                    child: Transform.scale(
                      scale: _bubbleScaleAnimation.value,
                      alignment: Alignment.bottomLeft,
                      child: MapBubble(
                        mapValue: "7,8 mn P",
                        textOpacity: _bubbleTextOpacity.value,
                        bubbleWidth: _bubbleWidthAnimation.value,
                        showWithoutAnyLayer: _hasLayer,
                        iconOpacity: _bubbleIconOpacityAnimation.value,
                      ),
                    ),
                  ),

                  Positioned(
                    right: 32,
                    bottom: 128,
                    child: Transform.scale(
                      scale: _bubbleScaleAnimation.value,
                      alignment: Alignment.bottomLeft,
                      child: MapBubble(
                        mapValue: "7,8 mn P",
                        textOpacity: _bubbleTextOpacity.value,
                        bubbleWidth: _bubbleWidthAnimation.value,
                        showWithoutAnyLayer: _hasLayer,
                        iconOpacity: _bubbleIconOpacityAnimation.value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
                bottom: 96,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Transform.scale(
                        scale: _scaleAnimation.value,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            // The main button (CircleAvatar in this case)
                            GestureDetector(
                              onTap: () async {
                                _animationController2
                                  ..reset()
                                  ..forward();
                                await Future.delayed(
                                    const Duration(seconds: 1));
                                setState(() {
                                  _isMenuOpen = !_isMenuOpen;
                                });
                              },
                              child: Offstage(
                                offstage: _isMenuOpen,
                                child: AnimatedBuilder(
                                  animation: _animationController2,
                                  builder: (context, child) => Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.decelerate,
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.transparent,
                                        ),
                                        child: CircleAvatar(
                                          radius: 28,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.4),
                                          child: Image.asset(
                                            'assets/icon/${_selectedOption.icon}.png',
                                            color: Colors.white,
                                            width: 20,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        height: _initialContainerSize.value,
                                        width: _initialContainerSize.value,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: _showColor
                                                ? Colors.white
                                                : Colors.transparent,
                                            width: _initialBorderSize.value,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Dropdown menu (visible when tapped)
                            if (_isMenuOpen)
                              Positioned(
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.0, 0.5),
                                    end: Offset.zero,
                                  ).animate(CurvedAnimation(
                                    parent: _animationController2,
                                    curve: Curves.easeOut,
                                  )),
                                  child: ScaleTransition(
                                    scale: Tween<double>(
                                      begin: 0.1, // Starts scaled down
                                      end: 1.0, // Scales up to full size
                                    ).animate(CurvedAnimation(
                                      parent: _animationController2,
                                      curve: Curves.easeOut,
                                    )),
                                    child: Material(
                                      color: const Color(0xfffcf4e9),
                                      elevation: 4,
                                      borderRadius: BorderRadius.circular(40),
                                      child: Container(
                                        width: 190,
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: MapMenu.values.map((menu) {
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _selectedOption = menu;
                                                  _isMenuOpen = false;

                                                  if (menu.isWithoutAnyLayer) {
                                                    _bubbleController.forward();
                                                    _hasLayer = true;
                                                    _bubbleWith = 40;
                                                  } else if (menu.isPrice) {
                                                    _bubbleController.reverse();
                                                    _hasLayer = false;
                                                    _bubbleWith = 96;
                                                  }
                                                });
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/icon/${menu.icon}.png',
                                                      color: _selectedOption ==
                                                              menu
                                                          ? const Color(
                                                              0xffFC9E12)
                                                          : const Color(
                                                              0xff757575),
                                                      width: 18,
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Text(
                                                      menu.value,
                                                      style: TextStyle(
                                                        color:
                                                            _selectedOption ==
                                                                    menu
                                                                ? const Color(
                                                                    0xffFC9E12)
                                                                : const Color(
                                                                    0xff757575),
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Transform.scale(
                        scale: _scaleAnimation.value,
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.white.withOpacity(0.4),
                          child: Image.asset(
                            'assets/icon/send.png',
                            color: Colors.white,
                            width: 20,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Transform.scale(
                        scale: _scaleAnimation.value,
                        alignment: Alignment.center,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(32),
                            ),
                          ),
                          height: 50,
                          width: 168,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.sort_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                "List of variants",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
