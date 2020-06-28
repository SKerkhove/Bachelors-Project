def overlapping_edges_test(encoding,delta,n_coordinates):
    r"""
    returns a value False or True, depending on whether the defined graph has overlapping edges
    
    INPUT:
    
     - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
     
     - ''delta'' - a positive scalar
     
     - ''n_coordinates'' - an n x 2 matrix containing coordinates in the form [x_1,y_1;...;x_n,y_n]
     
     OUTPUT:
     
     - a value False or True,  depending on whether the defined graph has overlapping edges
     
     EXAMPLES:
         sage: overlapping_edges_test(vector([2,2,1,0,1,1,2]),10,matrix([[0,10],[5,5]]))
         False
         sage: overlapping_edges_test(vector([2,2,1,0,1,1,2]),10,matrix([[0,10],[10,10]]))
         True
    
    """
    m=encoding[0]
    n=encoding[1]
    value=True
    
    sink_coord=zero_matrix(RR,m,2)
    for i in range(m):
        sink_coord[i,0]=i*delta
    
    coordinates=block_matrix([[sink_coord],[n_coordinates]])

    edges_source_goal=zero_matrix(QQ,2*n,4)
    for i in range(2*n):
        if i%2==0:
            source_vertice_label=i/2+m
        else:
            source_vertice_label=(i-1)/2+m
        source_vertice_x=coordinates[source_vertice_label,0]
        source_vertice_y=coordinates[source_vertice_label,1]

        goal_vertice_label=encoding[3+i]
        goal_vertice_x=coordinates[goal_vertice_label,0]
        goal_vertice_y=coordinates[goal_vertice_label,1]

        edges_source_goal[i,:]=vector([source_vertice_x,source_vertice_y,goal_vertice_x,goal_vertice_y])
    
    for i in range(2*n):
        p_0=vector([edges_source_goal[i,0],edges_source_goal[i,1]])
        p_1=vector([edges_source_goal[i,2],edges_source_goal[i,3]])
        if p_0==p_1:
            continue
        r=p_1-p_0
        
        for j in range(i+1,2*n):
            q_0=vector([edges_source_goal[j,0],edges_source_goal[j,1]])
            q_1=vector([edges_source_goal[j,2],edges_source_goal[j,3]])
            if q_0==q_1:
                continue
            
            if p_0 == q_1 and p_1==q_0:
                continue

            s=q_1-q_0
            r_cross_s=r[0]*s[1]-r[1]*s[0]

            q_min_p=q_0-p_0
            q_min_p_cross_r=q_min_p[0]*r[1]-q_min_p[1]*r[0]

            if r_cross_s == 0 and q_min_p_cross_r == 0:
                t_0=q_min_p*r/(r*r)
                t_1=t_0+s*r/(r*r)
                if 0<=t_0<=1 or 0<=t_1<=1:
                    if t_0 == 0 and t_1<0:
                        continue
                    if t_0 == 1 and t_1>1:
                        continue
                    if t_1 == 0 and t_0<0:
                        continue
                    if t_1 == 1 and t_1>1:
                        continue
                    value = False
                    break

    return value