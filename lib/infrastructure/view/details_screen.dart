import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:approach_to_charge/domain/entity/cat.dart';

class DetailsScreen extends StatelessWidget {
  final Cat catData;

  const DetailsScreen({required this.catData, super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(catData.name ?? 'Cat Breed'),
        backgroundColor: const Color(0xFF00BCD4)
      ),
      child: _buildContent(context),
    )
        : Scaffold(
      appBar: AppBar(
        title: Text(catData.name ?? 'Cat Breed',
            style: const TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFF00BCD4),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Hero(
            tag: catData.id ?? 'Cat Breed',
            child: Material(
              elevation: 10.0,
              shadowColor: Colors.grey.withOpacity(0.5),
              borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(12.0)),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12.0)),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.network(
                    'https://cdn2.thecatapi.com/images/${catData.referenceImageId}.jpg',
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: double.infinity,
                        child: Image.asset("assets/cat.png"),
                      );
                    },
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
                            )),
                      );
                    },
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Description:',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${catData.description}',
                      style:
                      const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithIcon(
                      'Origin: ',
                      'https://flagcdn.com/16x12/${catData.countryCode?.toLowerCase()}.png',
                      catData.origin ?? '',
                      Colors.black,
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithIcons(
                      'Intelligence: ',
                      Icons.pets,
                      catData.intelligence ?? 0,
                      Colors.brown,
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithIcons(
                      'Affection Level: ',
                      Icons.favorite,
                      catData.affectionLevel ?? 0,
                      Colors.red,
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithIcons(
                      'Health Issues: ',
                      Icons.sick,
                      catData.healthIssues ?? 0,
                      Colors.green,
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithIcons(
                      'Energy Level: ',
                      Icons.flash_on,
                      catData.energyLevel ?? 0,
                      Colors.yellow,
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithIcons(
                      'Adaptability: ',
                      Icons.adjust,
                      catData.adaptability ?? 0,
                      Colors.blue,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Life Span: ${catData.lifeSpan} years',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithIcons(
                      'Dog Friendly: ',
                      Icons.pets,
                      catData.dogFriendly ?? 0,
                      Colors.blue,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Weight: ${catData.weight?.metric} kg',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Temperament: ${catData.temperament}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithYesNo(
                      'Natural: ',
                      catData.natural == 1,
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithYesNo(
                      'Indoor: ',
                      catData.indoor == 1,
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithYesNo(
                      'Lap: ',
                      catData.lap == 1,
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithIcons(
                      'Child Friendly: ',
                      Icons.child_friendly,
                      catData.childFriendly ?? 0,
                      Colors.orange,
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithIcons(
                      'Social Needs: ',
                      Icons.people,
                      catData.socialNeeds ?? 0,
                      Colors.purple,
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithIcons(
                      'Stranger Friendly: ',
                      Icons.emoji_people,
                      catData.strangerFriendly ?? 0,
                      Colors.brown,
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithIcons(
                      'Vocalisation: ',
                      Icons.volume_up,
                      catData.vocalisation ?? 0,
                      Colors.red,
                    ),
                    const SizedBox(height: 10),
                    _buildRowWithYesNo(
                      'Hypoallergenic: ',
                      catData.hypoallergenic == 1,
                    ),
                    const SizedBox(height: 10),
                    if (catData.altNames != null &&
                        catData.altNames!.isNotEmpty)
                      Text(
                        'Alternate Names: ${catData.altNames}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowWithIcon(String label, String iconUrl, String value, Color iconColor) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Image.network(
          iconUrl,
          width: 20,
          height: 20,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.error, color: Colors.red);
          },
        ),
        const SizedBox(width: 5),
        Text(
          value,
          style: TextStyle(fontSize: 16, color: iconColor),
        ),
      ],
    );
  }

  Widget _buildRowWithIcons(String label, IconData icon, int count, Color iconColor) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          children: List.generate(
            count,
                (index) => Icon(
              icon,
              size: 16,
              color: iconColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRowWithYesNo(String label, bool condition) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Icon(
          condition ? Icons.check : Icons.close,
          size: 16,
          color: condition ? Colors.green : Colors.red,
        ),
      ],
    );
  }
}
