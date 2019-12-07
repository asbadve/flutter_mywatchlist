import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MovieCardView extends StatelessWidget {
  static const double CARD_CORNER_RADIUS = 5.0;
  static const double CARD_HEIGHT = 5.0;
  final String title;
  final String overview;
  final String releaseDate;
  final String imagePath;
  final String voteAverage;
  final VoidCallback onPress;
  final double width;

  MovieCardView(
      {this.title,
      this.overview,
      this.releaseDate,
      this.imagePath,
      this.onPress,
      this.voteAverage,
      this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 225,
        width: width,
        child: Card(
          elevation: 6,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(CARD_CORNER_RADIUS)),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                    child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(CARD_CORNER_RADIUS),
                      bottomLeft: Radius.circular(CARD_CORNER_RADIUS)),
                  child: CachedNetworkImage(
                    imageUrl: imagePath,
                    placeholder: (context, url) =>
                        SpinKitPulse(color: Colors.white),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                    height: 225,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                )),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: 8, right: 8, top: 8, bottom: 0),
                        alignment: Alignment.topLeft,
                        child: Text(
                          title,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 6.0),
                        alignment: Alignment.centerLeft,
                        child: RatingBar(
//                          initialRating: 4,
                          initialRating: voteAverage == null
                              ? 0
                              : (double.parse(voteAverage) * 5) / 10,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemSize: 14.0,
                          ignoreGestures: true,
                          itemCount: 5,
                          tapOnlyMode: true,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.pink[800],
                          ),
                          onRatingUpdate: null,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 8, bottom: 4, top: 1),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              size: 21.0,
                            ),
                            Text(
                              " " + releaseDate,
                              style: Theme.of(context).textTheme.subtitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                          alignment: Alignment.topLeft,
                          child: RichText(
                            maxLines: 7,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                                style: Theme.of(context).textTheme.subhead,
                                text: overview),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RecommCardView extends StatelessWidget {
  static const double CARD_CORNER_RADIUS = 5.0;
  static const double CARD_HEIGHT = 5.0;
  final String title;
  final String imagePath;
  final VoidCallback onPress;
  final double width;
  final double height;

  RecommCardView(
      {this.title, this.imagePath, this.onPress, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        child: Card(
          elevation: 6,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(CARD_CORNER_RADIUS)),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                    height: 225,
                    width: 150,
                    child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(CARD_CORNER_RADIUS),
                      bottomLeft: Radius.circular(CARD_CORNER_RADIUS)),
                  child: CachedNetworkImage(
                    imageUrl: imagePath,
                    placeholder: (context, url) =>
                        SpinKitPulse(color: Colors.white),
                    errorWidget: (context, url, error) => new Icon(Icons.error),

                    fit: BoxFit.cover,
                  ),
                )),
              ),
              Container(
                margin: EdgeInsets.all(2.0),
                alignment: Alignment.center,
                child: Text(
                  title,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonCardView extends StatelessWidget {
  static const double CARD_CORNER_RADIUS = 5.0;
  static const double CARD_HEIGHT = 5.0;
  final String title;
  final String imagePath;
  final VoidCallback onPress;

  PersonCardView({this.title, this.imagePath, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 300,
        child: Card(
          elevation: 6,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(CARD_CORNER_RADIUS)),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                    child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(CARD_CORNER_RADIUS),
                      topRight: Radius.circular(CARD_CORNER_RADIUS)),
                  child: CachedNetworkImage(
                    imageUrl: imagePath,
                    placeholder: (context, url) =>
                        SpinKitPulse(color: Colors.white),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(4),
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class RecommendationCardView extends StatelessWidget {
  static const double CARD_CORNER_RADIUS = 5.0;
  static const double CARD_HEIGHT = 5.0;
  final String title;
  final String imagePath;
  final VoidCallback onPress;

  RecommendationCardView({this.title, this.imagePath, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 225,
        width: 150,
        child: Card(
          elevation: 6,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(CARD_CORNER_RADIUS)),
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(CARD_CORNER_RADIUS),
                          topRight: Radius.circular(CARD_CORNER_RADIUS)),
                      child: CachedNetworkImage(
                        imageUrl: imagePath,
                        placeholder: (context, url) =>
                            SpinKitPulse(color: Colors.white),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )),
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(4),
                      alignment: Alignment.center,
                      child: Text(
                        title,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.subtitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
