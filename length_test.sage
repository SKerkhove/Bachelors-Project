def length_test(encoding,delta,coordinates,min_len):
    r"""
    returns a value False or True 
    depending on whether any of the edges defined by the coordinates and encoding has 
    a length smaller than the minimal value min_len
    
    INPUT:
    
     - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
     
     - ''delta'' - a positive scalar
     
     - ''coordinates'' - an n x 2 matrix containing coordinates in the form [x_1,y_1;...;x_n,y_n]
     
     - ''min_len'' - a positive scalar
     
    OUTPUT:
    
    - a value False or True, denoting whether all edges of the defined graph are larger than the minimum lenght
    
    EXAMPLES:
        sage: length_test(vector([2,3,1,0,1,0,4,1,2]),40,matrix([[160,40],[210,105],[280,0]]),10)
        True
        sage: length_test(vector([2,1,1,0,1]),10,matrix([[1,3]]),10)
        False

    """
    
    
    m=encoding[0]
    n=encoding[1]
    value=True
    
    sink_coord=zero_matrix(RR,m,2)
    for i in range(m):
        sink_coord[i,0]=i*delta
    
    for i in range(n):
        source_vert_x=coordinates[i,0]
        source_vert_y=coordinates[i,1]
        
        
        goal_vert_L=encoding[3+2*i]
        goal_vert_R=encoding[4+2*i]
        if goal_vert_L <m:
            goal_vert_L_x=sink_coord[goal_vert_L,0]
            goal_vert_L_y=sink_coord[goal_vert_L,1]
        if goal_vert_L>=m:
            goal_vert_L_x=coordinates[goal_vert_L-m,0]
            goal_vert_L_y=coordinates[goal_vert_L-m,1]
            
        if goal_vert_R <m:
            goal_vert_R_x=sink_coord[goal_vert_R,0]
            goal_vert_R_y=sink_coord[goal_vert_R,1]
        if goal_vert_R>=m:
            goal_vert_R_x=coordinates[goal_vert_R-m,0]
            goal_vert_R_y=coordinates[goal_vert_R-m,1]    
        
        delta_L_x=source_vert_x-goal_vert_L_x
        delta_L_y=source_vert_y-goal_vert_L_y
        delta_R_x=source_vert_x-goal_vert_R_x
        delta_R_y=source_vert_y-goal_vert_R_y
        
       
        edge_length_sq=delta_L_x^2+delta_L_y^2
        edge_length=sqrt(edge_length_sq)
        if edge_length<min_len:
            value=False
            break
                    
        edge_length_sq=delta_R_x^2+delta_R_y^2
        edge_length=sqrt(edge_length_sq)
        if edge_length<min_len:
            value=False 
            break
    
    
    return value