require 'opengl'
require 'glut'

include OpenGL
include GLUT

$angle = 0.0  # Angle of rotation

def init
  glClearColor(0.0, 0.0, 0.0, 0.0)  # Set background color to black
  glEnable(GL_DEPTH_TEST)            # Enable depth testing for 3D
end

def display
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)  # Clear the screen and depth buffer
  glLoadIdentity  # Reset transformations

  # Move the object along the Z-axis
  glTranslatef(0.0, 0.0, -5.0)

  # Rotate the cube
  glRotatef($angle, 1.0, 1.0, 0.0)

  draw_cube

  glutSwapBuffers  # Swap the front and back buffers
end

def draw_cube
  glBegin(GL_QUADS)  # Start drawing a cube using quads

  # Front face
  glColor3f(1.0, 0.0, 0.0)  # Red
  glVertex3f(-1.0, -1.0, 1.0)
  glVertex3f(1.0, -1.0, 1.0)
  glVertex3f(1.0, 1.0, 1.0)
  glVertex3f(-1.0, 1.0, 1.0)

  # Back face
  glColor3f(0.0, 1.0, 0.0)  # Green
  glVertex3f(-1.0, -1.0, -1.0)
  glVertex3f(-1.0, 1.0, -1.0)
  glVertex3f(1.0, 1.0, -1.0)
  glVertex3f(1.0, -1.0, -1.0)

  # Left face
  glColor3f(0.0, 0.0, 1.0)  # Blue
  glVertex3f(-1.0, -1.0, -1.0)
  glVertex3f(-1.0, -1.0, 1.0)
  glVertex3f(-1.0, 1.0, 1.0)
  glVertex3f(-1.0, 1.0, -1.0)

  # Right face
  glColor3f(1.0, 1.0, 0.0)  # Yellow
  glVertex3f(1.0, -1.0, -1.0)
  glVertex3f(1.0, 1.0, -1.0)
  glVertex3f(1.0, 1.0, 1.0)
  glVertex3f(1.0, -1.0, 1.0)

  # Top face
  glColor3f(1.0, 0.0, 1.0)  # Magenta
  glVertex3f(-1.0, 1.0, -1.0)
  glVertex3f(-1.0, 1.0, 1.0)
  glVertex3f(1.0, 1.0, 1.0)
  glVertex3f(1.0, 1.0, -1.0)

  # Bottom face
  glColor3f(0.0, 1.0, 1.0)  # Cyan
  glVertex3f(-1.0, -1.0, -1.0)
  glVertex3f(1.0, -1.0, -1.0)
  glVertex3f(1.0, -1.0, 1.0)
  glVertex3f(-1.0, -1.0, 1.0)

  glEnd  # End drawing the cube
end

def reshape(width, height)
  glViewport(0, 0, width, height)  # Set the viewport
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity

  # Set up perspective projection
  aspect_ratio = width.to_f / height.to_f
  glFrustum(-aspect_ratio, aspect_ratio, -1.0, 1.0, 1.0, 100.0)

  glMatrixMode(GL_MODELVIEW)
end

def keyboard(key, x, y)
  case key
  when 27  # ESC key
    exit(0)  # Exit the program
  end
end

def update(value)
  $angle += 0.1  # Increment the rotation angle
  glutPostRedisplay  # Redraw the scene
  glutTimerFunc(16, :update, 0)  # Call update every 16 ms (~60 FPS)
end

# Initialize GLUT and OpenGL
glutInit
glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGB | GLUT_DEPTH)
glutInitWindowSize(500, 500)
glutCreateWindow("3D Moving Cube")

# Register callback functions
init
glutDisplayFunc(:display)
glutReshapeFunc(:reshape)
glutKeyboardFunc(:keyboard)

# Start the update loop
glutTimerFunc(16, :update, 0)

# Start the main loop
glutMainLoop
