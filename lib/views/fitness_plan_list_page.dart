import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../shimmerEffect/fitness_plan_list_Shimmer.dart';
import '../viewModel/fitness_plan_viewModel.dart';
import 'assign_plan_page.dart';
import 'assigned_plans_page.dart';

class FitnessPlanListPage extends StatelessWidget {
  const FitnessPlanListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FitnessPlanViewModel>(context);
    final plans = provider.plans;
    final isLoading = provider.isLoading;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Plans',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: const Icon(Icons.assignment,color: Colors.black,),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AssignedPlansPage()),
            ),
            tooltip: 'View Assigned Plans',
          ),
          IconButton(
            icon: const Icon(Icons.add,color: Colors.black,),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AssignPlanPage()),
            ),
            tooltip: 'Add New Plan',
          ),
        ],
      backgroundColor: Colors.white,),
      body: Container(
        color: Colors.white,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       theme.colorScheme.primary.withOpacity(0.1),
        //       Colors.white,
        //     ],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        // ),
        child: isLoading
            ? ListView.builder(
          itemCount: 3,
          itemBuilder: (_, index) => const ShimmerTile(),
        )
            : ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 12),
          itemCount: plans.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, index) {
            final plan = plans[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: plan.imageUrl != null && plan.imageUrl.isNotEmpty
                              ? Image.asset(
                            plan.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                              : Container(
                            width: 80,
                            height: 80,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image, color: Colors.grey),
                          ),
                        ),
                        Positioned(
                          bottom: 6,
                          right: 6,
                          child: Container(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getTypeColor(plan.type).withOpacity(0.85),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              plan.type.isNotEmpty ? plan.type.toUpperCase() : 'N/A',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan.title.isNotEmpty ? plan.title : 'No Title',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            plan.description.isNotEmpty
                                ? plan.description
                                : 'No description available',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[700],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 0),
                              minimumSize: const Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () async {
                              try {
                                await provider.savePlan(plan);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Plan saved to Firestore')),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $e')),
                                );
                              }
                            },
                            child: const Text(
                              'Save Plan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'cardio':
        return Colors.red.shade400;
      case 'strength':
        return Colors.blue.shade400;
      case 'yoga':
        return Colors.green.shade400;
      default:
        return Colors.grey.shade600;
    }
  }
}