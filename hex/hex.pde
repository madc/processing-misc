public class Hexagon {
	public PVector center;
	public ArrayList<PVector> p;
	
	public color c;
  
	public Hexagon(PVector _center, ArrayList<PVector> _p) {
		center = _center;
		p = _p;
	}
}

ArrayList<Hexagon> hexagons = new ArrayList<Hexagon>();

// The length of a side / radius of the hexagon
final int sideLength = 20;

void setup() {
	size(800, 600, P2D);

	update();
}

void draw() {
	background(0);

	for(int i = 0; i < hexagons.size(); i++) {
		Hexagon hexagon = hexagons.get(i);
		
		if(isInside(hexagon, new PVector(mouseX, mouseY))) {
			stroke(222);
			fill(222);
		} else {
			stroke(hexagon.c);
			fill(hexagon.c);
		}
		
	    beginShape();
	    for (int j=0; j<hexagon.p.size(); j++) {
			vertex(hexagon.p.get(j).x, hexagon.p.get(j).y);
	    }
	    endShape(CLOSE);
	}
}

/**
 * Fills the ArrayList with hexagons
 */
void update() {
	float hexagonWidth = 2*sideLength;
	float hexagonHeight = 2*((sqrt(3)/2)*sideLength);
		
	int cols = 0;
	int rows;
	
	while((cols-1)*(hexagonWidth+sideLength) < width) {		
		rows = 0;
		while((rows-1)*(hexagonHeight/2) < height) {
			float posLeft = cols*(hexagonWidth+sideLength);
			
			if(rows%2 == 0) {
				posLeft += sideLength*1.5;
			}
			
			Hexagon hexagon = addHexagon(new PVector(posLeft, rows*(hexagonHeight/2)));
			hexagons.add(hexagon);
			
			rows++;
		}

		cols ++;
	}
}

/**
 * Creates a new hexagon-object around a given center.
 */
Hexagon addHexagon(PVector center) {
	ArrayList<PVector> p = new ArrayList<PVector>();
		
	for (int i = 0; i < 6; i++) {
		float angle = PI*i/3;
		p.add(new PVector(center.x+cos(angle)*sideLength, center.y+sin(angle)*sideLength));
    }
	
	Hexagon hexagon = new Hexagon(center, p);
	
	int rand = (int)random(-10, 3);
	hexagon.c = color(35 + rand, 37 + rand, 39 + rand);
	
	return hexagon;
}

/**
 *  Determine, if given coordinates are inside a given hexagon
 *  http://stackoverflow.com/a/5195868/709769
 */
boolean isInside(Hexagon hexagon, PVector p) {
  float dx = abs(p.x - hexagon.center.x)/(sideLength*2);
  float dy = abs(p.y - hexagon.center.y)/(sideLength*2);
  float a = 0.25 * sqrt(3.0);
  return (dy <= a) && (a*dx + 0.25*dy <= 0.5*a);
}

void keyPressed() {
	// Use Spacebar to save frame...
	if (keyCode == 32) {
		saveFrame("hex-######.png");
	} else { // ...use every other key to re-create the pattern
		update();
	}
}