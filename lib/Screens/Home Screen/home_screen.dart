import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_walet/Controller/Auth%20Controller/auth_controller.dart';
import 'package:card_walet/Screens/Card%20Details%20Screen/card_details_screen.dart';
import 'package:card_walet/Screens/Profile%20Screen/profile_screen.dart';
import 'package:card_walet/Screens/Search%20Result%20Screen/Widgets/custom_card.dart';
import 'package:card_walet/Screens/Search%20Result%20Screen/search_result_screen.dart';
import 'package:card_walet/Widgets/user_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import 'Widgets/item_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final AuthController authController = Get.find();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  int limit = 10;
  int skip = 0;
  String? _result;
  TabController? _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(initialIndex: 0,
      length: 2,
      vsync: this
      );

    scrollController.addListener(
          () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          skip = limit + skip;
          if (limit <= authController.totalCount.value) {
            authController.getSportList(
              limit: limit,
              skip: skip,
            );
          }
        }
      },

    );
  }
  bool isSwitched = false;

  final sportsList = [
    {
      "icon": "assets/icon/MMA.png",
      'name': 'MMA',
      'color': Color(0xFFFFF6AB),
    },
    {
      "icon": "assets/icon/baseball.png",
      'name': 'Baseball',
      'color': Color(0xFFA6E8FE),
    },
    {
      "icon": "assets/icon/basketball.png",
      'name': 'Basketball',
      'color': Color(0xFFDCFEDB),
    },
    {
      "icon": "assets/icon/boxing.png",
      'name': 'Boxing',
      'color': Color(0xFFEADAFE),
    },
    {
      "icon": "assets/icon/football.png",
      'name': 'Football',
      'color': Color(0xFFFFD064),
    },
    {
      "icon": "assets/icon/track and field.png",
      'name': 'Track and Field',
      'color': Color(0xFFFFC6A8),
    },
    {
      "icon": "assets/icon/gymnastics.png",
      'name': 'Gymnastics',
      'color': Color(0xFFFFD064),
    },
    {
      "icon": "assets/icon/swimming.png",
      'name': 'Swimming',
      'color': Color(0xFFDCFEDB),
    },
    {
      "icon": "assets/icon/tennis.png",
      'name': 'Tennis',
      'color': Color(0xFFEADAFE),
    },
    {
      "icon": "assets/icon/wrestling.png",
      'name': 'Wrestling',
      'color': Color(0xFFFFD064),
    },
    {
      "icon": "assets/icon/hockey.png",
      'name': 'Hockey',
      'color': Color(0xFFDCFEDB),
    },
    {
      "icon": "assets/icon/racing.png",
      'name': 'Racing',
      'color': Color(0xFFA6E8FE),
    },
    {
      "icon": "assets/icon/golf.png",
      'name': 'Golf',
      'color': Color(0xFFFFD064),
    },
    {
      "icon": "assets/icon/soccer.png",
      'name': 'Soccer',
      'color': Color(0xFFFFD064),
    },
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Obx(
              () => UserAccountsDrawerHeader(
                  accountName: Text(
                      "${authController.appUser.value.userDetails!.firstName} ${authController.appUser.value.userDetails!.lastName}"),
                  accountEmail: Text(
                      "${authController.appUser.value.userDetails!.email}"),
                  currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(10000.0),
                    child: CachedNetworkImage(
                      imageUrl: authController
                          .appUser.value.userDetails!.profilePicture!,
                      placeholder: (context, url) =>
                          Container(child: CircularProgressIndicator()),
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => Text(
                        "${authController.appUser.value.userDetails!.firstName![0].toUpperCase()}",
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  )),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Log out"),
              onTap: () {
                Navigator.pop(context);
                authController.logOut();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(title:Text("Profile")),
      body: Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Obx(() =>
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: CachedNetworkImage(
                              imageUrl: authController.appUser.value.userDetails!.profilePicture!,
                              placeholder: (context,url)=>
                                  Container(
                                    child: CircularProgressIndicator(),
                                  ),
                              fit: BoxFit.fill,
                              errorWidget: (context, url, error) => Text(
                                "${authController.appUser.value.userDetails!.firstName![0].toUpperCase()}",
                                style: TextStyle(fontSize: 40.0),
                              ),

                            ),
                          ),
                      ) ,
                      SizedBox(width: 20,),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Obx(() =>Text("${
                                  authController
                                      .appUser.value.userDetails!.firstName
                              } ${authController.appUser.value.userDetails!.lastName}",style: TextStyle(fontSize: 20,color: Colors.black),)),
                            ),
                            Row(
                              children: [
                                Icon(Icons.mail_outline),
                                SizedBox(width: 5,),
                                Container(
                                  width: 180,
                                  child: Obx(() =>Text("${
                                      authController
                                          .appUser.value.userDetails!.email
                                  }",overflow: TextOverflow.ellipsis,)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone_outlined),
                                SizedBox(width: 5,),
                                Container(
                                  child: Obx(() =>Text("${
                                      authController
                                          .appUser.value.userDetails!.phoneNumber
                                  }")),
                                ),
                              ],
                            ),
                            Container(
                                child:Row(children: [
                                  Text("Make Profile Private",
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                    ),),
                                  Switch(value: isSwitched, onChanged: (value){
                                    setState(() {
                                      isSwitched=value;
                                      print(isSwitched);
                                    });
                                  },)

                                ],)
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Obx(
                  //       () => GestureDetector(
                  //         onTap: () {
                  //         Get.to(() => ProfilePage());
                  //         },
                  //         child: Image(image:AssetImage(
                  //           'assets/icon/edit.png',
                  //           // fit: BoxFit.cover,
                  //         ),
                  //           height: 20,
                  //         )
                  //   ),
                  // ),

                  Obx(
                        () => UserAvatar(
                        onPress: () {
                          Get.to(() => ProfilePage());
                      },
                      imgUrl: authController
                          .appUser.value.userDetails!.profilePicture!,
                    ),
                  )

                ],
              ),

            ),
            SizedBox(
              height: defaultPadding,
            ),
            TabBar(
            indicatorColor: Colors.lime,
                labelColor: const Color(0xFF3baee7),
                controller: _tabController,
                tabs: [
              Container(
                child: Tab(
                  text: "Card Collections",
                ),
              ),
              Tab(
                text: "Recent Trades",
              )
            ]),
            Expanded(
              child: TabBarView(
                children: [Padding(
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        authController.selectedSport.value =
                        sportsList[index]['name']! as String;
                        Get.to(() => SearchResultScreen());
                      },
                      child: ItemWidget(
                        color: sportsList[index]['color']! as Color,
                        icon: sportsList[index]['icon']! as String,
                        name: sportsList[index]['name']! as String,
                      ),
                    ),
                    itemCount: sportsList.length,
                  ),
                ),
                  SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Obx(
                          () => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: defaultPadding),
                            child: Text("Owner Card (${authController.totalCount})",textAlign: TextAlign.left,
                                style:TextStyle(color: Colors.black)),
                          ),
                          ...List.generate(
                            authController.playersList.length,
                                (index) => CustomCard(
                              img: authController.playersList[index].imageUrl,
                              baseInsert: authController.playersList[index].sport,
                              collection: authController.playersList[index].variation,
                              name: authController.playersList[index].playerName,
                              parrallel: '#\'d / 79',
                              printRun: '79',
                              setName: authController.playersList[index].setName,
                              year: authController.playersList[index].setYear,
                              price: authController.playersList[index].priceScore,
                              onPress: () {
                                authController.selectedPlayer.value =
                                authController.playersList[index];
                                Get.to(
                                      () => CardDetailsScreen(
                                    id: authController.playersList[index].id!,
                                  ),
                                );
                              },
                            ),
                          ).toList()
                        ],
                      ),
                    ),
                  ),

                )],
                controller: _tabController,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class CustomDelegate extends SearchDelegate<String> {
  final AuthController authController = Get.find();

  final sportsList = [
    {
      "icon": "assets/icon/MMA.png",
      'name': 'MMA',
      'color': Color(0xFFFFF6AB),
    },
    {
      "icon": "assets/icon/baseball.png",
      'name': 'Baseball',
      'color': Color(0xFFA6E8FE),
    },
    {
      "icon": "assets/icon/basketball.png",
      'name': 'Basketball',
      'color': Color(0xFFDCFEDB),
    },
    {
      "icon": "assets/icon/boxing.png",
      'name': 'Boxing',
      'color': Color(0xFFEADAFE),
    },
    {
      "icon": "assets/icon/football.png",
      'name': 'Football',
      'color': Color(0xFFFFD064),
    },
    {
      "icon": "assets/icon/track and field.png",
      'name': 'Track and Field',
      'color': Color(0xFFFFC6A8),
    },
    {
      "icon": "assets/icon/gymnastics.png",
      'name': 'Gymnastics',
      'color': Color(0xFFFFD064),
    },
    {
      "icon": "assets/icon/swimming.png",
      'name': 'Swimming',
      'color': Color(0xFFDCFEDB),
    },
    {
      "icon": "assets/icon/tennis.png",
      'name': 'Tennis',
      'color': Color(0xFFEADAFE),
    },
    {
      "icon": "assets/icon/wrestling.png",
      'name': 'Wrestling',
      'color': Color(0xFFFFD064),
    },
    {
      "icon": "assets/icon/hockey.png",
      'name': 'Hockey',
      'color': Color(0xFFDCFEDB),
    },
    {
      "icon": "assets/icon/racing.png",
      'name': 'Racing',
      'color': Color(0xFFA6E8FE),
    },
    {
      "icon": "assets/icon/golf.png",
      'name': 'Golf',
      'color': Color(0xFFFFD064),
    },
    {
      "icon": "assets/icon/soccer.png",
      'name': 'Soccer',
      'color': Color(0xFFFFD064),
    },
  ];

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      icon: Icon(Icons.chevron_left), onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) => Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    print(query);
    List<Map<String, Object>> listToShow;
    if (query.isNotEmpty)
      listToShow = sportsList
          .where((e) =>
              e['name']!.toString().toLowerCase().contains(query) &&
              e['name']!.toString().toLowerCase().startsWith(query))
          .toList();
    else
      listToShow = sportsList;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: GridView.builder(
        itemCount: listToShow.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (_, i) {
          var noun = listToShow[i];
          return GestureDetector(
            onTap: () {
              authController.selectedSport.value = noun['name']! as String;
              Get.to(() => SearchResultScreen());
            },
            child: ItemWidget(
              color: noun['color']! as Color,
              icon: noun['icon']! as String,
              name: noun['name']! as String,
            ),
          );
        },
      ),
    );
  }
}
