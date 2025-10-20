# GestureDetector Widget Demo

A Flutter demo showcasing the **GestureDetector** widget through an interactive draggable and scalable color box.

## Screenshot

<img width="395" height="807" alt="image" src="https://github.com/user-attachments/assets/2dc0920d-34e3-49dd-b5ab-387484aa2bae" />

*Interactive box that responds to tap, double-tap, long press, drag, and pinch gestures*

## Widget Description

The **GestureDetector** widget wraps any child widget and detects various touch gestures like taps, drags, and pinch-to-zoom, enabling interactive user experiences without Material Design button constraints.

## Real-World Use Case

This demo simulates a **draggable box** where users can:
- Move/Drag the box to different parts of the screen
- Zoom in/out by double tapping
- Tap to change color
- Reset to original state via long press

Similar functionality is found in apps like Instagram when double tapping to like a post, Shazam when moving the widget around, or even in the Google photos when you long press to select a photo.

## Three Key Properties Demonstrated

### 1. **onTap** (VoidCallback)
- **What it does:** Detects a single quick tap on the widget
- **Demo behavior:** Changes the box color randomly
- **Code example:**
```dart
GestureDetector(
  onTap: () {
    setState(() {
      color = generateRandomColor();
    });
  },
)
```

### 2. **onScaleUpdate** (GestureScaleUpdateCallback)
- **What it does:** Handles both dragging AND pinch-to-zoom simultaneously using focal point and scale factor
- **Demo behavior:** Drag to move, pinch with two fingers to resize
- **Code example:**
```dart
GestureDetector(
  onScaleUpdate: (details) {
    setState(() {
      // details.scale handles zoom (1.0 = no change)
      scale = initialScale * details.scale;
      // details.focalPoint handles position
      position = initialPosition + details.focalPoint;
    });
  },
)
```

### 3. **onLongPress** (VoidCallback)
- **What it does:** Triggers when user presses and holds for ~500ms
- **Demo behavior:** Resets box to center position and original size
- **Code example:**
```dart
GestureDetector(
  onLongPress: () {
    setState(() {
      position = Offset(screenWidth/2, screenHeight/2);
      scale = 1.0;
    });
  },
)
```

## How to Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/gesture_detector_demo.git
   cd gesture_detector_demo
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                          # Entry point
├── models/
│   ├── box_state.dart                # Box state model
│   └── gesture_state_tracker.dart    # Gesture tracking
├── services/
│   └── gesture_service.dart          # Business logic
├── widgets/
│   ├── gesture_info_card.dart        # Info display
│   └── interactive_box.dart          # Main interactive widget
└── pages/
    └── gesture_demo_page.dart        # Main page
```

## Features Implemented

 **Tap** - Random color change  
 **Double Tap** - Toggle zoom (1.0x ↔ 1.6x)  
 **Long Press** - Reset to center  
 **Drag** - Move box around screen  
 **Pinch/Zoom** - Scale between 0.5x and 3.0x  
 **Boundary Checking** - Box stays within screen bounds  
 **Smooth Animations** - 180ms transition effects  

## Technologies Used

- **Flutter SDK:** 3.0+
- **Dart:** 3.0+
- **State Management:** setState
- **Architecture:** Service-oriented with separation of concerns


## Author

**Noel Odero**  
 
Presentation Date: 2nd October 2025


