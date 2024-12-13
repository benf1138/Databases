let angle = 0; // Rotation angle

function setup() {
  createCanvas(800, 600);
  background(0);

  // Draw stars
  for (let i = 0; i < 200; i++) {
    fill(255);
    noStroke();
    ellipse(random(width), random(height), random(1, 3));
  }
}

function draw() {
  background(0);

  // Redraw stars
  for (let i = 0; i < 200; i++) {
    fill(255);
    noStroke();
    ellipse(random(width), random(height), random(1, 3));
  }

  translate(width / 2, height / 2); // Center the TIE Fighter
  rotate(radians(angle)); // Rotate the TIE Fighter
  drawTIEFighter(); // Draw the TIE Fighter
  angle += 1; // Increment rotation angle
}

function drawTIEFighter() {
  // Solar panels
  fill(50);
  rect(-160, -100, 80, 200); // Left panel
  rect(80, -100, 80, 200);  // Right panel

  // Panel frames
  stroke(100);
  strokeWeight(4);
  line(-160, -100, -80, 0); // Left diagonal top
  line(-160, 100, -80, 0);  // Left diagonal bottom
  line(160, -100, 80, 0);   // Right diagonal top
  line(160, 100, 80, 0);    // Right diagonal bottom

  // Connecting bar from cockpit to wings (extended properly)
  stroke(100);
  strokeWeight(6);
  line(-80, 0, -160, -100); // Left side bar
  line(-80, 0, -160, 100);  // Left side bar
  line(80, 0, 160, -100);   // Right side bar
  line(80, 0, 160, 100);    // Right side bar

  // Central cockpit
  fill(80);
  stroke(150);
  strokeWeight(2);
  ellipse(0, 0, 120, 120); // Main sphere

  // Cockpit details
  fill(60);
  ellipse(0, 0, 80, 80);  // Inner detail
  line(-40, 0, 40, 0);    // Horizontal frame
  line(0, -40, 0, 40);    // Vertical frame
  line(-28, -28, 28, 28); // Diagonal frame 1
  line(-28, 28, 28, -28); // Diagonal frame 2

  // Connecting struts
  fill(60);
  rect(-80, -10, 0, 20); // Left connector (touching)
  rect(80, -10, 0, 20);  // Right connector (touching)
}
