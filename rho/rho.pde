public class Rhombus {
	public PVector center;
	public ArrayList<PVector> p;
	
	public color c;
  
	public Rhombus(PVector _center, ArrayList<PVector> _p) {
		center = _center;
		p = _p;
	}
}

ArrayList<Rhombus> rhombus = new ArrayList<Rhombus>();

final int sideLength = 10;

void setup() {
	size(800, 600, P2D);

	update();
}

void draw() {
	background(0);

	for(int i = 0; i < rhombus.size(); i++) {
		Rhombus rho = rhombus.get(i);
		
		if(isInside(rho, new PVector(mouseX, mouseY))) {
			stroke(222);
			fill(222);
		} else {
			stroke(rho.c);
			fill(rho.c);
		}
		
	    beginShape();
	    for (int j=0; j<rho.p.size(); j++) {
			vertex(rho.p.get(j).x, rho.p.get(j).y);
	    }
	    endShape(CLOSE);
	}
}

/**
 * Fills the ArrayList with rhombus
 */
void update() {
	float diameter = sideLength*sqrt(2);
	
	int cols = 0;
	int rows;

	while((cols-1.5)*diameter < width) {
		rows = 0;
		while((rows-1)*(diameter/2) < height) {
			float posLeft = cols*diameter;

			if(rows%2 == 0) {
				posLeft -= diameter*1.5;
			}

			Rhombus rho = addRhombus(new PVector(posLeft, rows*(diameter/2)));
			rhombus.add(rho);

			rows++;
		}

		cols ++;
	}
}

/**
 * Creates a new rhombus-object around a given center.
 */
Rhombus addRhombus(PVector center) {
	ArrayList<PVector> p = new ArrayList<PVector>();
	
	float radius = sideLength*sqrt(2)/2;
	
	for (int i = 0; i < 4; i++) {
		float angle = PI*i/2;
		p.add(new PVector(center.x+cos(angle)*radius, center.y+sin(angle)*radius));
    }

	Rhombus rhombus = new Rhombus(center, p);
	
	int rand = (int)random(-10, 3);
	rhombus.c = color(35 + rand, 37 + rand, 39 + rand);
	
	return rhombus;
}

/**
 *  Determine, if given coordinates are inside a given rhombus
 *	tba.
 */
boolean isInside(Rhombus rhombus, PVector p) {	
	
	return false;
}

void keyPressed() {
	// Use Spacebar to save frame...
	if (keyCode == 32) {
		saveFrame("rho-######.png");
	} else { // ...use every other key to re-create the pattern
		update();
	}
}