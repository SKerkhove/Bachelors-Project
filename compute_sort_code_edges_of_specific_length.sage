A=generate_list_of_coordinates(encoding,delta,min_len,100000)
#attempting to find all the sets of coordinates

unique_list_of_coordinates=[]
#throwing all the duplicate coordinates away
for i in range(num_of_iterations):
    x=A[i][2,0]
    y=A[i][2,1]
    if [x,y] not in unique_list_of_coordinates:
        unique_list_of_coordinates.append([x,y])

def pyt_compt(unique_list_of_coordinates):
    #pythagoras computer, to compute the hypothenuse of a rectangular triangle
    k=len(unique_list_of_coordinates)
    length_list=[]
    for i in srange(k):
        del_x_L=w[i][0]
        del_x_R=50-w[i][0]
        
        del_y=w[i][1]
        
        len_L_sq=del_x_L^2+del_y^2
        len_R_sq=del_x_R^2+del_y^2
        
        len_L=sqrt(len_L_sq)
        len_R=sqrt(len_R_sq)
        length_list.append([len_L,len_R,w[i]])
        
    return length_list

length_list=pyt_compt(unique_list_of_coordinates)
#the above gives a list of the lengths of all the edges
#the below gives the same list, but sorted from small to large
length_list_dup=sorted(length_list)

#we now remove all edges larger than 50
for i in range(len(length_list)):
    len_L=length_list[i][0]
    len_R=length_list[i][1]
    if len_L>=50 or len_R>=50: #the >= can be changed in <= to find all the edges smaller than 50
        length_list_dup.remove(length_list[i])

#calculate the average length of each pair of coordinates that has edges larger than 50
gem_len_list=[]
for i in range(len(length_list_dup)):
    gem_len=(length_list_dup[i][0]+length_list_dup[i][1])/2
    gem_len_list.append([gem_len,length_list_dup[i][2]])
sorted(gem_len_list)

#the final output is a list that gives the average length of the edges of one set of coordinates
#and the corresponding coordinates for the inner vertex