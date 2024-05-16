import java.util.ArrayList;
import java.util.HashSet;

UserManager userManager;
ArrayList<User> users;

void setup() {
  size(800, 800);
  userManager = new UserManager();
  //userManager.initializeUsers("normal", 5); // Initialize 5 normal users
  //userManager.initializeUsers("mouse", 1);  // Initialize 1 mouse-controlled user
}

void draw() {
  userManager.run();
  users = userManager.getUsers();
  for (User user : users) {
    // code here
  }
}
