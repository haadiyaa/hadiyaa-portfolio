import 'package:flutter/material.dart';
import 'package:haadiya_portfolio/widgets/backdrop.dart';
import 'package:haadiya_portfolio/core/constants.dart';
import 'package:haadiya_portfolio/views/sections/contact_section.dart';
import 'package:haadiya_portfolio/views/sections/experience_section.dart';
import 'package:haadiya_portfolio/views/sections/hero_section.dart';
import 'package:haadiya_portfolio/widgets/nav_bar.dart';
import 'package:haadiya_portfolio/viewmodels/nav_vm.dart';
import 'package:haadiya_portfolio/core/responsive.dart';
import 'package:haadiya_portfolio/views/sections/stack_section.dart';
import 'package:haadiya_portfolio/views/sections/work_section.dart';
import 'package:provider/provider.dart' as pv;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final loop = AnimationController(vsync: this, duration: K.loopMs)..repeat();
  late final intro = AnimationController(vsync: this, duration: K.introMs)..forward();
  final mouse = ValueNotifier<Offset>(const Offset(-500, -500));

  @override
  void dispose() {
    loop.dispose();
    intro.dispose();
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
                SingleChildScrollView(
                    child: Center(
                        child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: K.maxWidth),
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: context.pad),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  HeroSection(intro),
                                  const ExperienceSection(),
                                  const WorkSection(),
                                  const StackSection(),
                                  const ContactSection(),
                                ]))))),
                const Positioned(top: 0, left: 0, right: 0, child: NavBar()),
              ]))));
}
