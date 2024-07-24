import 'dart:io';
import 'package:approach_to_charge/infrastructure/provider/error/home_provider_error.dart';
import 'package:approach_to_charge/infrastructure/provider/home_provider.dart';
import 'package:approach_to_charge/infrastructure/view/home/components/cat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? _buildCupertinoPageScaffold(context)
        : _buildMaterialScaffold(context);
  }

  Widget _buildMaterialScaffold(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catbreeds', style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFF00BCD4),
        centerTitle: true,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildCupertinoPageScaffold(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Catbreeds'),
        backgroundColor: CupertinoColors.systemTeal,
      ),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Platform.isIOS
                ? CupertinoTextField(
                    onChanged: (breed) {
                      context.read<HomeProvider>().findCatByBreed(breed);
                    },
                    placeholder: 'Write the breed of the cat',
                    prefix: const Icon(CupertinoIcons.search),
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CupertinoColors.systemGrey),
                    ),
                  )
                : TextField(
                    onChanged: (breed) {
                      context.read<HomeProvider>().findCatByBreed(breed);
                    },
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: InputDecoration(
                      labelText: 'Write the breed of the cat',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<HomeProvider>(
                builder: (context, homeprovider, child) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showErrorDialog(context);
                  });

                  if (homeprovider.loading && homeprovider.cats.isEmpty) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await context.read<HomeProvider>().loadListCatRefresh();
                    },
                    child: homeprovider.cats.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.pets,
                                  color: Colors.grey,
                                  size: 80,
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'No data available.',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Please try searching for a different breed.',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[600],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            controller: homeprovider.scrollController,
                            itemCount: homeprovider.cats.length +
                                (homeprovider.hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == homeprovider.cats.length) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              final catData = homeprovider.cats[index];
                              return CatCard(catData: catData);
                            },
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showErrorDialog(BuildContext context) {
    if (context.read<HomeProvider>().errortype is ErrorOfNetWork) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<HomeProvider>().changetoNone();
        if (Platform.isIOS) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Row(
                children: [
                  Icon(CupertinoIcons.exclamationmark_triangle,
                      color: CupertinoColors.destructiveRed),
                  SizedBox(width: 10),
                  Text('Network Error')
                ],
              ),
              content: const Text(
                  'An error occurred while fetching data. Please check your internet connection and try again.'),
              actions: [
                CupertinoDialogAction(
                  onPressed: () {
                    context.read<HomeProvider>().loadListCatRefresh();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Retry'),
                ),
                CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.red),
                  SizedBox(width: 10),
                  Text('Network Error')
                ],
              ),
              content: const Text(
                  'An error occurred while fetching data. Please check your internet connection and try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    context.read<HomeProvider>().loadListCatRefresh();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Retry'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      });
    }
  }
}
