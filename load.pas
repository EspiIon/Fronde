unit load;

interface
uses SDL2,SDL2_image,structure;
procedure chargementSetting(var projectile:Tprojectile;var trajectory:Ttrajectory;var background:Tbackground;var sdlRenderer:PSDL_RENDERER);
procedure InitStructure(var construction:TabStructure; var sdlRenderer:PSDL_RENDERER);
implementation


procedure chargementSetting(var projectile:Tprojectile;var trajectory:Ttrajectory;var background:Tbackground;var sdlRenderer:PSDL_RENDERER);
var surface:PSDL_Surface;
begin
    //chargement des textures
    surface := IMG_Load('./assets/projectile.png');
    projectile.texture := SDL_CreateTextureFromSurface(sdlRenderer, surface);
    SDL_FreeSurface(surface);


    //taille
    projectile.destRect.w:=50;
    projectile.destRect.h:=50;
    projectile.destRect.x:=100;
    projectile.pos.x:=100;
    projectile.destRect.y:=600;
    projectile.pos.y:=600;
    projectile.actif:=true;
    trajectory.g:=9;
    projectile.t:=0;

    background.destRect.w:=1800;
    background.destRect.h:=800;
    
    surface := IMG_Load('./assets/background.png'); //on charge l'image dans une surface
    background.texture := SDL_CreateTextureFromSurface(sdlRenderer, surface); //on la transforme en texture
    end;

procedure InitStructure(var construction:TabStructure; var sdlRenderer:PSDL_RENDERER);
var i,j:integer;
    surface:PSDL_Surface;
begin
    for i:=1 to 20 do
        begin
            for j:=1 to 20 do
                begin
                    construction[i][j].destRect.w:=50; //dimensions et position
                    construction[i][j].destRect.h:=50;
                    construction[i][j].destRect.x:=1000 + i*50;
                    construction[i][j].destRect.y:=800-j*50;
                    construction[i][j].actif:=true;
                    construction[i][j].count:=0;
                    surface := IMG_Load('./assets/terre.png');
                    construction[i][j].texture:=SDL_CreateTextureFromSurface(sdlRenderer, surface);
                    SDL_FreeSurface(surface);

                end;
        end;
end;

//remise a zero du j
end.