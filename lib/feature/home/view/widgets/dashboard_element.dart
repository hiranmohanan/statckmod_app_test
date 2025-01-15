part of '../home_view.dart';

SizedBox dashboardElement({
  required String title,
  String? subTitle,
  double? height,
  double? width,
}) {
  return SizedBox(
    height: height ?? 30.sp,
    width: width,
    child: ListTile(
      title: Text(Kstrings.taskPending),
      subtitle: Text(subTitle ?? ''),
    ),
  );
}
