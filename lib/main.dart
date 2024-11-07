import 'package:flutter/material.dart';

void main() {
  runApp(const WeddingInvitationApp());
}

class WeddingInvitationApp extends StatelessWidget {
  const WeddingInvitationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const InvitationScreen(),
    );
  }
}

// Main Invitation Screen with Drag-and-Drop Interaction
class InvitationScreen extends StatelessWidget {
  const InvitationScreen({super.key});

  void _onDragCompleted(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const InvitationDetailsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double imageSize = 120;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            const Text(
              "Celebrate Love",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8B5E3C),
                fontFamily: 'Serif',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Drag the groom to his bride to see the invitation!",
                style: TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PersonImageWidget(
                  imagePath: 'assets/images/man.jpg',
                  label: 'Groom',
                  imageSize: imageSize,
                  isDraggable: true,
                  onDragCompleted: () => _onDragCompleted(context),
                ),
                const SizedBox(width: 20),
                PersonImageWidget(
                  imagePath: 'assets/images/woman.jpg',
                  label: 'Bride',
                  imageSize: imageSize,
                  isDraggable: false,
                  onDragCompleted: () => _onDragCompleted(context),
                ),
              ],
            ),
            const Spacer(flex: 2),
            Text(
              "A beautiful union awaits...",
              style: TextStyle(
                fontSize: 16,
                color: Colors.brown[300],
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Reusable Draggable Image Widget
class PersonImageWidget extends StatelessWidget {
  final String imagePath;
  final String label;
  final double imageSize;
  final bool isDraggable;
  final VoidCallback onDragCompleted;

  const PersonImageWidget({
    super.key,
    required this.imagePath,
    required this.label,
    required this.imageSize,
    required this.isDraggable,
    required this.onDragCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDraggable)
          Draggable<int>(
            data: 1,
            feedback: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  Image.asset(imagePath, width: imageSize),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            childWhenDragging: Opacity(
              opacity: 0.5,
              child: Image.asset(imagePath, width: imageSize),
            ),
            child: Image.asset(imagePath, width: imageSize),
          )
        else
          DragTarget<int>(
            builder: (context, candidateData, rejectedData) {
              return Image.asset(
                imagePath,
                width: imageSize,
                color: candidateData.isNotEmpty ? Colors.brown[200] : null,
              );
            },
            onWillAcceptWithDetails: (details) => true,
            onAcceptWithDetails: (details) => onDragCompleted(),
          ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

// Elegant Invitation Page
class InvitationDetailsPage extends StatelessWidget {
  const InvitationDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "You’re Invited",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8B5E3C),
                  fontFamily: 'Serif',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                "We warmly invite you to celebrate the wedding of",
                style: TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                "Emma & Liam",
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xFF8B5E3C),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Serif',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Text(
                "Saturday, April 6, 2024",
                style: TextStyle(fontSize: 18),
              ),
              const Text(
                "Lovely Wedding Venue, City",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 20),
              const Text(
                "Join us for a beautiful celebration of love, laughter, "
                "and happily ever after.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF8B5E3C),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Back to Main",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
