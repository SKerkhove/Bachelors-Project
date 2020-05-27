def same_vertices_test(coordinates):
    
    r""""
    returns a value True or False indicating whether the coordinates all indicate unique points
    
    INPUT:
    
    - ''coordinates'' - an n x 2 matrix containing coordinates in the form [x_1,y_1;...;x_n,y_n]
    
    OUTPUT:
    
    - a value False or True, indicating whether the input matrix has unique coordinates
    
    EXAMPLES:
        sage: same_vertices_test(matrix([[1,2],[3,4],[1,2]]))
        False
        sage: same_vertices_test(matrix([[1,2],[3,4],[1,3]]))
        True
    
    """
    n=coordinates.nrows()
    value=True
    for i in range(n):
        for j in range(n):
            if coordinates[i,:]==coordinates[j,:]:
                if i!=j:
                    value = False
    return value 