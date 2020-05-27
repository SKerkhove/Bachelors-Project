def target_function(encoding,coordinates):
    r"""
    returns a score denoting how 'beautiful' the drawing of the graph is
    
    INPUT:
    
    - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
    
    - '' coordinates'' - an (n+m) x 2 matrix containing coordinates in the form [x_1,y_1;...;x_n+m,y_n+m]
    
    OUTPUT:
    
    - a scalar
    
    EXAMPLES:
    
    """
    
    #the parameters
    L_0 = 20
    c_se=1
    c_le=1
    alpha=2
    beta=1
    
    #getting the prerequisites from the data
    m=encoding[0]
    n=encoding[1]
    
    #vertices_sink is an n x 4 matrix of which the first two columns give the coordinates for the left vertice with\
    #which the source is connected and the column 2 and 3 give the coordinates for the right vertice
    #edges_length is an n x 2 matrix of which the first column gives the lenght of the left edge of the source vertex\
    #and the second column gives the length of the right edge
    vertices_sink = zero_matrix(RR,n,4)
    edges_length=zero_matrix(RR,n,2)

    for i in range(n):
        e_L=encoding[3+2*i]
        e_R=encoding[4+2*i]
        vertices_sink[i,0:2]=coordinates[e_L,:]
        vertices_sink[i,2:4]=coordinates[e_R,:]
        
        coord_source_x=coordinates[m+i,0]
        coord_source_y=coordinates[m+i,1]
        
        coord_sink_L_x=coordinates[e_L,0]
        coord_sink_L_y=coordinates[e_L,1]
        
        coord_sink_R_x=coordinates[e_R,0]
        coord_sink_R_y=coordinates[e_R,1]
        
        delta_x_L=coord_source_x-coord_sink_L_x
        delta_y_L=coord_source_y-coord_sink_L_y
        
        delta_x_R=coord_source_x-coord_sink_R_x
        delta_y_R=coord_source_y-coord_sink_R_y
        
        edges_length[i,0] = sqrt(delta_x_L^2+delta_y_L^2)
        edges_length[i,1] = sqrt(delta_x_R^2+delta_y_R^2)
        

        
    
    # short edges
    short_edges_score=0
    #long edges
    long_edges_score = 0
    for i in range(n):
        length_L=edges_length[i,0]
        length_R=edges_length[i,1]
        
        left_short_edges_score = c_se*(length_L/L_0)^alpha
        right_short_edges_score =c_se*(length_R/L_0)^alpha
        
        left_long_edges_score = c_le*(L_0/length_L)^beta
        right_long_edges_score = c_le*(L_0/length_R)^beta
        
        short_edges_score += left_short_edges_score+right_short_edges_score
        long_edges_score += left_long_edges_score+right_long_edges_score
    
    #intersections
    intersections_score = 0
    
    #personally I would really like a symmetry score
    
    score=short_edges_score+long_edges_score+intersections_score
    
    return score