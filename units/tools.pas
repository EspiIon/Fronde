unit tools;

interface
uses SDL2,structure,Math;

function CalculNorme(x,y:real):real;
procedure updateLife(var life:integer;velocity:coord);
procedure collisionStructure_Structure(var construction1,construction2:TStructure);
procedure collisionProjectile_Structure(var projectile:Tprojectile;var construction:TStructure);
function Overlap(A, B: TSDL_Rect; var ox, oy: Integer):Boolean;
procedure Resolve(var A, B: TSDL_Rect;var A_components:Tcomponents; ox, oy: Integer);

implementation

function CalculNorme(x,y:real):real;
begin
CalculNorme:= sqrt(sqr(x)+sqr(y));
end;

procedure updateLife(var life:integer;velocity:coord);
begin
if round(CalculNorme(velocity.x,velocity.y)) >10 then
	life:=life-round(CalculNorme(velocity.x,velocity.y));
	

end;


procedure absorbtionCollision(var components1,components2:Tcomponents);
var components1_temp:Tcomponents;
CONST e=0.7;
begin
	if components2.masse>500 then
		begin
			components1.velocity.x:=-e*components1.velocity.x;
			components1.velocity.y:=-e*components1.velocity.y;
		end
	else if components2.masse= components1.masse then
		begin
			components1_temp:=components1;
			components1:=components2;
		end
	else
		begin
			components1_temp.velocity.x:=components1.velocity.x;
			components1_temp.velocity.y:=components1.velocity.y;

			components1.velocity.x:=e*((components1.masse-components2.masse)*components1.velocity.x+2*components2.masse*components2.velocity.x)/(components2.masse+components1.masse);
			components1.velocity.y:=e*((components1.masse-components2.masse)*components1.velocity.y+2*components2.masse*components2.velocity.y)/(components2.masse+components1.masse);

			components2.velocity.x:=e*((components2.masse-components1.masse)*components2.velocity.x+2*components1.masse*components1_temp.velocity.x)/(components1.masse+components2.masse);
					
		end;
			// writeln(components1.velocity.x,' ',components1.velocity.y);
end;
//SAT (Separating Axis Theorem)
function Overlap(A, B: TSDL_Rect; var ox, oy: Integer):Boolean;
begin
  ox := Min(A.x + A.w+1, B.x + B.w) - Max(A.x, B.x);
  oy := Min(A.y + A.h+1, B.y + B.h) - Max(A.y, B.y);
  Overlap := (ox > 0) and (oy > 0);
end;

procedure Resolve(var A, B: TSDL_Rect;var A_components:Tcomponents; ox, oy: Integer);
begin
  if ox < oy then
  begin
    // Collision horizontale
    if A_components.velocity.x > 0 then
      A.x:=A.x-ox
    else
      A.x :=A.x+ox;

  end
  else
  begin
    // Collision verticale
    if A_components.velocity.y > 0 then
      A.y :=A.y- oy
    else
      A.y :=A.y+ oy;
	
  end;
end;

procedure collisionProjectile_Structure(var projectile:Tprojectile;var construction:TStructure);
var ox,oy:integer;
begin
	if Overlap(projectile.destRect, construction.destRect, ox, oy) then
		Resolve(projectile.destrect, construction.destRect,projectile.components,ox, oy);

	//updateLife(construction.life,projectile.components.velocity);

	absorbtionCollision(projectile.components,construction.components);
end;

procedure collisionStructure_Structure(var construction1,construction2:TStructure);
var ox,oy:integer;
begin
	if Overlap(construction1.destRect, construction2.destRect, ox, oy) then
    	Resolve(construction1.destrect, construction2.destRect,construction1.components,ox, oy);
	//vie
	//updateLife(construction1.life,construction1.components.velocity);
	//updateLife(construction2.life,construction1.components.velocity);
	
	//vitesse
	absorbtionCollision(construction1.components,construction2.components);
end;

procedure creationHitbox();
begin
end;
end.
