# Built in SketchUp RUBY_VERSION = 1.8.0

include Math

def my_create_equilateral_triangle
	model = Sketchup.active_model
	model.start_operation('Equilateral Triangle', true)
	group = model.active_entities.add_group
	entities = group.entities

	p1 = Geom::Point3d.new(0, 0, 0)
	p2 = Geom::Point3d.new(1.m, 0, 0)
	p3 = Geom::Point3d.new(0.5.m, 0.866.m, 0)

	mesh = Geom::PolygonMesh.new
	mesh.add_polygon(p1, p2, p3)

	entities.fill_from_mesh mesh, true, 4
	model.commit_operation
end

def my_create_square
	model = Sketchup.active_model
	model.start_operation('Create Square', true)
	group = model.active_entities.add_group
	entities = group.entities

	p1 = Geom::Point3d.new(0, 0, 0)
	p2 = Geom::Point3d.new(1.m, 0, 0)
	p3 = Geom::Point3d.new(1.m, 1.m, 0)
	p4 = Geom::Point3d.new(0, 1.m, 0)

	mesh = Geom::PolygonMesh.new
	mesh.add_polygon(p1, p2, p4)
	mesh.add_polygon(p2, p4, p3)

	entities.fill_from_mesh mesh, true, 4
	model.commit_operation
end

def my_create_tetrahedron
	model = Sketchup.active_model
	model.start_operation('Create Tetrahedron', true)
	group = model.active_entities.add_group
	entities = group.entities

	p1 = Geom::Point3d.new(0, 0, 0)
	p2 = Geom::Point3d.new(1.m, 0, 0)
	p3 = Geom::Point3d.new(0.5.m, 0.866.m, 0)       # y = sqrt(3)/2
	p4 = Geom::Point3d.new(0.5.m, 0.289.m, 0.817.m) # z = 2/sqrt(6)

	mesh = Geom::PolygonMesh.new
	mesh.add_polygon(p1, p2, p3)
	mesh.add_polygon(p1, p2, p4)
	mesh.add_polygon(p2, p3, p4)
	mesh.add_polygon(p1, p3, p4)

	entities.fill_from_mesh mesh, true, 4
	model.commit_operation
end

def my_create_octahedron
  model = Sketchup.active_model
	model.start_operation('Create Octahedron', true)
	group = model.active_entities.add_group
	entities = group.entities

	p1 = Geom::Point3d.new(0, 0, 0)
	p2 = Geom::Point3d.new(1.m, 0, 0)
	p3 = Geom::Point3d.new(1.m, 1.m, 0)
	p4 = Geom::Point3d.new(0, 1.m, 0)
	p5 = Geom::Point3d.new(0.5.m, 0.5.m, 0.7071.m)	# z = 1/sqrt(2)
	p6 = Geom::Point3d.new(0.5.m, 0.5.m, -0.7071.m)

	mesh = Geom::PolygonMesh.new
	
	mesh.add_polygon(p1, p2, p5)
	mesh.add_polygon(p2, p3, p5)
	mesh.add_polygon(p3, p4, p5)
	mesh.add_polygon(p4, p1, p5)	
	
	mesh.add_polygon(p1, p2, p6)
	mesh.add_polygon(p2, p3, p6)
	mesh.add_polygon(p3, p4, p6)
	mesh.add_polygon(p4, p1, p6)
	
#	face = entities.add_face([p1, p2, p3, p4])	
	entities.fill_from_mesh mesh, true, 4
	model.commit_operation
end

def my_create_cube
	model = Sketchup.active_model
	model.start_operation('Create Cube', true)
	group = model.active_entities.add_group
	entities = group.entities
	p1 = Geom::Point3d.new(0, 0, 0)
	p2 = Geom::Point3d.new(1.m, 0, 0)
	p3 = Geom::Point3d.new(1.m, 1.m, 0)
	p4 = Geom::Point3d.new(0, 1.m, 0)
	face = entities.add_face([p1, p2, p3, p4])
	face.pushpull(-1.m)
	model.commit_operation
end

