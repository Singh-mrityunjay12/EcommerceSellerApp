import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/shimmer/list_tile_shimmer.dart';
import '../../../data/repository/user_model/user_model.dart';
import '../../../utils/helpers/cloud_helper_functions.dart';

import '../../authentication/persionalizations/controllers/user_controller.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final controller = Get.put(UserController());
  final List<UserModel> _search = [];
  // //For storing search users
  final List<UserModel> _searchUser = [];
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MAppBar(
        title: _isSearching
            ? TextField(
                onChanged: (value) {
                  //search logic
                  _searchUser.clear();
                  // final users = controller.userName;

                  for (var i in _search) {
                    if (i.fullName
                            .toLowerCase()
                            .contains(value.toLowerCase()) ||
                        i.email.toLowerCase().contains(value.toLowerCase())) {
                      _searchUser.add(i);
                    }
                    setState(() {
                      _searchUser;
                    });
                  }
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15),
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              )
            : Obx(() =>
                Text('All Users (${controller.userCollectionLength.value})')),
        showBackArrow: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                });
                print(_searchUser.length);
              },
              icon: Icon(_isSearching ? Icons.close : Icons.search)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: controller.getAllUsers(),
                  builder: (context, snapshot) {
                    const loader = MListTileShimmer();

                    final widget = MCloudHelperFunction.checkMultiRecordState(
                        snapshot: snapshot, loader: loader);

                    if (widget != null) {
                      return widget;
                    }

                    //Users Found!

                    final users = snapshot.data!;

                    _search.clear();
                    _search.addAll(users);

                    if (_search.isNotEmpty) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: _isSearching
                              ? _searchUser.length
                              : _search.length,
                          itemBuilder: (_, index) {
                            final user = _isSearching
                                ? _searchUser[index]
                                : _search[index];

                            return SizedBox(
                              height: 170,
                              width: double.infinity,
                              child: Card(
                                child: ListTile(
                                    leading: user.profilePicture != ''
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Image.network(
                                              height: 60,
                                              user.profilePicture,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : const SizedBox(),
                                    title: Text(user.username),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(user.fullName),
                                        Text(user.email),
                                        Text(user.phoneNumber),
                                        Text(user.id),
                                      ],
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          // Get.to(() => AddressScreen(
                                          //       id: user.id,
                                          //     ));
                                          // bottomController.showBottomSheet();
                                        },
                                        icon: const Icon(Icons.more_vert))),
                              ),
                            );
                          });
                    } else {
                      return const Center(child: Text("No Connection Found"));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
