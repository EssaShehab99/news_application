import 'package:flutter/material.dart';
import 'package:news_application/shared/components/components.dart';
import 'package:news_application/shared/components/constants.dart';
import 'package:skeleton_text/skeleton_text.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return defaultMaterialButton(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 100,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              buildSkeletonsText(index),
                              buildSizedBox(),
                              buildSkeletonsText(index),
                              buildSizedBox(),
                              buildSkeletonsText(index),
                              buildSizedBox(),
                              buildSkeletonsText(index),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.only(end: padding),
                        height: 100,
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(borderRadius),
                            color: Colors.grey.withOpacity(0.2)),
                        alignment: Alignment.center,
                        child: SkeletonAnimation(
                          shimmerColor: Colors.grey,
                          borderRadius: BorderRadius.circular(borderRadius),
                          shimmerDuration: 1000,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(borderRadius),
                                color: Colors.grey.withOpacity(0.2)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                defaultDivider()
              ],
            ),
            onPressed: () {});
      },
    );
  }

  SizedBox buildSizedBox() => SizedBox(height: 19,);

  Widget buildSkeletonsText(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: SkeletonAnimation(
        borderRadius: BorderRadius.circular(borderRadius),
        shimmerColor: index % 2 != 0 ? Colors.grey : Colors.white54,
        child: Container(
          height: 10,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Colors.grey.withOpacity(0.2)),
        ),
      ),
    );
  }
}