def my_create_icosahedron
  	model = Sketchup.active_model
	model.start_operation('Create Icosahedron', true)
	group = model.active_entities.add_group
	entities = group.entities
	
	p = []
	r = 1/sin(PI/5)/2      # Radius of the circle circumscribed around the pentagon / Радиус описанной вокруг образующего пятиугольника окружности
	h = sqrt(1 - r*r)      # Высота вершины над плоскостью образующего пятиугольника
	h2 = 2*sin(3*PI/10)    # Длина длинной хорды (соединяющей вершины образующего пятиугольника через одну)
	h3 = sqrt(h2*h2 - r*r) # Высота вершины над плоскостью пятиугольника, паралельного образующему (т.е. следующего под ним)
	h4 = (h3 - h)/2        # Половина расстояния между двумя образующими пятиугольниками, лежащими в паралельных плоскостях
	hh = (h3 + h)/2        # Расстояние от центра до вершины : h3 - h5 = h3 - (h3 - h)/2 = h3 - h3/2 + h/2 = (h3 + h)/2
	
 	p0 = Geom::Point3d.new(0, 0, hh.m)
	p1 = Geom::Point3d.new(0, 0, -hh.m)	
	for i in 0...5
		p[i]   = Geom::Point3d.new(r * sin(2 * PI * i / 5).m, r * cos(2 * PI * i / 5).m, h4.m)
		p[i+5] = Geom::Point3d.new(r * sin(PI*(2*i + 1)/5).m, r * cos(PI*(2*i + 1)/5).m, -h4.m)
	end
  	mesh = Geom::PolygonMesh.new
  	for i in 0...5
    		mesh.add_polygon(p[i], p[(i+1)%5], p0)
    		mesh.add_polygon(p[((i+1)%5)+5], p[i+5], p1)		# Reverse traversal order / обратный порядок обхода (вершины 1 и 2 поменял местами)
    		mesh.add_polygon(p[(i+1)%5], p[i], p[i+5])		# Reverse traversal order / обратный порядок обхода (вершины 1 и 2 поменял местами)
    		mesh.add_polygon(p[i+5], p[((i+1)%5)+5], p[(i+1)%5])    
	end
  	entities.fill_from_mesh mesh, true, 4
  	model.commit_operation
end

def my_create_tricylinder
  	model = Sketchup.active_model
	model.start_operation('Triangulated Cylinder', true)
	group = model.active_entities.add_group
	entities = group.entities
	n  = 16
	p  = []
	r  = 1/sin(PI/n)/2
	xm = r * sin(PI/n)
	ym = r * (1 - cos(PI/n))
	zm = sqrt(1 - xm*xm - ym*ym) 
	h  = zm/2
	for i in 0...n
		p[i]   = Geom::Point3d.new(r * sin(2 * PI * i / n).m, r * cos(2 * PI * i / n).m, h.m)
		p[i+n] = Geom::Point3d.new(r * sin(PI*(2*i + 1)/n).m, r * cos(PI*(2*i + 1)/n).m, -h.m)
	end
	mesh = Geom::PolygonMesh.new
	for i in 0...n
		mesh.add_polygon(p[(i+1)%n], p[i], p[i+n])		# Reverse traversal order / обратный порядок обхода (вершины 1 и 2 поменял местами)
    	  	mesh.add_polygon(p[i+n], p[((i+1)%n)+n], p[(i+1)%n])
#		face = entities.add_face([p[(i+1)%n], p[i], p[i+n]])
#		face = entities.add_face([p[i+n], p[((i+1)%n)+n], p[(i+1)%n]])
	end
	entities.fill_from_mesh mesh, true, 4
	model.commit_operation
end

def my_create_dodecahedron
	puts "Create Dodecahedron\n"
  	model = Sketchup.active_model
	model.start_operation('Create Dodecahedron', true)
	group = model.active_entities.add_group
	entities = group.entities
	p  = []
	b  = []
	r  = 1/sin(PI/5)/2	# Radius of the circle circumscribed around the pentagon / Радиус описанной вокруг образующего пятиугольника окружности
