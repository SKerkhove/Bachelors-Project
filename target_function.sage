def target_function(encoding,delta,coordinates):
    r"""
    returns a score denoting how 'beautiful' the drawing of the graph is
    
    INPUT:
    
    - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
    
    - ''coordinates'' - an (n+m) x 2 matrix containing coordinates in the form [x_1,y_1;...;x_n+m,y_n+m]
    
    OUTPUT:
    
    - a scalar, the larger the value, the less 'beautiful' the drawing is
    
    EXAMPLES:
    
    """
    
    #the parameters
    L_0 =  50        #short and long edges score
    L_1 = 20         #distance between unrelated vertices
    L_2 = 0.4*L_0    #height y-coordinate
    c_se = 5         #short edges
    c_le = 16        #long edges
    c_dv = 10        #distance between unrelaed vertices
    c_ss = 0         #symmetry
    c_hy = 1        #height y-coordinate
    c_os = 1         #overshoot
    alpha = 0.9      #short edges
    beta = 1         #long edges
    gamma = 15       #intersections
    epsilon = 5      #intersections
    zeta = 5         #unrelated vertices
    eta = 10         #symmetry
    theta = 20       #height y-coordinate
    iota = 5         #overshoot
    kappa = 10       #points on one line
    labda = 5        #points on one line
    mu = 2           #horizontal lines
    nu = 1           #horizontal lines
    
    #getting the prerequisites from the data
    m=encoding[0]
    n=encoding[1]
    
    #vertices_sink is an n x 4 matrix of which the first two columns give the coordinates for the left vertex with\
    #which the source is connected and the column 2 and 3 give the coordinates for the right vertex
    #edges_length is an n x 2 matrix of which the first column gives the length of the left edge of the source vertex\
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
        
        left_short_edges_score = c_se*(L_0/length_L)^alpha
        right_short_edges_score =c_se*(L_0/length_R)^alpha
        
        left_long_edges_score = c_le*(length_L/L_0)^beta
        right_long_edges_score = c_le*(length_R/L_0)^beta
        
        short_edges_score += left_short_edges_score+right_short_edges_score
        long_edges_score += left_long_edges_score+right_long_edges_score
    
    #intersections score
    intersections_score = 0
    num_of_intersections=1

    for i in range(2*n):
        p_0=vector([edges_begin_end[i,0],edges_begin_end[i,1]])
        p_1=vector([edges_begin_end[i,2],edges_begin_end[i,3]])

        for j in range(i+1,2*n):
            q_0=vector([edges_begin_end[j,0],edges_begin_end[j,1]])
            q_1=vector([edges_begin_end[j,2],edges_begin_end[j,3]])

            if p_0==q_0 or p_0 == q_1:
                continue
            if p_1 == q_0 or p_1 == q_1:
                continue
            
            value=intersection_test(p_0,p_1,q_0,q_1)
            if value == True:
                num_of_intersections+=1
    
    intersections_score = num_of_intersections^gamma*RDF(log(num_of_intersections))^epsilon
    
    #distance between unrelated vertices
    distance_vertices_score=0
    for i in range(n):
        vertex_1_x=coordinates[i+m,0]
        vertex_1_y=coordinates[i+m,1]
        for j in range(i+m):
            if j == encoding[3+2*i] or j == encoding[4+2*i]:
                continue
            vertex_2_x=coordinates[j,0]
            vertex_2_y=coordinates[j,1]
            Length_ij_sq=(vertex_2_x-vertex_1_x)^2+(vertex_2_y-vertex_1_y)^2
            Length_ij=sqrt(Length_ij_sq)
            distance_vertices_score+=c_dv*(L_1/Length_ij)^zeta

        for j in range(i+m+1,n+m):
            if j == encoding[3+2*i] or j == encoding[4+2*i]:
                continue
            vertex_2_x=coordinates[j,0]
            vertex_2_y=coordinates[j,1]
            Length_ij_sq=(vertex_2_x-vertex_1_x)^2+(vertex_2_y-vertex_1_y)^2
            Length_ij=sqrt(Length_ij_sq)
            distance_vertices_score+=c_dv*(L_1/Length_ij)^zeta
            
    #height y-coordinate score
    height_y_score=0
    for i in range(n):
        vertex_y=coordinates[m+i,1]
        height_y_score+=c_hy*(L_2/vertex_y)^theta
    
    #overshoot score
    overshoot_score = 0
    for i in range(n):
        vertex_x=coordinates[m+i,0]
        if vertex_x>delta:
            overshoot_score += c_os*(vertex_x-delta)^iota
        if vertex_x<0:
            overshoot_score += c_os*abs(vertex_x)^iota
            
    #points on line score
    num_vert_on_line = points_on_line_test(coordinates)
    points_on_line_score = -num_vert_on_line^kappa*RDF(log(num_vert_on_line))^labda
    
    #horizontal 'lines' score
    num_horizontal_lines=1
    for i in range(m+n):
        p_x=coordinates[i,0]
        for j in range(i+1,m+n):
            q_x=coordinates[j,0]
            if p_x==q_x:
                num_horizontal_lines+=1
    horizontal_lines_score = -num_horizontal_lines^mu*RDF(log(num_horizontal_lines))^nu
    
    #symmetry score
    symmetry_score=0
    for i in range(n):
        vertex_x=coordinates[m+i,0]
        if vertex_x<=0.5*delta:
            symmetry_score+=-c_ss*(0.5*delta-vertex_x)^eta
        if vertex_x>0.5*delta:
            symmetry_score+=c_ss*(vertex_x-0.5*delta)^eta

    score=short_edges_score+long_edges_score+intersections_score\
    +distance_vertices_score+height_y_score\
    +overshoot_score+horizontal_lines_score+points_on_line_score+symmetry_score
    
    
    return score