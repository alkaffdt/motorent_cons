import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/features/home/presentation/providers/get_all_transactions_provider.dart';

class TransactionsHistoryPage extends ConsumerWidget {
  const TransactionsHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getAllTransactionsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Transactions History')),
      body: state.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Image.network(
                    data[index].vehicle?.images.first ?? '',
                    width: 48,
                  ),
                  title: Text(data[index].vehicle?.name ?? ''),
                  subtitle: Text(
                    '${data[index].durationInDays.toString()} day${data[index].durationInDays! > 1 ? 's' : ''}',
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
