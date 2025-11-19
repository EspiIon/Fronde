
program main;


uses SDL2, SDL2_image,sysutils,affichage,interaction,movement,structure,load,hitbox;

var sdlWindow1:PSDL_Window;//fenetre
    sdlRenderer:PSDL_Renderer;//rendu
    enCours:boolean;
    bJouer, bQuitter, bRetour, bNv1, bNv2, bNv3 : TBouton ;
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
chargementniveau(construction);
InitStructure(construction,sdlRenderer);


//Menu()
// bQuitter.actif := false ;
// initialisation(sdlRenderer, bJouer, bQuitter, fond);
// while not bQuitter.actif do 
// 	begin 
// 		affiche_debut(sdlRenderer,fond, bJouer, bQuitter);
// 		mouseEvents(bJouer, bQuitter, bRetour, bNv1, bNv2, bNv3);
// 		if bJouer.actif then
// 			affiche_niveau(sdlRenderer,bNv1,bNv2,bNv3,bRetour,fond);
		
// 	end;
	
// //ChargerNiveau()
// while bJouer.actif do
// 	begin
// 		if bNv1.actif then
// 			{charger niveau 1}
// 		if bNv2.actif then
// 			{charger niveau 2}
// 		if bNv3.actif then
// 			{charger niveau 3}
// 	end;
		




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
    projectile.falling:=True;
    // Effacer l'écran en noir
    CalculOfTrajectory(trajectory,projectile);
	  ProjectileValide(projectile,trajectory);    
    destructionStructure(construction);
    ConstructionFalling(construction);


    Velocity(trajectory,projectile);
    velocityConstructions(construction);
    collisionConstruction(construction,projectile);
    hitboxStructure(construction);
    
    MouvementProjectile(trajectory,projectile);
	  MovementConstructions(construction);
    
    //affichage
    affichageBackground(sdlRenderer,background);
    affichageTrajectory(sdlRenderer,trajectory);
    affichageProjectile(sdlRenderer,projectile);
    affichageStructure(sdlRenderer,construction);
	
	//sdl render
    SDL_SetRenderDrawColor(sdlRenderer, 0, 0, 0, 255);
    SDL_RenderPresent(sdlRenderer);
    sdl_delay(16);
    SDL_RenderClear(sdlRenderer);
  end;
    SDL_DestroyRenderer(sdlRenderer);
    SDL_DestroyWindow(sdlWindow1);
    SDL_Quit; 
end.
    

