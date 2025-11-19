unit menu ;

interface
uses SDL2, SDL2_image,structure;

CONST 
    SURFACEWIDTH=900; {largeur en pixels de la surface de jeu}
	SURFACEHEIGHT=500; {hauteur en pixels de la surface de jeu}
	IMAGEWIDTH = 125; {largeur en pixels de l'image}
	IMAGEHEIGHT = 75; {hauteur en pixels de l'image}



procedure initialisation( var sdlRenderer: PSDL_Renderer; var bJouer, bQuitter : TBouton ; var fond : TBackground);
procedure affiche_debut( var sdlRenderer : PSDL_Renderer; var fond : TBackground ; var bJouer, bQuitter : TBouton);
procedure initialisationNv( var sdlRenderer: PSDL_Renderer; var bNv1, bNv2, bNv3, bRetour : TBouton ; var fond : TBackground);
procedure affiche_niveau(var sdlRenderer : PSDL_Renderer; var bNv1, bNv2, bNv3, bRetour: TBouton ; var fond : TBackground);
procedure mouseEvents( var bJouer, bQuitter, bRetour, bNv1, bNv2, bNv3 : TBouton);
implementation

procedure initialisation( var sdlRenderer: PSDL_Renderer; var bJouer, bQuitter : TBouton ; var fond : TBackground);
begin
	{choix position taille des boutons jouer et quitter}
	bJouer.bouton.x := 100;
	bJouer.bouton.y := 175;
	bJouer.bouton.w := IMAGEWIDTH;
	bJouer.bouton.h := IMAGEHEIGHT;
	
	bQuitter.bouton.x := 100;
	bQuitter.bouton.y := 275;
	bQuitter.bouton.w := IMAGEWIDTH;
	bQuitter.bouton.h := IMAGEHEIGHT;
	
	fond.destRect.x := 0; 
	fond.destRect.y := 0;
	fond.destRect.w := SURFACEWIDTH;
	fond.destRect.h := SURFACEHEIGHT;
	
	{chargement des images comme textures}
	bJouer.texture := IMG_LoadTexture(sdlRenderer, 'assests/button/startbutton.png');
	bQuitter.texture := IMG_LoadTexture(sdlRenderer, 'assets/button/exit.png');
	fond.texture := IMG_LoadTexture(sdlRenderer, 'assets/background.png');
end;

procedure affiche_debut( var sdlRenderer : PSDL_Renderer; var fond : TBackground ; var bJouer, bQuitter : TBouton);
begin 


    SDL_RenderClear(sdlRenderer); //efface le rendu 
	SDL_RenderCopy(sdlRenderer, fond.texture, nil, @fond); 	//Coller l'element fond dans le rendu en cours avec les caracteristiques destination_fond
	SDL_RenderCopy(sdlRenderer, bJouer.texture, nil, @bJouer); //Coller l'element play dans le rendu en cours avec les caracteristiques destination_rect
	SDL_RenderCopy(sdlRenderer, bQuitter.texture, nil, @bQuitter); //Coller l'element quitter dans le rendu en cours avec les caracteristiques destination_quitter

	
	SDL_RenderPresent(sdlRenderer);//Générer le rendu 

end;

procedure initialisationNv( var sdlRenderer: PSDL_Renderer; var bNv1, bNv2, bNv3, bRetour : TBouton ; var fond : TBackground);
begin
	{choix position taille des boutons de niveaux + retour}
	bNv1.bouton.x := 250;
	bNv1.bouton.y := 200;
	bNv1.bouton.w := IMAGEWIDTH;
	bNv1.bouton.h := IMAGEHEIGHT;
	
	bNv2.bouton.x := 400;
	bNv2.bouton.y := 200;
	bNv2.bouton.w := IMAGEWIDTH;
	bNv2.bouton.h := IMAGEHEIGHT;
	
	bNv3.bouton.x := 550;
	bNv3.bouton.y := 200;
	bNv3.bouton.w := IMAGEWIDTH;
	bNv3.bouton.h := IMAGEHEIGHT;
	
	bRetour.bouton.x := 400;
	bRetour.bouton.y := 100;
	bRetour.bouton.w := IMAGEWIDTH;
	bRetour.bouton.h := IMAGEHEIGHT;
	
	fond.destRect.x := 0; 
	fond.destRect.y := 0;
	fond.destRect.w := SURFACEWIDTH;
	fond.destRect.h := SURFACEHEIGHT;
	
	{chargement des images comme textures}
	bNv1.texture := IMG_LoadTexture(sdlRenderer, 'assests/button/startbutton.png'); {modifier image}
	bNv2.texture := IMG_LoadTexture(sdlRenderer, 'assets/button/exit.png'); {modifier image}
	bNv3.texture := IMG_LoadTexture(sdlRenderer, 'assests/button/startbutton.png'); {modifier image}
	bRetour.texture := IMG_LoadTexture(sdlRenderer, 'assests/button/startbutton.png'); {modifier image}
	fond.texture := IMG_LoadTexture(sdlRenderer, 'assets/background.png');
end;

procedure affiche_niveau( var sdlRenderer : PSDL_Renderer; var bNv1, bNv2, bNv3, bRetour : TBouton ; var fond : TBackground);

begin

	begin 
		SDL_RenderClear(sdlRenderer); //efface le rendu 
		SDL_RenderCopy(sdlRenderer, fond.texture, nil, @fond); 	//Coller l'element fond dans le rendu en cours avec les caracteristiques destination_fond
		SDL_RenderCopy(sdlRenderer, bNv1.texture, nil, @bNv1); //Coller l'element nv1 dans le rendu en cours avec les caracteristiques boutonNv1
		SDL_RenderCopy(sdlRenderer, bNv2.texture, nil, @bNv2); //Coller l'element nv2 dans le rendu en cours avec les caracteristiques boutonNv2
		SDL_RenderCopy(sdlRenderer, bNv3.texture, nil, @bNv3); //Coller l'element nv3 dans le rendu en cours avec les caracteristiques boutonNv3
		SDL_RenderCopy(sdlRenderer, bRetour.texture, nil, @bRetour); //Coller l'element retour dans le rendu en cours avec les caracteristiques boutonRetour
	
		SDL_RenderPresent(sdlRenderer);//Générer le rendu
	end ;
end;

procedure mouseEvents( var bJouer, bQuitter, bRetour, bNv1, bNv2, bNv3 : TBouton);
var 
x,y : LongInt ;
event : TSDL_Event ;
begin 

	while SDL_PollEvent(@event)<>0 do {récupérer les évènements}
	begin
		if event.button.button = SDL_BUTTON_LEFT then
		begin
			{récupération de coodonnées}
		
			x :=Event.button.x;
			y :=event.button.y;
			{test de la position de la souris sur le bouton jouer}
			if (x>bJouer.bouton.x) and (x<bJouer.bouton.x + bJouer.bouton.w) and (y>bJouer.bouton.y) and (y<bJouer.bouton.y + bJouer.bouton.h) then
				bJouer.actif:= True;
			{test de la position de la souris sur le bouton quitter}
			if (x>bQuitter.bouton.x) and (x<bQuitter.bouton.x + bQuitter.bouton.w) and (y>bQuitter.bouton.y) and (y<bQuitter.bouton.y + bQuitter.bouton.h) then
				bQuitter.actif := True ;
			{test de la position de la souris sur le bouton retour}
			if (x>bRetour.bouton.x) and (x<bRetour.bouton.x + bRetour.bouton.w) and (y>bRetour.bouton.y) and (y<bRetour.bouton.y + bRetour.bouton.h) then
				bRetour.actif := True ;
			{test de la position de la souris sur le bouton niveau 1}
			if (x>bNv1.bouton.x) and (x<bNv1.bouton.x + bNv1.bouton.w) and (y>bNv1.bouton.y) and (y<bNv1.bouton.y + bNv1.bouton.h) then
				bNv1.actif := True ;
			{test de la position de la souris sur le bouton niveau 2}
			if (x>bNv2.bouton.x) and (x<bNv2.bouton.x + bNv2.bouton.w) and (y>bNv2.bouton.y) and (y<bNv2.bouton.y + bNv2.bouton.h) then
				bNv2.actif := True ;
			{test de la position de la souris sur le bouton niveau 3}
			if (x>bNv3.bouton.x) and (x<bNv3.bouton.x + bNv3.bouton.w) and (y>bNv3.bouton.y) and (y<bNv3.bouton.y + bNv3.bouton.h) then
				bNv3.actif := True ;
		end;
	end;
end;


end.

