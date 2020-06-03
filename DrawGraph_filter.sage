def DrawGraph_filter(encoding,delta,min_len):
    
    r"""
    returns coordinates that are a proper solution to the system
    
    INPUT: 
     
     - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
     
     - ''delta'' - a positive scalar
     
     - ''min_len'' - a positive scalar
     
     OUTPUT:
     
     - an n x 2 matrix containing coordinates in the form [x_1,y_1;...;x_n,y_n],
         because of randomization, the coordinates can change with each use of the function 
         
     EXAMPLES:
         sage: DrawGraph_filter(vector([2,1,1,0,1]),40,10)
         [120.000000000000 240.000000000000]
         
         sage: DrawGraph_filter(vector([2,2,1,0,1,0,1]),40,10)
         [-32.0000000000000  96.0000000000000]
         [ 48.0000000000000  16.0000000000000]
         
    """
    value = False
    k=0
    while value == False:
        coordinates=DrawGraph_algorithm(encoding,delta)
        v1=positive_test(coordinates)
        v2=same_vertices_test(encoding, delta, coordinates)
        v3=length_test(encoding,delta,coordinates,min_len)
        v4=overlapping_edges_test(encoding,delta,coordinates)
        value = all([v1,v2,v3,v4])
        k=k+1
        if k == 10^3:
            coordinates=0
            break
        
    return coordinates