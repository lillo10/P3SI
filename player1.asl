// Agent player1 in project entrega.mas2j

//direcciones
dir("up",0).
dir("down",1).
dir("left",2).
dir("right",3).

//Almacena el valor del Owner para este agente
propietario(1).

//Almacena el valor del owner para el rival
propietarioRival(2).

//almacena el valor de las celdas conquistadas
contador1(0).

//almacena el valor del  mayor numero de celdas conquistadas
contador2(0).

//La bandera se activa si encuentra una figura que conquiste territorio
bandera(0).

//direccion movimiento a realizar
direccion(0).

//siguiente movimiento que va a realizar
siguiente(moverDesdeEnDireccion(pos(0,0),0)).

//siguiente movimiento a realizar si no hay figuras con propietario
siguiente2(moverDesdeEnDireccion(pos(0,0),0)).


/* Initial goals */

/* Plans */

//Comprueba si hay figura de 5 fichas para conquistar territorio
+!comprobarQuintuple : propietario(P) <-

//Se realiza una busqueda de la figura de 5 fichas en horizontal
.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_)) & tablero(celda(X-2,Y,_),ficha(Color,_)) &
	tablero(celda(X-1,Y,_),ficha(Color,_)) &  
	tablero(celda(X+1,Y,_),ficha(Color,_))  & tablero(celda(X+2,Y,_),ficha(Color,_)) & (tablero(celda(X,Y+1,P),ficha(Color,_)) | tablero(celda(X,Y-1,P),ficha(Color,_))),ListaQuintupleH);
	
//Se realiza una busqueda de la figura de 5 fichas en vertical
.findall(celda(X,Y),tablero(celda(X,Y,1),ficha(_,_))  & tablero(celda(X,Y-2,_),ficha(Color,_)) &
	tablero(celda(X,Y-1,_),ficha(Color,_)) &  
	tablero(celda(X,Y+1,_),ficha(Color,_))  & tablero(celda(X,Y+2,_),ficha(Color,_)) & (tablero(celda(X+1,Y,P),ficha(Color,_)) | tablero(celda(X-1,Y,P),ficha(Color,_))),ListaQuintupleV);
	
	//Si existe una figura de 5 horizontal
	if(.length(ListaQuintupleH)>0){
		
		//Se recorre la lista
		for(.member(celda(X,Y),ListaQuintupleH) ){
		
		//Se consulta el tipo de cada coordenada de la figura
		?tablero(celda(X-2,Y,_),ficha(Color,Tipo));
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo1));
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo2));
		?tablero(celda(X+2,Y,_),ficha(Color,Tipo3));
		
		//Si la ficha consultada tiene el mismo color que el resto de la figura
		if(tablero(celda(X,Y+1,_),ficha(Color,_))){
		
		//consultamos el Tipo de la ficha
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo4));
		?dir(Dir1000,0);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X-2,Y,Tipo,X-1,Y,Tipo1,X+1,Y,Tipo2,X+2,Y,Tipo3,X,Y+1,Tipo4,Dir1000,X,Y+1);
		}
		
		
		//Si la ficha consultada tiene el mismo color que el resto de la figura
		if(tablero(celda(X,Y-1,_),ficha(Color,_))){
		
		//consultamos el Tipo de la ficha
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo5));
		?dir(Dir2,1);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X-2,Y,Tipo,X-1,Y,Tipo1,X+1,Y,Tipo2,X+2,Y,Tipo3,X,Y-1,Tipo5,Dir2,X,Y-1);
		}
		
		}	
	}
	
	
	//Si existe una figura de 5 horizontal
	if(.length(ListaQuintupleV)>0){
		
		//Se recorre la lista
		for(.member(celda(X,Y),ListaQuintupleV) ){
		
			//Se consulta el tipo de cada coordenada de la figura
			?tablero(celda(X,Y-2,_),ficha(Color,Tipo6));
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo7));
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo8));
			?tablero(celda(X,Y+2,_),ficha(Color,Tipo9));
			
			
			//Si la ficha consultada tiene el mismo color que el resto de la figura
			if(tablero(celda(X+1,Y,_),ficha(Color,_))){
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo10));
			?dir(Dir3,2);
			
			//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar1(X,Y-2,Tipo6,X,Y-1,Tipo7,X,Y+1,Tipo8,X,Y+2,Tipo9,X+1,Y,Tipo10,Dir3,X+1,Y);
		}
		
		
		//Si la ficha consultada tiene el mismo color que el resto de la figura
		if(tablero(celda(X-1,Y,_),ficha(Color,_))){
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo11));
		?dir(Dir4,3);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X,Y-2,Tipo6,X,Y-1,Tipo7,X,Y+1,Tipo8,X,Y+2,Tipo9,X-1,Y,Tipo11,Dir4,X-1,Y);
		}
		
		}
	
	}
	//Se llama a la siguiente comprobacion de figuras
	!comprobarT.

	
+!comprobarQuintuple  <-
.print("�No se est� recibiendo la creencia del valor de los propietarios para cada jugador!");
!comprobarT.
	
	
//Comprueba si hay figura T para conquistar territorio
+!comprobarT : propietario(P) <-

//Se realiza una busqueda para cada una de las posibles posiciones de la T
.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_)) & tablero(celda(X-1,Y,_),ficha(Color,_)) &
tablero(celda(X+1,Y,_),ficha(Color,_)) &  
tablero(celda(X,Y-1,_),ficha(Color,_))  & tablero(celda(X,Y-2,_),ficha(Color,_)) & tablero(celda(X,Y+1,P),ficha(Color,_)),ListaTAbajo);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X-1,Y,_),ficha(Color,_)) &
tablero(celda(X+1,Y,_),ficha(Color,_)) &  
tablero(celda(X,Y+1,_),ficha(Color,_))  & tablero(celda(X,Y+2,_),ficha(Color,_)) & tablero(celda(X,Y-1,P),ficha(Color,_)),ListaTArriba);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X,Y+1,_),ficha(Color,_)) &
tablero(celda(X,Y-1,_),ficha(Color,_)) &  
tablero(celda(X-1,Y,P),ficha(Color,_))  & tablero(celda(X+1,Y,_),ficha(Color,_)) & tablero(celda(X+2,Y,_),ficha(Color,_)),ListaTIzquierda);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X,Y+1,_),ficha(Color,_)) &
tablero(celda(X,Y-1,_),ficha(Color,_)) &  
tablero(celda(X+1,Y,P),ficha(Color,_))  & tablero(celda(X-1,Y,_),ficha(Color,_)) & tablero(celda(X-2,Y,_),ficha(Color,_)),ListaTDerecha);

	// Si se encontr� una T
	if(.length(ListaTAbajo)>0){
		for(.member(celda(X,Y),ListaTAbajo) ){
		
			//Se consulta el tipo de cada coordenada de la figura
			?tablero(celda(X-1,Y,_),ficha(Color,Tipo12));
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo13));
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo14));
			?tablero(celda(X,Y-2,_),ficha(Color,Tipo15));
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo16));
			?dir(Dir5,0);
			
			//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar1(X-1,Y,Tipo12,X+1,Y,Tipo13,X,Y-1,Tipo14,X,Y-2,Tipo15,X,Y+1,Tipo16,Dir5,X,Y+1);
		}
	
	}
	
		// Si se encontr� una T
	if(.length(ListaTArriba)>0){
		for(.member(celda(X,Y),ListaTArriba) ){
		
			//Se consulta el tipo de cada coordenada de la figura
			?tablero(celda(X-1,Y,_),ficha(Color,Tipo17));
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo18));
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo19));
			?tablero(celda(X,Y+2,_),ficha(Color,Tipo20));
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo21));
			?dir(Dir6,1);
			
			//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar1(X-1,Y,Tipo17,X+1,Y,Tipo18,X,Y+1,Tipo19,X,Y+2,Tipo20,X,Y-1,Tipo21,Dir6,X,Y-1);
		}
	}
	
		// Si se encontr� una T
	if(.length(ListaTIzquierda)>0){
			for(.member(celda(X,Y),ListaTIzquierda) ){
			
			//Se consulta el tipo de cada coordenada de la figura
			?tablero(celda(X-1,Y,_),ficha(Color,Tipo22));
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo23));
			?tablero(celda(X+2,Y,_),ficha(Color,Tipo24));
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo25));
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo26));
			?dir(Dir7,3);
			
			//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar1(X-1,Y,Tipo22,X+1,Y,Tipo23,X+2,Y,Tipo24,X,Y-1,Tipo25,X,Y+1,Tipo26,Dir7,X-1,Y);
		}
	}
	
	// Si se encontr� una T
	if(.length(ListaTDerecha)>0){
			for(.member(celda(X,Y),ListaTDerecha) ){
			
			//Se consulta el tipo de cada coordenada de la figura
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo27));
			?tablero(celda(X-1,Y,_),ficha(Color,Tipo28));
			?tablero(celda(X-2,Y,_),ficha(Color,Tipo29));
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo30));
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo31));
			?dir(Dir8,2);
			
			//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar1(X+1,Y,Tipo27,X-1,Y,Tipo28,X-2,Y,Tipo29,X,Y-1,Tipo30,X,Y+1,Tipo31,Dir8,X+1,Y);
		}
	}
	//Se llama a la siguiente comprobacion de figuras
	!comprobar4.
	
+!comprobarT  <-
.print("�No se est� recibiendo la creencia del valor de los propietarios para cada jugador!");
!comprobar4.	
	

//Comprueba si hay figura de 4 fichas para conquistar territorio
+!comprobar4 : propietario(P) <- 

