unit interaction;


interface
uses SDL2, SDL2_image,structure,SysUtils,Math;

procedure drag(var trajectory:Ttrajectory;event: TSDL_Event);

implementation

procedure drag(var trajectory:Ttrajectory;event: TSDL_Event);
begin
        trajectory.pos.x:=event.button.x;
        trajectory.pos.y:=event.button.y;
end;
end.