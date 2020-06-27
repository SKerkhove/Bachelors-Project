def A_matrix(encoding,inclines):
     #saved under the name A_matrix_algorithm
     r"""
     Return the matrix A in the system Ax=b
     
     INPUT:
     
     - ''encoding'' - a vector of the form (m,n,s,e_1,e_2,...,e_2n)
     
     - ''inclines'' - a 2n x 2 matrix of the form [a_1^L,b_1^L;...;a_n^R,b_n^R]
     
     OUTPUT:
     
     - a matrix A of size 2n x 2n
     
     EXAMPLES:
         sage: A_matrix(vector([2,1,1,0,1]),matrix([[1 ,1] ,[ -1 ,1]]))
         [1,-1]
         [1,1]
         
         sage: A_matrix(vector([2,2,1,0,1,1,2]),matrix([[0,-1],[1,-1],[-1,0],[0,-1]]))
         [-1  0  0  0]
         [-1 -1  0  0]
         [ 0  0  0  1]
         [ 1  0 -1  0]
     
     """
     m=encoding[0]
     n=encoding[1]
     A=zero_matrix(2*n,2*n)
     two_cycles_list=[]
     for i in range(2*n):
         e=encoding[i+3]
         if e>=m:    
             if encoding[2*e-1]==m+floor(i/2) or encoding[2*e]==m+floor(i/2):
                two_cycle=sorted([e,m+floor(i/2)])
                if two_cycle in two_cycles_list:
                    if i%2 == 0:
                        A[i,i]=inclines[i,1]
                        A[i,i+1]=-inclines[i,0]
                        if e >= m:
                            A[i,2*(e-m+1)-2]=-inclines[i,1]
                            A[i,2*(e-m+1)-1]=inclines[i,0]
                    if i%2 == 1:
                        A[i,i]=-inclines[i,0]
                        A[i,i-1]=inclines[i,1]
                        if e >= m:
                            A[i,2*(e-m+1)-2]=-inclines[i,1]
                            A[i,2*(e-m+1)-1]=inclines[i,0]
                    continue
                two_cycles_list.append(two_cycle)
                if i%2 == 0:
                    A[i,i+1]=1
                if i%2 == 1:
                    A[i,i]=1
                continue           
         if i%2 == 0:
             A[i,i]=inclines[i,1]
             A[i,i+1]=-inclines[i,0]
             if e >= m:
                A[i,2*(e-m+1)-2]=-inclines[i,1]
                A[i,2*(e-m+1)-1]=inclines[i,0]
         if i%2 == 1:
             A[i,i]=-inclines[i,0]
             A[i,i-1]=inclines[i,1]
             if e >= m:
                A[i,2*(e-m+1)-2]=-inclines[i,1]
                A[i,2*(e-m+1)-1]=inclines[i,0]
         
     
     return A