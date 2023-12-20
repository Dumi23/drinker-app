import 'package:flutter/material.dart';
import 'package:gout/api/api.dart';
import 'package:gout/language/appLocalizations.dart';
import 'package:gout/models/hotel_list_data.dart';
import 'package:gout/providers/theme_provider.dart';
import 'package:gout/utils/enum.dart';
import 'package:gout/utils/helper.dart';
import 'package:gout/utils/text_styles.dart';
import 'package:gout/utils/themes.dart';
import 'package:gout/widgets/common_card.dart';
import 'package:gout/widgets/list_cell_animation_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

Image urlImage(imgurl) {
  try {
    print(imgurl);
    return Image.network(
      imgurl,
      fit: BoxFit.fill,
    );
  } catch (_) {
    return Image.network(
      "https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg",
      fit: BoxFit.fill,
    );
  }
}

class PlaceListView extends StatelessWidget {
  final bool isShowDate;
  final VoidCallback callback;
  final Place placeData;
  final AnimationController animationController;
  final Animation<double> animation;

  const PlaceListView(
      {Key? key,
      required this.placeData,
      required this.animationController,
      required this.animation,
      required this.callback,
      this.isShowDate: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListCellAnimationView(
      animation: animation,
      animationController: animationController,
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 16),
        child: CommonCard(
          color: AppTheme.backgroundColor,
          child: ClipRRect(
            //   borderRadius: BorderRadius.all(Radius.circular(0.0)),
            child: AspectRatio(
              aspectRatio: 2.7,
              child: Stack(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 0.90,
                        child: Image.network(
                          "https://5cw4rvtc-8000.euw.devtunnels.ms/${placeData.image}",
                          fit: BoxFit.fill,
                          errorBuilder: ((context, error, stackTrace) {
                            return Image.network(
                              "https://www.pulsecarshalton.co.uk/wp-content/uploads/2016/08/jk-placeholder-image.jpg",
                              fit: BoxFit.fill,
                            );
                          }),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width >= 360
                                  ? 12
                                  : 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                placeData.name,
                                maxLines: 2,
                                textAlign: TextAlign.left,
                                style:
                                    TextStyles(context).getBoldStyle().copyWith(
                                          fontSize: 16,
                                        ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                placeData.street_name,
                                style: TextStyles(context)
                                    .getDescriptionStyle()
                                    .copyWith(
                                      fontSize: 14,
                                    ),
                              ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                FontAwesomeIcons.mapMarkerAlt,
                                                size: 12,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                              Text(
                                                " ${placeData.type.name} ",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyles(context)
                                                    .getDescriptionStyle()
                                                    .copyWith(
                                                      fontSize: 14,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      onTap: () {
                        try {
                          callback();
                        } catch (e) {}
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
