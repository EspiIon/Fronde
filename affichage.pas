unit affichage;


interface
uses SDL2, SDL2_image,SDL2_gfx,structure,SysUtils;

procedure affichageTrajectory(var sdlRenderer:PSDL_Renderer;trajectory:Ttrajectory);

implementation

procedure affichageTrajectory(var sdlRenderer:PSDL_Renderer;trajectory:Ttrajectory);
var i:integer;
    cross:TSDL_Rect;
begin
if trajectory.dragging then
    begin
        writeln('dessin!');
        // cross.x:=trajectory.POS0.x;
        // cross.y:=trajectory.POS0.y;
        // cross.w:=100;
        // cross.h:=100;
        // SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 55, 255);
        // SDL_RenderFillRect(sdlRenderer, @cross);
        for i:=1 to 10 do
                begin
                    trajectory.curvepoints[i].destRect.w:=10;
                    trajectory.curvepoints[i].destRect.h:=10;
                    SDL_SetRenderDrawColor(sdlRenderer, 255, 255, 255, 255);
                    SDL_RenderFillRect(sdlRenderer, @trajectory.curvepoints[i].destRect );
                    writeln('i: ',i,' ',trajectory.curvepoints[i].destRect.h);
                end;
        end;
    end;
end.