//Se realiza una busqueda para cada una de las posibles posiciones de la figura cuadruple
.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_)) & tablero(celda(X-1,Y,_),ficha(Color,_)) &
tablero(celda(X-2,Y,_),ficha(Color,_)) &  
tablero(celda(X+1,Y,_),ficha(Color,_))  & (tablero(celda(X,Y-1,P),ficha(Color,_)) | tablero(celda(X,Y+1,P),ficha(Color,_))),Lista4HDerecha);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X-1,Y,_),ficha(Color,_)) &
tablero(celda(X+1,Y,_),ficha(Color,_)) &  
tablero(celda(X+2,Y,_),ficha(Color,_))  & (tablero(celda(X,Y-1,P),ficha(Color,_)) | tablero(celda(X,Y+1,P),ficha(Color,_))),Lista4HIzquierda);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X,Y-1,_),ficha(Color,_)) &
tablero(celda(X,Y+1,_),ficha(Color,_)) &  
tablero(celda(X,Y+2,_),ficha(Color,_))  & (tablero(celda(X-1,Y,P),ficha(Color,_)) | tablero(celda(X+1,Y,P),ficha(Color,_))),Lista4YArriba);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X,Y+1,_),ficha(Color,_)) &
tablero(celda(X,Y-1,_),ficha(Color,_)) &  
tablero(celda(X,Y-2,_),ficha(Color,_))  & (tablero(celda(X-1,Y,P),ficha(Color,_)) | tablero(celda(X+1,Y,P),ficha(Color,_))),Lista4YAbajo);

	// Si se encontr� una cuadruple
	if(.length(Lista4HDerecha)>0){
			
			//Se recorre la lista
			for(.member(celda(X,Y),Lista4HDerecha) ){
				
				//Se consulta el tipo de cada coordenada de la figura
				?tablero(celda(X-2,Y,_),ficha(Color,Tipo32));
				?tablero(celda(X-1,Y,_),ficha(Color,Tipo33));
				?tablero(celda(X+1,Y,_),ficha(Color,Tipo34));
				
				//si la ficha dada tiene el mismo color que las restantes de la figura
				if(tablero(celda(X,Y+1,_),ficha(Color,_))){
				?tablero(celda(X,Y+1,_),ficha(Color,Tipo35));
				?dir(Dir9,0);
				
				//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
				!contar1(X-2,Y,Tipo32,X-1,Y,Tipo33,X+1,Y,Tipo34,X,Y+1,Tipo35,6,6,6,Dir9,X,Y+1);
				}
				
				//si la ficha dada tiene el mismo color que las restantes de la figura
				if(tablero(celda(X,Y-1,_),ficha(Color,_))){
				?tablero(celda(X,Y-1,_),ficha(Color,Tipo36));
				?dir(Dir10,1);
				
				//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
				!contar1(X-2,Y,Tipo32,X-1,Y,Tipo33,X+1,Y,Tipo34,X,Y-1,Tipo36,6,6,6,Dir10,X,Y-1);
				}
		
		}

	
	}
	
	// Si se encontr� una cuadruple
	if(.length(Lista4HIzquierda)>0){
	
	for(.member(celda(X,Y),Lista4HIzquierda) ){
			?tablero(celda(X-1,Y,_),ficha(Color,Tipo37));
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo38));
			?tablero(celda(X+2,Y,_),ficha(Color,Tipo39));
		
			if(tablero(celda(X,Y+1,_),ficha(Color,_))){
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo40));
			?dir(Dir11,0);
			
			//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar1(X-1,Y,Tipo37,X+1,Y,Tipo38,X+2,Y,Tipo39,X,Y+1,Tipo40,6,6,6,Dir11,X,Y+1);
			}
			
			if(tablero(celda(X,Y-1,_),ficha(Color,_))){
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo41));
			?dir(Dir12,1);
			
			//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar1(X-1,Y,Tipo37,X+1,Y,Tipo38,X+2,Y,Tipo39,X,Y-1,Tipo41,6,6,6,Dir12,X,Y-1);
			}
		}
	}
	
	// Si se encontr� una cuadruple
	if(.length(Lista4YArriba)>0){
		
	for(.member(celda(X,Y),Lista4YArriba) ){
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo42));
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo43));
			?tablero(celda(X,Y+2,_),ficha(Color,Tipo44));
		
			if(tablero(celda(X-1,Y,_),ficha(Color,_))){
			?tablero(celda(X-1,Y,_),ficha(Color,Tipo45));
			?dir(Dir13,3);
			
			//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar1(X,Y-1,Tipo42,X,Y+1,Tipo43,X,Y+2,Tipo44,X-1,Y,Tipo45,6,6,6,Dir13,X-1,Y);
			
			}
			
			if(tablero(celda(X+1,Y,_),ficha(Color,_))){
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo46));
			?dir(Dir14,2);
			//Recibe las coordenadas de la figura, los tipos de cada ficha y la ficha que se va a mover
			!contar1(X,Y-1,Tipo42,X,Y+1,Tipo43,X,Y+2,Tipo44,X+1,Y,Tipo46,6,6,6,Dir14,X+1,Y);
			}
		}
	}
	
	// Si se encontr� una cuadruple
	if(.length(Lista4YAbajo)>0){

	for(.member(celda(X,Y),Lista4YAbajo) ){
		
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo47));
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo48));
			?tablero(celda(X,Y-2,_),ficha(Color,Tipo49));
		
			if(tablero(celda(X-1,Y,_),ficha(Color,_))){
			?tablero(celda(X-1,Y,_),ficha(Color,Tipo50));
			?dir(Dir15,3);
			
			//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar1(X,Y-1,Tipo47,X,Y+1,Tipo48,X,Y-2,Tipo49,X-1,Y,Tipo50,6,6,6,Dir15,X-1,Y);
			}
			
			if(tablero(celda(X+1,Y,_),ficha(Color,_))){
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo51));
			?dir(Dir16,2);
			
			//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar1(X,Y-1,Tipo47,X,Y+1,Tipo48,X,Y-2,Tipo49,X+1,Y,Tipo51,6,6,6,Dir16,X+1,Y);
			}
		}
	}
	//Se llama al no encontrar ninguna ficha cuadruple
	!comprobarCuadrado.
	
+!comprobar4  <-
.print("�No se est� recibiendo la creencia del valor de los propietarios para cada jugador!");
!comprobarCudrado.	
	
//Comprueba si hay figura cuadrado para conquistar territorio	
+!comprobarCuadrado : propietario(P) <-

//Se realiza una busqueda para cada una de las posibles posiciones de la figura cuadrado
.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_)) & tablero(celda(X+1,Y,_),ficha(Color,_)) &
tablero(celda(X,Y+1,_),ficha(Color,_)) &  
tablero(celda(X+1,Y+1,_),ficha(Color,_))  & (tablero(celda(X-1,Y,P),ficha(Color,_)) | tablero(celda(X,Y-1,P),ficha(Color,_))),ListaCuadradoUpI);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_)) & tablero(celda(X-1,Y,_),ficha(Color,_)) &
tablero(celda(X-1,Y+1,_),ficha(Color,_)) &  
tablero(celda(X,Y+1,_),ficha(Color,_))  & (tablero(celda(X,Y-1,P),ficha(Color,_)) | tablero(celda(X+1,Y,P),ficha(Color,_))),ListaCuadradoUpD);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_)) & tablero(celda(X+1,Y,_),ficha(Color,_)) &
tablero(celda(X,Y-1,_),ficha(Color,_)) &  
tablero(celda(X+1,Y-1,_),ficha(Color,_))  & (tablero(celda(X-1,Y,P),ficha(Color,_)) | tablero(celda(X,Y+1,P),ficha(Color,_))),ListaCuadradoDI);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_)) & tablero(celda(X,Y-1,_),ficha(Color,_)) &
tablero(celda(X-1,Y,_),ficha(Color,_)) &  
tablero(celda(X-1,Y-1,_),ficha(Color,_))  & (tablero(celda(X+1,Y,P),ficha(Color,_)) | tablero(celda(X,Y+1,P),ficha(Color,_))),ListaCuadradoDD);

	if(.length(ListaCuadradoUpI)>0){ 

		for(.member(celda(X,Y),ListaCuadradoUpI) ){
		//se consulta el tipo de todas las fichas de la figura para enviarselo a contar1
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo52));
		?tablero(celda(X+1,Y+1,_),ficha(Color,Tipo53));
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo54));
	
		if(tablero(celda(X-1,Y,_),ficha(Color,_))){
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo55));
		?dir(Dir17,3);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X+1,Y,Tipo52,X+1,Y+1,Tipo53,X,Y+1,Tipo54,X-1,Y,Tipo55,6,6,6,Dir17,X-1,Y);
		}
		
		if(tablero(celda(X,Y-1,_),ficha(Color,_))){
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo56));
		?dir(Dir18,1);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X+1,Y,Tipo52,X+1,Y+1,Tipo53,X,Y+1,Tipo54,X,Y-1,Tipo56,6,6,6,Dir18,X,Y-1);
		}
		}
	}
	
	if(.length(ListaCuadradoUpD)>0){

	for(.member(celda(X,Y),ListaCuadradoUpD)){
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo57));
		?tablero(celda(X-1,Y+1,_),ficha(Color,Tipo58));
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo59));
	
		if(tablero(celda(X+1,Y,_),ficha(Color,_))){
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo60));
		?dir(Dir19,2);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X-1,Y,Tipo57,X-1,Y+1,Tipo58,X,Y+1,Tipo59,X+1,Y,Tipo60,6,6,6,Dir19,X+1,Y);
		}
		
		if(tablero(celda(X,Y-1,_),ficha(Color,_))){
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo61));
		?dir(Dir20,1);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X-1,Y,Tipo57,X-1,Y+1,Tipo58,X,Y+1,Tipo59,X,Y-1,Tipo61,6,6,6,Dir20,X,Y-1);
		}
		}
	}
	
	if(.length(ListaCuadradoDI)>0){

	for(.member(celda(X,Y),ListaCuadradoDI)){
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo62));
		?tablero(celda(X+1,Y-1,_),ficha(Color,Tipo63));
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo64));
	
		if(tablero(celda(X-1,Y,_),ficha(Color,_))){
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo65));
		?dir(Dir21,3);
		
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X+1,Y,Tipo62,X+1,Y-1,Tipo63,X,Y-1,Tipo64,X-1,Y,Tipo65,6,6,6,Dir21,X-1,Y);
		}
		
		if(tablero(celda(X,Y+1,_),ficha(Color,_))){
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo66));
		?dir(Dir22,0);
		
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X+1,Y,Tipo62,X+1,Y-1,Tipo63,X,Y-1,Tipo64,X,Y+1,Tipo66,6,6,6,Dir22,X,Y+1);
		}
		}
	}
	
	
	if(.length(ListaCuadradoDD)>0){
		
	for(.member(celda(X,Y),ListaCuadradoDD)){
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo67));
		?tablero(celda(X-1,Y-1,_),ficha(Color,Tipo68));
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo69));
	
		if(tablero(celda(X+1,Y,_),ficha(Color,_))){
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo70));
		?dir(Dir23,2);
		//Recibe las coordenadas de la figura, los tipos de cada ficha y la ficha que se va a mover
		!contar1(X-1,Y,Tipo67,X-1,Y-1,Tipo68,X,Y-1,Tipo69,X+1,Y,Tipo70,6,6,6,Dir23,X+1,Y);
		}
		
		if(tablero(celda(X,Y+1,_),ficha(Color,_))){
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo71));
		?dir(Dir24,0);
		//Recibe las coordenadas de la figura, los tipos de cada ficha y la ficha que se va a mover
		!contar1(X-1,Y,Tipo67,X-1,Y-1,Tipo68,X,Y-1,Tipo69,X,Y+1,Tipo71,6,6,6,Dir24,X,Y+1);
		}
		}
	}
	//Se llama al no encontrar ningun cuadrado
	!comprobarTriple.
	
