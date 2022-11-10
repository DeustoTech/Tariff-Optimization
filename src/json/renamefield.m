function r = renamefield(r,old,new)
    r.(new) = r.(old);
    r = rmfield(r,old);
end