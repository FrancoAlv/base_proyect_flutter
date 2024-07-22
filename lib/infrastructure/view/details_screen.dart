import 'package:flutter/material.dart';
import 'package:approach_to_charge/domain/entity/cat.dart';

class DetailsScreen extends StatelessWidget {
  final Cat catData;

  const DetailsScreen({required this.catData, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catData.name ?? 'Cat Breed', style:const  TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFF00BCD4),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Hero(tag: catData.id ?? 'Cat Breed',
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.5,
                child: Image.network(
                  'https://cdn2.thecatapi.com/images/${catData.referenceImageId}.jpg',
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(height: MediaQuery.of(context).size.height*0.5,width: double.infinity,child: Image.asset("assets/cat.png"),);
                  },
                  fit: BoxFit.cover,
                  width: double.infinity
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${catData.description}',
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Origin: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Image.network(
                            'https://flagcdn.com/16x12/${catData.countryCode?.toLowerCase()}.png',
                            width: 20,
                            height: 20,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error, color: Colors.red);
                            },
                          ),
                          const SizedBox(width: 5),
                          Text(
                            catData.origin ?? '',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const  Text(
                            'Intelligence: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      Row(
                        children: [
                          const Text(
                            'Affection Level: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: List.generate(
                              catData.affectionLevel ?? 0,
                                  (index) => const Icon(
                                Icons.favorite,
                                size: 16,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Health Issues: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: List.generate(
                              catData.healthIssues ?? 0,
                                  (index) => const Icon(
                                Icons.sick,
                                size: 16,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Energy Level: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: List.generate(
                              catData.energyLevel ?? 0,
                                  (index) => const Icon(
                                Icons.flash_on,
                                size: 16,
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const  Text(
                            'Adaptability: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: List.generate(
                              catData.adaptability ?? 0,
                                  (index) => const Icon(
                                Icons.adjust,
                                size: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Life Span: ${catData.lifeSpan} years',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Dog Friendly: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: List.generate(
                              catData.dogFriendly ?? 0,
                                  (index) => const Icon(
                                Icons.pets,
                                size: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Weight: ${catData.weight?.metric} kg',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Temperament: ${catData.temperament}',
                        style:const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Natural: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          catData.natural == 1
                              ? const Icon(Icons.check, size: 16, color: Colors.green)
                              :const Icon(Icons.close, size: 16, color: Colors.red),
                        ],
                      ),
                      const  SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Indoor: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          catData.indoor == 1
                              ?const Icon(Icons.home, size: 16, color: Colors.green)
                              :const Icon(Icons.close, size: 16, color: Colors.red),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Lap: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          catData.lap == 1
                              ? const Icon(Icons.airline_seat_recline_extra, size: 16, color: Colors.green)
                              : const Icon(Icons.close, size: 16, color: Colors.red),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Child Friendly: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: List.generate(
                              catData.childFriendly ?? 0,
                                  (index) => const Icon(
                                Icons.child_friendly,
                                size: 16,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Social Needs: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: List.generate(
                              catData.socialNeeds ?? 0,
                                  (index) => const Icon(
                                Icons.people,
                                size: 16,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Stranger Friendly: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: List.generate(
                              catData.strangerFriendly ?? 0,
                                  (index) => const Icon(
                                Icons.emoji_people,
                                size: 16,
                                color: Colors.brown,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Vocalisation: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: List.generate(
                              catData.vocalisation ?? 0,
                                  (index) => const Icon(
                                Icons.volume_up,
                                size: 16,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const  Text(
                            'Hypoallergenic: ',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          catData.hypoallergenic == 1
                              ?const Icon(Icons.check, size: 16, color: Colors.green)
                              :const Icon(Icons.close, size: 16, color: Colors.red),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (catData.altNames != null && catData.altNames!.isNotEmpty)
                        Text(
                          'Alternate Names: ${catData.altNames}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
