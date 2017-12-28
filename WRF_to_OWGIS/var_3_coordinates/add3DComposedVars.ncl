;start procedure add3DComposedVars
procedure add3DComposedVars(varNames, fin,fout, dim_time, dim_lat, dim_lon) begin
    ;start of variables cycle 
    ;;;;;;; Iterate over all the files and add each variable
    do varIdx =0,dimsizes(varNames)-1,1 ; This loop iterates over the variables
        print("Adding "+varNames(varIdx)+"...")

        ;valid if there are variable ws10
        ;;;;;;; ---------- For WS10 ----------
        if(varNames(varIdx) .eq. "WS10") then
            u10= fin->U10                   ;get variable in fin
            v10= fin->U10                   ;get variable in fin

            newVar = new( (/dim_time, dim_lat, dim_lon/),"float", 0);declare variable newVar
            newVar = sqrt(u10^2 + v10^2)*3.6 ;assing sqrt(u10^2 + v10^2)*3.6 to newVar 
            newVar@units = "km/hr";atributes
      
        end if

        ;valid if there are variable prec2
        ;;;;;;; ---------- For PREC2 ----------
        if(varNames(varIdx) .eq. "PREC2") then
            rainc= fin->RAINC               ;get variable in fin
            rainnc= fin->RAINNC             ;get variable in fin

            newVar = new( (/dim_time, dim_lat, dim_lon/),"float", 0);declare variable newVar
            newVar = rainc+rainnc         ;assing rainc+rainnc to newVar 
        end if

        ;valid if there are variable t2c
        ;;;;;;; ---------- For T2C ----------
        if(varNames(varIdx) .eq. "T2C") then
            t2= fin->T2                 ;get variable in fin
            newVar = new( (/dim_time, dim_lat, dim_lon/),"float", 0);declare variable newVar
            newVar = t2-273.15               ;assing t2-273.15 to newVar 
            newVar@units = "C";atributes
        end if
;****************************************************
        if(varNames(varIdx) .eq. "T2C_1") then
            ;t2= fin->T2                 ;get variable in fin
            newVar = new( (/dim_time, dim_lat, dim_lon/),"float", 0);declare variable newVar
            newVar@units = "C";atributes}
            
            do it=0, dim_time-1
              newVar(it,:,:)=-15.0000
            end do
        end if

        if(varNames(varIdx) .eq. "T2C_5") then
            ;t2= fin->T2                 ;get variable in fin
            newVar = new( (/dim_time, dim_lat, dim_lon/),"float", 0);declare variable newVar
            newVar@units = "C";atributes}
            
            do it=0, dim_time-1
              newVar(it,:,:)=-5.0000
            end do
        end if

        if(varNames(varIdx) .eq. "T2C_10") then
            ;t2= fin->T2                 ;get variable in fin
            newVar = new( (/dim_time, dim_lat, dim_lon/),"float", 0);declare variable newVar
            newVar@units = "C";atributes}
            
            do it=0, dim_time-1
               newVar(it,:,:)=0
            end do
        end if

        if(varNames(varIdx) .eq. "T2C_90") then
            ;t2= fin->T2                 ;get variable in fin
            newVar = new( (/dim_time, dim_lat, dim_lon/),"float", 0);declare variable newVar
            newVar@units = "C";atributes}
            
            do it=0, dim_time-1
               newVar(it,:,:)=20.0000
            end do
        end if
        if(varNames(varIdx) .eq. "T2C_95") then
            ;t2= fin->T2                 ;get variable in fin
            newVar = new( (/dim_time, dim_lat, dim_lon/),"float", 0);declare variable newVar
            newVar@units = "C";atributes}
            
            do it=0, dim_time-1
               newVar(it,:,:)=25.00000
            end do
        end if
        if(varNames(varIdx) .eq. "T2C_99") then
            ;t2= fin->T2                 ;get variable in fin
            newVar = new( (/dim_time, dim_lat, dim_lon/),"float", 0);declare variable newVar
            newVar@units = "C";atributes}
            
            do it=0, dim_time-1
               newVar(it,:,:)=30.0000
            end do
        end if
;****************************************************

        ;valid if there are variable sstc
        ;;;;;;; ---------- For SSTC----------
        if(varNames(varIdx) .eq. "SSTC") then
            sst= fin->SST             ;get variable in fin
            newVar = new( (/dim_time, dim_lat, dim_lon/),"float", 0);declare variable newVar
            newVar = sst-273.15                ;assing sst-273.15 to newVar 
            newVar@units = "C";atributes
        end if

        ;valid if there are variable prec2b
        ;;;;;;; ---------- For PREC2B----------
        if(varNames(varIdx) .eq. "PREC2B") then
            temp= fout->PREC2               ;get variable in fin
            newVar = new( (/dim_time, dim_lat, dim_lon/),"float", 0);declare variable newVar
            newVar = temp*1  ;assing temp*1 to newVar
        end if

        filevardef(fout, varNames(varIdx) ,typeof(newVar), (/"Time","Latitude","Longitude" /) ) ; time dimension
        filevarattdef(fout,varNames(varIdx),newVar); copy T attributes
        fout->$varNames(varIdx)$ = (/newVar/);add in file fout

        delete(newVar)
        print("Done!")
    end do
    ;end of variables cycle 
end
;end procedure add3DComposedVars