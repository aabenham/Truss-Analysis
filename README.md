Truss Input:
We start by defining the total number of joints in the truss structure. Joint connection points where members connect. Next, we define C, a connectivity matrix that defines how members are connected at joints. 

Support Forces Sx and Sy are also defined by matrices. These matrices define the direction and location of external supports applied to the truss. Sx represents horizontal reaction forces, and Sy represents vertical reaction forces. The columns in these matrices allow for the definition of supports in different directions at various joints.

The load vector L specifies where the load is applied to the truss. L’s size is twice the number of nodes, the first half corresponds to horizontal loads and the second half to vertical loads.

Coordinate vectors X and Y define the positions of each node in the truss, member lengths and orientations can be calculated.


Code Overview:
Our program starts by determining the size of the truss connectivity matrix, C, which defines how the members are connected at joints. It then initializes several matrices and variables that store support force values, member lengths, member orientations (stored in Member_Matrix), buckling loads (Pcrit), and potential failure weights. Next, our program calculates the lengths for all members by determining the distance between its two connecting joints. Using these lengths, the critical load (Pcrit) is calculated. The function adds support forces to the Member_Matrix to create matrix A and calculates the tension or compression forces in each truss member (T) using the inverse of A multiplied by the load vector L. Each member force gets categorized as either tension (T), compression (C), or zero force (Z) reaction forces are calculated at the supports. To determine the maximum theoretical load that the truss can support, the program iterates and incrementally increases the applied load to the truss until one of the members under compression reaches its critical buckling load. 

The cost of the truss is calculated based on the number of joints and the total length of all members using the equation cost = 10 * joints + total length of the truss. Upon completion of all calculations, the program prints information about each member, including lengths and critical loads, the forces in each member under the given load, the cost of the truss, the theoretical maximum load/cost ratio, and the maximum theoretical load before buckling. 
