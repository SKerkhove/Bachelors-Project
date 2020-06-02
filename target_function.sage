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
    L_0 = 10
    c_se=1
    c_le=1
    alpha=1
    beta=1
    gamma=1
    epsilon=1
    
    #getting the prerequisites from the data
    m=encoding[0]
    n=encoding[1]
    
    #vertices_sink is an n x 4 matrix of which the first two columns give the coordinates for the left vertice with\
    #which the source is connected and the column 2 and 3 give the coordinates for the right vertice
    #edges_length is an n x 2 matrix of which the first column gives the lenght of the left edge of the source vertex\
    #and the second column gives the length of the right edge
    #edges_begin_end is a 2n x 4 matrix containing the begin and end point of each edges in the rows
    vertices_sink = zero_matrix(RR,n,4)
    edges_length=zero_matrix(RR,n,2)
    edges_begin_end=zero_matrix(RR,2*n,4)

    for i in range(n):
        e_L=encoding[3+2*i]
        e_R=encoding[4+2*i]
        vertices_sink[i,0:2]=coordinates[e_L,:]
        vertices_sink[i,2:4]=coordinates[e_R,:]
        
        coord_source_x=coordinates[m+i,0]
        coord_source_y=coordinates[m+i,1]
        edges_begin_end[[2*i,2*i+1],0]=coord_source_x
        edges_begin_end[[2*i,2*i+1],1]=coord_source_y

        coord_sink_L_x=coordinates[e_L,0]
        coord_sink_L_y=coordinates[e_L,1]
        edges_begin_end[2*i,2]=coord_sink_L_x
        edges_begin_end[2*i,3]=coord_sink_L_y


        coord_sink_R_x=coordinates[e_R,0]
        coord_sink_R_y=coordinates[e_R,1]
        edges_begin_end[2*i+1,2]=coord_sink_R_x
        edges_begin_end[2*i+1,3]=coord_sink_R_y
        
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
    num_of_intersections=0

    for i in range(2*n):
        p_0=vector([edges_begin_end[i,0],edges_begin_end[i,1]])
        p_1=vector([edges_begin_end[i,2],edges_begin_end[i,3]])

        for j in range(2*n):
            if i == j:
                continue
            q_0=vector([edges_begin_end[j,0],edges_begin_end[j,1]])
            q_1=vector([edges_begin_end[j,2],edges_begin_end[j,3]])

            if p_0==q_0 or p_0 == q_1:
                continue
            if p_1 == q_0 or p_1 == q_1:
                continue
            
            value=intersection_test(p_0,p_1,q_0,q_1)
            if value == True:
                num_of_intersections+=1
    if num_of_intersections !=0:
        intersections_score = num_of_intersections^gamma*RDF(log(num_of_intersections))^epsilon
    
    score=short_edges_score+long_edges_score+intersections_score
    
    return score