+!comprobarCuadrado  <-
.print("�No se est� recibiendo la creencia del valor de los propietarios para cada jugador!");
!comprobarTriple.	
	
//Comprueba si hay figura de 3 fichas para conquistar territorio
+!comprobarTriple : propietario(P)  <-

//Se realiza una busqueda para cada una de las posibles posiciones de la figura triple
.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X-1,Y,_),ficha(Color,_)) &
tablero(celda(X-2,Y,_),ficha(Color,_)) &  
(tablero(celda(X+1,Y,P),ficha(Color,_)) | tablero(celda(X,Y-1,P),ficha(Color,_)) | tablero(celda(X,Y+1,P),ficha(Color,_))),Lista3HD);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))   & tablero(celda(X-1,Y,_),ficha(Color,_)) &
tablero(celda(X+1,Y,_),ficha(Color,_)) &  
(tablero(celda(X,Y-1,P),ficha(Color,_)) | tablero(celda(X,Y+1,P),ficha(Color,_))),Lista3HMedio);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X+1,Y,_),ficha(Color,_)) &
tablero(celda(X+2,Y,_),ficha(Color,_)) &  
(tablero(celda(X-1,Y,P),ficha(Color,_)) | tablero(celda(X,Y-1,P),ficha(Color,_)) | tablero(celda(X,Y+1,P),ficha(Color,_))),Lista3HI);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))   & tablero(celda(X,Y-1,_),ficha(Color,_)) &
tablero(celda(X,Y-2,_),ficha(Color,_)) & 
(tablero(celda(X-1,Y,P),ficha(Color,_)) | tablero(celda(X+1,Y,P),ficha(Color,_)) | tablero(celda(X,Y+1,P),ficha(Color,_))),Lista3VAbajo);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))   & tablero(celda(X,Y-1,_),ficha(Color,_)) &
tablero(celda(X,Y+1,_),ficha(Color,_)) &  
(tablero(celda(X+1,Y,P),ficha(Color,_)) | tablero(celda(X-1,Y,P),ficha(Color,_))),Lista3VM);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X,Y+1,_),ficha(Color,_)) &
tablero(celda(X,Y+2,_),ficha(Color,_)) & 
(tablero(celda(X-1,Y,P),ficha(Color,_)) | tablero(celda(X+1,Y,P),ficha(Color,_)) | tablero(celda(X,Y-1,P),ficha(Color,_))),Lista3VArriba);


	if(.length(Lista3HMedio)>0){ 
	for(.member(celda(X,Y),Lista3HMedio)){
		
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo72));
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo73));
	
		if(tablero(celda(X,Y+1,_),ficha(Color,_))){
		
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo74));
		?dir(Dir25,0);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X-1,Y,Tipo72,X+1,Y,Tipo73,X,Y+1,Tipo74,6,6,6,6,6,6,Dir25,X,Y+1);
		}
		
		if(tablero(celda(X,Y-1,_),ficha(Color,_))){
		
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo75));
		?dir(Dir26,1);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X-1,Y,Tipo72,X+1,Y,Tipo73,X,Y-1,Tipo75,6,6,6,6,6,6,Dir26,X,Y-1);
		}
		}
	}
	

	if(.length(Lista3HI)>0){

	for(.member(celda(X,Y),Lista3HI)){
		
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo76));
		?tablero(celda(X+2,Y,_),ficha(Color,Tipo77));
	
		if(tablero(celda(X,Y+1,_),ficha(Color,_))){
		
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo78));
		?dir(Dir27,0);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X+1,Y,Tipo76,X+2,Y,Tipo77,X,Y+1,Tipo78,6,6,6,6,6,6,Dir27,X,Y+1);
		}
		
		if(tablero(celda(X,Y-1,_),ficha(Color,_))){
	
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo79));
		?dir(Dir28,1);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X+1,Y,Tipo76,X+2,Y,Tipo77,X,Y-1,Tipo79,6,6,6,6,6,6,Dir28,X,Y-1);
		}
		
		if(tablero(celda(X-1,Y,_),ficha(Color,_))){
		
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo80));
		?dir(Dir29,3);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X+1,Y,Tipo76,X+2,Y,Tipo77,X-1,Y,Tipo80,6,6,6,6,6,6,Dir29,X-1,Y);
		}
		}
	}
	

	if(.length(Lista3HD)>0){
	
	for(.member(celda(X,Y),Lista3HD)){
		
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo81));
		?tablero(celda(X-2,Y,_),ficha(Color,Tipo82));
		
		if(tablero(celda(X,Y+1,_),ficha(Color,_))){

		?tablero(celda(X,Y+1,_),ficha(Color,Tipo83));
		?dir(Dir30,0);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X-1,Y,Tipo81,X-2,Y,Tipo82,X,Y+1,Tipo83,6,6,6,6,6,6,Dir30,X,Y+1);		
		}
	
		if(tablero(celda(X,Y-1,_),ficha(Color,_))){
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo84));
		?dir(Dir31,1);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X-1,Y,Tipo81,X-2,Y,Tipo82,X,Y-1,Tipo84,6,6,6,6,6,6,Dir31,X,Y-1);
		}
		
		if(tablero(celda(X+1,Y,_),ficha(Color,_))){
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo85));
		?dir(Dir32,2);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X-1,Y,Tipo81,X-2,Y,Tipo82,X+1,Y,Tipo85,6,6,6,6,6,6,Dir32,X+1,Y);
		
		}	
		}
	}
	
	

	if(.length(Lista3VAbajo)>0){

	for(.member(celda(X,Y),Lista3VAbajo)){
		
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo86));
		?tablero(celda(X,Y-2,_),ficha(Color,Tipo87));
	
		if(tablero(celda(X+1,Y,_),ficha(Color,_))){

		?tablero(celda(X+1,Y,_),ficha(Color,Tipo88));
		?dir(Dir33,2);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X,Y-1,Tipo86,X,Y-2,Tipo87,X+1,Y,Tipo88,6,6,6,6,6,6,Dir33,X+1,Y);
		}
		
		if(tablero(celda(X-1,Y,_),ficha(Color,_))){
	
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo89));
		?dir(Dir34,3);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X,Y-1,Tipo86,X,Y-2,Tipo87,X-1,Y,Tipo89,6,6,6,6,6,6,Dir34,X-1,Y);
		}
		
		if(tablero(celda(X,Y+1,_),ficha(Color,_))){
	
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo900));
		?dir(Dir35,0);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X,Y-1,Tipo86,X,Y-2,Tipo87,X1,Y+1,Tipo900,6,6,6,6,6,6,Dir35,X,Y+1);
		
		}
		}
	}
	

	if(.length(Lista3VArriba)>0){

		for(.member(celda(X,Y),Lista3VArriba)){
		
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo90));
		?tablero(celda(X,Y+2,_),ficha(Color,Tipo91));
	
		if(tablero(celda(X-1,Y,_),ficha(Color,_))){
			
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo92));
		?dir(Dir36,3);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X,Y+1,Tipo90,X,Y+2,Tipo91,X-1,Y,Tipo92,6,6,6,6,6,6,Dir36,X-1,Y);
		}
		
		if(tablero(celda(X+1,Y,_),ficha(Color,_))){
	
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo93));
		?dir(Dir37,2);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X,Y+1,Tipo90,X,Y+2,Tipo91,X+1,Y,Tipo93,6,6,6,6,6,6,Dir37,X+1,Y);
		}
		
		if(tablero(celda(X,Y-1,_),ficha(Color,_))){
			
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo94));
		?dir(Dir38,1);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar1(X,Y+1,Tipo90,X,Y+2,Tipo91,X,Y-1,Tipo94,6,6,6,6,6,6,Dir38,X,Y-1);
		
		}
		}
	}
	
	

	if(.length(Lista3VM)>0){
	
	for(.member(celda(X,Y),Lista3VM)){
		
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo95));
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo96));
	
		if(tablero(celda(X+1,Y,_),ficha(Color,_))){
	
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo97));
		?dir(Dir39,2);
		//Recibe las coordenadas de la figura, los tipos de cada ficha y la ficha que se va a mover
		!contar1(X,Y-1,Tipo95,X,Y+1,Tipo96,X+1,Y,Tipo97,6,6,6,6,6,6,Dir39,X+1,Y);
		}
		
		if(tablero(celda(X-1,Y,_),ficha(Color,_))){
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo98));
		?dir(Dir40,3);
		//Recibe las coordenadas de la figura, los tipos de cada ficha y la ficha que se va a mover
		!contar1(X,Y-1,Tipo95,X,Y+1,Tipo96,X-1,Y,Tipo98,6,6,6,6,6,6,Dir40,X-1,Y);
		}
		}
	}
	
	.wait(1200);
	//se consulta la bandera que se activa si se encontr� una figura con propietario
	?bandera(S);
	//Si no se encontr� una figura con propietario se pasa a comprobar figura sin propietario
	if(S=0){
			!movimientoFigura;
	}else{
	
	// si se encontr� un movimiento con propietario se efectura
	?siguiente(moverDesdeEnDireccion(pos(X1,Y1),Dir));		
	.print("Muevo la casilla ",X1," ",Y1," hacia ",Dir);
	.send(judge,tell,moverDesdeEnDireccion(pos(X1,Y1),Dir));
	.send(judge,untell,moverDesdeEnDireccion(pos(X1,Y1),Dir));
	
	// se resetea la bandera y el contador de celdas conquistadas por el movimiento
	-+bandera(0);
	-+contador2(0);
	}. 

