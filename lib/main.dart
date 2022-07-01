import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppy/screen/auth_state_change_screen.dart';
import 'package:video_player/video_player.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance
      .activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping Cart',
        theme: ThemeData.dark(),
        home: const AuthStateChangeScreen(),
      ),
    );
  }
}

class H extends StatefulWidget {
  const H({Key? key}) : super(key: key);

  @override
  State<H> createState() => _HState();
}

class _HState extends State<H> with SingleTickerProviderStateMixin {
  VideoPlayerController? controller;
  List<String> videos = ['videos/orange.mp4', 'videos/pizza.mp4'];

  AnimationController? _controller;
  Animation<Offset>? animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(_controller!);
    _controller!.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                4,
                (index) => SlideTransition(
                      position: animation!,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: Colors.red,
                          title: Text('Item $index'),
                          onTap: () {},
                        ),
                      ),
                    ))));
  }
}
