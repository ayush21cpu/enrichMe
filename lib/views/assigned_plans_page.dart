import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../viewModel/AssignedPlans_viewModel.dart';

class AssignedPlansPage extends StatelessWidget {
  const AssignedPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AssignedPlansViewModel()..fetchAssignedPlans(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Assigned Plans',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),

          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          child: Consumer<AssignedPlansViewModel>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                ///shimmer loading effect
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder:
                      (context, index) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Card(
                            child: ListTile(
                              title: Container(height: 16, color: Colors.white),
                              subtitle: Container(
                                height: 14,
                                color: Colors.white,
                              ),
                              trailing: Container(
                                width: 50,
                                height: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                );
              }

              if (provider.errorMessage != null) {
                return Center(
                  child: Text(
                    provider.errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              }

              if (provider.plans.isEmpty) {
                return const Center(child: Text('No plans assigned yet!'));
              }

              return ListView.builder(
                itemCount: provider.plans.length,
                itemBuilder: (_, index) {
                  final plan = provider.plans[index];
                  return Card(
                    margin: const EdgeInsets.all(12),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        plan['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        plan['description'],
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color:
                              plan['type'] == 'premium'
                                  ? Colors.green.shade200
                                  : Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          plan['type'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}