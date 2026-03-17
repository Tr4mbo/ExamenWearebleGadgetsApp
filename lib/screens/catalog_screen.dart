import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  // Dummy data for gadgets & wearables
  static final List<Product> _products = [
    Product(
      id: 'p1',
      name: 'Smart Glasses AR-X',
      description: 'Gafas de realidad aumentada con display OLED y cámara integrada 4K.',
      price: 15999.0,
      imageUrl: 'https://images.pexels.com/photos/1081685/pexels-photo-1081685.jpeg?auto=compress&cs=tinysrgb&w=600', // Replace AR glasses
      category: 'Wearables',
    ),
    Product(
      id: 'p2',
      name: 'Vital Ring Pro',
      description: 'Anillo inteligente que monitorea sueño, ritmo cardíaco y oxígeno en sangre.',
      price: 5499.0,
      imageUrl: 'https://images.pexels.com/photos/17834/pexels-photo.jpg?auto=compress&cs=tinysrgb&w=600', // Replace Ring
      category: 'Wearables',
    ),
    Product(
      id: 'p3',
      name: 'OmniWatch Series 8',
      description: 'Reloj inteligente con pantalla de zafiro, GPS y batería de 14 días.',
      price: 8999.0,
      imageUrl: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=600&q=80',
      category: 'Wearables',
    ),
    Product(
      id: 'p4',
      name: 'Drone Phantom V',
      description: 'Dron plegable con cámara 8K, seguimiento automático y 45 mins de vuelo.',
      price: 24500.0,
      imageUrl: 'https://images.unsplash.com/photo-1527977966376-1c8408f9f108?w=600&q=80', // Replace Drone
      category: 'Drones',
    ),
    Product(
      id: 'p5',
      name: 'PowerGrid 30k',
      description: 'Batería portátil de grafeno con 30,000 mAh y carga ultrarrápida bidireccional.',
      price: 2100.0,
      imageUrl: 'https://images.unsplash.com/photo-1609081219090-a6d81d3085bf?w=600&q=80',
      category: 'Energía',
    ),
    Product(
      id: 'p6',
      name: 'NeuroPods Max',
      description: 'Auriculares de conducción ósea con cancelación activa de ruido.',
      price: 3450.0,
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&q=80',
      category: 'Audio',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Extract unique categories
    final List<String> categories = _products.map((p) => p.category).toSet().toList();
    // Default fallback if categories happen to be empty
    if (categories.isEmpty) categories.add('All');

    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Catálogo de Gadgets'),
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Theme.of(context).colorScheme.primary,
            tabs: categories.map((category) => Tab(text: category)).toList(),
          ),
          actions: [
            Consumer<CartProvider>(
              builder: (context, cart, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const CartScreen()),
                        );
                      },
                    ),
                    if (cart.itemCount > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '${cart.itemCount}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: TabBarView(
          children: categories.map((category) {
            // Filter products by the current tab's category
            final categoryProducts = _products.where((p) => p.category == category).toList();
            
            return LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = constraints.maxWidth > 800 ? 4 : constraints.maxWidth > 500 ? 3 : 2;
                return GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: categoryProducts.length,
                  itemBuilder: (ctx, i) => ProductCard(product: categoryProducts[i]),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
