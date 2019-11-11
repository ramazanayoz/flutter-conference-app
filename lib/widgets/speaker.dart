import 'package:flutter/material.dart';
import 'package:flutter_conference_app/models/conference_data.dart';
import 'package:flutter_conference_app/models/data.dart';
import 'package:flutter_conference_app/utils.dart';
import 'package:flutter_conference_app/widgets/reusable.dart';
import 'package:flutter_conference_app/widgets/talk.dart';
import 'package:flutter_villains/villains/villains.dart';
import 'package:provider/provider.dart';

class SpeakerWidget extends StatelessWidget {
  final Speaker speaker;

  SpeakerWidget(this.speaker);

  void _goToTalk(context, AugmentedTalk talk) {
    Navigator.of(context).push(FadeRoute(TalkWidget(talk, popBack: true)));
  }

  Widget _getTalks(BuildContext context) {
    return Consumer<ConferenceData>(builder: (context, data, child) {
      List<AugmentedTalk> talks = data.getTalksForSpeaker(speaker.id);
      if (talks == null || talks.length == 0) {
        return Text("This speaker has no talks!",
            textAlign: TextAlign.justify,
            style: TextStyle(
                fontSize: 16.0, height: 1.2, color: Colors.grey[300]));
      } else {
        var talkRows = <Widget>[];
        for (final talk in talks) {
          talkRows.add(InkWell(
              onTap: () => _goToTalk(context, talk),
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                      children: <TextSpan>[
                        TextSpan(
                            text: "${talk.time} - ${talk.track.name}",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: " - ${talk.title}"),
                      ]))));
        }
        return Column(
          children: talkRows,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
          body: Builder(
              builder: (context) =>
                  Container(
                      color: Theme
                          .of(context)
                          .backgroundColor,
                      child: Stack(children: <Widget>[
                        Reusable.header,
                        Villain(
                            villainAnimation: VillainAnimation.fromBottom(
                                relativeOffset: 0.05,
                                to: Duration(milliseconds: 200)),
                            secondaryVillainAnimation: VillainAnimation
                                .fade(),
                            animateExit: true,
                            child: Center(
                                child: SingleChildScrollView(
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    padding: EdgeInsets.only(
                                        top: Utils
                                            .getSpeakerOrientationTopMargin(
                                            orientation),
                                        bottom: 40.0,
                                        right: Utils.getOrientationSideMargin(
                                            orientation),
                                        left: Utils.getOrientationSideMargin(
                                            orientation)),
                                    child: Column(children: <Widget>[
                                      Stack(
                                          alignment: AlignmentDirectional
                                              .topCenter,
                                          children: <Widget>[
                                            Card(
                                                elevation: 12.0,
                                                margin: EdgeInsets.only(
                                                    top: 82.0, bottom: 20.0),
                                                child: Padding(
                                                    padding: EdgeInsets.all(
                                                        18.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      children: <Widget>[
                                                        Container(
                                                            padding:
                                                            EdgeInsets.only(
                                                                top: 80.0,
                                                                bottom: 6.0),
                                                            child: Text(
                                                              "${speaker
                                                                  .name}",
                                                              textAlign:
                                                              TextAlign
                                                                  .center,
                                                              style: TextStyle(
                                                                  fontSize: 32.0),
                                                            )),
                                                        Text(
                                                          "${speaker
                                                              .company}",
                                                          style: TextStyle(
                                                              color:
                                                              Theme
                                                                  .of(context)
                                                                  .textTheme
                                                                  .caption
                                                                  .color),
                                                        ),
                                                        Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                top: 10.0,
                                                                bottom: 10.0,
                                                                left: 30.0,
                                                                right: 30.0),
                                                            child: Divider(
                                                              indent: 10.0,
                                                            )),
                                                        Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                            children: Reusable
                                                                .getLinkIcons(
                                                                speaker))
                                                      ],
                                                    ))),
                                            Hero(
                                                tag: "avatar${speaker.id}",
                                                child: Reusable.circleAvatar(speaker.imagePath, 80.0)),
                                          ]),
                                      Container(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          padding: EdgeInsets.only(
                                              top: 10.0,
                                              bottom: 4.0,
                                              right: 6.0,
                                              left: 6.0),
                                          child: Text(
                                            'Talks',
                                            style: TextStyle(
                                                fontSize: 22.0,
                                                color: Colors.white),
                                          )),
                                      Container(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          padding: EdgeInsets.only(
                                              top: 4.0,
                                              bottom: 14.0,
                                              right: 6.0,
                                              left: 6.0),
                                          child: _getTalks(context)),
                                      Container(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          padding: EdgeInsets.only(
                                              top: 10.0,
                                              bottom: 4.0,
                                              right: 6.0,
                                              left: 6.0),
                                          child: Text(
                                            'About',
                                            style: TextStyle(
                                                fontSize: 22.0,
                                                color: Colors.white),
                                          )),
                                      Container(
                                          alignment:
                                          AlignmentDirectional.centerStart,
                                          padding: EdgeInsets.only(
                                              top: 4.0,
                                              bottom: 14.0,
                                              right: 6.0,
                                              left: 6.0),
                                          child: Text(
                                            "${speaker.bio}",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                height: 1.2,
                                                color: Colors.white),
                                          )),
                                    ])))),
                        Reusable.statusBarTopShadow,
                        Reusable.backArrow(context)
                      ]))));
    });
  }
}
