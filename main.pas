program main;


uses SDL2, SDL2_image,sysutils,affichage,interaction,movement,structure,load;

var sdlWindow1:PSDL_Window;//fenetre
    sdlRenderer:PSDL_Renderer;//rendu
    enCours:boolean;
    event: TSDL_Event;
    trajectory:Ttrajectory;
    projectile:Tprojectile;
    background:Tbackground;

begin
sdlWindow1 := SDL_CreateWindow('Fenêtre SDL2',
                              SDL_WINDOWPOS_CENTERED,
                              SDL_WINDOWPOS_CENTERED,
                              1800, 800,
                              SDL_WINDOW_SHOWN);

sdlRenderer:= SDL_CreateRenderer(sdlWindow1, -1, SDL_RENDERER_ACCELERATED);
enCours := True;
chargementSetting(projectile,trajectory,background,sdlRenderer);

while enCours do
  begin
    // Gestion de la fermeture de la fenêtre
    while SDL_PollEvent(@event) <> 0 do
        begin
          case event.type_ of

            SDL_MOUSEBUTTONDOWN:
            if event.button.button = SDL_BUTTON_LEFT then
                begin
                    projectile.Throw:=False;
                    trajectory.dragging:=True;
                    trajectory.POS0.x:=event.button.x;
                    trajectory.POS0.y:=event.button.y;
                end;

            SDL_MOUSEBUTTONUP:
            if event.button.button = SDL_BUTTON_LEFT then
                begin
                trajectory.dragging:=False;
                projectile.Throw:=True;
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
    
    // Effacer l'écran en noir
    
    
    if projectile.pos.y>800 then
      begin
        projectile.Throw:=False;
      end;
    if not projectile.Throw then
      begin
        projectile.t:=0;
        projectile.pos.x:=100;
        projectile.pos.y:=600;
        projectile.destRect.x:=round(projectile.pos.x);
        projectile.destRect.y:=round(projectile.pos.y);
      end;
    
    MouvementProjectile(trajectory,projectile);
    CalculOfTrajectory(trajectory);
    //affichage
    affichageBackground(sdlRenderer,background);
    affichageTrajectory(sdlRenderer,trajectory);
    affichageProjectile(sdlRenderer,projectile);
    

    SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 0, 255);
    SDL_RenderPresent(sdlRenderer);
    sdl_delay(16);
    SDL_RenderClear(sdlRenderer);
  end;
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyWindow(sdlWindow1);
    SDL_Quit; 
end.
    
