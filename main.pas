program main;


uses SDL2, SDL2_image,sysutils,affichage,interaction,movement,structure,load,hitbox;


//variable utilisé
var sdlWindow1:PSDL_Window;//fenetre
    sdlRenderer:PSDL_Renderer;//rendu
    enCours:boolean;
    event: TSDL_Event;
    trajectory:Ttrajectory;
    projectile:Tprojectile;
    background:Tbackground;
    construction:TabStructure;


begin

sdlWindow1 := SDL_CreateWindow('Fenêtre SDL2',
                              SDL_WINDOWPOS_CENTERED,
                              SDL_WINDOWPOS_CENTERED,
                              1800, 800,
                              SDL_WINDOW_SHOWN);

sdlRenderer:= SDL_CreateRenderer(sdlWindow1, -1, SDL_RENDERER_ACCELERATED);
enCours := True;
chargementSetting(projectile,trajectory,background,sdlRenderer);
InitStructure(construction,sdlRenderer);


while enCours do//boucle de jeu
  begin
    // Gestion de la fermeture de la fenêtre
    while SDL_PollEvent(@event) <> 0 do //evenement (souris clavier)
        begin
          case event.type_ of

            SDL_MOUSEBUTTONDOWN:
            if event.button.button = SDL_BUTTON_LEFT then //au clique gauche
                begin
                    projectile.Throw:=False; //projetile en position de depart
                    trajectory.dragging:=True;
                    trajectory.POS0.x:=event.button.x;//position de la souris recuperé
                    trajectory.POS0.y:=event.button.y;
                end;

            SDL_MOUSEBUTTONUP:
            if event.button.button = SDL_BUTTON_LEFT then //clique gauche relaché
                begin
                trajectory.dragging:=False;
                projectile.Throw:=True;
                end;
            SDL_MOUSEMOTION: //mouvement de la souris
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
        projectile.velocity.x:=-trajectory.powerx;
        projectile.velocity.y:=-trajectory.powery;
        projectile.pos.x:=100;
        projectile.pos.y:=600;
        projectile.destRect.x:=round(projectile.pos.x);
        projectile.destRect.y:=round(projectile.pos.y);
      end;


    Velocity(trajectory,projectile);
    MouvementProjectile(trajectory,projectile);
    CalculOfTrajectory(trajectory);
    collisionConstruction(construction,projectile);
    updatecounter(construction);
    cascadeConstruction(construction);

    
    //affichage
    affichageBackground(sdlRenderer,background);
    affichageTrajectory(sdlRenderer,trajectory);
    affichageProjectile(sdlRenderer,projectile);
    affichageStructure(sdlRenderer,construction);

    SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 0, 255);
    SDL_RenderPresent(sdlRenderer);
    sdl_delay(16);
    SDL_RenderClear(sdlRenderer);
  end;
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyWindow(sdlWindow1);
    SDL_Quit; 
end.
    

