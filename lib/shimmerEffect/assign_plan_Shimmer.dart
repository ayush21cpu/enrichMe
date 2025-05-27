import "package:flutter/material.dart";
import "package:shimmer/shimmer.dart";

Widget buildShimmerBox({double height = 50}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    child: Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(6),
      ),
    ),
  );
}