def generate_list_of_coordinates(encoding,delta,min_len,num_of_iterations):
    r"""
    returns a list containing coordinates for the system determined by encoding and delta

    INPUT: 
     
    - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
     
    - ''delta'' - a positive scalar
     
    - ''min_len'' - a positive scalar

    - ''num_of_iterations'' - a positive integer

    OUTPUT:

    - a list containing num_of_iterations times a solution to the system

    """
    
    n=encoding[1]
    list_of_coordinates=[]
    
    if n<3:
        #we're first generating all possible inclines, stored in set_of_inclines
        positive_inclines=matrix([[0,1],[1,0],[1,1],[1,2],[1,3],[1,4],\
        [2,1],[2,3],[3,1],[3,2],[3,4],[4,1],[4,3]])
        nofinclines=(positive_inclines.nrows()-1)*2
        half_nofi=nofinclines/2
        set_of_inclines=zero_matrix(nofinclines,2)
        for i in range(nofinclines):
            if i<=half_nofi:
                set_of_inclines[i,:]=positive_inclines[i,:]
            if i>half_nofi:
                set_of_inclines[i,0]=positive_inclines[i-half_nofi+1,0]
                set_of_inclines[i,1]=-positive_inclines[i-half_nofi+1,1]
                
        m=encoding[0]
        m_coordinates=zero_matrix(RR,m,2)
        for i in range(m):
            m_coordinates[i,0]=i*delta
        counter=0
        for i in range(nofinclines):
            inclines=zero_matrix(2*n,2)
            inclines[0,:]=set_of_inclines[i,:]
            for j in range(nofinclines):
                incl = set_of_inclines[j,:]
                if incl == inclines[0,:]:
                    continue
                inclines[1,:]=incl
                if n == 1:
                    x=inclines_to_coordinates(encoding,inclines,delta)
                    if x == 0:
                        continue
                    n_coordinates=zero_matrix(RR,n,2)
                    for q in range(n):
                        n_coordinates[q,0]=x[2*q]
                        n_coordinates[q,1]=x[2*q+1]
                    value=DrawGraph_filter_incl(encoding,n_coordinates,delta,min_len)
                    if value == False:
                        counter+=1
                        continue
                    coordinates=block_matrix([[m_coordinates],[n_coordinates]])
                    list_of_coordinates.append(coordinates)
                    continue
                for k in range(nofinclines):
                    inclines[2,:]=set_of_inclines[k,:]
                    for l in range(nofinclines):
                        incl=set_of_inclines[l,:]
                        if incl==inclines[2,:]:
                            continue
                        inclines[3,:]=incl
                        if n == 2:
                            x=inclines_to_coordinates(encoding,inclines,delta)
                            if x == 0:
                                continue
                            n_coordinates=zero_matrix(RR,n,2)
                            for r in range(n):
                                n_coordinates[r,0]=x[2*r]
                                n_coordinates[r,1]=x[2*r+1]
                            value=DrawGraph_filter_incl(encoding,n_coordinates,delta,min_len)
                            if value == False:
                                counter+=1
                                continue
                            coordinates=block_matrix([[m_coordinates],[n_coordinates]])
                            list_of_coordinates.append(coordinates)
                            continue
                        for o in range(nofinclines):
                            inclines[4,:]=set_of_inclines[k,:]
                            for p in range(nofinclines):
                                incl=set_of_inclines[p,:]
                                if incl==inclines[4,:]:
                                    continue
                                inclines[5,:]=incl
                                x=inclines_to_coordinates(encoding,inclines,delta)
                                n_coordinates=zero_matrix(RR,n,2)
                                for s in range(n):
                                    n_coordinates[s,0]=x[2*s]
                                    n_coordinates[s,1]=x[2*s+1]
                                value=DrawGraph_filter_incl(encoding,n_coordinates,delta,min_len)
                                if value == False:
                                    continue
                                coordinates=block_matrix([[m_coordinates],[n_coordinates]])
                                list_of_coordinates.append(coordinates)
        print(counter)
        
    else:
        for i in range(num_of_iterations):
            coordinates=DrawGraph_filter(encoding,delta,min_len)
            list_of_coordinates.append(coordinates)
    print(len(list_of_coordinates))
    return list_of_coordinates