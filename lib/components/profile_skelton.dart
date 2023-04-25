
import 'package:flutter/material.dart';

import '../constraints/constants.dart';

class ProfileSkelton extends StatelessWidget{
const ProfileSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircleSkeleton(size: 124,),
          const SizedBox(height: defaultPadding),
          const Skeleton(width: 150),
          const SizedBox(height: defaultPadding ),
          const Skeleton(width: 50,),
          const SizedBox(height: defaultPadding),
          const Skeleton(width: 250,),
          const SizedBox(height: defaultPadding),
          Row(
            children: const [
              Expanded(
                child: Skeleton(),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: Skeleton(),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Row(
            children: const [
              Expanded(
                child: Skeleton(),
              ),
              SizedBox(width: defaultPadding),
              Expanded(
                child: Skeleton(),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}

class Skeleton extends StatelessWidget {
  const Skeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(defaultPadding / 2),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 187, 173, 173).withOpacity(0.05),
          borderRadius:
              const BorderRadius.all(Radius.circular(defaultPadding))),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({Key? key, this.size = 24}) : super(key: key);

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}


