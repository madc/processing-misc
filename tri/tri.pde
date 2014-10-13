public class Triangle {
	public PVector center;
	public ArrayList<PVector> p;

	public color c;

	public Triangle(PVector _center, ArrayList<PVector> _p) {
		center = _center;
		p = _p;
	}
}

ArrayList<Triangle> triangles = new ArrayList<Triangle>();

// The length of a side of the triangle
final int sideLength = 20;

void setup() {
	size(800, 600, P2D);
	frame.setResizable(true);
	
	update();
}

void draw() {
	background(0, 0, 0);
		
	for(int i = 0; i < triangles.size(); i++) {
		Triangle triangle = triangles.get(i);
		
		if(isInside(triangle, new PVector(mouseX, mouseY))) {
			stroke(222);
			fill(222);
		} else {
			stroke(triangle.c);
			fill(triangle.c);
		}
	
	    beginShape();
	    for (int j=0; j<triangle.p.size(); j++) {
			vertex(triangle.p.get(j).x, triangle.p.get(j).y);
	    }
	    endShape(CLOSE);
	}
}

/**
 * Fills the ArrayList with triangles
 */
void update() {
	float triangleHeight = (sqrt(3)/2)*sideLength;	
	
	int cols = 0;
	int rows;
	
	while((cols-1)*triangleHeight < width) {
		rows = 0;
		while((rows-1)*(sideLength/2) < height) {
			float posX = cols*triangleHeight;
			
			if(rows%2 == 0) {
				posX -= triangleHeight;
			}
			
			Triangle triangle = addTriangle(new PVector(posX, rows*(sideLength/2)), cols%2!=0);
			triangles.add(triangle);

			rows++;
		}

		cols ++;
	}
}

/**
 * Creates a new triangle-opbject around a given center.
 */
Triangle addTriangle(PVector center, boolean mirror) {
	float radius = (sqrt(3)/3)*sideLength;
	
	ArrayList<PVector> p = new ArrayList<PVector>();
		
	for (int i = 0; i < 3; i++) {
		float angle = PI*i/1.5;
		float xdiff = 0;
		
		if(mirror == true) {
			angle -= PI;
			xdiff = radius/2;
		}
		
		p.add(new PVector(center.x+cos(angle)*radius+xdiff, center.y+sin(angle)*radius));
    }
	
	Triangle triangle = new Triangle(center, p);
	
	int rand = (int)random(-10, 3);
	triangle.c = color(35 + rand, 37 + rand, 39 + rand);
	
	return triangle;
}

/**
 *  Determine, if given coordinates are inside a given triangle
 *	http://stackoverflow.com/a/13301035/709769
 */
boolean isInside(Triangle triangle, PVector p) {
	float alpha = ((triangle.p.get(1).y - triangle.p.get(2).y)*(p.x - triangle.p.get(2).x) + (triangle.p.get(2).x - triangle.p.get(1).x)*(p.y - triangle.p.get(2).y)) /
	        ((triangle.p.get(1).y - triangle.p.get(2).y)*(triangle.p.get(0).x - triangle.p.get(2).x) + (triangle.p.get(2).x - triangle.p.get(1).x)*(triangle.p.get(0).y - triangle.p.get(2).y));
	
	float beta = ((triangle.p.get(2).y - triangle.p.get(0).y)*(p.x - triangle.p.get(2).x) + (triangle.p.get(0).x - triangle.p.get(2).x)*(p.y - triangle.p.get(2).y)) /
	       ((triangle.p.get(1).y - triangle.p.get(2).y)*(triangle.p.get(0).x - triangle.p.get(2).x) + (triangle.p.get(2).x - triangle.p.get(1).x)*(triangle.p.get(0).y - triangle.p.get(2).y));
	
	float gamma = 1.0f - alpha - beta;

	return (alpha > 0 && beta > 0 && gamma > 0);
}

void keyPressed() {
	if (keyCode == 32) {
		saveFrame("tri-######.png");
	} else {
		update();
	}
}