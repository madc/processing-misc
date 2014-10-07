public class Hexagon {
	public PVector center;
	public ArrayList<PVector> p;
	
	public color c;
  
	public Hexagon(PVector _center, ArrayList<PVector> _p) {
		center = _center;
		p = _p;
	}
}

ArrayList<Hexagon> hexagons;
final int sideWidth = 10;

int cols;
int rows;

void setup() {
	size(800, 600, P2D);

	update();
}

void draw() {
	background(0);

	for(int i = 0; i < hexagons.size(); i++) {
		Hexagon h = hexagons.get(i);
		
		stroke(h.c);
		fill(h.c);
		
	    beginShape();
	    for (int j=0; j<6; j++) {
			vertex(h.p.get(j).x, h.p.get(j).y);
	    }
	    endShape(CLOSE);
	}
}

/**
 * Fills the ArrayList with hexagons
 */
void update() {
	float hex_width = 2*sideWidth;
	float hex_height = 2*((sqrt(3)/2)*sideWidth);
	
	hexagons = new ArrayList<Hexagon>();
	
	cols = 0;
	while((cols-1)*(hex_width+sideWidth) < width) {		
		rows = 0;
		while((rows-1)*(hex_height/2) < height) {
			float posLeft = cols*(hex_width+sideWidth);
			
			if(rows%2 == 0) {
				posLeft += sideWidth*1.5;
			}
			
			Hexagon hexagon = addHexagon(new PVector(posLeft, rows*(hex_height/2)));
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
		p.add(new PVector(center.x + cos(angle) * (sideWidth), center.y + sin(angle) * (sideWidth)));
    }
	
	Hexagon hexagon = new Hexagon(center, p);
	
	int rand = (int)random(-10, 3);
	hexagon.c = color(35 + rand, 37 + rand, 39 + rand);
	
	return hexagon;
}

void keyPressed() {
	// Use Spacebar to save frame...
	if (keyCode == 32) {
		saveFrame("hex-######.png");
	} else { // ...use every other key to re-create the pattern
		update();
	}
}