unit movement;


interface
uses SDL2, SDL2_image,structure,SysUtils,interaction;

procedure CalculOfTrajectory(var trajectory:Ttrajectory);
procedure power(var trajectory:Ttrajectory);

implementation

procedure CalculOfTrajectory(var trajectory:Ttrajectory);
var i,g:integer;
begin
    if trajectory.dragging then
        begin
            g:=9;
            power(trajectory);
            for i:=0 to 9 do
                begin
                    trajectory.curvepoints[i+1].destRect.x:=-trajectory.powerx*i+ 100;
                    trajectory.curvepoints[i+1].destRect.y:=round(-trajectory.powery*i+(1/2)*g*(i*i) + 600);
                    writeln('calcul i: ',i);
                end;
        end;
end;

procedure power(var trajectory:Ttrajectory);
    begin
        trajectory.powerx:=round((trajectory.pos.x-trajectory.POS0.x)/2);
        trajectory.powery:=round((trajectory.pos.y-trajectory.POS0.y)/2);
    end;

end.