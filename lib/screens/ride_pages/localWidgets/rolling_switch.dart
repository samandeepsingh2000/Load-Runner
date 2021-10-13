// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, use_key_in_widget_constructors

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

/// Customable and attractive Switch button.
/// Currently, you can't change the widget
/// width and height properties.
///
/// As well as the classical Switch Widget
/// from flutter material, the following
/// arguments are required:
///
/// * [value] determines whether this switch is on or off.
/// * [onChanged] is called when the user toggles the switch on or off.
///
/// If you don't set these arguments you would
/// experiment errors related to animationController
/// states or any other undesirable behavior, please
/// don't forget to set them.
///
class RollingSwitchCustom extends StatefulWidget {
  @required
  final bool value;
  @required
  final Function(bool) onChanged;
  late final String textOff;
  late final String textOn;
  final Color colorOn;
  final Color colorOff;
  final double? textSize;
  final Duration animationDuration;
  final IconData? iconOn;
  final IconData? iconOff;
  final Function? onTap;
  final Function? onDoubleTap;
  final Function? onSwipe;
  late final Size size;

  RollingSwitchCustom(
      {this.value = false,
      this.textOff = "Off",
      this.textOn = "On",
      this.textSize = 14.0,
      this.colorOn = Colors.green,
      this.colorOff = Colors.red,
      this.iconOff = Icons.flag,
      this.iconOn = Icons.check,
      this.animationDuration = const Duration(milliseconds: 600),
      this.onTap,
      this.onDoubleTap,
      this.onSwipe,
      required this.onChanged,
      required this.size});

  @override
  _RollingSwitchCustomState createState() => _RollingSwitchCustomState();
}

class _RollingSwitchCustomState extends State<RollingSwitchCustom>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  double value = 0.0;

  late bool turnState;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: widget.animationDuration);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value;
    _determine();
  }

  @override
  Widget build(BuildContext context) {
    Color? transitionColor = Color.lerp(widget.colorOff, widget.colorOn, value);

    return GestureDetector(
      onDoubleTap: () {
        _action();
        if (widget.onDoubleTap != null) widget.onDoubleTap!();
      },
      onTap: () {
        _action();
        if (widget.onTap != null) widget.onTap!();
      },
      onPanEnd: (details) {
        _action();
        if (widget.onSwipe != null) widget.onSwipe!();
        //widget.onSwipe();
      },
      child: Container(
        padding: EdgeInsets.all(5),
        width: widget.size.width * 0.2,
        decoration: BoxDecoration(
            color: transitionColor, borderRadius: BorderRadius.circular(50)),
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: Offset(10 * value, 0), //original
              child: Opacity(
                opacity: (1 - value).clamp(0.0, 1.0),
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  height: 25,
                  child: Text(
                    widget.textOff,
                    style: const TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFFFCFA),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(10 * (1 - value), 0), //original
              child: Opacity(
                opacity: value.clamp(0.0, 1.0),
                child: Container(
                  padding: const EdgeInsets.only(/*top: 10,*/ left: 5),
                  alignment: Alignment.centerLeft,
                  height: 25,
                  child: Text(
                    widget.textOn,
                    style: const TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffFFFCFA),
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset((widget.size.width * 0.08) * value, 0),
              child: Transform.rotate(
                angle: lerpDouble(0, 2 * pi, value) ?? 0,
                child: Container(
                  height: 25,
                  width: 25,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Opacity(
                            opacity: (1 - value).clamp(0.0, 1.0),
                            child: Container()),
                      ),
                      Center(
                          child: Opacity(
                              opacity: value.clamp(0.0, 1.0),
                              child: Icon(
                                widget.iconOn,
                                size: 21,
                                color: transitionColor,
                              ))),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _action() {
    _determine(changeState: true);
  }

  _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = turnState;
      (turnState)
          ? animationController.forward()
          : animationController.reverse();

      widget.onChanged(turnState);
    });
  }
}