+!comprobarTriple  <-
.print("�No se est� recibiendo la creencia del valor de los propietarios para cada jugador!");
	!movimientoFigura.
	
+!movimientoFigura  <-

//Se realiza una busqueda de la figura de 5 fichas en horizontal
.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_)) & tablero(celda(X-2,Y,_),ficha(Color,_)) &
	tablero(celda(X-1,Y,_),ficha(Color,_)) &  
	tablero(celda(X+1,Y,_),ficha(Color,_))  & tablero(celda(X+2,Y,_),ficha(Color,_)) & (tablero(celda(X,Y+1,0),ficha(Color,_)) | tablero(celda(X,Y-1,0),ficha(Color,_))),ListaQuintupleH);
	
//Se realiza una busqueda de la figura de 5 fichas en vertical
.findall(celda(X,Y),tablero(celda(X,Y,1),ficha(_,_))  & tablero(celda(X,Y-2,_),ficha(Color,_)) &
	tablero(celda(X,Y-1,_),ficha(Color,_)) &  
	tablero(celda(X,Y+1,_),ficha(Color,_))  & tablero(celda(X,Y+2,_),ficha(Color,_)) & (tablero(celda(X+1,Y,0),ficha(Color,_)) | tablero(celda(X-1,Y,0),ficha(Color,_))),ListaQuintupleV);
	
	//Si existe una figura de 5 horizontal
	if(.length(ListaQuintupleH)>0){
		
		//Se recorre la lista
		for(.member(celda(X,Y),ListaQuintupleH) ){
		
		//Se consulta el tipo de cada coordenada de la figura
		?tablero(celda(X-2,Y,_),ficha(Color,Tipo));
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo1));
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo2));
		?tablero(celda(X+2,Y,_),ficha(Color,Tipo3));
		
		//Si la ficha consultada tiene el mismo color que el resto de la figura
		if(tablero(celda(X,Y+1,_),ficha(Color,_))){
		
		//consultamos el Tipo de la ficha
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo4));
		?dir(Dir1000,0);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X-2,Y,Tipo,X-1,Y,Tipo1,X+1,Y,Tipo2,X+2,Y,Tipo3,X,Y+1,Tipo4,Dir1000,X,Y+1);
		}
		
		
		//Si la ficha consultada tiene el mismo color que el resto de la figura
		if(tablero(celda(X,Y-1,_),ficha(Color,_))){
		
		//consultamos el Tipo de la ficha
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo5));
		?dir(Dir2,1);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X-2,Y,Tipo,X-1,Y,Tipo1,X+1,Y,Tipo2,X+2,Y,Tipo3,X,Y-1,Tipo5,Dir2,X,Y-1);
		}
		
		}	
	}
	
	
	//Si existe una figura de 5 horizontal
	if(.length(ListaQuintupleV)>0){
		
		//Se recorre la lista
		for(.member(celda(X,Y),ListaQuintupleV) ){
		
			//Se consulta el tipo de cada coordenada de la figura
			?tablero(celda(X,Y-2,_),ficha(Color,Tipo6));
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo7));
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo8));
			?tablero(celda(X,Y+2,_),ficha(Color,Tipo9));
			
			
			//Si la ficha consultada tiene el mismo color que el resto de la figura
			if(tablero(celda(X+1,Y,_),ficha(Color,_))){
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo10));
			?dir(Dir3,2);
			
			//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar2(X,Y-2,Tipo6,X,Y-1,Tipo7,X,Y+1,Tipo8,X,Y+2,Tipo9,X+1,Y,Tipo10,Dir3,X+1,Y);
		}
		
		
		//Si la ficha consultada tiene el mismo color que el resto de la figura
		if(tablero(celda(X-1,Y,_),ficha(Color,_))){
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo11));
		?dir(Dir4,3);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X,Y-2,Tipo6,X,Y-1,Tipo7,X,Y+1,Tipo8,X,Y+2,Tipo9,X-1,Y,Tipo11,Dir4,X-1,Y);
		}
		
		}
	
	}
	//Se llama a la siguiente comprobacion de figuras
	!comprobarT3.

	
+!movimientoFigura  <-
.print("�No se est� recibiendo la creencia del valor de los propietarios para cada jugador!");
!comprobarT3.
	
	
//Comprueba si hay figura T para conquistar territorio
+!comprobarT3 <-

//Se realiza una busqueda para cada una de las posibles posiciones de la T
.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_)) & tablero(celda(X-1,Y,_),ficha(Color,_)) &
tablero(celda(X+1,Y,_),ficha(Color,_)) &  
tablero(celda(X,Y-1,_),ficha(Color,_))  & tablero(celda(X,Y-2,_),ficha(Color,_)) & tablero(celda(X,Y+1,0),ficha(Color,_)),ListaTAbajo);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X-1,Y,_),ficha(Color,_)) &
tablero(celda(X+1,Y,_),ficha(Color,_)) &  
tablero(celda(X,Y+1,_),ficha(Color,_))  & tablero(celda(X,Y+2,_),ficha(Color,_)) & tablero(celda(X,Y-1,0),ficha(Color,_)),ListaTArriba);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X,Y+1,_),ficha(Color,_)) &
tablero(celda(X,Y-1,_),ficha(Color,_)) &  
tablero(celda(X-1,Y,0),ficha(Color,_))  & tablero(celda(X+1,Y,_),ficha(Color,_)) & tablero(celda(X+2,Y,_),ficha(Color,_)),ListaTIzquierda);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X,Y+1,_),ficha(Color,_)) &
tablero(celda(X,Y-1,_),ficha(Color,_)) &  
tablero(celda(X+1,Y,0),ficha(Color,_))  & tablero(celda(X-1,Y,_),ficha(Color,_)) & tablero(celda(X-2,Y,_),ficha(Color,_)),ListaTDerecha);

	// Si se encontr� una T
	if(.length(ListaTAbajo)>0){
		for(.member(celda(X,Y),ListaTAbajo) ){
		
			//Se consulta el tipo de cada coordenada de la figura
			?tablero(celda(X-1,Y,_),ficha(Color,Tipo12));
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo13));
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo14));
			?tablero(celda(X,Y-2,_),ficha(Color,Tipo15));
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo16));
			?dir(Dir5,0);
			
			//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar2(X-1,Y,Tipo12,X+1,Y,Tipo13,X,Y-1,Tipo14,X,Y-2,Tipo15,X,Y+1,Tipo16,Dir5,X,Y+1);
		}
	
	}
	
		// Si se encontr� una T
	if(.length(ListaTArriba)>0){
		for(.member(celda(X,Y),ListaTArriba) ){
		
			//Se consulta el tipo de cada coordenada de la figura
			?tablero(celda(X-1,Y,_),ficha(Color,Tipo17));
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo18));
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo19));
			?tablero(celda(X,Y+2,_),ficha(Color,Tipo20));
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo21));
			?dir(Dir6,1);
			
			//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar2(X-1,Y,Tipo17,X+1,Y,Tipo18,X,Y+1,Tipo19,X,Y+2,Tipo20,X,Y-1,Tipo21,Dir6,X,Y-1);
		}
	}
	
		// Si se encontr� una T
	if(.length(ListaTIzquierda)>0){
			for(.member(celda(X,Y),ListaTIzquierda) ){
			
			//Se consulta el tipo de cada coordenada de la figura
			?tablero(celda(X-1,Y,_),ficha(Color,Tipo22));
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo23));
			?tablero(celda(X+2,Y,_),ficha(Color,Tipo24));
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo25));
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo26));
			?dir(Dir7,3);
			
			//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar2(X-1,Y,Tipo22,X+1,Y,Tipo23,X+2,Y,Tipo24,X,Y-1,Tipo25,X,Y+1,Tipo26,Dir7,X-1,Y);
		}
	}
	
	// Si se encontr� una T
	if(.length(ListaTDerecha)>0){
			for(.member(celda(X,Y),ListaTDerecha) ){
			
			//Se consulta el tipo de cada coordenada de la figura
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo27));
			?tablero(celda(X-1,Y,_),ficha(Color,Tipo28));
			?tablero(celda(X-2,Y,_),ficha(Color,Tipo29));
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo30));
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo31));
			?dir(Dir8,2);
			
			//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar2(X+1,Y,Tipo27,X-1,Y,Tipo28,X-2,Y,Tipo29,X,Y-1,Tipo30,X,Y+1,Tipo31,Dir8,X+1,Y);
		}
	}
	//Se llama a la siguiente comprobacion de figuras
	!comprobar43.
	
+!comprobarT3 <-
.print("�No se est� recibiendo la creencia del valor de los propietarios para cada jugador!");
!comprobar43.	
	

//Comprueba si hay figura de 4 fichas para conquistar territorio
+!comprobar43  <- 

