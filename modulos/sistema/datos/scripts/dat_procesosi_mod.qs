/***************************************************************************
                              dat_procesosi_mod.qs
                            -------------------
   begin                : lun dic 13 2004
   copyright            : (C) 2004-2005 by InfoSiAL S.L.
   email                : mail@infosial.com
***************************************************************************/
/***************************************************************************
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; version 2 of the License.               *
 ***************************************************************************/ 
/***************************************************************************
   Este  programa es software libre. Puede redistribuirlo y/o modificarlo
   bajo  los  términos  de  la  Licencia  Pública General de GNU   en  su
   versión 2, publicada  por  la  Free  Software Foundation.
 ***************************************************************************/

/** @file */ 

////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_declaration interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var sep:String = "ð";
    function oficial( context ) { interna( context ); } 
	function establecerDirectorio() { return this.ctx.oficial_establecerDirectorio() ;}
	function importar() { return this.ctx.oficial_importar() ;}
	function ordenImportacion(listaTablas):Array { return this.ctx.oficial_ordenImportacion(listaTablas) ;}
	function obtenerRelaciones(tabla):String { return this.ctx.oficial_obtenerRelaciones(tabla) ;}
	function moduloTabla(tabla):String { return this.ctx.oficial_moduloTabla(tabla) ;}
	function vaciarModulo(listaOrdenada):Boolean { return this.ctx.oficial_vaciarModulo(listaOrdenada) ;}
	function consultarDependencias(tablas):Boolean { return this.ctx.oficial_consultarDependencias(tablas) ;}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
	function pub_obtenerRelaciones(tabla):String { return this.obtenerRelaciones(tabla) ;}
}

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_definition interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function init() {
    this.iface.init();
}

