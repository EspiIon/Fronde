unit structure;

interface
uses SDL2, SDL2_image;//on utilise la librairie SDL2


CONST MAX_X=20;
CONST MAX_Y=20;
CONST POINTCURVE=20;
type coord = 
    record
    x,y:real;
    end;
type Tcomponents = 
    record
    velocity,r,n:coord;
    masse:real;
    end;
type Tcurvepoint = 
    record
    destRect:TSDL_Rect;//rectangle de destination
    end;

type tabRenduPosition = array[1..POINTCURVE] of Tcurvepoint;
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
    actif,falling,Throw,colliding:boolean;
    pos,POS0:coord;
    components:Tcomponents;
    t:real;
    end;
    
type TStructure =
    record
    destRect:TSDL_Rect;
    actif,falling:boolean;
    texture:PSDL_Texture;
    count:integer;
    id,life:integer;//1x2, 2x1 type de bloc :integer;//1x2, 2x1 type de bloc
    components:Tcomponents;
end;
    


type TabStructure = array[1..MAX_X] of array[1..MAX_Y] of TStructure;


//type background
type Tbackground =
    record
    destRect:TSDL_Rect;//rectangle de destination
    texture:PSDL_Texture;//texture
    end;

type TBouton =
	record 
	bouton : TSDL_RECT;
	texture : PSDL_TEXTURE;
	actif : Boolean
end;
implementation
end.
