import 'package:tango/router/app_routes_constant.dart';

List<ActionModel> actionList = [
  ActionModel(
    id: "1",
    title: "Sell a product",
    iconName: "buy",
    dynamicLink: Routes.productViewAll.name,
  ),
  ActionModel(
    id: "2",
    title: "Rent a product",
    iconName: "rent",
    dynamicLink: Routes.addProductScreen.name,
  ),
  // ActionModel(
  //   id: "3",
  //   title: "Current Weather",
  //   iconName: "weather",
  //   dynamicLink: Routes.weatherHomeScreen.name,
  // ),
];

class ActionModel {
  ActionModel({
    required this.id,
    required this.title,
    required this.iconName,
    required this.dynamicLink,
  });

  String id;
  String title;
  String iconName;
  String dynamicLink;
}