//Se realiza una busqueda para cada una de las posibles posiciones de la figura cuadruple
.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_)) & tablero(celda(X-1,Y,_),ficha(Color,_)) &
tablero(celda(X-2,Y,_),ficha(Color,_)) &  
tablero(celda(X+1,Y,_),ficha(Color,_))  & (tablero(celda(X,Y-1,0),ficha(Color,_)) | tablero(celda(X,Y+1,0),ficha(Color,_))),Lista4HDerecha);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X-1,Y,_),ficha(Color,_)) &
tablero(celda(X+1,Y,_),ficha(Color,_)) &  
tablero(celda(X+2,Y,_),ficha(Color,_))  & (tablero(celda(X,Y-1,0),ficha(Color,_)) | tablero(celda(X,Y+1,0),ficha(Color,_))),Lista4HIzquierda);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X,Y-1,_),ficha(Color,_)) &
tablero(celda(X,Y+1,_),ficha(Color,_)) &  
tablero(celda(X,Y+2,_),ficha(Color,_))  & (tablero(celda(X-1,Y,0),ficha(Color,_)) | tablero(celda(X+1,Y,0),ficha(Color,_))),Lista4YArriba);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X,Y+1,_),ficha(Color,_)) &
tablero(celda(X,Y-1,_),ficha(Color,_)) &  
tablero(celda(X,Y-2,_),ficha(Color,_))  & (tablero(celda(X-1,Y,0),ficha(Color,_)) | tablero(celda(X+1,Y,0),ficha(Color,_))),Lista4YAbajo);

	// Si se encontr� una cuadruple
	if(.length(Lista4HDerecha)>0){
			
			//Se recorre la lista
			for(.member(celda(X,Y),Lista4HDerecha) ){
				
				//Se consulta el tipo de cada coordenada de la figura
				?tablero(celda(X-2,Y,_),ficha(Color,Tipo32));
				?tablero(celda(X-1,Y,_),ficha(Color,Tipo33));
				?tablero(celda(X+1,Y,_),ficha(Color,Tipo34));
				
				//si la ficha dada tiene el mismo color que las restantes de la figura
				if(tablero(celda(X,Y+1,_),ficha(Color,_))){
				?tablero(celda(X,Y+1,_),ficha(Color,Tipo35));
				?dir(Dir9,0);
				
				//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
				!contar2(X-2,Y,Tipo32,X-1,Y,Tipo33,X+1,Y,Tipo34,X,Y+1,Tipo35,6,6,6,Dir9,X,Y+1);
				}
				
				//si la ficha dada tiene el mismo color que las restantes de la figura
				if(tablero(celda(X,Y-1,_),ficha(Color,_))){
				?tablero(celda(X,Y-1,_),ficha(Color,Tipo36));
				?dir(Dir10,1);
				
				//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
				!contar2(X-2,Y,Tipo32,X-1,Y,Tipo33,X+1,Y,Tipo34,X,Y-1,Tipo36,6,6,6,Dir10,X,Y-1);
				}
		
		}

	
	}
	
	// Si se encontr� una cuadruple
	if(.length(Lista4HIzquierda)>0){
	
	for(.member(celda(X,Y),Lista4HIzquierda) ){
			?tablero(celda(X-1,Y,_),ficha(Color,Tipo37));
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo38));
			?tablero(celda(X+2,Y,_),ficha(Color,Tipo39));
		
			if(tablero(celda(X,Y+1,_),ficha(Color,_))){
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo40));
			?dir(Dir11,0);
			
			//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar2(X-1,Y,Tipo37,X+1,Y,Tipo38,X+2,Y,Tipo39,X,Y+1,Tipo40,6,6,6,Dir11,X,Y+1);
			}
			
			if(tablero(celda(X,Y-1,_),ficha(Color,_))){
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo41));
			?dir(Dir12,1);
			
			//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar2(X-1,Y,Tipo37,X+1,Y,Tipo38,X+2,Y,Tipo39,X,Y-1,Tipo41,6,6,6,Dir12,X,Y-1);
			}
		}
	}
	
	// Si se encontr� una cuadruple
	if(.length(Lista4YArriba)>0){
		
	for(.member(celda(X,Y),Lista4YArriba) ){
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo42));
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo43));
			?tablero(celda(X,Y+2,_),ficha(Color,Tipo44));
		
			if(tablero(celda(X-1,Y,_),ficha(Color,_))){
			?tablero(celda(X-1,Y,_),ficha(Color,Tipo45));
			?dir(Dir13,3);
			
			//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar2(X,Y-1,Tipo42,X,Y+1,Tipo43,X,Y+2,Tipo44,X-1,Y,Tipo45,6,6,6,Dir13,X-1,Y);
			
			}
			
			if(tablero(celda(X+1,Y,_),ficha(Color,_))){
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo46));
			?dir(Dir14,2);
			//Recibe las coordenadas de la figura, los tipos de cada ficha y la ficha que se va a mover
			!contar2(X,Y-1,Tipo42,X,Y+1,Tipo43,X,Y+2,Tipo44,X+1,Y,Tipo46,6,6,6,Dir14,X+1,Y);
			}
		}
	}
	
	// Si se encontr� una cuadruple
	if(.length(Lista4YAbajo)>0){

	for(.member(celda(X,Y),Lista4YAbajo) ){
		
			?tablero(celda(X,Y-1,_),ficha(Color,Tipo47));
			?tablero(celda(X,Y+1,_),ficha(Color,Tipo48));
			?tablero(celda(X,Y-2,_),ficha(Color,Tipo49));
		
			if(tablero(celda(X-1,Y,_),ficha(Color,_))){
			?tablero(celda(X-1,Y,_),ficha(Color,Tipo50));
			?dir(Dir15,3);
			
			//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar2(X,Y-1,Tipo47,X,Y+1,Tipo48,X,Y-2,Tipo49,X-1,Y,Tipo50,6,6,6,Dir15,X-1,Y);
			}
			
			if(tablero(celda(X+1,Y,_),ficha(Color,_))){
			?tablero(celda(X+1,Y,_),ficha(Color,Tipo51));
			?dir(Dir16,2);
			
			//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
			!contar1(X,Y-1,Tipo47,X,Y+1,Tipo48,X,Y-2,Tipo49,X+1,Y,Tipo51,6,6,6,Dir16,X+1,Y);
			}
		}
	}
	//Se llama al no encontrar ninguna ficha cuadruple
	!comprobarCuadrado3.
	
+!comprobar43  <-
.print("�No se est� recibiendo la creencia del valor de los propietarios para cada jugador!");
!comprobarCudrado3.	
	
//Comprueba si hay figura cuadrado para conquistar territorio	
+!comprobarCuadrado3 <-

//Se realiza una busqueda para cada una de las posibles posiciones de la figura cuadrado
.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_)) & tablero(celda(X+1,Y,_),ficha(Color,_)) &
tablero(celda(X,Y+1,_),ficha(Color,_)) &  
tablero(celda(X+1,Y+1,_),ficha(Color,_))  & (tablero(celda(X-1,Y,0),ficha(Color,_)) | tablero(celda(X,Y-1,0),ficha(Color,_))),ListaCuadradoUpI);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_)) & tablero(celda(X-1,Y,_),ficha(Color,_)) &
tablero(celda(X-1,Y+1,_),ficha(Color,_)) &  
tablero(celda(X,Y+1,_),ficha(Color,_))  & (tablero(celda(X,Y-1,0),ficha(Color,_)) | tablero(celda(X+1,Y,0),ficha(Color,_))),ListaCuadradoUpD);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_)) & tablero(celda(X+1,Y,_),ficha(Color,_)) &
tablero(celda(X,Y-1,_),ficha(Color,_)) &  
tablero(celda(X+1,Y-1,_),ficha(Color,_))  & (tablero(celda(X-1,Y,0),ficha(Color,_)) | tablero(celda(X,Y+1,0),ficha(Color,_))),ListaCuadradoDI);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_)) & tablero(celda(X,Y-1,_),ficha(Color,_)) &
tablero(celda(X-1,Y,_),ficha(Color,_)) &  
tablero(celda(X-1,Y-1,_),ficha(Color,_))  & (tablero(celda(X+1,Y,0),ficha(Color,_)) | tablero(celda(X,Y+1,0),ficha(Color,_))),ListaCuadradoDD);

	if(.length(ListaCuadradoUpI)>0){ 

		for(.member(celda(X,Y),ListaCuadradoUpI) ){
		//se consulta el tipo de todas las fichas de la figura para enviarselo a contar2
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo52));
		?tablero(celda(X+1,Y+1,_),ficha(Color,Tipo53));
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo54));
	
		if(tablero(celda(X-1,Y,_),ficha(Color,_))){
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo55));
		?dir(Dir17,3);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X+1,Y,Tipo52,X+1,Y+1,Tipo53,X,Y+1,Tipo54,X-1,Y,Tipo55,6,6,6,Dir17,X-1,Y);
		}
		
		if(tablero(celda(X,Y-1,_),ficha(Color,_))){
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo56));
		?dir(Dir18,1);
		
		//Se envia al plan contar1 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X+1,Y,Tipo52,X+1,Y+1,Tipo53,X,Y+1,Tipo54,X,Y-1,Tipo56,6,6,6,Dir18,X,Y-1);
		}
		}
	}
	
	if(.length(ListaCuadradoUpD)>0){

	for(.member(celda(X,Y),ListaCuadradoUpD)){
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo57));
		?tablero(celda(X-1,Y+1,_),ficha(Color,Tipo58));
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo59));
	
		if(tablero(celda(X+1,Y,_),ficha(Color,_))){
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo60));
		?dir(Dir19,2);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X-1,Y,Tipo57,X-1,Y+1,Tipo58,X,Y+1,Tipo59,X+1,Y,Tipo60,6,6,6,Dir19,X+1,Y);
		}
		
		if(tablero(celda(X,Y-1,_),ficha(Color,_))){
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo61));
		?dir(Dir20,1);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X-1,Y,Tipo57,X-1,Y+1,Tipo58,X,Y+1,Tipo59,X,Y-1,Tipo61,6,6,6,Dir20,X,Y-1);
		}
		}
	}
	
	if(.length(ListaCuadradoDI)>0){

	for(.member(celda(X,Y),ListaCuadradoDI)){
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo62));
		?tablero(celda(X+1,Y-1,_),ficha(Color,Tipo63));
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo64));
	
		if(tablero(celda(X-1,Y,_),ficha(Color,_))){
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo65));
		?dir(Dir21,3);
		
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X+1,Y,Tipo62,X+1,Y-1,Tipo63,X,Y-1,Tipo64,X-1,Y,Tipo65,6,6,6,Dir21,X-1,Y);
		}
		
		if(tablero(celda(X,Y+1,_),ficha(Color,_))){
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo66));
		?dir(Dir22,0);
		
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X+1,Y,Tipo62,X+1,Y-1,Tipo63,X,Y-1,Tipo64,X,Y+1,Tipo66,6,6,6,Dir22,X,Y+1);
		}
		}
	}
	
	
	if(.length(ListaCuadradoDD)>0){
		
	for(.member(celda(X,Y),ListaCuadradoDD)){
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo67));
		?tablero(celda(X-1,Y-1,_),ficha(Color,Tipo68));
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo69));
	
		if(tablero(celda(X+1,Y,_),ficha(Color,_))){
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo70));
		?dir(Dir23,2);
		//Recibe las coordenadas de la figura, los tipos de cada ficha y la ficha que se va a mover
		!contar2(X-1,Y,Tipo67,X-1,Y-1,Tipo68,X,Y-1,Tipo69,X+1,Y,Tipo70,6,6,6,Dir23,X+1,Y);
		}
		
		if(tablero(celda(X,Y+1,_),ficha(Color,_))){
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo71));
		?dir(Dir24,0);
		//Recibe las coordenadas de la figura, los tipos de cada ficha y la ficha que se va a mover
		!contar2(X-1,Y,Tipo67,X-1,Y-1,Tipo68,X,Y-1,Tipo69,X,Y+1,Tipo71,6,6,6,Dir24,X,Y+1);
		}
		}
	}
	//Se llama al no encontrar ningun cuadrado
	!comprobarTriple3.
	
