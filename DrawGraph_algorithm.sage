def DrawGraph_algorithm(encoding,delta):
     #saved under the name 'DrawGraph_algorithm'
     r"""
     returns a matrix with coordinates of the internal nodes
     
     INPUT: 
     
     - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
     
     - ''delta'' - a positive scalar
     
     OUTPUT:
     
     - an n x 2 matrix containing coordinates in the form [x_1,y_1;...;x_n,y_n],
         because of randomization, the coordinates can change with each use of the function 
     
     EXAMPLES:
         sage: DrawGraph_algorithm(vector([2,1,1,0,1]),1)
         [ 0.818181818181818 -0.272727272727273]
         sage: DrawGraph_algorithm(vector([2,2,1,0,1,0,1]),1)
         [ 3.00000000000000  3.00000000000000]
         [0.307692307692308 0.230769230769231]
                  
     """

     #we're first generating all possible inclines, stored in set_of_inclines
     positive_inclines=matrix([[0,1],[1,0],[1,1],[1,2],[1,3],[1,4],\
     [2,1],[2,3],[3,1],[3,2],[3,4],[4,1],[4,3]])
     nofinclines=(positive_inclines.nrows()-1)*2
     half_nofi=nofinclines/2
     set_of_inclines=zero_matrix(nofinclines,2)
     for i in range(nofinclines):
         if i<=half_nofi:
             set_of_inclines[i,:]=positive_inclines[i,:]
         if i>half_nofi:
             set_of_inclines[i,0]=positive_inclines[i-half_nofi+1,0]
             set_of_inclines[i,1]=-positive_inclines[i-half_nofi+1,1]

     #from here on we will be computing the solution x
     #for a random set of inclines
     n=encoding[1]
     inclines=zero_matrix(2*n,2)
     x=0
     while x==0:
         for i in range(2*n):
             k=ZZ.random_element(0,nofinclines)
             inclines[i,:]=set_of_inclines[k,:]
             if i%2 == 1:
                 if inclines[i,:]==inclines[i-1,:]:
                     if k==nofinclines-1:
                         inclines[i,:]=set_of_inclines[0,:]
                     if k<nofinclines-1:
                         inclines[i,:]=set_of_inclines[k+1,:]
         x=inclines_to_coordinates(encoding,inclines,delta)

                    
     #changing the look of the output
     coordinates=zero_matrix(RR,n,2)
     for i in range(n):
         coordinates[i,0]=x[2*i]
         coordinates[i,1]=x[2*i+1]
        
     return coordinates