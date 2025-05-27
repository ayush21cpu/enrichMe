import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../viewModel/AssignPlan_ViewModel.dart';
import '../shimmerEffect/assign_plan_Shimmer.dart';

class AssignPlanPage extends StatelessWidget {
  const AssignPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AssignPlanViewModel(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Assign Plan',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
          backgroundColor: Colors.white,),
        body: Container(
          color: Colors.white,
          child: const Padding(
            padding: EdgeInsets.only(left: 18.0,right: 18,top: 30,),
            child: AssignPlanForm(),
          ),
        ),
      ),
    );
  }
}

class AssignPlanForm extends StatelessWidget {
  const AssignPlanForm({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssignPlanViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (provider.errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              provider.errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        _buildUsersDropdown(provider),
        const SizedBox(height: 20),
        _buildPlansDropdown(provider),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: provider.isAssigning
              ? null
              : () async {
            bool success = await provider.assignPlan();
            if (success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Plan assigned successfully!')),
              );
            }
          },
          child: provider.isAssigning
              ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          )
              : const Text('Assign Plan'),
        ),
      ],
    );
  }

  Widget _buildUsersDropdown(AssignPlanViewModel provider) {
    if (provider.isLoadingUsers) {
      return buildShimmerBox(height: 50);
    }
    if (provider.users.isEmpty) {
      return const Text('No users found');
    }
    return DropdownButton<String>(
      isExpanded: true,
      hint: const Text('Select User'),
      value: provider.selectedUserId,
      items: provider.users.map((doc) {
        final email = doc.data()?['email'] ?? 'No Email';
        return DropdownMenuItem(
          value: doc.id,
          child: Text(email),
        );
      }).toList(),
      onChanged: provider.selectUser,
    );
  }

  Widget _buildPlansDropdown(AssignPlanViewModel provider) {
    if (provider.isLoadingPlans) {
      return buildShimmerBox(height: 50);
    }
    if (provider.plans.isEmpty) {
      return const Text('No plans found');
    }
    return DropdownButton<String>(
      isExpanded: true,
      hint: const Text('Select Fitness Plan'),
      value: provider.selectedPlanId,
      items: provider.plans.map((doc) {
        final title = doc.data()?['title'] ?? 'No Title';
        return DropdownMenuItem(
          value: doc.id,
          child: Text(title),
        );
      }).toList(),
      onChanged: provider.selectPlan,
    );
  }
}
