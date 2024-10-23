require 'opengl'
require 'glut'

include OpenGL
include GLUT

$angle = 0.0
$x_move = 0.0
$y_move = 0.0

def init
  glClearColor(0.0, 0.0, 0.0, 0.0)  # Set background color to black
  glEnable(GL_DEPTH_TEST)            # Enable depth testing for 3D
end

def display
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
  glLoadIdentity

  # Apply translation based on keyboard input
  glTranslatef($x_move, $y_move, -5.0)

  # Apply rotation
  glRotatef($angle, 1.0, 1.0, 0.0)

  draw_cube

  glutSwapBuffers
end

def draw_cube
  glBegin(GL_QUADS)

  # Front face
  glColor3f(1.0, 0.0, 0.0)  # Red color
  glVertex3f(-1.0, -1.0, 1.0)
  glVertex3f(1.0, -1.0, 1.0)
  glVertex3f(1.0, 1.0, 1.0)
  glVertex3f(-1.0, 1.0, 1.0)

  glEnd
end

def reshape(width, height)
  glViewport(0, 0, width, height)
  glMatrixMode(GL_PROJECTION)
  glLoadIdentity

  # Use glFrustum to create a perspective projection
  aspect_ratio = width.to_f / height.to_f
  glFrustum(-aspect_ratio, aspect_ratio, -1.0, 1.0, 1.0, 100.0)

  glMatrixMode(GL_MODELVIEW)
end

def keyboard(key, x, y)
  case key
  when 'w'
    $y_move += 0.1
  when 's'
    $y_move -= 0.1
  when 'a'
    $x_move -= 0.1
  when 'd'
    $x_move += 0.1
  when 27  # ESC key
    exit 0
  end
end

def update(value)
  $angle += 1.0
  glutPostRedisplay  # Redraw the scene
  glutTimerFunc(16, :update, 0)  # Call update every ~16ms (60 FPS)
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

# Use `glutTimerFunc` instead of `glutIdleFunc`
glutTimerFunc(16, :update, 0)

# Start the main loop
glutMainLoop
