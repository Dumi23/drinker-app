import 'package:flutter/material.dart';
import 'package:gout/api/api.dart';
import 'package:gout/modules/hotel_detailes/attendees_data_view.dart';
import 'package:gout/widgets/common_appbar_view.dart';
import '../../models/hotel_list_data.dart';
import 'review_data_view.dart';

class AttendesListScreen extends StatefulWidget {
  final Event eventData;

  const AttendesListScreen({Key? key, required this.eventData})
      : super(key: key);
  @override
  _ReviewsListScreenState createState() => _ReviewsListScreenState();
}

class _ReviewsListScreenState extends State<AttendesListScreen>
    with TickerProviderStateMixin {
  List<HotelListData> reviewsList = HotelListData.reviewsList;
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommonAppbarView(
            iconData: Icons.close,
            onBackClick: () {
              Navigator.pop(context);
            },
            titleText: "Attendees ${widget.eventData.atendees.length}",
          ),
          // animation of Review and feedback data
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                  top: 8, bottom: MediaQuery.of(context).padding.bottom + 8),
              itemCount: widget.eventData.atendees.length,
              itemBuilder: (context, index) {
                var count = widget.eventData.atendees.length > 10
                    ? 10
                    : widget.eventData.atendees.length;
                var animation = Tween(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: animationController,
                        curve: Interval((1 / count) * index, 1.0,
                            curve: Curves.fastOutSlowIn)));
                animationController.forward();
                // page to redirect the feedback and review data
                return AtendeeView(
                  callback: () {},
                  attende: widget.eventData.atendees[index],
                  animation: animation,
                  animationController: animationController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
