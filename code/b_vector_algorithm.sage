def b_vector(encoding,delta,inclines):
     #saved under the name 'b_vector_algorithm'
     r"""
     Return the vector $b$ in the system $Ax=b$
     
     INPUT:
     
     - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
     
     - ''delta'' - a positive scalar
     
     - ''inclines'' - a matrix of 2n inclines, of the form $[a_1^L,b_1^L; ... ;a_n^R,b_n^R]$
     
     OUTPUT:
     
     - a vector $b$ of size 2n x 1
     
     EXAMPLES:
     
         sage: b_vector(vector([2,1,1,0,1]),1,matrix([[1,1],[-1,1]]))
         (0,1)
         sage: b_vector(vector([2,2,1,0,1,1,2]),1,\matrix([[0,-1],[1,-1],[-1,0],[0,-1]]))
         (0,-1,0,0)
     """
     m=encoding[0]
     n=encoding[1]
    
     b=zero_vector(2*n)
     two_cycles_list=[]
     for i in range(2*n):
         e=encoding[i+3]
         if e < m:
             b[i]=e*delta*inclines[i,1]
         else:    
             if encoding[2*e-1]==m+floor(i/2) or encoding[2*e]==m+floor(i/2):
                 two_cycle=sorted([e,m+floor(i/2)])
                 if two_cycle in two_cycles_list:
                     continue
                 b[i]=delta
                 two_cycles_list.append(two_cycle)

     return b