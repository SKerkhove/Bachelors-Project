def positive_test(coordinates):
    
    r""""
    returns a value True or False based on whether the coordinates all lie above the line y=0
    
    INPUT:
    
    - ''coordinates'' - an n x 2 matrix containing coordinates in the form [x_1,y_1;...;x_n,y_n]
    
    OUTPUT:
    
    - a value False or True, indicating whether the input matrix had coordinates below or on the line y=0
    
    EXAMPLES:
        sage: positive_test(matrix([[1,4],[2,3]]))
        True

        sage: positive_test(matrix([[1,4],[2,-2]]))
        False
        
        sage: positive_test(matrix([[1,0],[2,3],[4,5]]))
        False
    
    """
    n=coordinates.nrows()
    value=True
    for i in range(n):
         if coordinates[i,1]<=0:
             value = False
             break

    return value