function interna_init() 
{
	connect( this.child( "pbExaminar" ), "clicked()", this, "iface.establecerDirectorio" );
	connect( this.child( "pbnImportar" ), "clicked()", this, "iface.importar" );
	
	this.child("fdbModulo").setFilter("idmodulo <> 'sys'");
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////


function oficial_establecerDirectorio() {
	var util:FLUtil = new FLUtil();
	this.child( "fdbDirCSV" ).setValue( FileDialog.getExistingDirectory( util.translate( "scripts", "Texto CSV (*.csv)" ), util.translate( "scripts", "Elegir Directorio" ) ) );
}


function oficial_importar() 
{
	var util:FLUtil = new FLUtil();
	
	var cursor:FLSqlCursor = this.cursor();
	var dir:String = cursor.valueBuffer( "dircsv" );
	var idModulo:String = cursor.valueBuffer( "idmodulo" );
	var borradoPrevio:Boolean = cursor.valueBuffer( "borradoprevio" );
	var tabla:String, fichero:String;
	var listaOrdenada:Array = [];

	if ( !dir || dir == "" || !idModulo || idModulo == "" )
		return ;
	
	if ( !File.isDir(dir)) {
		MessageBox.critical
		( util.translate( "scripts", "El directorio indicado no es válido" ),
		MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
		
	if (borradoPrevio) {
		var res = MessageBox.critical( util.translate( "scripts", "Se va a proceder a eliminar TODOS LOS DATOS DEL MÓDULO\nantes de la importación de los nuevos datos.\n\n¿Está realmente seguro?" ), MessageBox.No, MessageBox.Yes, MessageBox.NoButton );
		
		if ( res != MessageBox.Yes )
				return;
	}
				
	this.setDisabled( true );
	
	var paso:Number = 0;
			
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("flfiles");
	q.setSelect("nombre");
	q.setFrom("flfiles");
	q.setWhere("nombre like '%.mtd' AND idmodulo = '" + idModulo + "'");
	
	if (!q.exec()) return;
	
	var listaTablas:Array = [];
	while (q.next()) {
	
		tabla = q.value(0).toString().split(".");
		tabla = tabla[0];
		
		listaTablas[paso++] = tabla;
	
	}
	
	listaOrdenada = this.iface.ordenImportacion(listaTablas);
	
	if (!listaOrdenada) {
		MessageBox.critical( util.translate( "scripts", "Los datos no se importarán" ),
		MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		this.setDisabled( false );
		return ;
	}

	if (borradoPrevio) {
		if (!this.iface.vaciarModulo(listaOrdenada)) {
			MessageBox.critical( util.translate( "scripts", "Los datos no se importarán" ),	MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
			this.setDisabled( false );
			return ;
		}
	}
	
	formRecorddat_procesosi_tab.iface.pub_crearProgress( util.translate( "scripts", "Importando...\n\nProgreso total:" ),
			fldatosppal.iface.pub_lineasTablas(listaTablas, dir) );
	formRecorddat_procesosi_tab.iface.pub_setProgress(1);
	
	for (var i = 0; i < listaOrdenada.length; i++) {	
	
		if (formRecorddat_procesosi_tab.iface.pub_importarTabla(listaOrdenada[i],
				dir + listaOrdenada[i] + ".csv", true, util) == "cancel") {
			MessageBox.information ( util.translate( "scripts", "Se canceló la importación" ),	MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
			this.close();
			return;
		}
	}

 	formRecorddat_procesosi_tab.iface.pub_destroyProgress();
	
	MessageBox.information ( util.translate( "scripts", "Proceso finalizado" ),
		MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		
	this.setDisabled( false );
	this.child("pushButtonAccept").animateClick();
}

function oficial_ordenImportacion(listaTablas):Array
{
	var datosTablas:Array = [];
	var relacionesTabla:Array = [];
	var tabla:String, nomFichero:String;
	var importarTabla:Boolean;
	var tablasOtrosModulos:String = "";
	var todasImportadas:Boolean = false;
	
	var listaOrdenada:Array = [];
	var numOrden:Number = 0;
	
	var util = new FLUtil();		
	util.createProgressDialog( util.translate( "scripts", "Buscando dependencias..." ),	5);
	util.setProgress(1);
	
	// Crear el array de dependencias
	for (var i = 0; i < listaTablas.length; i++) {		
		
		tabla = listaTablas[i];
		datosTablas[tabla] = new Array(2);
		datosTablas[tabla]["importada"] = false;
		datosTablas[tabla]["relaciones"] = this.iface.obtenerRelaciones(tabla);
		
	}
	
	// Importar las que no tienen relaciones M1
	for (var i = 0; i < listaTablas.length; i++) {		
		
		tabla = listaTablas[i];
		nomFichero = tabla + ".csv";
		
		if (datosTablas[tabla]["relaciones"] == "") {
			datosTablas[tabla]["importada"] = true;
			listaOrdenada[numOrden++] = tabla;
		}
	}
	
	// Importar aquellas cuyas relacionadas ya están importadas
	var paso:Number = 0;
	while(!todasImportadas) {
	
		todasImportadas = true;
		for (var i = 0; i < listaTablas.length; i++) {
			
			tabla = listaTablas[i];
			nomFichero = tabla + ".csv";
			
			if (datosTablas[tabla]["importada"]) continue;
			todasImportadas = false;
			
			relacionesTabla = datosTablas[tabla]["relaciones"].split(this.iface.sep);
			importarTabla = true;
			
			for (var j = 0; j < relacionesTabla.length; j++) {
				
				// Si alguna no está importada salta
				switch (this.iface.moduloTabla(relacionesTabla[j])) {
				
					case "actualModulo":
						if (!datosTablas[relacionesTabla[j]]["importada"]) 
								importarTabla = false;
					break;
					
					case "noModulo":
					case "otroModulo":
						if (tablasOtrosModulos.search(relacionesTabla[j]) < 0)
								tablasOtrosModulos += "\n      " + relacionesTabla[j] 
					break;
				}
			}
			
			if (importarTabla) {
				datosTablas[tabla]["importada"] = true;
				listaOrdenada[numOrden++] = tabla;
			}
			
		}
		// Bucle de seguridad
		
		if (paso++ == 200) break;
		util.setProgress(paso);
	}
	
	util.destroyProgressDialog();
	if (!this.iface.consultarDependencias(tablasOtrosModulos)) return false;
	return listaOrdenada;
}


function oficial_obtenerRelaciones(tabla):String
{
	var util:FLUtil = new FLUtil();
	var stringRelaciones:String = "";
	
	var contenido:String = util.sqlSelect( "flfiles", "contenido", "nombre = '" + tabla + ".mtd'" );
	var nomTablaRel:String;

	xmlTabla = new FLDomDocument();
	xmlTabla.setContent(contenido);
	
	
	var listaRelaciones = xmlTabla.elementsByTagName("relation");
	if (!listaRelaciones) return "";

	for (var i = 0; i < listaRelaciones.length(); i++) {
		
		nodoRelacion = listaRelaciones.item(i);
		if (nodoRelacion.namedItem("card")) {
			if (nodoRelacion.namedItem("card").toElement().text() == "M1") {
				nomTablaRel = nodoRelacion.namedItem("table").toElement().text();
				if (nomTablaRel != tabla && nomTablaRel != "flmodules")
						stringRelaciones += nomTablaRel + this.iface.sep;
			}
		}
	}
	// Eliminar el último sep
	stringRelaciones = stringRelaciones.left(stringRelaciones.length - this.iface.sep.length)
	return stringRelaciones;
}



// Controla si una tabla pertenece a un módulo
// aún no cargado o a uno distinto al que se 
// está importando
function oficial_moduloTabla(tabla):String
{
	var util:FLUtil = new FLUtil();
	
	var modTabla:String = util.sqlSelect( "flfiles", "idmodulo",
		"nombre='" + tabla + ".mtd'");
		
	if (!modTabla) {
		return "noModulo";
	}
		
	if (modTabla != this.cursor().valueBuffer("idmodulo")) {
		return "otroModulo";
	}
	
	return "actualModulo";
}


// Se borran los registros del módulo completo en
// sentido inverso
function oficial_vaciarModulo(listaOrdenada):Boolean 
{
	var util:FLUtil = new FLUtil();
	
	fldatosppal.iface.pub_crearProgress( util.translate( "scripts", "Vaciando tablas...\n\nProgreso total:" ),
			fldatosppal.iface.pub_numRegistros(listaOrdenada) );
	fldatosppal.iface.pub_setProgress(1);
	
	for (var i = listaOrdenada.length - 1; i >= 0; i--) {	
		
		if (fldatosppal.iface.pub_vaciarTabla(listaOrdenada[i], false, true) == "cancel") {
			fldatosppal.iface.pub_destroyProgress();
			return false;
		}
	}
	
	fldatosppal.iface.pub_destroyProgress();
	return true;
}

function oficial_consultarDependencias(tablas):Boolean
{
	if (tablas == "") return true;	
	
	var util:FLUtil = new FLUtil();
	var res = MessageBox.critical
	( util.translate( "scripts", "Los datos a importar contienen relaciones con algunas tablas\npertenecientes a otros módulos. Asegúrese de que dichos módulos\nhan sido cargados y previamente importados para garantizar\nla coherencia de los datos.\n\nListado de tablas de otros módulos:") + tablas + util.translate( "scripts", "\n\n¿Desea continuar con la importación?" ),
	MessageBox.Yes, MessageBox.No, MessageBox.NoButton );

	if ( res != MessageBox.Yes )
		return false;
		
	return true;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////