unit movement;


interface
uses SDL2, SDL2_image,structure,SysUtils,interaction,Math,tools;

procedure CalculOfTrajectory(var trajectory:Ttrajectory;projectile:Tprojectile);
procedure power(var trajectory:Ttrajectory);
procedure MouvementProjectile(var trajectory:Ttrajectory;var projectile:Tprojectile);
procedure Velocity(var trajectory:Ttrajectory;var projectile:Tprojectile);
procedure ProjectileValide(var projectile:Tprojectile;trajectory:Ttrajectory);
procedure MovementConstructions(var construction:TabStructure);
procedure ConstructionFalling(var construction:TabStructure);
procedure velocityConstructions(var construction:TabStructure);

implementation

procedure CalculOfTrajectory(var trajectory:Ttrajectory;projectile:Tprojectile);
var i:integer;
    t:real;
begin
    if trajectory.dragging then
        begin
            power(trajectory);
            for i:=1 to POINTCURVE do
                begin
                    t:=i/3;
                    trajectory.curvepoints[i].destRect.x:=-round(trajectory.powerx*t)+round(projectile.POS0.x);
                    trajectory.curvepoints[i].destRect.y:=round(-trajectory.powery*t+(1/2)*trajectory.g*sqr(t) + projectile.POS0.y);
                end;
        end;
end;

procedure MovementConstructions(var construction:TabStructure);
var i,j:integer;
begin
for i:=1 to MAX_X do
    begin
        for j:=2 to MAX_Y do
            begin
                if construction[i][j].actif and  construction[i][j].falling then
                    begin
                        construction[i][j].destRect.y:= round(construction[i][j].destRect.y + construction[i][j].components.velocity.y*0.16);
                    end;
                construction[i][j].destRect.x:= round(construction[i][j].destRect.x + construction[i][j].components.velocity.x*0.16);
            end;
    end;
end;

procedure velocityConstructions(var construction:TabStructure);
var i,j,g:integer;
	lambda:real;
begin
g:=16;
lambda:=0.3;
for i:=1 to MAX_X do
    begin
        for j:=2 to MAX_Y do
            begin
                if construction[i][j].actif and  construction[i][j].falling then
                    begin
                        construction[i][j].components.velocity.y:= construction[i][j].components.velocity.y + g*0.16;
                    end;
                construction[i][j].components.velocity.x:= construction[i][j].components.velocity.x - construction[i][j].components.velocity.x*lambda*0.16;
            end;
    end;
end;

procedure Velocity(var trajectory:Ttrajectory;var projectile:Tprojectile);
begin
    if projectile.Throw and projectile.falling then
        begin
            projectile.components.velocity.y:=projectile.components.velocity.y + trajectory.g*projectile.t;
        end;
end;

procedure MouvementProjectile(var trajectory:Ttrajectory;var projectile:Tprojectile);
begin
    if projectile.Throw then
        begin
			projectile.t:=0.16;
            projectile.pos.x:=projectile.pos.x + projectile.components.velocity.x*projectile.t;
            projectile.pos.y:=projectile.pos.y + projectile.components.velocity.y*projectile.t;

            projectile.destRect.x:=round(projectile.pos.x);
            projectile.destRect.y:=round(projectile.pos.y);
            
            
         end;
end;

procedure power(var trajectory:Ttrajectory);
var power,alpha:real;
    begin
        power:=sqrt(sqr((trajectory.POS0.y-trajectory.pos.y)/2) + sqr((trajectory.pos.x-trajectory.POS0.x)/2));
        if (power)<>0 then
        begin
            alpha:= arcsin(0.5*(trajectory.POS0.y-trajectory.pos.y)/(power));
        end;
        power:=Min(power/2,120);
        trajectory.powerx:=-round(power*cos(alpha));
        trajectory.powery:=-round(power*sin(alpha)); 
    end;

procedure ConstructionFalling(var construction:TabStructure);
var i,j:integer;
begin
    for i:=1 to MAX_X do
        begin
            for j:=2 to MAX_Y do
                begin
                    construction[i][j].falling:=True;
                end;
        end;
end;

procedure ProjectileValide(var projectile:Tprojectile;trajectory:Ttrajectory);
begin
	if projectile.pos.y>800 then
		  begin
			projectile.Throw:=False;
		  end;
		if not projectile.Throw then
		  begin
			projectile.t:=0;
			projectile.components.velocity.x:=-trajectory.powerx;
			projectile.components.velocity.y:=-trajectory.powery;
			projectile.pos.x:=100;
			projectile.pos.y:=600;
			projectile.destRect.x:=round(projectile.pos.x);
			projectile.destRect.y:=round(projectile.pos.y);
		  end;
end;
end.
