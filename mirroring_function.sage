def mirroring_function(encoding,coordinates):
    m=encoding[0]
    n=encoding[1]
    
    new_encoding=[m,n,encoding[2]]
    print(new_encoding)
    for i in range(2*n):
        e=encoding[3+i]
        if e==1:
            new_encoding.append(0)
        if e==0:
            new_encoding.append(1)
        if e not in [0,1]:
            new_encoding.append(e)
        print(new_encoding)
    new_coordinates=zero_matrix(RR,m+n,2)
    for i in range(m):
        new_coordinates[i,:]=coordinates[i,:]
    for i in range(n):
        x=coordinates[2+i,0]
        new_x=50-x
        new_coordinates[2+i,0]=new_x
        new_coordinates[2+i,1]=coordinates[2+i,1]
    return new_encoding,new_coordinates