unit affichage;


interface
uses SDL2, SDL2_image,SDL2_gfx,structure,SysUtils;

procedure affichageTrajectory(var sdlRenderer:PSDL_Renderer;trajectory:Ttrajectory);
procedure affichageProjectile(var sdlRenderer:PSDL_Renderer;projectile:Tprojectile);
procedure affichageBackground(var sdlRenderer:PSDL_Renderer;background:Tbackground);
procedure affichageStructure(var sdlRenderer:PSDL_Renderer;structure:TabStructure);

implementation

procedure affichageTrajectory(var sdlRenderer:PSDL_Renderer;trajectory:Ttrajectory);
var i:integer;
begin
if trajectory.dragging then
    begin
        for i:=1 to POINTCURVE do
                begin
                    trajectory.curvepoints[i].destRect.w:=10;
                    trajectory.curvepoints[i].destRect.h:=10;
                    SDL_SetRenderDrawColor(sdlRenderer, 255, 255, 255, 255);
                    SDL_RenderFillRect(sdlRenderer, @trajectory.curvepoints[i].destRect );
                end;
        end;
    end;

procedure affichageProjectile(var sdlRenderer:PSDL_Renderer;projectile:Tprojectile);
begin
    if projectile.actif then
    begin
    SDL_RenderCopy(sdlRenderer, projectile.texture, nil, @projectile.destRect);
    end;
end;
procedure affichageBackground(var sdlRenderer:PSDL_Renderer;background:Tbackground);
begin
    SDL_RenderCopy(sdlRenderer, background.texture, nil, @background.destRect)
end;

procedure affichageStructure(var sdlRenderer:PSDL_Renderer;structure:TabStructure);
var
  i, j: Integer;
begin
    for i := 1 to MAX_X do
        begin
            for j := 1 to MAX_Y do
            begin
                if structure[i, j].actif then
                    begin
                        SDL_RenderCopy(sdlRenderer, structure[i, j].texture, nil, @structure[i, j].destRect);
                    end;
            end;
        end;
end;

end.
