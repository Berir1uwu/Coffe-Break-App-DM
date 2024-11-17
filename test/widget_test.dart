import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:camera/camera.dart';
import 'package:coffebreakapp/main.dart';
import 'package:coffebreakapp/AddRecipesScreen.dart';
import 'package:coffebreakapp/RecipesScreen.dart';

class MockCameraDescription extends CameraDescription {
  const MockCameraDescription()
      : super(
          name: 'MockCamera',
          lensDirection: CameraLensDirection.back,
          sensorOrientation: 0,
        );
}

void main() {
  testWidgets('Prueba de navegación y cámara en Mis recetas', (WidgetTester tester) async {
    // Crea un mock de la cámara

    // Construye la app y pasa el mock de la cámara
    await tester.pumpWidget(const MaterialApp(
      home: CoffeeBreakApp(),
    ));

    // Encuentra el botón de 'Mis recetas'
    final buttonFinder = find.text('Mis recetas');

    // Verifica que el botón esté presente
    expect(buttonFinder, findsOneWidget);

    // Toca el botón para navegar a AddRecipeScreen
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    // Verifica que se muestra AddRecipeScreen
    expect(find.byType(AddRecipeScreen), findsOneWidget);

    // Verifica que la cámara fue pasada correctamente
    final addRecipeScreen = tester.widget<AddRecipeScreen>(find.byType(AddRecipeScreen));
    expect(addRecipeScreen.camera, isA<CameraDescription>());
  });

  testWidgets('Prueba de navegación a RecipesScreen', (WidgetTester tester) async {
    // Construye la app
    await tester.pumpWidget(const MaterialApp(
      home: CoffeeBreakApp(),
    ));

    // Encuentra el botón de 'Mi Barista'
    final buttonFinder = find.text('Mi Barista');

    // Verifica que el botón esté presente
    expect(buttonFinder, findsOneWidget);

    // Toca el botón para navegar a RecipesScreen
    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    // Verifica que se muestra RecipesScreen
    expect(find.byType(RecipesScreen), findsOneWidget);
  });
}
