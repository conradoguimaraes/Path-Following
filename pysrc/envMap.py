import matplotlib as mpl
import matplotlib.pyplot as plt
import numpy as np

class envMap():
    def __init__(self) -> None:
        pass
    #end-def
    
    
    def draw
    
    
    
    def showTestPlot(self):
        X = np.linspace(0, 2*np.pi, 100)
        Y = np.cos(X)
        
        fig, ax = plt.subplots()
        ax.plot(X,Y, color='blue')
        
        plt.savefig("test_figure.pdf")
        plt.show()
    #end-def
    
#end-class

if __name__ == "__main__":
    pass
#end-if-else