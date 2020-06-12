def choosing_best_five_pictures(encoding,delta,min_len,num_of_iterations):
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
    list_of_coordinates=generate_list_of_coordinates(encoding,delta,min_len,num_of_iterations)

    list_of_unique_coordinates=[]
    for i in range(num_of_iterations):
        list_of_unique_coordinates.append(list_of_coordinates[i])

    #while i<num_of_iterations
    for i in range(num_of_iterations):
        for j in range(i+1,num_of_iterations):
            if list_of_coordinates[i]==list_of_coordinates[j]:
                list_of_unique_coordinates.remove(list_of_coordinates[i])
                break
            duplicate_num=0
            for k in range(m,m+n):
                coord_1=list_of_coordinates[i][k,:]
                for l in range(m,m+n):
                    if coord_1==list_of_coordinates[j][l,:]:
                        duplicate_num +=1
                        break
                if duplicate_num==n:
                    list_of_unique_coordinates.remove(list_of_coordinates[i])
            break
    
    num_unique_coordinates=len(list_of_unique_coordinates)
                
    score_list=[]
    for i in range(num_unique_coordinates):
        score=target_function(encoding,list_of_unique_coordinates[i])
        score_list.append([score,i])
    
    score_list=sorted(score_list)
    best_score_list=[]
    best_five=[]
    if num_unique_coordinates<5:
        best_five=list_of_unique_coordinates
    else:
        for i in range(5):
            best_score_list.append(score_list[i][0])
            k=score_list[i][1]
            best_five.append(list_of_unique_coordinates[k])

    return best_five