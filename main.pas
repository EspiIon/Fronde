program main;


uses SDL2, SDL2_image,sysutils,affichage,interaction,movement,structure;

var sdlWindow1:PSDL_Window;//fenetre
    sdlRenderer:PSDL_Renderer;//rendu
    enCours:boolean;
    event: TSDL_Event;
    trajectory:Ttrajectory;

begin
sdlWindow1 := SDL_CreateWindow('Fenêtre SDL2',
                              SDL_WINDOWPOS_CENTERED,
                              SDL_WINDOWPOS_CENTERED,
                              1800, 800,
                              SDL_WINDOW_SHOWN);

sdlRenderer:= SDL_CreateRenderer(sdlWindow1, -1, SDL_RENDERER_ACCELERATED);
enCours := True;

while enCours do
  begin
    // Gestion de la fermeture de la fenêtre
    while SDL_PollEvent(@event) <> 0 do
        begin
          case event.type_ of

            SDL_MOUSEBUTTONDOWN:
            if event.button.button = SDL_BUTTON_LEFT then
                begin
                    trajectory.dragging:=True;
                    trajectory.POS0.x:=event.button.x;
                    trajectory.POS0.y:=event.button.y;
                end;

            SDL_MOUSEBUTTONUP:
            if event.button.button = SDL_BUTTON_LEFT then
                begin
                trajectory.dragging:=False;
                end;
            SDL_MOUSEMOTION:
              begin
                // Récupération des coordonnées de la souris
                trajectory.POS.x:= event.motion.x;
                trajectory.POS.y:= event.motion.y;
              end;
            SDL_QUITEV:
              enCours := False;
         end;
      end;
    writeln('nouveaux screen');
    
    // Effacer l'écran en noir
    

    CalculOfTrajectory(trajectory);
    affichageTrajectory(sdlRenderer,trajectory);
    // Mise à jour de l'affichage
    SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 0, 255);
    SDL_RenderPresent(sdlRenderer);
    sdl_delay(16);
    SDL_RenderClear(sdlRenderer);
  end;
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyWindow(sdlWindow1);
    SDL_Quit;
end.
    
