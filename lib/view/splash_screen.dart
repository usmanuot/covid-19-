import 'dart:async';

import 'package:covid_19/view/world_casses.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  timer() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const WorldCasses()),
          (route) => false);
    });
  }

  late final AnimationController controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 5))
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: controller,
              child: Container(
                width: 200,
                height: 200,
                child: Center(
                  child: Image(image: AssetImage('images/virus.png')),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                    angle: controller.value * 0.2 * math.pi, child: child);
              },
            ),
            const SizedBox(height: 40),
            const Center(
                child: Text('Covid-19\nTracker App',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w500))),
          ],
        ),
      ),
    );
  }
}