#	h  = sqrt(3*r*r-1)/2
#	h  = r*sin(3*PI/10)
	h  = r*cos(PI/5)	# Радиус вписаной в пятиугольник окружности (высота), 
				# она же - расстояние от грани до ближайшей параллельной ей плоскости, вмещающей 5 вершин
				# Другие интересные зависимости:
				# Соотношение между радиусами вписанной и описанной вокруг правильного пятиугольника окружностей: 
				#   2*h == r + sqrt(B*B - r*r), где B = длина грани, или для произвольной длины грани:
				#   2*h == r + sqrt(3*r*r - 4*h*h)
				
	h2 = sqrt(r*(r+2*h))	# Расстояние от грани до следующей (т.е. через одну) параллельной ей плоскости, вмещающей 5 вершин
	z  = (h2 + r)/2
	z2 = (h2 - r)/2
	for i in 0...5      
		p[i]   = Geom::Point3d.new(r * sin(2 * PI * i / 5).m, r * cos(2 * PI * i / 5).m,  z.m)     # Ceiling edge / Верхняя грань
		p[i+5] = Geom::Point3d.new(r * sin(PI*(2*i + 1)/5).m, r * cos(PI*(2*i + 1)/5).m, -z.m)     # Floor edge / Нижняя
		b[i]   = Geom::Point3d.new(2*h*sin(2 * PI * i / 5).m, 2*h*cos(2 * PI * i / 5).m, z2.m)     # Top girth / Вехний пояс	
		b[i+5] = Geom::Point3d.new(2*h*sin(PI*(2*i + 1)/5).m, 2*h*cos(PI*(2*i + 1)/5).m,-z2.m)     # Bottom girth / Нижний
	end
	face = entities.add_face(p[0], p[1], p[2], p[3], p[4])
	face = entities.add_face(p[5], p[6], p[7], p[8], p[9])
	for i in 0...5
		face = entities.add_face(p[i],   b[i],   b[i+5],     b[(i+1)%5],   p[(i+1)%5])
#		face = entities.add_face(p[i],   b[i],   b[i+5])
#		face = entities.add_face(p[i],   p[(i+1)%5], b[i+5])
#		face = entities.add_face(p[(i+1)%5], b[(i+1)%5], b[i+5])

		face = entities.add_face(p[i+5], b[i+5], b[(i+1)%5], b[(i+1)%5+5], p[(i+1)%5+5])
	end
	model.commit_operation
end

def my_create_dodecahedron_tri
	puts "Create Dodecahedron Triangled\n"
  	model = Sketchup.active_model
	model.start_operation('Create Dodecahedron', true)
	group = model.active_entities.add_group
	entities = group.entities
	p  = []
	b  = []
	r  = 1/sin(PI/5)/2
	h  = r*cos(PI/5) 
	h2 = sqrt(r*(r+2*h))
	z  = (h2 + r)/2
	z2 = (h2 - r)/2
	for i in 0...5      
		p[i]   = Geom::Point3d.new(r * sin(2 * PI * i / 5).m, r * cos(2 * PI * i / 5).m,  z.m)     # Ceiling edge / Верхняя грань
		p[i+5] = Geom::Point3d.new(r * sin(PI*(2*i + 1)/5).m, r * cos(PI*(2*i + 1)/5).m, -z.m)     # Floor edge / Нижняя         
		b[i]   = Geom::Point3d.new(2*h*sin(2 * PI * i / 5).m, 2*h*cos(2 * PI * i / 5).m, z2.m)     # Top girth / Вехний пояс	 
		b[i+5] = Geom::Point3d.new(2*h*sin(PI*(2*i + 1)/5).m, 2*h*cos(PI*(2*i + 1)/5).m,-z2.m)     # Bottom girth / Нижний       
	end
#	face = entities.add_face(p[0], p[1], p[2], p[3], p[4])
	face = entities.add_face(p[0], p[1], p[2])
	face = entities.add_face(p[2], p[3], p[0])
	face = entities.add_face(p[0], p[3], p[4])
#	face = entities.add_face(p[5], p[6], p[7], p[8], p[9])
	face = entities.add_face(p[5], p[6], p[7])
	face = entities.add_face(p[7], p[8], p[5])
	face = entities.add_face(p[5], p[8], p[9])
	for i in 0...5
#		face = entities.add_face(p[i],   b[i],   b[i+5],     b[(i+1)%5],   p[(i+1)%5])	
		face = entities.add_face(p[i],   b[i],   b[i+5])
		face = entities.add_face(p[i],   p[(i+1)%5], b[i+5])
		face = entities.add_face(p[(i+1)%5], b[(i+1)%5], b[i+5])
