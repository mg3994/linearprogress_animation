// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Linear Gradient Progress Indicator'),
//         ),
//         body: Center(
//           child: GradientProgressIndicator(
//             value: 0.5, // Change this value to control the progress
//             gradient: LinearGradient(
//               colors: [Colors.blue, Colors.pink],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class GradientProgressIndicator extends StatelessWidget {
//   final double value;
//   final Gradient gradient;

//   GradientProgressIndicator({required this.value, required this.gradient});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRect(
//       child: LinearProgressIndicator(
//         value: value,
//         valueColor: Animat,
//         backgroundColor: Colors.transparent,
//       ),
//     );
//   }
// }

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
  late Animation<double?>? _progressAnimation;

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
          tween: ColorTween(
              begin: Color.fromARGB(255, 100, 52, 244),
              end: const Color.fromARGB(255, 94, 39, 176)),
          weight: 50,
        ),
        TweenSequenceItem(
          tween: ColorTween(
              begin: const Color.fromARGB(255, 94, 39, 176),
              end: Color.fromARGB(255, 146, 81, 243)),
          weight: 50,
        ),
      ],
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    // _controller.repeat(reverse: true);
    _progressAnimation = Tween<double>(begin: 0.0, end: 0.5) //percentage
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0.0, 1)));
    _controller.forward().whenComplete(() {
      _controller.stop();
      _progressAnimation = null;
      _controller.repeat(reverse: true);
    });
    // Add a listener to the progress animation to stop it after running once
    // _progressAnimation.addStatusListener((status) {
    //   if (status == AnimationStatus.reverse) {
    //     _controller.stop();
    //   }
    // });
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
          value: _progressAnimation?.value, //0.5,
          valueColor: AlwaysStoppedAnimation<Color?>(_colorAnimation.value),
        ),
      ),
    );
  }
}
