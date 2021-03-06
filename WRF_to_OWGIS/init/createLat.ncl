;start fuction addLat
function addLat(fin,fout) begin
    ; Adding latitude variable
    XLAT = fin->XLAT;get variable in fin
    temp = dimsizes(XLAT)
    dim_lat = temp(1)
    lat = new(dim_lat,float)
    lat = XLAT(0,:,0)
    delete_VarAtts(lat,-1)
    lat@standard_name = "latitude";atributes
    lat@long_name= "Latitude";atributes
    lat@units = "degrees_north";atributes
    filedimdef(fout, (/"Latitude"/), dim_lat , (/ False /))
    filevardef(fout, "Latitude" ,typeof(lat),"Latitude") ; lat dimension
    filevarattdef(fout,"Latitude",lat)                  ; copy latitude attributes
    fout->Latitude  = (/lat/);add in file fout
    return dim_lat
end
;end fuction addLat
