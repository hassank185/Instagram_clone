



import 'package:flutter/material.dart';
import 'package:instagram_clone/consts.dart';
import 'package:instagram_clone/features/presentation/widgets/form_container_widget.dart';
import 'package:instagram_clone/theme/style.dart';

class SingleCommentWidget extends StatefulWidget {
  const SingleCommentWidget({Key? key}) : super(key: key);

  @override
  State<SingleCommentWidget> createState() => _SingleCommentWidgetState();
}

class _SingleCommentWidgetState extends State<SingleCommentWidget> {

  bool _isUserReplaying = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: secondaryColor,
                shape: BoxShape.circle
            ),
          ),
          sizeHor(10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Username", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: primaryColor),),
                      Icon(Icons.favorite_outline, size: 20, color: darkGreyColor,)
                    ],
                  ),
                  sizeVer(4),
                  Text("This is comment", style: TextStyle(color: primaryColor),),
                  sizeVer(4),
                  Row(
                    children: [
                      Text("08/07/2022", style: TextStyle(color: darkGreyColor, fontSize: 12),),
                      sizeHor(15),
                      GestureDetector(onTap: () {
                        setState(() {
                          _isUserReplaying = !_isUserReplaying;
                        });
                      },child: Text("Replay", style: TextStyle(color: darkGreyColor, fontSize: 12),)),
                      sizeHor(15),
                      Text("View Replays", style: TextStyle(color: darkGreyColor, fontSize: 12),),

                    ],
                  ),
                  _isUserReplaying == true? sizeVer(10) : sizeVer(0),
                  _isUserReplaying == true? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FormContainerWidget(hintText: "Post your replay..."),
                      sizeVer(10),
                      Text(
                        "Post",
                        style: TextStyle(color: blueColor),
                      )
                    ],
                  ) : Container(width: 0, height: 0,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
