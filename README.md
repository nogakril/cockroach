# Cockroach 🪳

This project was created as part of a course exploring **AI-driven interactive installations**.  
Using a **live camera feed** that detected the positions of visitors’ feet on the floor (x,y coordinates), we coded a **Processing sketch** that simulated the behavior of cockroaches: scattering, running, and escaping in response to movement.

The result was a reactive visual system where digital cockroaches “lived” in the installation space, creating a playful and slightly unsettling encounter between audience and algorithm.

---

## 🎥 Concept

Cockroaches are creatures that thrive in the periphery, scurrying away when humans appear.  
We translated this behavior into a **generative installation**:

- Visitors walking in the space acted as **disturbances**.  
- Their presence, tracked via x,y coordinates from a camera, pushed cockroaches away.  
- The simulation became a **living surface** where human movement dictated insect behavior.  

The work highlights the uncanny link between organic behavior, human presence, and algorithmic simulation.

---

## 🛠️ Technical Details

- **Language / Framework:** [Processing](https://processing.org/)  
- **Libraries:**  
  - `ddf.minim` for sound (looping cockroach scurry audio)  
  - Custom `Animation` class for sprite-based cockroach visuals  
- **Behavioral Model:**  
  - ~200 animated cockroaches  
  - Movement vectors updated per frame  
  - Avoidance force applied when within radius of visitor’s x,y position  
  - Screen-wrapping for continuous swarm presence  

---

## Pictures

![IMG-20240620-WA0009](https://github.com/user-attachments/assets/2f507e16-efac-4785-a70c-b1ce72b584ed)

