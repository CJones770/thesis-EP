%create table of P1, P2, and demographic variables

%P1 and P2 variables must be loaded using 

table_sw_PEBs = table;
Ep1s = zeros(num_subs,21,21);
Ep2s = zeros(num_subs,21,21);
for n=1:num_subs
    for x=1:21
        for y=1:21
            Ep1s(n,x,y) = P1{n,1}.Ep.A(x,y);
            Ep2s(n,x,y) = P2{n,1}.Ep.A(x,y);
        end
    end
end
table_sw_PEBs.Ep1s = Ep1s;
table_sw_PEBs.Ep2s = Ep2s;

sw_PEBs_with_demographics = horzcat(table_sw_PEBs, joinedTable(:,9:31));
