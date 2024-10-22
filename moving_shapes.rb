require 'opengl'
require 'glut'


include OpenGL
include GLUT 

def init 
    glClearColor(0,0,0,0) #make the background colr black
    glEnable(GL_DEPTH_TEST) #Enable 3D depth testing 
end 

