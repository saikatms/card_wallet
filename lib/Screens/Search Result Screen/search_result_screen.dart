import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_walet/Controller/Auth%20Controller/auth_controller.dart';
import 'package:card_walet/Screens/AddCard/add_card.dart';
import 'package:card_walet/Screens/Card%20Details%20Screen/card_details_screen.dart';
import 'package:card_walet/Screens/Profile%20Screen/profile_screen.dart';
import 'package:card_walet/Widgets/back_button.dart';
import 'package:card_walet/Widgets/user_avatar.dart';
import 'package:card_walet/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Widgets/custom_card.dart';

class SearchResultScreen extends StatefulWidget {
  SearchResultScreen({Key? key}) : super(key: key);

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> with SingleTickerProviderStateMixin{
  final AuthController authController = Get.find();

  final scrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _result;
  TabController? _tabController;
  @override

  int limit = 10;
  int skip = 0;

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


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authController.totalCount.value = 0;
    return FutureBuilder(
      future: Future.wait([
        authController.getSportList(
          limit: limit,
          skip: 0,
        ),
        authController.getSportListCount()
      ]),
      builder: (context, snapshot) {
        return Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: true,

            appBar: AppBar(
            backgroundColor: mainColor,
            leading: CustomBackButton(),
            title: Text(
              "Profile",
              // 'Search Results (${authController.totalCount})',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: const Color(0xff03dac6),
            foregroundColor: Colors.black,
            onPressed: () {
        // Respond to button press
              Get.to(()=>AddCard());

            },
            icon: Icon(Icons.add),
            label: Text('New Card'),
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

          body:Container(
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
                                        width: 200,
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
                      // InkWell(
                      //     onTap: () {},
                      //
                      //     child: Image.asset(
                      //       'assets/icon/edit.png',
                      //       height: 25,
                      //       width: 25,
                      //       // fit: BoxFit.cover,
                      //     )
                      // )
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
                    children: [
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

                )
                    , SingleChildScrollView(
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
      },
    );
  }
}
