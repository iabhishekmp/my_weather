import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/geo_city/geo_city_cubit.dart';

class SearchCityPage extends StatelessWidget {
  const SearchCityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GeoCityCubit, GeoCityState>(
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'City name',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                context.read<GeoCityCubit>().onCityChange(value);
              },
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BlocBuilder<GeoCityCubit, GeoCityState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.hasSearched) {
                    if (state.cities == null || state.cities!.isEmpty) {
                      return const Center(
                        child: Text(
                          'No cities found',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                  }
                  if (state.cities == null || state.cities!.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return ListView.builder(
                    itemCount: state.cities!.length,
                    itemBuilder: (context, index) {
                      final city = state.cities![index];
                      return ListTile(
                        title: Text(
                          city.name,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          '${city.country}, ${city.state}',
                          style: const TextStyle(color: Colors.white54),
                        ),
                        onTap: () {},
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
