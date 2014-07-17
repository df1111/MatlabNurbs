% Basis.m
% Description: Generates the basis functions used for Nurbs curve
% construction.
% Inputs:
% ppoint (u,v)    - paramaterized surface variable.
% knot (S,T)      - knot vector
% order (k,l)     - order of spline curve*
% maxindex (m,n)  - maximum index in meshgrid
% Outputs:
% N               - Matrix with all spline values calculated
% *Note: Order refers to 0...(k/l) wheras degree refers to 1...(k/l)-1.
function N = Basis(ppoint,knot,order,index)
% Initailize empty matrix:
% Fill matrix with all first order splines:
for i=1:numel(knot)-1
    if (knot(i)<=ppoint) && (ppoint<knot(i+1))
        N(i,1) = 1;
    else
        N(i,1) = 0;
    end
end
N
% Fill all higher order splines:
for i=1:index-1
    for k=2:order
        temp1 = ( ppoint - knot(i) );
        temp2 = ( knot(i+k-1) );
        if temp1 == 0 && temp2 == 0;
            temp3 = 0;
        else
            temp3 = ( temp1 / temp2 ) * N(i,k-1);
        end
        temp4 = ( knot(i+k) - ppoint ); 
        temp5 = ( knot(i+k)- knot(i+1) );
        if temp4 == 0 && temp5 == 0
            temp6 = 0;
        else
            temp6 = ( temp4 / temp5 ) * N(i+1,k-1);
        end
        N(i,k) = double(temp3) + double(temp6);
    end
end
N_order = N(:,order);