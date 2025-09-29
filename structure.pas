unit structure;

interface
uses SDL2;//on utilise la librairie SDL2

type coord = 
    record
    x,y:real;
    end;

type Tcurvepoint = 
    record
    destRect:TSDL_Rect;//rectangle de destination
    pos:coord;
    end;

type tabRenduPosition = array[1..20] of Tcurvepoint;
type Ttrajectory = 
    record
    pos,POS0:coord;
    powerx,powery,velocity:integer;
    curvepoints:tabRenduPosition;
    dragging:boolean;
    g:real;
    end;

type Tprojectile =
    record
    destRect:TSDL_Rect;//rectangle de destination
    texture:PSDL_Texture;
    actif,Throw:boolean;
    pos,vitesse:coord;
    t:real;
    end;

//type background
type Tbackground =
    record
    destRect:TSDL_Rect;//rectangle de destination
    texture:PSDL_Texture;//texture
    end;
    
implementation
end.
