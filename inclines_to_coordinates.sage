def inclines_to_coordinates(encoding,inclines,delta):
     #saved under the name 'inclines_to_coordinates'
        
     r"""
     returns a vector x containing the coordinates of the system defined by the encoding, inclines and delta
     
     INPUT:
     
     - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
     
     - ''inclines'' - a matrix of 2n inclines, of the form $[a_1^L,b_1^L; ... ;a_n^R,b_n^R]$
     
     - ''delta'' - a positive scalar
     
     OUTPUT:
     
     - a 2n x 1 vector x containing the coordinates of the form (x_1,y_1,...,x_n,y_n)
     
     EXAMPLES:
         sage: inclines_to_coordinates(vector([2,1,1,0,1]),matrix([[1 ,1] ,[ -1 ,1]]),1)
         (1/2,1/2)
         sage: inclines_to_coordinates(vector([2,2,1,0,1,0,1]),matrix([[0,1],[1,-1],[1,1],[0,1]]),1)
         (0,1,1,1)
     
     """
     A=A_matrix(encoding,inclines)
     b=b_vector(encoding,delta,inclines)
    
     if det(A)==0:
         x=0
     if abs(det(A))>0:
         x=A\b
     return x