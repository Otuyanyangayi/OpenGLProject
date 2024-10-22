require 'opengl'
require 'glut'


include OpenGL
include GLUT 

puts "Start"

def init 
    glClearColor(0,0,0,0) #make the background colr black
    glEnable(GL_DEPTH_TEST) #Enable 3D depth testing 
end 

def draw_cube
    glBegin(GL_QUADS)  # Start drawing a cube using quads
  
    # Define vertices for each face of the cube
    # Front face
    glColor3f(1.0, 0.0, 0.0)  # Red color
    glVertex3f(-1.0, -1.0, 1.0)
    glVertex3f(1.0, -1.0, 1.0)
    glVertex3f(1.0, 1.0, 1.0)
    glVertex3f(-1.0, 1.0, 1.0)
  
    
  
    glEnd
  end

  puts "Done"