+!comprobarCuadrado3  <-
.print("�No se est� recibiendo la creencia del valor de los propietarios para cada jugador!");
!comprobarTriple3.	
	
//Comprueba si hay figura de 3 fichas para conquistar territorio
+!comprobarTriple3  <-

//Se realiza una busqueda para cada una de las posibles posiciones de la figura triple
.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X-1,Y,_),ficha(Color,_)) &
tablero(celda(X-2,Y,_),ficha(Color,_)) &  
(tablero(celda(X+1,Y,0),ficha(Color,_)) | tablero(celda(X,Y-1,0),ficha(Color,_)) | tablero(celda(X,Y+1,0),ficha(Color,_))),Lista3HD);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))   & tablero(celda(X-1,Y,_),ficha(Color,_)) &
tablero(celda(X+1,Y,_),ficha(Color,_)) &  
(tablero(celda(X,Y-1,0),ficha(Color,_)) | tablero(celda(X,Y+1,0),ficha(Color,_))),Lista3HMedio);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X+1,Y,_),ficha(Color,_)) &
tablero(celda(X+2,Y,_),ficha(Color,_)) &  
(tablero(celda(X-1,Y,0),ficha(Color,_)) | tablero(celda(X,Y-1,0),ficha(Color,_)) | tablero(celda(X,Y+1,0),ficha(Color,_))),Lista3HI);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))   & tablero(celda(X,Y-1,_),ficha(Color,_)) &
tablero(celda(X,Y-2,_),ficha(Color,_)) & 
(tablero(celda(X-1,Y,0),ficha(Color,_)) | tablero(celda(X+1,Y,0),ficha(Color,_)) | tablero(celda(X,Y+1,0),ficha(Color,_))),Lista3VAbajo);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))   & tablero(celda(X,Y-1,_),ficha(Color,_)) &
tablero(celda(X,Y+1,_),ficha(Color,_)) &  
(tablero(celda(X+1,Y,0),ficha(Color,_)) | tablero(celda(X-1,Y,0),ficha(Color,_))),Lista3VM);

.findall(celda(X,Y),tablero(celda(X,Y,_),ficha(_,_))  & tablero(celda(X,Y+1,_),ficha(Color,_)) &
tablero(celda(X,Y+2,_),ficha(Color,_)) & 
(tablero(celda(X-1,Y,0),ficha(Color,_)) | tablero(celda(X+1,Y,0),ficha(Color,_)) | tablero(celda(X,Y-1,0),ficha(Color,_))),Lista3VArriba);


	if(.length(Lista3HMedio)>0){ 
	for(.member(celda(X,Y),Lista3HMedio)){
		
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo72));
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo73));
	
		if(tablero(celda(X,Y+1,_),ficha(Color,_))){
		
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo74));
		?dir(Dir25,0);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X-1,Y,Tipo72,X+1,Y,Tipo73,X,Y+1,Tipo74,6,6,6,6,6,6,Dir25,X,Y+1);
		}
		
		if(tablero(celda(X,Y-1,_),ficha(Color,_))){
		
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo75));
		?dir(Dir26,1);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X-1,Y,Tipo72,X+1,Y,Tipo73,X,Y-1,Tipo75,6,6,6,6,6,6,Dir26,X,Y-1);
		}
		}
	}
	

	if(.length(Lista3HI)>0){

	for(.member(celda(X,Y),Lista3HI)){
		
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo76));
		?tablero(celda(X+2,Y,_),ficha(Color,Tipo77));
	
		if(tablero(celda(X,Y+1,_),ficha(Color,_))){
		
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo78));
		?dir(Dir27,0);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X+1,Y,Tipo76,X+2,Y,Tipo77,X,Y+1,Tipo78,6,6,6,6,6,6,Dir27,X,Y+1);
		}
		
		if(tablero(celda(X,Y-1,_),ficha(Color,_))){
	
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo79));
		?dir(Dir28,1);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X+1,Y,Tipo76,X+2,Y,Tipo77,X,Y-1,Tipo79,6,6,6,6,6,6,Dir28,X,Y-1);
		}
		
		if(tablero(celda(X-1,Y,_),ficha(Color,_))){
		
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo80));
		?dir(Dir29,3);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X+1,Y,Tipo76,X+2,Y,Tipo77,X-1,Y,Tipo80,6,6,6,6,6,6,Dir29,X-1,Y);
		}
		}
	}
	

	if(.length(Lista3HD)>0){
	
	for(.member(celda(X,Y),Lista3HD)){
		
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo81));
		?tablero(celda(X-2,Y,_),ficha(Color,Tipo82));
		
		if(tablero(celda(X,Y+1,_),ficha(Color,_))){

		?tablero(celda(X,Y+1,_),ficha(Color,Tipo83));
		?dir(Dir30,0);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X-1,Y,Tipo81,X-2,Y,Tipo82,X,Y+1,Tipo83,6,6,6,6,6,6,Dir30,X,Y+1);		
		}
	
		if(tablero(celda(X,Y-1,_),ficha(Color,_))){
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo84));
		?dir(Dir31,1);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X-1,Y,Tipo81,X-2,Y,Tipo82,X,Y-1,Tipo84,6,6,6,6,6,6,Dir31,X,Y-1);
		}
		
		if(tablero(celda(X+1,Y,_),ficha(Color,_))){
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo85));
		?dir(Dir32,2);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X-1,Y,Tipo81,X-2,Y,Tipo82,X+1,Y,Tipo85,6,6,6,6,6,6,Dir32,X+1,Y);
		
		}	
		}
	}
	
	

	if(.length(Lista3VAbajo)>0){

	for(.member(celda(X,Y),Lista3VAbajo)){
		
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo86));
		?tablero(celda(X,Y-2,_),ficha(Color,Tipo87));
	
		if(tablero(celda(X+1,Y,_),ficha(Color,_))){

		?tablero(celda(X+1,Y,_),ficha(Color,Tipo88));
		?dir(Dir33,2);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X,Y-1,Tipo86,X,Y-2,Tipo87,X+1,Y,Tipo88,6,6,6,6,6,6,Dir33,X+1,Y);
		}
		
		if(tablero(celda(X-1,Y,_),ficha(Color,_))){
	
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo89));
		?dir(Dir34,3);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X,Y-1,Tipo86,X,Y-2,Tipo87,X-1,Y,Tipo89,6,6,6,6,6,6,Dir34,X-1,Y);
		}
		
		if(tablero(celda(X,Y+1,_),ficha(Color,_))){
	
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo900));
		?dir(Dir35,0);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X,Y-1,Tipo86,X,Y-2,Tipo87,X1,Y+1,Tipo900,6,6,6,6,6,6,Dir35,X,Y+1);
		
		}
		}
	}
	

	if(.length(Lista3VArriba)>0){

		for(.member(celda(X,Y),Lista3VArriba)){
		
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo90));
		?tablero(celda(X,Y+2,_),ficha(Color,Tipo91));
	
		if(tablero(celda(X-1,Y,_),ficha(Color,_))){
			
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo92));
		?dir(Dir36,3);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X,Y+1,Tipo90,X,Y+2,Tipo91,X-1,Y,Tipo92,6,6,6,6,6,6,Dir36,X-1,Y);
		}
		
		if(tablero(celda(X+1,Y,_),ficha(Color,_))){
	
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo93));
		?dir(Dir37,2);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X,Y+1,Tipo90,X,Y+2,Tipo91,X+1,Y,Tipo93,6,6,6,6,6,6,Dir37,X+1,Y);
		}
		
		if(tablero(celda(X,Y-1,_),ficha(Color,_))){
			
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo94));
		?dir(Dir38,1);
		
		//Se envia al plan contar2 todas las coordenadas de la figura y la direcci�n del posible movimiento
		!contar2(X,Y+1,Tipo90,X,Y+2,Tipo91,X,Y-1,Tipo94,6,6,6,6,6,6,Dir38,X,Y-1);
		
		}
		}
	}
	
	if(.length(Lista3VM)>0){
	
	for(.member(celda(X,Y),Lista3VM)){
		
		?tablero(celda(X,Y-1,_),ficha(Color,Tipo95));
		?tablero(celda(X,Y+1,_),ficha(Color,Tipo96));
	
		if(tablero(celda(X+1,Y,_),ficha(Color,_))){
	
		?tablero(celda(X+1,Y,_),ficha(Color,Tipo97));
		?dir(Dir39,2);
		//Recibe las coordenadas de la figura, los tipos de cada ficha y la ficha que se va a mover
		!contar2(X,Y-1,Tipo95,X,Y+1,Tipo96,X+1,Y,Tipo97,6,6,6,6,6,6,Dir39,X+1,Y);
		}
		
		if(tablero(celda(X-1,Y,_),ficha(Color,_))){
		?tablero(celda(X-1,Y,_),ficha(Color,Tipo98));
		?dir(Dir40,3);
		//Recibe las coordenadas de la figura, los tipos de cada ficha y la ficha que se va a mover
		!contar2(X,Y-1,Tipo95,X,Y+1,Tipo96,X-1,Y,Tipo98,6,6,6,6,6,6,Dir40,X-1,Y);
		}
		}
	}
	
	.wait(600);
	//se consulta la bandera que se activa si se encontr� una figura con propietario
	?bandera(S);
	//Si no se encontr� una figura con propietario se pasa a comprobar figura sin propietario
	if(S=0){
			!movimientoRamdon;
	}else{
	
	// si se encontr� un movimiento con propietario se efectura
	?siguiente2(moverDesdeEnDireccion(pos(X1,Y1),Dir));		
	.print("Muevo la casilla ",X1," ",Y1," hacia ",Dir);
	.send(judge,tell,moverDesdeEnDireccion(pos(X1,Y1),Dir));
	.send(judge,untell,moverDesdeEnDireccion(pos(X1,Y1),Dir));
	
	// se resetea la bandera y el contador de celdas conquistadas por el movimiento
	-+bandera(0);
	-+contador2(0);
	}. 

