import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as pv;
import '../core/constants.dart';
import '../core/responsive.dart';
import '../viewmodels/nav_vm.dart';
import '../widgets/backdrop.dart';
// import '../widgets/nav_bar.dart'; // navbar switched off for now
import 'sections/contact_section.dart';
import 'sections/experience_section.dart';
import 'sections/hero_section.dart';
import 'sections/stack_section.dart';
import 'sections/work_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final loop = AnimationController(vsync: this, duration: K.loopMs)..repeat();
  late final intro = AnimationController(vsync: this, duration: K.introMs)..forward();
  final scroll = ScrollController();
  final mouse = ValueNotifier<Offset>(const Offset(-500, -500));

  @override
  void dispose() {
    loop.dispose();
    intro.dispose();
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => pv.ChangeNotifierProvider(
      create: (_) => NavViewModel(),
      child: Scaffold(
          body: MouseRegion(
              onHover: (e) => mouse.value = e.position,
              child: Stack(children: [
                Backdrop(loop, mouse),
                HeroSection(intro, loop, mouse, scroll), // pinned behind the page, driven by the scroll position
                SingleChildScrollView(
                    controller: scroll,
                    child: Center(
                        child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: K.maxWidth),
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: context.pad),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  SizedBox(height: context.h * (1 + K.pinFactor)), // room for the pinned hero
                                  const ExperienceSection(),
                                  const WorkSection(),
                                  const StackSection(),
                                  const ContactSection(),
                                ]))))),
                // const Positioned(top: 0, left: 0, right: 0, child: NavBar()), // navbar switched off for now
              ]))));
}