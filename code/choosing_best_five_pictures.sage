def choosing_best_five_pictures(encoding,delta,min_len,num_of_iterations,list_of_coordinates=0,list_of_unique_coordinates=0):
    r"""
    returns the five best coordinates after a certain number of applying DrawGraph_filter

    INPUT:
     
    - ''encoding'' - a vector of the form $[m,n,s,e_1,e_2,...,e_2n]$
     
    - ''delta'' - a positive scalar
     
    - ''min_len'' - a positive scalar

    - ''num_of_iterations'' - a positive integer

    OUTPUT:

    - a list of 5 coordinate systems

    """
    m=encoding[0]
    n=encoding[1]
    
    e_list=[]
    for i in range(n):
        e_list.append([encoding[2*i+3],encoding[2*i+4]])
        
        
    if list_of_coordinates == 0:                   
        list_of_coordinates=generate_list_of_coordinates(encoding,delta,min_len,num_of_iterations)
    if list_of_unique_coordinates == 0:
        list_of_unique_coordinates=[]
        for i in range(num_of_iterations):
            list_of_unique_coordinates.append(list_of_coordinates[i])
    
        length = len(list_of_coordinates)
        for i in range(length):
            coord_1=list_of_coordinates[i]
#           stop = False
            for j in range(i+1,length):
#               if stop == True:
#                   break
                coord_2=list_of_coordinates[j]
                if coord_1==coord_2:
                    list_of_unique_coordinates.remove(coord_1)
                    break
            
#                for k in range(m,m+n):
#                    if stop == True:
#                        break
#                    for l in range(k+1,m+n):
#                        if e_list[k-m] == e_list[l-m]:
#                            if coord_1[k] == coord_2[l] and coord_1[l] == coord_2[k]:
#                                if coord_1[m:k] == coord_2[m:k] and\
#                                coord_1[k+1:l] == coord_2[k+1:l] and\
#                                coord_1[l+1:m+n] == coord_2[l+1:m+n]:
#                                    list_of_unique_coordinates.remove(coord_1)
#                                    stop = True
#                                    break
            
            #still not completely valid for like 010101
            #break
    #else:
    #    list_of_unique_coordinates=generate_list_of_coordinates(encoding,delta,min_len,num_of_iterations)
                        
    num_unique_coordinates=len(list_of_unique_coordinates)
                
    score_list=[]
    for i in range(num_unique_coordinates):
        score=target_function(encoding,delta,list_of_unique_coordinates[i])
        score_list.append([score,i])
    
    score_list=sorted(score_list)
    best_score_list=[]
    best_five=[]
    if num_unique_coordinates<10:
        best_five=list_of_unique_coordinates
    else:
        for i in range(10):
            best_score_list.append(score_list[i][0])
            k=score_list[i][1]
            best_five.append(list_of_unique_coordinates[k])

    return best_five