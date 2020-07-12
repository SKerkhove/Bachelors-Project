def points_on_line_test(coordinates):
    r"""
    INPUT:
    
    - ''coordinates'' - an (n+m) x 2 matrix containing coordinates in the form [x_1,y_1;...;x_n+m,y_n+m]
    """
    
    num_vertices=coordinates.nrows()
    
    num_vert_on_line = 1
    for i in range(num_vertices):
        a_x=coordinates[i,0]
        a_y=coordinates[i,1]
        for j in range(i+1,num_vertices):
            b_x=coordinates[j,0]
            b_y=coordinates[j,1]
            s=vector([b_x-a_x,b_y-a_y])
            norm_s=s*s
            for k in range(j+1,num_vertices):
                v=vector([coordinates[k,0]-a_x,coordinates[k,1]-a_y])
                proj_len=(v*s)/norm_s
                proj=proj_len*s
                if proj == v:
                    num_vert_on_line +=1
                    #print(i,j,k,s,v,proj_len)
    return num_vert_on_line