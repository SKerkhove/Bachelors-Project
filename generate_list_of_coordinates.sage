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
    for i in range(num_of_iterations):
        coordinates=DrawGraph_filter(encoding,delta,min_len)
        list_of_coordinates.append(coordinates)
    
    return list_of_coordinates