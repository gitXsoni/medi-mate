import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:medi_mate/constants.dart';

import '../home_page.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2500), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPrimaryColor,
      child: Center(
        child: Column(
          children: [
            const FlareActor(
              'assets/animations/Success Check.flr',
              alignment: Alignment.center,
              fit: BoxFit.contain,
              animation: 'Untitiled',
              sizeFromArtboard: true,
            ),
            Text(
              "You've added a medicine.",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color:Colors.white),
            ),
            Text(
              "We'll remind you at your scheduled time",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color:Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
