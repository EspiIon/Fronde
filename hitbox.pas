unit hitbox;

interface
uses SDL2, SDL2_image,structure;


procedure collisionConstruction(var construction:TabStructure;var projectile:Tprojectile);
procedure cascadeConstruction(var construction:TabStructure);
procedure updatecounter(var construction:TabStructure);

implementation

procedure collisionConstruction(var construction:TabStructure;var projectile:Tprojectile);

var i,j:integer;
begin
    for i:=1 to 20 do
        begin
            for j:=1 to 20 do//on parcours le tableau
                begin
                    if construction[i][j].actif then//si la structure est active
                        begin
                            if SDL_HasIntersection(@projectile.destRect,@construction[i][j].destRect) then//on regarde si elle touche le projectile
                                begin
                                    if j<>1 then
                                        begin
                                            construction[i][j].actif:=false;//on la desactive
                                        end;
                                    projectile.velocity.x:=0.8*projectile.velocity.y;
                                    projectile.velocity.y:=0.8*projectile.velocity.x;//on modifie la vitesse du projectile
                                end;
                        end;
                end;
        end;
end;


procedure cascadeConstruction(var construction:TabStructure);
var i,j:integer;
begin
    for i:=1 to 20 do
        begin
            for j:=2 to 20 do
                begin
                    if not construction[i][j-1].actif and construction[i][j].actif then// si la structure est active est que la structure en dessous n'es pas active
                        begin
                            if construction[i][j-1].count=0 then //timer pour ne pas supprimer instantanément
                                begin
                                    construction[i][j].actif:=false;
                                    construction[i][j].count:=10;
                                end;
                        end;
                end;
        end;
end;

procedure updatecounter(var construction:TabStructure);//pour faire fonctionner le timer, a chaque tour on enleve 1
var i,j:integer;
begin
    for i:=1 to 20 do
        begin
            for j:=1 to 20 do
                begin
                    if construction[i][j].count>0 then
                        begin
                            construction[i][j].count:=construction[i][j].count-1;
                        end;
                end;
        end;
end;
end.