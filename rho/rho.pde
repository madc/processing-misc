public class Rhombus {
	public PVector center;
	public ArrayList<PVector> p;
	
	public color c;
  
	public Rhombus(PVector _center, ArrayList<PVector> _p) {
		center = _center;
		p = _p;
	}
}

ArrayList<Rhombus> rhombus;
final int sideWidth = 10;
float rho_dia = sideWidth*sqrt(2);

int cols;
int rows;

void setup() {
	size(800, 600, P2D);

	update();
}

void draw() {
	background(0);

	for(int i = 0; i < rhombus.size(); i++) {
		Rhombus rho = rhombus.get(i);
		
		stroke(rho.c);
		fill(rho.c);
		
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
	rhombus = new ArrayList<Rhombus>();

	/*Rhombus rho = addRhombus(new PVector(100, 100));
	rhombus.add(rho);*/

	cols = 0;
	while((cols-1.5)*rho_dia < width) {
		rows = 0;
		while((rows-1)*(rho_dia/2) < height) {
			float posLeft = cols*rho_dia;

			if(rows%2 == 0) {
				posLeft -= rho_dia*1.5;
			}

			Rhombus rho = addRhombus(new PVector(posLeft, rows*(rho_dia/2)));
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
	
	float rho_radius = rho_dia/2;
	
	for (int i = 0; i < 4; i++) {
		float angle = PI*i/2;
		p.add(new PVector(center.x+cos(angle)*rho_radius, center.y+sin(angle)*rho_radius));
    }

	Rhombus rhombus = new Rhombus(center, p);
	
	int rand = (int)random(-10, 3);
	rhombus.c = color(35 + rand, 37 + rand, 39 + rand);
	
	return rhombus;
}

void keyPressed() {
	// Use Spacebar to save frame...
	if (keyCode == 32) {
		saveFrame("rho-######.png");
	} else { // ...use every other key to re-create the pattern
		update();
	}
}