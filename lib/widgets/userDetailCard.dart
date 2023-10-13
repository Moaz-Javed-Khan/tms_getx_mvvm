import 'package:flutter/material.dart';
import 'package:graphqlgetxexample/extentions/constants.dart';
import 'package:graphqlgetxexample/models/UserModel.dart';

class UserDetailCard extends StatefulWidget {
  const UserDetailCard({
    super.key,
    required this.user,
  });

  final User? user;
  @override
  State<UserDetailCard> createState() => _UserDetailCardState();
}

class _UserDetailCardState extends State<UserDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.tealAccent[100],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (widget.user?.profilePic != null)
                ? ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(60),
                    ),
                    child: Image.network(
                      IMG_END_POINT + widget.user!.profilePic!,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  )
                : const Icon(
                    Icons.account_circle,
                    size: 120,
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.user?.fullName?.en.toString() ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  widget.user?.email.toString() ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  widget.user?.address?.en.toString() ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Text(
              widget.user?.status ?? "",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
