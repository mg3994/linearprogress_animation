import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text('Custom Gradient Progress Indicator'),
        ),
        body: Center(
          child: CustomGradientProgressIndicator(),
        ),
      ),
    );
  }
}

class CustomGradientProgressIndicator extends StatefulWidget {
  @override
  _CustomGradientProgressIndicatorState createState() =>
      _CustomGradientProgressIndicatorState();
}

class _CustomGradientProgressIndicatorState
    extends State<CustomGradientProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _colorAnimation = TweenSequence<Color?>(
      <TweenSequenceItem<Color?>>[
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.blue, end: Colors.purple),
          weight: 50,
        ),
        TweenSequenceItem(
          tween: ColorTween(begin: Colors.purple, end: Colors.pink),
          weight: 50,
        ),
      ],
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(100), // Rounded rectangular border
      // ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: LinearProgressIndicator(
          backgroundColor: Colors.white24,
          value: 0.5,
          valueColor: AlwaysStoppedAnimation<Color?>(_colorAnimation.value),
        ),
      ),
    );
  }
}
