import 'dart:io';
import 'package:approach_to_charge/domain/entity/cat.dart';
import 'package:approach_to_charge/infrastructure/router/main_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class CatCard extends StatelessWidget {
  final Cat catData;

  const CatCard({super.key, required this.catData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFE0F7FA),
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                catData.name?.toUpperCase() ?? 'Cat Breed',
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF004D40)),
              ),
            ),
            const SizedBox(height: 10),
            Hero(
              tag: catData.id ?? 'Cat Breed',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  "https://cdn2.thecatapi.com/images/${catData.referenceImageId}.jpg",
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Image.asset("assets/cat.png"),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Origin: ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF004D40)),
                ),
                Image.network(
                  'https://flagcdn.com/16x12/${catData.countryCode?.toLowerCase() ?? ""}.png',
                  width: 20,
                  height: 20,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, color: Colors.red);
                  },
                ),
                const SizedBox(width: 5),
                Text(
                  catData.origin ?? "",
                  style: const TextStyle(fontSize: 16, color: Color(0xFF004D40)),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  'Intelligence: ',
                  style: TextStyle(fontSize: 16, color: Color(0xFF004D40)),
                ),
                Row(
                  children: List.generate(
                    catData.intelligence ?? 0,
                        (index) => const Icon(
                      Icons.pets,
                      size: 16,
                      color: Colors.brown,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Platform.isIOS
                  ? CupertinoButton.filled(
                borderRadius: BorderRadius.circular(10),
                onPressed: () {
                  context.go(DetailsRouter().path, extra: catData);
                },
                child: const Text(
                  'Here for more information',
                  style: TextStyle(color: Colors.white),
                ),
              )
                  : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BCD4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  context.go(DetailsRouter().path, extra: catData);
                },
                child: const Text(
                  'Here for more information',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
