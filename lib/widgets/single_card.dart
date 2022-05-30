import 'package:flutter/material.dart';

import '../models/petmodel.dart';
import '../screens/adopt_pet_screen.dart';

class SingleCard extends StatelessWidget {
  final Pet pet;
  const SingleCard({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(pet.image);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => AdoptPetScreen(pet: pet),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: 40.0, bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: pet.price!,
              child: Container(
                width: double.infinity,
                height: 250.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(pet.image!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.0, 12.0, 40.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    pet.breed!,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    pet.price!,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12.0, 0.0, 40.0, 12.0),
              child: Text(
                pet.address!,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