+!comprobarTriple3  <-
.print("�No se est� recibiendo la creencia del valor de los propietarios para cada jugador!");
	!movimientoRamdon.
	
	
//Calcula los puntos obtenidos por la explosi�n de las posiciones pasados por parametro
//guarda el movimiento que conquista m�s celdas priorizando el robo de celdas al rival
+!contar1(X1,Y1,Tipo1,X2,Y2,Tipo2,X3,Y3,Tipo3,X4,Y4,Tipo4,X5,Y5,Tipo5,Dir1,X,Y) : size(N) <-
	
	//se resetea el contador de celdas
	-+contador1(0);
	
	//se activa la bandera para que no se realice un movimiento sin propietario
	-+bandera(1);
	
	//se llama para cada par de coordenadas a este plan que contar� las celdas 
	//que se conquistar�n con la explosion de la ficha
	!sumadorParcial(X1,Y1,Tipo1,Dir1);
	.wait(10);
	!sumadorParcial(X2,Y2,Tipo2,Dir1);
	.wait(10);
	!sumadorParcial(X3,Y3,Tipo3,Dir1);
	.wait(10);
	!sumadorParcial(X4,Y4,Tipo4,Dir1);
	.wait(10);
	!sumadorParcial(X5,Y5,Tipo5,Dir1);
	.wait(10);
	
	//Se consultan los contadores
	?contador2(Z);
	?contador1(U);

	//si el contador actual es mayor que el almacenado del movimiento anterior
	//se guarda el movimiento
	if(U>Z){
	-+contador2(U);
	-+siguiente(moverDesdeEnDireccion(pos(X,Y),Dir1));
	
	
	}. 	
	
	
+!contar1 <-
	.print("ERROR es necesario la creencia del tama�o del tablero").
	
	
	
+!contar2(X1,Y1,Tipo1,X2,Y2,Tipo2,X3,Y3,Tipo3,X4,Y4,Tipo4,X5,Y5,Tipo5,Dir1,X,Y) : size(N) <-
	//se resetea el contador de celdas
	-+contador1(0);
	
	//se activa la bandera para que no se realice un movimiento sin propietario
	-+bandera(1);
	
	//se llama para cada par de coordenadas a este plan que sumar� los puntos en funci�n del tipo de ficha que sea
	!sumadorParcial2(X1,Y1,Tipo1,Dir1);
	.wait(10);
	!sumadorParcial2(X2,Y2,Tipo2,Dir1);
	.wait(10);
	!sumadorParcial2(X3,Y3,Tipo3,Dir1);
	.wait(10);
	!sumadorParcial2(X4,Y4,Tipo4,Dir1);
	.wait(10);
	!sumadorParcial2(X5,Y5,Tipo5,Dir1);
	.wait(10);
	
	//Se consultan los contadores
	?contador2(Z);
	?contador1(U);

	//si el contador actual es mayor que el almacenado del movimiento anterior
	//se guarda el movimiento
	if(U>Z){
	-+contador2(U);
	-+siguiente2(moverDesdeEnDireccion(pos(X,Y),Dir1));
	
	
	}. 	
	
	
+!contar2 <-
	.print("ERROR es necesario la creencia del tama�o del tablero").	
	

//Se realiza la suma de las fichas que se conquistar�an con la explosi�n
//de la celda pasada como parametro en funcion del tipo
+!sumadorParcial(X1,Y1,Tipo1,Dir1) <-

