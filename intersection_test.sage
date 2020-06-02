def intersection_test(p_1,p_2,q_1,q_2):
    r"""
    returns a value True or False indicating whether the line segments defined by the points intersect

    INPUT:

    - ''p_1'' - a vector indicating the source point of the first line segment

    - ''p_2'' - a vector indicating the end point of the first line segment

    - ''q_1'' - a vector indicating the source point of the second line segment

    - ''q_2'' - a vector indicating the end point of the second line segment

    OUTPUT:

    - a value True or False, depending on whether the line segments intersect

    EXAMPLES:
        sage: intersection_test(vector([1,1]),vector([4,4]),vector([3,0]),vector([1,4]))
        True
        sage: intersection_test(vector([1,0]),vector([3,3]),vector([5,2]),vector([3,5]))
        False
    """
    
    value=False
    #computing r
    r=zero_vector(RR,2)
    r[0]=p_2[0]-p_1[0]
    r[1]=p_2[1]-p_1[1]

    #computing s
    s=zero_vector(RR,2)
    s[0]=q_2[0]-q_1[0]
    s[1]=q_2[1]-q_1[1]

    r_x_s=r[0]*s[1]-r[1]*s[0]
    if r_x_s!=0:
        q_min_p=q_1-p_1
        q_min_p_x_s=q_min_p[0]*s[1]-q_min_p[1]*s[0]
        t=q_min_p_x_s/r_x_s

        q_min_p_x_r=q_min_p[0]*r[1]-q_min_p[1]*r[0]
        u=q_min_p_x_r/r_x_s

        if 0<=t<1 and 0<=u<=1:
            value=True

    return value