from trajectory2D import trajectory2D
from envMap import envMap
import numpy as np
from numpy import pi


#Init the Path Object with the desired trajectory config/parameters
path = trajectory2D(trajectoryName = "trajectory_eightshape_v1")

#Build the Path segments
path.eightShape(delta = pi/8)