//se consulta el valor del owner del jugador actual y del rival
?propietario(OwnerPlayer1);
?propietarioRival(OwnerPlayer2);
	
	//se realiza la suma si las coordenadas pasados por parametro est�n dentro del tablero
	if(not X1<0 & not X1>N-1 & not Y1<0 & not Y1>N-1){
	
	//si la ficha es de tipo IN
	if(Tipo1==in){
		
		?tablero(celda(X1,Y1,Prop1),_);
		//si la celda pertenece al rival, sumando m�s puntos si la celda pertenece al rival
		if(Prop1=OwnerPlayer2){
		?contador1(P1);
		//se incrementa el contador con 2 puntos
		-+contador1(P1+2);
		}else{
			//si la celda no tiene propietario
			if(Prop1=0){
		 ?contador1(P3);
		 //se incrementa el contador con 1 punto
		-+contador1(P3+1);
			}else{
			//si la celda nos pertence
			if(Prop1=OwnerPlayer1){
			//se incrementa el contador 0.05 puntos
			 ?contador1(P2);
			 -+contador1(P2+0.05);	
			}
			}
		}
	
	}else{
	
		//si la ficha es de tipo IN
		if(Tipo1==gs){
			//se consulta el valor del owner de la celda  pasada por parametro
			?tablero(celda(X1,Y1,Prop2),_);
			//si la celda pertenece al propietario, sumando m�s puntos si la celda pertenece al rival
			if(Prop2=OwnerPlayer2){
			?contador1(P4);
			-+contador1(P4+3);
			}else{
				//si la celda no tiene propietario
				if(Prop2=0){
			 ?contador1(P5);
			-+contador1(P5+2);
				}else{
				
				//si la celda nos pertenece
				if(Prop2=OwnerPlayer1){
				 ?contador1(P6);
				 -+contador1(P6+0.50);	
				}
				}
			}
			}else{
		
		//si la ficha es de tipo IN
		if(Tipo1==co){
		
		//Se comprueban el Owner de las celdas superior que explotarian y las celdas inferiores
		
		//se comprueba la celda superior a explotar
		if(not Y1=0){
		
		?tablero(celda(X1,Y1-1,Prop3),_);
		
		//se suman los puntos en funcion del propietario, sumando m�s puntos si la celda pertenece al rival
		if(Prop3=OwnerPlayer2){
		?contador1(P7);
		-+contador1(P7+2);
		}else{
			if(Prop3=0){
		 ?contador1(P8);
		-+contador1(P8+1);
			}else{
			if(Prop3=OwnerPlayer1){
			 ?contador1(P9);
			 -+contador1(P9+0.05);	
			}
			}
		}
		}
		
		//se comprueba la celda superior a explotar
		if(not X1=0 & not Y1=0){
		?tablero(celda(X1-1,Y1-1,Prop4),_);
		
			//se suman los puntos en funcion del propietario, sumando m�s puntos si la celda pertenece al rival
			if(Prop4=OwnerPlayer2){
		?contador1(P10);
		-+contador1(P10+2);
		}else{
			if(Prop4=0){
		 ?contador1(P11);
		-+contador1(P11+1);
			}else{
			if(Prop4=OwnerPlayer1){
			 ?contador1(P12);
			 -+contador1(P12+0.05);	
			}
			}
		}
		}
		
		//se comprueba la celda superior a explotar
		if(not X1=N-1 & not Y1=0){
		?tablero(celda(X1+1,Y1-1,Prop5),_);
			
		//se suman los puntos en funcion del propietario, sumando m�s puntos si la celda pertenece al rival
			if(Prop5=OwnerPlayer2){
		?contador1(P13);
		-+contador1(P13+2);
		}else{
			if(Prop5=0){
		 ?contador1(P14);
		-+contador1(P14+1);
			}else{
			if(Prop5=OwnerPlayer1){
			 ?contador1(P15);
			 -+contador1(P15+0.05);	
			}
			}
		}
		}
		
		//se comprueba la celda inferior a explotar
		if(not Y1=N-1){
		?tablero(celda(X1,Y1+1,Prop6),_);
		
		//se suman los puntos en funcion del propietario, sumando m�s puntos si la celda pertenece al rival
		if(Prop6=OwnerPlayer2){
		?contador1(P16);
		-+contador1(P16+2);
		}else{
			if(Prop6=0){
		 ?contador1(P17);
		-+contador1(P17+1);
			}else{
			if(Prop6=OwnerPlayer1){
			 ?contador1(P18);
			 -+contador1(P18+0.05);	
			}
			}
		}
		}
		
		//se comprueba la celda inferior a explotar
		if(not X1=0 & not Y=N-1){
		?tablero(celda(X1-1,Y1+1,Prop7),_);
		
			//se suman los puntos en funcion del propietario, sumando m�s puntos si la celda pertenece al rival
			if(Prop7=OwnerPlayer2){
		?contador1(P19);
		-+contador1(P19+2);
		}else{
			if(Prop7=0){
		 ?contador1(P20);
		-+contador1(P20+1);
			}else{
			if(Prop7=OwnerPlayer1){
			 ?contador1(P21);
			 -+contador1(P21+0.05);	
			}
			}
		}
		}
		
		//se comprueba la celda inferior a explotar
		if(not X1=N-1 & not Y1=N-1){
		?tablero(celda(X1+1,Y1+1,Prop8),_);
		
			//se suman los puntos en funcion del propietario, sumando m�s puntos si la celda pertenece al rival
			if(Prop8=OwnerPlayer2){
		?contador1(P22);
		-+contador1(P22+2);
		}else{
			if(Prop8=0){
		 ?contador1(P23);
		-+contador1(P23+1);
			}else{
			if(Prop8=OwnerPlayer1){
			 ?contador1(P24);
			 -+contador1(P24+0.05);	
			}
			}
		}
		}
		
		}else{
		
	//si la ficha es de tipo IN
		if(Tipo1==ip){
		
		//se comprueba la direccion pasada por parametro, si es 0 o 1, es decir, si es una explosion vertical
		if(Dir1=="up" | Dir1=="down"){
		
		//se realizan tres busquedas en la columna que explotar�a la ficha ip, y se suman los puntos en funci�n del 
		//numero de fichas que pertenecen al rival, a nadie y al agente.
		.findall(celda(X,Y),tablero(celda(X1,Y,OwnerPlayer2),ficha(_,_)),ListaFilaRival);
		?contador1(P25);
		//se incrementa el contador en 2 puntos por el numero de celdas pertenecientes al rival
		-+contador1(P25+(2*(.length(ListaFilaRival))));
		
		.findall(celda(X,Y),tablero(celda(X1,Y,0),ficha(_,_)),ListaFilaSin);
		?contador1(P26);
		//se incrementa el contador en 1 puntos por el numero de celdas sin propietario
		-+contador1(P26+(.length(ListaFilaSin)));
		
		
		.findall(celda(X,Y),tablero(celda(X1,Y,OwnerPlayer1),ficha(_,_)),ListaFilaSin12);
		?contador1(P27);
		//se incrementa el contador en 0.05 puntos por el numero de celdas pertenecientes al propio jugador
		-+contador1(P27+(0.05*(.length(ListaFilaRival12))));
		
		}else{
		
		//se comprueba la direccion pasada por parametro, si es 2 o 3, es decir, si es una explosion horizontal
		if(Dir1=="right" | Dir1=="left"){
		
			//se realizan tres busquedas en la fila que explotar�a la ficha ip, y se suman los puntos en funci�n del 
		//numero de fichas que pertenecen al rival, a nadie y al agente.
		.findall(celda(X,Y),tablero(celda(X,Y1,OwnerPlayer2),ficha(_,F)),ListaFilaRival1);
		?contador1(P28);
		-+contador1(P28+(2*(.length(ListaFilaRival1))));
		
		.findall(celda(X,Y),tablero(celda(X,Y1,0),ficha(_,_)),ListaFilaSin1);
		?contador1(P29);
		-+contador1(P29+(.length(ListaFilaSin1)));
		
		.findall(celda(X,Y),tablero(celda(X,Y1,OwnerPlayer1),ficha(_,_)),ListaFilaSin13);
		?contador1(P30);
		-+contador1(P30+(0.05*(.length(ListaFilaSin13))));
		
		}
	
		}
		
		}else {
		
		//FICHAS TIPO CT
		if(Tipo1==ct){
		
		//se realizan tres busquedas de fichas con el color de la celda X1,Y1, una busqueda para las celdas de ese color
		//que pertenecen al rival, otra para las sin propietario y otra busqueda para las celdas que nos pertenecen.
		?tablero(celda(X,Y,_),ficha(Color1,_));
		//Primera busqueda de fichas del color del rival
		.findall(celda(X,Y),tablero(celda(X,Y1,OwnerPlayer2),ficha(Color1,_)),ListaColorRival1);
		?contador1(P31);
		-+contador1(P31+(2*(.length(ListaColorRival1))));
		//Segunda busqueda de fichas sin propietario
		.findall(celda(X,Y),tablero(celda(X,Y1,0),ficha(Color1,_)),ListaColorSin1);
		?contador1(P32);
		-+contador1(P32+(1*(.length(ListaColorSin1))));
		//Tercera busqueda de fichas propiedad del agente
		.findall(celda(X,Y),tablero(celda(X,Y1,OwnerPlayer1),ficha(Color1,_)),ListaColorSin14);
		?contador1(P33);
		-+contador1(P33+(0.05*(.length(ListaColorSin14))));
		}
		}
		}
		}
		}
		}.
		
//Se realiza una suma de puntos en funci�n del tipo de ficha que sea
//de este modo se prioriza la figura que tenga m�s puntos
+!sumadorParcial2(X1,Y1,Tipo1,Dir1) : size(N) <-
	
	
	//se realiza la suma si las coordenadas pasados por parametro est�n dentro del tablero
	if(not X1<0 & not X1>N-1 & not Y1<0 & not Y1>N-1){
	
	//si la ficha es de tipo IN
	if(Tipo1==in){
		
		 ?contador1(P3);
		 //se incrementa el contador con 1 punto
		-+contador1(P3+1);
		
	}else{
	
		//si la ficha es de tipo GS
		if(Tipo1==gs){
		//se incrementa el contador con 5 puntos
			?contador1(P4);
			-+contador1(P4+5);
		
			}else{
		
		//si la ficha es de tipo CO
		if(Tipo1==co){
		//se incrementa el contador con 12 puntos
		?contador1(P4);
			-+contador1(P4+12);
		}else{
		
	//si la ficha es de tipo IN
		if(Tipo1==ip){
			
		//se comprueba la direccion pasada por parametro, en este caso ser�a explosion vertical
		if(Dir1="up" | Dir1="down"){
		
		//se realiza una busqueda en la columna que explotar�a la ficha ip, para saber cuantos obstaculos y celdas vacias hay
		.findall(celda(X,Y),tablero(celda(X1,Y,_),obstacle) | tablero(celda(X1,Y,_),e),ListaObstacle);
		?contador1(P5);
		//se incrementa el contador con 2 puntos m�s el tama�o del tablero menos el numero de obstaculos y celdas vacias encontrados en la columna
		-+contador1(P5+(N-.length(ListaObstacle))+2);
		
		}else{
		
	//se comprueba la direccion pasada por parametro, en este caso ser�a explosion horizontal
		if(Dir1=="right" | Dir1=="left"){
	
		//se realiza una busqueda en la columna que explotar�a la ficha ip, para saber cuantos obstaculos y celdas vacias hay
		.findall(celda(X,Y),tablero(celda(X,Y1,_) | tablero(celda(X1,Y,_),e),obstacle),ListaObstacle2);
		?contador1(P6);
		//se incrementa el contador con  os puntos por la explosion de una ficha de tipo IP
		//(2 puntos) m�s el tama�o del tablero menos el numero de obstaculos y celdas vacias encontrados en la fila
		-+contador1(P6+(N-.length(ListaObstacle2))+2);
		
		}
	
		}
		
		}else {
		
		//FICHAS TIPO CT
		if(Tipo1==ct){
		
		//se realizan una busqueda de fichas con el color de la celda X1,Y1, para saber cuantas fichas explotar�an
		?tablero(celda(X1,Y1,_),ficha(Color1,_));
		.findall(celda(X,Y),tablero(celda(X,Y1,_),ficha(Color1,_)),ListaColorRival1);
		?contador1(P31);
		//se incrementa el contador con los puntos por la explosion de una ficha de tipo CT m�s el numero 
		//de fichas del mismo color que la coordenada X1 Y1 encontradas
		-+contador1(P31+8+(1*(.length(ListaColorRival1))));
		
		}
		}
		}
		}
		}
		}.
		
	
+!movimientoRamdon : size(G) <-
	//generacion de valores aleatorios
	.random(X,5); X1=math.round(X*G-1);
	.random(Y,5); Y1=math.round(Y*G-1);
	D=math.random(3); D1=math.round(D);
	
	//consulta la direccion correspondiente al valor generado entre 0 y 3
	?dir(Dir,D1);
	
	//se envia el movimiento
	.print("Muevo la casilla Aleatoriamente",X1," ",Y1," hacia ",Dir);
	.send(judge,tell,moverDesdeEnDireccion(pos(X1,Y1),Dir));
	.send(judge,untell,moverDesdeEnDireccion(pos(X1,Y1),Dir)). 
	
	
+!movimientoRamdom <-
.print("ERROR es necesario la creencia del tama�o del tablero").
	

//Envio primer movimiento
+puedesMover [source(judge)]  <-
	
	.wait(500);
	!comprobarQuintuple.
	

//Contestacion a fuera tablero

+invalido(fueraTablero,VECES)[source(judge)] <-
	!comprobarQuintuple.
	
+deleteTableroBB [source(judge)] <-
	.abolish(tablero(X,Y)).

//Try again
+tryAgain [source(judge)]<-
	!comprobarQuintuple.

//Notificacion movimiento cuando no era mi turno	
+invalido(fueraTurno,VECES)[source(judge)] <-.print("He solicitado en fuera de turno un n�mero de ",VECES).

//Confirmacioin valido
+valido[source(judge)] <-.print("Me han confirmado el movimiento").


