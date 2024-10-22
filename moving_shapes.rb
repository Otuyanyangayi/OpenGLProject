require 'opengl'
require 'glut'

include OpenGL
include GLUT

def init
  glClearColor(0.0, 0.0, 0.0, 0.0)  # Set background color to black
  glEnable(GL_DEPTH_TEST)            # Enable depth testing for 3D
end

def display
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)  # Clear screen and depth buffer
  glLoadIdentity  # Reset transformations

  # Move the object along the Z-axis to make it visible
  glTranslatef(0.0, 0.0, -5.0)

  # Call function to draw a cube
  draw_cube

  glutSwapBuffers
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

  # Other faces (e.g. Back, Left, Right, etc.) go here...

  glEnd
end

def reshape(width, height)
  glViewport(0, 0, width, height)
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity

  # Manually set up the perspective using glFrustum
  aspect_ratio = width.to_f / height.to_f
  glFrustum(-aspect_ratio, aspect_ratio, -1.0, 1.0, 1.0, 100.0)

  glMatrixMode(GL_MODELVIEW)
end

def keyboard(key, x, y)
  case key
  when 27 # ESC key
    exit 0
  end
end

# Initialize GLUT and OpenGL
glutInit
glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH)
glutInitWindowSize(500, 500)
glutCreateWindow("3D Moving Shapes")

# Register callback functions
init
glutDisplayFunc(:display)
glutReshapeFunc(:reshape)
glutKeyboardFunc(:keyboard)

# Start the main loop
glutMainLoop
