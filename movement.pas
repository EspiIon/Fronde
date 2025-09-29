unit movement;


interface
uses SDL2, SDL2_image,structure,SysUtils,interaction;

procedure CalculOfTrajectory(var trajectory:Ttrajectory);
procedure power(var trajectory:Ttrajectory);
procedure MouvementProjectile(var trajectory:Ttrajectory;var projectile:Tprojectile);
procedure Velocity(var trajectory:Ttrajectory;var projectile:Tprojectile);

implementation

procedure CalculOfTrajectory(var trajectory:Ttrajectory);
var i:integer;
begin
    if trajectory.dragging then
        begin
            
            power(trajectory);
            for i:=0 to 9 do
                begin
                    trajectory.curvepoints[i+1].destRect.x:=-trajectory.powerx*i+ 100;
                    trajectory.curvepoints[i+1].destRect.y:=round(-trajectory.powery*i+(1/2)*trajectory.g*(i*i) + 600);
                end;
        end;
end;

procedure Velocity(var trajectory:Ttrajectory;var projectile:Tprojectile);
begin
    if projectile.Throw then
        begin
            projectile.velocity.y:=projectile.velocity.y + trajectory.g*projectile.t;
        end;
end;
procedure MouvementProjectile(var trajectory:Ttrajectory;var projectile:Tprojectile);
begin
    if projectile.Throw then
        begin
            projectile.pos.x:=projectile.pos.x + projectile.velocity.x*projectile.t;
            projectile.pos.y:=projectile.pos.y + projectile.velocity.y*projectile.t;

            projectile.t:=0.16;
            projectile.destRect.x:=round(projectile.pos.x);
            projectile.destRect.y:=round(projectile.pos.y);
        end;
end;

procedure power(var trajectory:Ttrajectory);
    begin
        trajectory.powerx:=round((trajectory.pos.x-trajectory.POS0.x)/2);
        trajectory.powery:=round((trajectory.pos.y-trajectory.POS0.y)/2);
    end;

end.
