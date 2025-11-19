unit hitbox;

interface
uses SDL2, SDL2_image,structure,tools;


procedure collisionConstruction(var construction:TabStructure;var projectile:Tprojectile);
procedure updatecounter(var construction:TabStructure);
procedure destructionStructure(var construction:TabStructure);
procedure hitboxStructure(var construction:TabStructure);


implementation

procedure collisionConstruction(var construction:TabStructure;var projectile:Tprojectile);

var i,j:integer;
    bottom,right,left:TSDL_Rect;
    ox,oy:integer;
begin
    for i:=1 to MAX_X do
        begin
            for j:=1 to MAX_Y do
                begin
                    if (construction[i][j].actif) then
                        begin
                            bottom.x:=projectile.destRect.x+4;
                            bottom.y:=projectile.destRect.y+projectile.destRect.h-2;
                            bottom.w:=projectile.destRect.w-2;
                            bottom.h:=2;
                            
                            left.x:=projectile.destRect.x+1;
                            left.y:=projectile.destRect.y+4;
                            left.w:=2;
                            left.h:=projectile.destRect.h-8;

                            right.x:=projectile.destRect.x+projectile.destRect.w-3;
                            right.y:=projectile.destRect.y+4;
                            right.w:=2;
                            right.h:=projectile.destRect.h-8;

                            if SDL_HasIntersection(@projectile.destRect,@construction[i][j].destRect) then
                                begin
                                        projectile.colliding:=True;
                                        collisionProjectile_Structure(projectile,construction[i][j]);
                                end;



                            
                        end;
                end;
        end;
end;

procedure hitboxStructure(var construction:TabStructure);
var i,j,k,l,ox, oy:integer;
    bottom,right,left:TSDL_Rect;
    StopFalling:boolean;
begin
for i:=1 to MAX_X do
    begin
        for j:=2 to MAX_Y do
            begin
                if construction[i][j].actif then
                    begin
                        for k:=1 to MAX_X do
                            begin
                                for l:=1 to MAX_Y do
                                begin
                                    if construction[k][l].actif and ((i<>k) or (j<>l)) then
                                        begin
                                            bottom.x:=construction[i][j].destRect.x;
                                            bottom.y:=construction[i][j].destRect.y+construction[i][j].destRect.h;
                                            bottom.w:=construction[i][j].destRect.w;
                                            bottom.h:=2;
                                            
                                            left.x:=construction[i][j].destRect.x;
                                            left.y:=construction[i][j].destRect.y;
                                            left.w:=2;
                                            left.h:=construction[i][j].destRect.h;

                                            right.x:=construction[i][j].destRect.x+construction[i][j].destRect.w;
                                            right.y:=construction[i][j].destRect.y;
                                            right.w:=2;
                                            right.h:=construction[i][j].destRect.h;
                                            
                                            // if SDL_HasIntersection(@construction[i][j].destRect,@construction[k][l].destRect) then
                                            //     begin
                                            //             collisionStructure_Structure(construction[i][j],construction[k][l]);
                                            //     end;

                                            if SDL_HasIntersection(@bottom,@construction[k][l].destRect) then
                                                begin  
                                                    construction[i][j].falling:=False;
                                                    if construction[i][j].components.velocity.y>0 then
														collisionStructure_Structure(construction[i][j],construction[k][l]);
                                                end;
                                            if SDL_HasIntersection(@right,@construction[k][l].destRect) then
                                                begin
													if construction[i][j].components.velocity.x>0 then
														collisionStructure_Structure(construction[i][j],construction[k][l]);
                                                end;

                                            if SDL_HasIntersection(@left,@construction[k][l].destRect) then
                                                begin
													if construction[i][j].components.velocity.x<0 then
														collisionStructure_Structure(construction[i][j],construction[k][l]);
                                                end;
                                            
                                        end;
                                end;
                            end;
                        
                    end;
            end;
    end;
end;



procedure destructionStructure(var construction:TabStructure);
var i,j:integer;
begin
for i:= 1 to MAX_X do
	begin
		for j:= 2 to MAX_Y do
			begin
				if construction[i][j].life <=0 then
                    writeln('destruction');
			end;
	end;
	
end;

procedure updatecounter(var construction:TabStructure);
var i,j:integer;
begin
    for i:=1 to MAX_X do
        begin
            for j:=1 to MAX_Y do
                begin
                    if construction[i][j].count>0 then
                        begin
                            construction[i][j].count:=construction[i][j].count-1;
                        end;
                end;
        end;
end;
end.