#		face = entities.add_face(p[i+5], b[i+5], b[(i+1)%5], b[(i+1)%5+5], p[(i+1)%5+5])
		face = entities.add_face(p[i+5], b[i+5], b[(i+1)%5])
		face = entities.add_face(p[i+5], p[(i+1)%5+5], b[(i+1)%5])
		face = entities.add_face(p[(i+1)%5+5], b[(i+1)%5], b[(i+1)%5+5])
	end
	model.commit_operation
end

def my_create_dodecahedron_mesh
	puts "Create Dodecahedron Triangled\n"
  	model = Sketchup.active_model
	model.start_operation('Create Dodecahedron', true)
	group = model.active_entities.add_group
	entities = group.entities
	p  = []
	b  = []
	r  = 1/sin(PI/5)/2
	h  = r*cos(PI/5) 
	h2 = sqrt(r*(r+2*h))
	z  = (h2 + r)/2
	z2 = (h2 - r)/2
	for i in 0...5      
		p[i]   = Geom::Point3d.new(r * sin(2 * PI * i / 5).m, r * cos(2 * PI * i / 5).m,  z.m)     # Ceiling edge / Верхняя грань
		p[i+5] = Geom::Point3d.new(r * sin(PI*(2*i + 1)/5).m, r * cos(PI*(2*i + 1)/5).m, -z.m)     # Floor edge / Нижняя         
		b[i]   = Geom::Point3d.new(2*h*sin(2 * PI * i / 5).m, 2*h*cos(2 * PI * i / 5).m, z2.m)     # Top girth / Вехний пояс	 
		b[i+5] = Geom::Point3d.new(2*h*sin(PI*(2*i + 1)/5).m, 2*h*cos(PI*(2*i + 1)/5).m,-z2.m)     # Bottom girth / Нижний       
	end
	mesh = Geom::PolygonMesh.new	
#	face = entities.add_face(p[0], p[1], p[2], p[3], p[4])
	mesh.add_polygon(p[0], p[1], p[2])
	mesh.add_polygon(p[2], p[3], p[0])
	mesh.add_polygon(p[0], p[3], p[4])
#	face = entities.add_face(p[5], p[6], p[7], p[8], p[9])
	mesh.add_polygon(p[5], p[7], p[6])
	mesh.add_polygon(p[7], p[5], p[8])
	mesh.add_polygon(p[5], p[9], p[8])
	for i in 0...5
#		face = entities.add_face(p[i],   b[i],   b[i+5],     b[(i+1)%5],   p[(i+1)%5])	
		mesh.add_polygon(p[i],   b[i],   b[i+5])
		mesh.add_polygon(p[i],   b[i+5], p[(i+1)%5])
		mesh.add_polygon(p[(i+1)%5], b[i+5], b[(i+1)%5])
#		face = entities.add_face(p[i+5], b[i+5], b[(i+1)%5], b[(i+1)%5+5], p[(i+1)%5+5])
		mesh.add_polygon(p[i+5], b[(i+1)%5], b[i+5])
		mesh.add_polygon(p[i+5], p[(i+1)%5+5], b[(i+1)%5])
		mesh.add_polygon(p[(i+1)%5+5], b[(i+1)%5+5], b[(i+1)%5])
	end
	entities.fill_from_mesh mesh, true, 4
	model.commit_operation	
end

# if( not file_loaded?( "My_Plugin.rb" )
#	add_separator_to_menu("Plugins")
	plugins_menu = UI.menu("Plugins").add_submenu( "Proper Primitives" )
	plugins_menu.add_item( "Equilateral Triangle" )   { my_create_equilateral_triangle }
	plugins_menu.add_item( "Triangled Square" )       { my_create_square }
	plugins_menu.add_item( "Tetrahedron" )            { my_create_tetrahedron }
	plugins_menu.add_item( "Octahedron" )             { my_create_octahedron }
	plugins_menu.add_item( "Cube" )                   { my_create_cube }
	plugins_menu.add_item( "Icosahedron" )            { my_create_icosahedron }
	plugins_menu.add_item( "Dodecahedron" )           { my_create_dodecahedron }
	plugins_menu.add_item( "Dodecahedron triangled" ) { my_create_dodecahedron_tri }
	plugins_menu.add_item( "Dodecahedron meshed" )    { my_create_dodecahedron_mesh }	
	plugins_menu.add_item( "Triangulated Cylinder" )  { my_create_tricylinder }
	
# UI.menu("Plugins").add_item("Create Cube") { my_create_cube }
#	add_separator_to_menu("Plugins")
# end

