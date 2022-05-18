clear 

p_P6 = params_P6;

r = jsonencode(struct(p_P6))

fileID = fopen('data/input.json','w');

fwrite(fileID,r)
fclose(fileID);

%%

p_P2 = params_P2;

r = jsonencode(struct(p_P2))

fileID = fopen('data/input_P2.json','w');

fwrite(fileID,r);
fclose(fileID);

