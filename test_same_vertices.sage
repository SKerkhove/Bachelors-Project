def same_vertices_test(encoding, delta, n_coordinates):
    
    r""""
    returns a value True or False indicating whether the coordinates all indicate unique points
    
    INPUT:
    
    - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
     
    - ''delta'' - a positive scalar
    
    - ''n_coordinates'' - an n x 2 matrix containing coordinates in the form [x_1,y_1;...;x_n,y_n]
    
    OUTPUT:
    
    - a value False or True, indicating whether the input matrix has unique coordinates
    
    EXAMPLES:
        sage: same_vertices_test(matrix([[1,2],[3,4],[1,2]]))
        False
        sage: same_vertices_test(matrix([[1,2],[3,4],[1,3]]))
        True
    
    """
    m=encoding[0]
    m_coordinates=zero_matrix(RR,m,2)
    for i in range(m):
        m_coordinates[i,0]=i*delta
    
    coordinates=block_matrix([[m_coordinates],[n_coordinates]])
    k=coordinates.nrows()
    value=True
    for i in range(k):
        for j in range(i+1,k):
            if coordinates[i,:]==coordinates[j,:]:
                value = False
                break
                
    return value