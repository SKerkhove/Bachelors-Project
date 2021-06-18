def DrawGraph_filter_incl(encoding,n_coordinates,delta,min_len):
    
    r"""
    returns coordinates that are a proper solution to the system
    
    INPUT: 
     
     - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
     
     - ''n_coordinates'' - a n x 2 matrix of the form [x_1,y_1;...;x_n,y_n]
     
     - ''delta'' - a positive scalar
     
     - ''min_len'' - a positive scalar
     
     OUTPUT:
     
     - an (m+n) x 2 matrix containing coordinates in the form [x_1,y_1;...;x_m+n,y_m+n],
         because of randomization, the coordinates can change with each use of the function 
         
     EXAMPLES:
         sage: DrawGraph_filter(vector([2,1,1,0,1]),40,10)
         [  0.000000000000   0.000000000000]
         [ 40.000000000000   0.000000000000]
         [---------------------------------]
         [120.000000000000 240.000000000000]
         
         sage: DrawGraph_filter(vector([2,2,1,0,1,0,1]),40,10)
         [  0.0000000000000   0.0000000000000]
         [ 40.0000000000000   0.0000000000000]
         [-----------------------------------]
         [-32.0000000000000  96.0000000000000]
         [ 48.0000000000000  16.0000000000000]
         
    """
    if n_coordinates == 0:
        value = False
    else:
        v1=positive_test(n_coordinates)
        v2=same_vertices_test(encoding, delta, n_coordinates)
        v3=length_test(encoding,delta,n_coordinates,min_len)
        v4=overlapping_edges_test(encoding,delta,n_coordinates)
        value = all([v1,v2,v3,v4])
        

    return value