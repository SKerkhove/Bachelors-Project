def DrawGraph_compute_and_draw(encoding,delta,min_len):
    r"""
    returns a randomized plot of the graph defined by the encoding
    
    INPUT: 
     
     - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
     
     - ''delta'' - a positive scalar
     
     - ''min_len'' - a positive scalar
     
     OUTPUT:
     
     - a graphics plot 
         
    """
    
    m=encoding[0]
    n=encoding[1]
    
    coord=DrawGraph_filter(encoding,delta,min_len)
    
    coordinates=coord.rows()
    points=point2d(coord)
    plot_list=[points]
    
    for i in range(n):
        source_vertice=coordinates[m+i]
        
        left_vertice_label=encoding[2*i+3]
        right_vertice_label=encoding[2*i+4]
        
        left_vertice=coordinates[left_vertice_label]
        right_vertice=coordinates[right_vertice_label]
        
        left_edge=arrow2d(source_vertice,left_vertice)
        right_edge=arrow2d(source_vertice,right_vertice)
        
        plot_list.append(left_edge)
        plot_list.append(right_edge)
        
        plot=points
    for i in range(len(plot_list)-1):
        plot+=plot_list[i+1]
    
    
    return plot