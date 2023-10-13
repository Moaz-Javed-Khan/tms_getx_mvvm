import 'package:flutter/material.dart';
import 'package:graphqlgetxexample/widgets/dashboard_first_card.dart';
import 'package:graphqlgetxexample/widgets/dashboard_second_card.dart';
import 'package:graphqlgetxexample/widgets/dastboard_slider.dart';
import 'package:graphqlgetxexample/widgets/dashboard_list_tiles.dart';
import 'package:graphqlgetxexample/widgets/shimmer_dashboard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoading = true;

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        setState(() {
          isLoading = false;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: isLoading
              ? getShimmerLoading()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const DashboardFirstCard(),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Expanded(
                          flex: 5,
                          child: DashboardSecondCard(
                            cardName: "Total Tasks",
                            number: 10,
                          ),
                        ),
                        const Expanded(
                          flex: 5,
                          child: DashboardSecondCard(
                            cardName: "Monthly Tasks",
                            number: 8,
                          ),
                        ),
                      ],
                    ),
                    const DashboardSlider(),
                    const DashboardListTiles(),
                  ],
                ),
        ),
      ),
    );
  }
}
