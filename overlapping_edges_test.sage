def overlapping_edges_test(encoding,delta,coordinates):
    r"""
    returns a value False or True, depending on whether the defined graph has overlapping edges
    
    INPUT:
    
     - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
     
     - ''delta'' - a positive scalar
     
     - ''coordinates'' - an n x 2 matrix containing coordinates in the form [x_1,y_1;...;x_n,y_n]
     
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
    
    inclines=zero_vector(RR,2*n)
    source_vert_x=zero_vector(RR,2*n)
    source_vert_y=zero_vector(RR,2*n)
    goal_vert_x=zero_vector(RR,2*n)
    goal_vert_y=zero_vector(RR,2*n)
    
    for i in range(2*n):
        
        if i%2==0:
            source_vert_x[i]=coordinates[i/2,0]
            source_vert_y[i]=coordinates[i/2,1] 
            
        if i%2==1:
            source_vert_x[i]=coordinates[(i-1)/2,0]
            source_vert_y[i]=coordinates[(i-1)/2,1]
            
        goal_vert=encoding[i+2]
        if goal_vert<m:
            goal_vert_x[i]=sink_coord[goal_vert,0]
            goal_vert_y[i]=sink_coord[goal_vert,1]
        if goal_vert>=m:
            goal_vert_x[i]=coordinates[goal_vert-m,0]
            goal_vert_y[i]=coordinates[goal_vert-m,1]
        
        delta_x=source_vert_x[i]-goal_vert_x[i]
        delta_y=source_vert_y[i]-goal_vert_y[i]
        
        if delta_y==0:
            inclines[i]=10
        else:
            inclines[i]=delta_x/delta_y
        
    for i in range(2*n):
        for j in range(2*n):
            if j==i:
                continue
            if inclines[i]==inclines[j]:
                if source_vert_x[i]<source_vert_x[j]<goal_vert_x[i]:
                    if source_vert_y[i]<source_vert_y[j]<goal_vert_y[i] or \
                    source_vert_y[i]>source_vert_y[j]>goal_vert_y[i]:
                        delta_x = source_vert_x[j]-source_vert_x[i]
                        if source_vert_y[j]==source_vert_y[i]+delta_x*inclines[i]:
                            value=False
                            break
                        
                if source_vert_x[i]>source_vert_x[j]>goal_vert_x[i]:
                    if source_vert_y[i]<source_vert_y[j]<goal_vert_y[i] or \
                    source_vert_y[i]>source_vert_y[j]>goal_vert_y[i]:
                        delta_x = source_vert_x[j]-source_vert_x[i]
                        if source_vert_y[j]==source_vert_y[i]+delta_x*inclines[i]:
                            value=False
                            break
                        
        if value==False:
            break
        
    
    
    return value