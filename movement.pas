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
                    trajectory.curvepoints[i+1].destRect.x:=-trajectory.powerx*i+ 100; //calcule de trajectoire (P2) avec i le temps
                    trajectory.curvepoints[i+1].destRect.y:=round(-trajectory.powery*i+(1/2)*trajectory.g*(i*i) + 600);
                end;
        end;
end;

procedure Velocity(var trajectory:Ttrajectory;var projectile:Tprojectile);
begin
    if projectile.Throw then
        begin
            projectile.velocity.y:=projectile.velocity.y + trajectory.g*projectile.t; //calcule de la vitesse
        end;
end;
procedure MouvementProjectile(var trajectory:Ttrajectory;var projectile:Tprojectile);
begin
    if projectile.Throw then
        begin
            projectile.pos.x:=projectile.pos.x + projectile.velocity.x*projectile.t;//calcule de la position avec la vitesse
            projectile.pos.y:=projectile.pos.y + projectile.velocity.y*projectile.t;

            projectile.t:=0.16; // on incremente le temps (16ms)
            projectile.destRect.x:=round(projectile.pos.x);//arrondir pour transformer en integer et l'appliqué a la position du projectile
            projectile.destRect.y:=round(projectile.pos.y);
        end;
end;

procedure power(var trajectory:Ttrajectory);
    begin
        trajectory.powerx:=round((trajectory.pos.x-trajectory.POS0.x)/2);//calcule de la puissance en x et y (difference de distance avec le point de depart)
        trajectory.powery:=round((trajectory.pos.y-trajectory.POS0.y)/2);
    end;

end.
