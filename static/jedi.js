let saberAngle = 0; // Initial angle of the lightsaber
let swingDirection = 1; // Controls swing direction
let swinging = false; // Indicates if the lightsaber is swinging

function setup() {
  createCanvas(400, 400);
}

function draw() {
  background(0);
  drawDarthMaul();
}

function drawDarthMaul() {
  push();
  translate(width / 2, height / 2 + 70); // Move character to center

  // Draw body (cloak)
  fill(20, 20, 20); // Black for cloak
  beginShape();
  vertex(-30, 20); // Left shoulder
  vertex(30, 20); // Right shoulder
  vertex(50, 150); // Right edge of cloak
  vertex(-50, 150); // Left edge of cloak
  endShape(CLOSE);

  // Draw inner robe
  fill(50); // Dark gray for robe
  rect(-15, 20, 30, 100, 10); // Inner robe rectangle

  // Draw belt
  fill(80);
  rect(-20, 60, 40, 10); // Simple belt

  // Draw neck (black for Darth Maul's skin)
  fill(20, 20, 20); // Black
  rect(-7, 10, 14, 10); // Neck rectangle

  // Draw head (Darth Maul style)
  fill(200, 0, 0); // Red for main skin color
  ellipse(0, 0, 40, 50); // Head base

  // Add black tattoos on the face
  fill(0); 
  triangle(-20, -25, -5, -15, -10, 5); // Left pattern
  triangle(20, -25, 5, -15, 10, 5);   // Right pattern
  rect(-10, -20, 20, 10);             // Center stripe

  // Draw horns
  fill(240);
  ellipse(-15, -25, 5, 5); // Left horn
  ellipse(15, -25, 5, 5);  // Right horn
  ellipse(0, -30, 5, 5);   // Top horn

  // Draw Sith eyes
  fill(255, 204, 0); // Yellow for Sith eyes
  ellipse(-10, -5, 8, 8); // Left eye
  ellipse(10, -5, 8, 8); // Right eye
  fill(0);
  ellipse(-10, -5, 4, 4); // Left pupil
  ellipse(10, -5, 4, 4); // Right pupil

  // Draw mouth
  fill(0);
  arc(0, 10, 20, 10, 0, PI, CHORD); // Sinister smile

  // Draw boots
  fill(40); // Dark gray for boots
  rect(-20, 110, 15, 15); // Left boot
  rect(5, 110, 15, 15); // Right boot

  // Draw arm with double lightsaber (aligned with the other arm)
  push();
  translate(-20, 40); // Arm position adjusted to match height of the other arm
  rotate(saberAngle); // Rotate the saber with the angle
  stroke(120); // Handle
  strokeWeight(5);
  line(-40, 0, 40, 0); // Double-ended handle
  stroke(255, 0, 0); // Red lightsaber blade
  strokeWeight(8);
  line(-40, 0, -100, 0); // Left blade
  line(40, 0, 100, 0); // Right blade
  pop();

  // Draw other arm
  fill(20, 20, 20); // Cloak color
  ellipse(20, 40, 15, 40); // Left arm

  pop();

  // Animate saber swing
  if (swinging) {
    saberAngle += swingDirection * 0.05;
    if (saberAngle > PI / 4 || saberAngle < -PI / 4) {
      swingDirection *= -1; // Change swing direction
    }
  }
}

// Swing lightsaber on key press
function keyPressed() {
  swinging = !swinging; // Toggle swinging
}