unit load;

interface
uses SDL2,SDL2_image,structure;

CONST MAX_X = 20;
CONST MAX_Y = 20;

procedure chargementSetting(var projectile:Tprojectile;var trajectory:Ttrajectory;var background:Tbackground;var sdlRenderer:PSDL_RENDERER);
procedure InitStructure(var construction:TabStructure; var sdlRenderer:PSDL_RENDERER);
procedure chargementniveau(var construction:TabStructure);

implementation


procedure chargementSetting(var projectile:Tprojectile;var trajectory:Ttrajectory;var background:Tbackground;var sdlRenderer:PSDL_RENDERER);
var surface:PSDL_Surface;
begin
    //chargement des textures
    surface := IMG_Load('./assets/projectile.png');
    projectile.texture := SDL_CreateTextureFromSurface(sdlRenderer, surface);
    SDL_FreeSurface(surface);


    //taille
    projectile.destRect.w:=20;
    projectile.destRect.h:=20;
    projectile.destRect.x:=100;
    projectile.t:=0.16;
    projectile.destRect.y:=600;
    projectile.pos.x:=100-round(0.5*projectile.destRect.w);
    projectile.POS0.x:=100;
    projectile.POS0.y:=600;
    projectile.pos.y:=600-round(0.5*projectile.destRect.h);
    projectile.actif:=true;
    trajectory.g:=9;
    projectile.t:=0;
    projectile.components.masse:=1;
    background.destRect.w:=1800;
    background.destRect.h:=800;
    
    surface := IMG_Load('./assets/background.png');
    background.texture := SDL_CreateTextureFromSurface(sdlRenderer, surface);
    end;

procedure InitStructure(var construction:TabStructure; var sdlRenderer:PSDL_RENDERER);
var i,j:integer;
    surface:PSDL_Surface;
begin
    for i:=1 to 20 do
        begin
            for j:=1 to 20 do
                begin
                    if j=1 then
                        construction[i][j].components.masse:=1000
                    else
                        construction[i][j].components.masse:=2;

                    construction[i][j].destRect.w:=50;
                    construction[i][j].destRect.h:=50;
                    construction[i][j].destRect.x:=1000 + i*construction[i][j].destRect.w;
                    construction[i][j].destRect.y:=800-j*construction[i][j].destRect.h;
                    if construction[i][j].id =0 then
						begin
							surface := IMG_Load('./assets/terre.png');
							construction[i][j].life:=10000;
						end
					else
						begin
						surface := IMG_Load('./assets/slime.png');
						construction[i][j].life:=70;
						end;
                    construction[i][j].texture:=SDL_CreateTextureFromSurface(sdlRenderer, surface);
                    SDL_FreeSurface(surface);
                end;
        end;
end;
procedure chargementniveau(var construction:TabStructure);
var i,j:integer;
	begin
	for i:=1 to 20 do
        begin
            for j:=1 to 20 do
                begin
					if (j=1) or ((i=3) and (j<7))or ((i=10) and (j<5)) then
					begin
						construction[i][j].actif:=true;
						construction[i][j].id:=0;
                    end;
                    if ((i=3) and (j=7)) or ((i=10) and (j=5)) then
					begin
						construction[i][j].actif:=true;
						construction[i][j].id:=1;
                    end;
                end;
        end;
	end;
	
// procedure creerniveau(var construction : TabStructure);
// var fichier : file of TabStructure;
// 	i, j : Integer;
// begin
// 	assign(fichier, 'niveaux');
// 	rewrite(fichier);
	
// 	for i:=1 to MAX_X do
// 		begin
// 			for j:=1 to MAX_Y do
// 				begin
// 					if (j=1) or ((i=3) and (j<7))or ((i=10) and (j<5)) then
// 					begin
// 						construction[i][j].actif:=true;
// 						construction[i][j].id:=0;
// 					end;
// 					if ((i=3) and (j=7)) or ((i=10) and (j=5)) then
// 					begin
// 						construction[i][j].actif:=true;
// 						construction[i][j].id:=1;
// 					end;
// 				end;
// 		end;
	
// 	writeln(fichier, construction);
	
// 	{ecrire niv 2 et niv 3}
// 	close(fichier);
// end;

// procedure chargerniveau(var niv : Integer, var construction : TabStructure); {niv = num niveau a charger}
// var fichier : file of TabStructure
// 	i, j : Integer;
// begin
// 	assign(fichier, 'niveaux');
// 	resert(fichier);
	
// 	for i:= 1 to niv do
// 		read(fichier, construction);
	
// 	close(fichier);
// end;

//remise a zero du j
end.
