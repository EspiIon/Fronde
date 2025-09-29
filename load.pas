unit load;

interface
uses SDL2,SDL2_image,structure;
procedure chargementSetting(var projectile:Tprojectile;var trajectory:Ttrajectory;var background:Tbackground;var sdlRenderer:PSDL_RENDERER);
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
    
    surface := IMG_Load('./assets/background.png');
    background.texture := SDL_CreateTextureFromSurface(sdlRenderer, surface);
    end;

//remise a zero du j
end.