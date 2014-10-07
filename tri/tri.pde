public class Triangle {
	public PVector p1;
	public PVector p2;
	public PVector p3;
	
	public color c;
  
	public Triangle(PVector _p1, PVector _p2, PVector _p3) {
		p1 = _p1;
		p2 = _p2;
		p3 = _p3;
	}
}

ArrayList<Triangle> triangles;
final int sideWidth = 20;

int cols;
int rows;


void setup() {
	size(800, 600, P2D);
	frame.setResizable(true);
	
	update();
}


void draw() {
	background(0, 0, 0);
	    
	for(int i = 0; i < triangles.size(); i++) {
		Triangle t = triangles.get(i);
		
		//if(isInside(t, new PVector(mouseX, mouseY))) {
		//	stroke(color(200));
		//	fill(color(200));
		//} else {
			stroke(t.c);
			fill(t.c);
		//}
		
		triangle(t.p1.x, t.p1.y, t.p2.x, t.p2.y, t.p3.x, t.p3.y);
	}
}

/**
 * Fills the ArrayList with triangles
 */
void update() {
	float triangleWidth = sqrt(sq(sideWidth) - sq(sideWidth / 2.0));
	triangles = new ArrayList<Triangle>();
	
	cols = 0;
	while(cols*triangleWidth < width+200) {
		float multi = sideWidth/2;
		
		if(cols%2 == 0) {
			multi = sideWidth;
		}
		
		PVector p1 = new PVector(cols*triangleWidth, 0-multi);
		PVector p2 = new PVector(cols*triangleWidth, sideWidth-multi);
		Triangle triangle = addTriangle(p1, p2);
		triangles.add(triangle);

		Triangle lastTriangle = triangles.get(triangles.size()-1);
		triangle = addTriangle(lastTriangle.p3, lastTriangle.p2);
		triangles.add(triangle);

		rows = 0;
		while(rows*sideWidth < height) {	
			lastTriangle = triangles.get(triangles.size()-1);
			triangle = addTriangle(lastTriangle.p3, lastTriangle.p2);
			triangles.add(triangle);
	
			lastTriangle = triangles.get(triangles.size()-1);
			triangle = addTriangle(lastTriangle.p1, lastTriangle.p3);
			triangles.add(triangle);
			
			rows++;
		}
		
		cols ++;
	}
}

/**
 * Creates a new triangle-opbject around two given points.
 */
Triangle addTriangle(PVector p1, PVector p2) {
	float x3 = p1.x + (cos(atan2(p2.y-p1.y,p2.x-p1.x)-PI/3) * dist(p1.x,p1.y,p2.x,p2.y));
	float y3 = p1.y + (sin(atan2(p2.y-p1.y,p2.x-p1.x)-PI/3) * dist(p1.x,p1.y,p2.x,p2.y));
	
	PVector p3 = new PVector(x3, y3);
	
	Triangle triangle = new Triangle(p1, p2, p3);
	
	int rand = (int)random(-10, 3);
	triangle.c = color(35 + rand, 37 + rand, 39 + rand);

	return triangle;
}

/**
 *  Determine, if given coordinates are inside a given triangle
 *	http://stackoverflow.com/a/13301035/709769
 */
boolean isInside(Triangle t, PVector p) {	
	float alpha = ((t.p2.y - t.p3.y)*(p.x - t.p3.x) + (t.p3.x - t.p2.x)*(p.y - t.p3.y)) /
	        ((t.p2.y - t.p3.y)*(t.p1.x - t.p3.x) + (t.p3.x - t.p2.x)*(t.p1.y - t.p3.y));
	float beta = ((t.p3.y - t.p1.y)*(p.x - t.p3.x) + (t.p1.x - t.p3.x)*(p.y - t.p3.y)) /
	       ((t.p2.y - t.p3.y)*(t.p1.x - t.p3.x) + (t.p3.x - t.p2.x)*(t.p1.y - t.p3.y));
	float gamma = 1.0f - alpha - beta;
	
	if(alpha > 0 && beta > 0 && gamma > 0) {
		return true;
	}
	
	return false;
}


void keyPressed() {
	if (keyCode == 32) {
		saveFrame("tri-######.png");
	} else {
		update();
	}
}