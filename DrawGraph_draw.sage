def DrawGraph_draw(encoding,coord):
    r"""
    returns a randomized plot of the graph defined by the encoding
    
    INPUT: 
     
    - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
     
    - ''coord'' - an (m+n) x 2 matrix containing coordinates in the form [x_1,y_1;...;x_m+n,y_m+n]
     
    OUTPUT:
     
    - a graphics plot 
         
    """
    
    m=encoding[0]
    n=encoding[1]
    
    
    coordinates=coord.rows()
    points=point2d(coord,size=50)
    plot_list=[points]
    
    for i in range(n):
        source_vertice=coordinates[m+i]
        
        left_vertex_label=encoding[2*i+3]
        right_vertex_label=encoding[2*i+4]
        
        left_vertex=coordinates[left_vertex_label]
        right_vertex=coordinates[right_vertex_label]
        
        left_edge=arrow2d(source_vertice,left_vertex)
        right_edge=arrow2d(source_vertice,right_vertex)
        
        plot_list.append(left_edge)
        plot_list.append(right_edge)
        
        plot=points
    for i in range(len(plot_list)-1):
        plot+=plot_list[i+1]
    
    
    return plot