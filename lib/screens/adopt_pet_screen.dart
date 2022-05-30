import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/constant.dart';
import '../utils/network_service.dart';
import '/models/petmodel.dart';

class AdoptPetScreen extends StatefulWidget {
  final Pet pet;

  AdoptPetScreen({required this.pet});

  @override
  _AdoptPetScreenState createState() => _AdoptPetScreenState();
}

class _AdoptPetScreenState extends State<AdoptPetScreen> {
  Widget _buildInfoCard(String label, String info) {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 100.0,
      decoration: BoxDecoration(
        color: Color(0xFFF8F2F7),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            info,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  _callNumber(number) async {
    //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Hero(
                  tag: widget.pet.price!,
                  child: Container(
                    width: double.infinity,
                    height: 350.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          widget.pet.image!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.0, left: 10.0),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.pet.breed!,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.call),
                    iconSize: 30.0,
                    color: Theme.of(context).primaryColor,
                    onPressed: () => _callNumber(widget.pet.mobile),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                widget.pet.address!,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              height: 120.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(width: 30.0),
                  _buildInfoCard('Age', widget.pet.age.toString()),
                  _buildInfoCard('Sex', widget.pet.sex!),
                  _buildInfoCard('Color', widget.pet.color!),
                  _buildInfoCard('Price', widget.pet.price.toString()),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20.0, top: 30.0),
              width: double.infinity,
              height: 90.0,
              decoration: BoxDecoration(
                color: Color(0xFFFFF2D0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 8.0,
                ),
                leading: CircleAvatar(
                  child: ClipOval(
                    child: Image(
                      height: 40.0,
                      width: 40.0,
                      image: NetworkImage(widget.pet.image!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  widget.pet.name!,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Owner',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Montserrat',
                  ),
                ),
                trailing: Text(
                  widget.pet.address!,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 25.0),
              child: Text(
                'condition : ' + widget.pet.title!,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15.0,
                  height: 1.5,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                    width: 60.0,
                    child: IconButton(
                      onPressed: () => Share.share(
                          '${widget.pet.breed} ${widget.pet.price} check out my new puppy https://example.com/${widget.pet.id}',
                          subject: '${widget.pet.breed} ${widget.pet.price}'),
                      icon: Icon(Icons.share),
                    ),
                  ),
                  FlatButton.icon(
                    padding: EdgeInsets.all(
                      20.0,
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      adopt();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    icon: Icon(
                      Icons.pets,
                      color: Colors.white,
                    ),
                    label: Text(
                      'ADOPTION',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 20.0,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  adopt() async {
    String user_id = await Constants.UserId;
    String pet_id = widget.pet.id!;
    final json = await getData("request.php", params: {
      "user_id": user_id,
      "pet_id": pet_id,
    });
    Constants.show("pet request notified..");
    return;
  }
}
