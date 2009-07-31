/***************************************************************************
                              dat_procesos.qs
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

/** @File */

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
	var rutaDatos:String;
	var fichero:String;
	var nuevosAimportar:Number;
	var camposPublico[];
	var valores[];
    function oficial( context ) { interna( context ); } 
	function establecerFichero() { return this.ctx.oficial_establecerFichero() ;}
	function actualizarControles() { return this.ctx.oficial_actualizarControles() ;}
	function actualizarFichero() { return this.ctx.oficial_actualizarFichero() ;}
	function actualizarTabla() { return this.ctx.oficial_actualizarTabla() ;}
	function importar() { return this.ctx.oficial_importar() ;}
	function pbnVaciar_clicked() { return this.ctx.oficial_pbnVaciar_clicked() ;}
	function consultarNulo( campo, registro ):String { return this.ctx.oficial_consultarNulo( campo, registro ) ;}
	function crearValoresDefecto() { return this.ctx.oficial_crearValoresDefecto() ;}
	function bufferChanged( fN ) { return this.ctx.oficial_bufferChanged( fN ) ;}
	function preprocesarFichero(tabla:String, file, indicePK:String)  { return this.ctx.oficial_preprocesarFichero(tabla, file, indicePK) ;}
	function leerLinea(file, numCampos):String	{ return this.ctx.oficial_leerLinea(file, numCampos) ;}
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
	var util:FLUtil = new FLUtil();
	var tdbTabla:FLTableDB = this.child( "tdbTabla" );

	tdbTabla.setReadOnly( true );

	var cursor:FLSqlCursor = this.cursor();
	this.iface.fichero = "";
	this.iface.rutaDatos = util.sqlSelect("dat_opciones", "rutaDatos", "");
	if (cursor.valueBuffer("ficherocsv") && this.iface.rutaDatos) {
		this.iface.fichero = this.iface.rutaDatos + cursor.valueBuffer("ficherocsv");
		this.iface.actualizarTabla();
		this.iface.actualizarFichero();
	}
	
	this.iface.actualizarControles();

	connect( this.child( "pbExaminar" ), "clicked()", this, "iface.establecerFichero" );
	connect( this.child( "pbnImportar" ), "clicked()", this, "iface.importar" );
	connect( this.child( "pbnVaciar" ), "clicked()", this, "iface.pbnVaciar_clicked" );
	connect( this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged" );
	
	this.child("fdbFicheroCSV").setDisabled(true);
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_establecerFichero() 
{
	var util:FLUtil = new FLUtil();
	
	this.iface.rutaDatos = util.sqlSelect("dat_opciones", "rutaDatos", "");
	if (!File.isDir(this.iface.rutaDatos)) {
		MessageBox.warning( util.translate( "scripts", "La ruta de datos no ha sido establecida\nPuedes hacerlo en el formulario de ficheros"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return 0;
	}
	
	var rutaFich:String = FileDialog.getOpenFileName( util.translate( "scripts", "Texto CSV (*.txt;*.csv;)" ), util.translate( "scripts", "Elegir Fichero" ) );
	var F = new File(rutaFich);
	
	if (F.path + "/" != this.iface.rutaDatos) {
		MessageBox.warning( util.translate( "scripts", "Sólo es posible seleccionar ficheros de la ruta de datos:\n\n") + this.iface.rutaDatos, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return 0;
	}
	
	this.child("fdbFicheroCSV").setValue(F.name);

	this.iface.fichero = F.fullName;
	this.iface.actualizarFichero();
	this.iface.actualizarControles();
}

function oficial_actualizarControles()
{
	var tblFichero:FLTableDB = this.child( "tblFichero" );
	var pbnImportar:Object = this.child( "pbnImportar" );
	var pbnVaciar:Object = this.child( "pbnVaciar" );
	var curTabla:FLSqlCursor = this.child( "tdbTabla" ).cursor();

	if ( curTabla.size() == 0 )
		pbnVaciar.enabled = false;
	else
		pbnVaciar.enabled = true;

	if ( tblFichero.currentRow() < 0 )
		pbnImportar.enabled = false;
	else
		pbnImportar.enabled = true;
}

function oficial_actualizarFichero() 
{
	var util:FLUtil = new FLUtil();
	
	var cursor:FLSqlCursor = this.cursor();
	var codEsquema:String = cursor.valueBuffer( "codesquema" );

	if ( !this.iface.fichero || !codEsquema )
		return ;

	var curEsquema:FLSqlCursor = new FLSqlCursor( "dat_esquemas" );
	curEsquema.select( "codesquema = '" + codEsquema + "'" );
	if ( !curEsquema.first() )
		return ;

	var numCampos:Number = util.sqlSelect( "dat_correspondencias", "COUNT(*)", "codesquema = '" + codEsquema + "'" );
	if ( numCampos == false )
		numCampos = 0;

	var tblFichero:FLTableDB = this.child( "tblFichero" );
	var i:Number;

	while ( tblFichero.numRows() > 0 )
		tblFichero.removeRow( 0 );
	tblFichero.setNumCols( 0 );
	tblFichero.setNumCols( numCampos );
	for ( i = 0; i < numCampos; i++ )
		tblFichero.setColumnWidth( i, 100 );

	var qryCor:FLSqlQuery = new FLSqlQuery();
	qryCor.setTablesList( "dat_correspondencias" );
	qryCor.setSelect( "campotabla, campofichero, posicion, tipo" );
	qryCor.setFrom( "dat_correspondencias" );
	qryCor.setWhere( "codesquema = '" + codEsquema + "' ORDER BY posicion" );

	if ( !qryCor.exec() )
		return ;

	if ( !qryCor.first() )
		return ;

	var codTabla:String = curEsquema.valueBuffer( "codtabla" );
	var regExp:RegExp = new RegExp( this.iface.sep );
	regExp.global = true;
	var labels:String = util.fieldNameToAlias( qryCor.value( 0 ), codTabla ).replace( regExp, "-" );
	var posiciones:Array = [];
	var camposFichero:Array = [];
	var tipos:Array = [];

	i = 0;
	camposFichero[ i ] = qryCor.value( 1 );
	posiciones[ i ] = qryCor.value( 2 );
	tipos[ i++ ] = qryCor.value( 3 );
	while ( qryCor.next() ) {
		labels += " " + this.iface.sep + util.fieldNameToAlias( qryCor.value( 0 ), codTabla ).replace( regExp, "-" );
		camposFichero[ i ] = qryCor.value( 1 );
		posiciones[ i ] = qryCor.value( 2 );
		tipos[ i++ ] = qryCor.value( 3 );
	}
	tblFichero.setColumnLabels( this.iface.sep, labels );

	var j:Number = 0;
	var filaCampos:Boolean = util.sqlSelect( "dat_ficheros", "filacampos", "codfichero = '" + curEsquema.valueBuffer( "codfichero" ) + "'" );
	if ( filaCampos )
		j = 1;
	var lineas:Array = formRecorddat_ficheros.iface.pub_leerLineas( this.iface.fichero, j, j + 5 );
	var linea:Array = [];

	paso = 0;
	for ( i = 0; i < lineas.length; i++ ) {
		paso++;
		tblFichero.insertRows( i );
		linea = lineas[ i ].split( this.iface.sep );
		for ( j = 0; j < numCampos; j++ ) {
			if ( posiciones[ j ] < linea.length ) {
				var valor = fldatosppal.iface.pub_datoCampo( tipos[ j ], camposFichero[ j ],
				                                   linea[ posiciones[ j ] ], linea )
				            tblFichero.setText( i, j, valor );
			} else
				tblFichero.setText( i, j, "** POSICION DEL CAMPO FUERA DE RANGO" );
		}
	}
}

function oficial_actualizarTabla() 
{
	var cursor:FLSqlCursor = this.cursor();
	var codEsquema:String = cursor.valueBuffer( "codesquema" );
	var tdbTabla:FLTableDB = this.child( "tdbTabla" );
	if ( !codEsquema ) {
		tdbTabla.setTableName( "dat_void" );
		tdbTabla.refresh( true, true );
		return ;
	}

	var curEsquema:FLSqlCursor = new FLSqlCursor( "dat_esquemas" );
	curEsquema.select( "codesquema = '" + codEsquema + "'" );
	if ( !curEsquema.first() ) {
		tdbTabla.setTableName( "dat_void" );
		tdbTabla.refresh( true, true );
		return ;
	}

	tdbTabla.setTableName( curEsquema.valueBuffer( "codtabla" ) );
	tdbTabla.refresh( true, true );
}

function oficial_importar() 
{
	var cursor:FLSqlCursor = this.cursor();
	var codEsquema:String = cursor.valueBuffer( "codesquema" );

	if ( !this.iface.fichero || this.iface.fichero == "" || !codEsquema || codEsquema == "" )
		return ;

	var curEsquema:FLSqlCursor = new FLSqlCursor( "dat_esquemas" );
	curEsquema.select( "codesquema = '" + codEsquema + "'" );
	if ( !curEsquema.first() )
		return ;

	this.setDisabled( true );

	var curTabla:FLSqlCursor = new FLSqlCursor( curEsquema.valueBuffer( "codtabla" ) );
	
	// Obtener el campo clave	
	var pk:String = curTabla.primaryKey();
	var indicePK:Number = 0;
	
	
	curTabla.setActivatedCommitActions(false);
	var totalSteps:Number = formRecorddat_ficheros.iface.pub_numeroLineas( this.iface.fichero );

	if ( totalSteps > 0 ) {
		var util:FLUtil = new FLUtil();

		var qryCor:FLSqlQuery = new FLSqlQuery();
		qryCor.setTablesList( "dat_correspondencias" );
		qryCor.setSelect( "campotabla, campofichero, posicion, tipo" );
		qryCor.setFrom( "dat_correspondencias" );
		qryCor.setWhere( "codesquema = '" + codEsquema + "' ORDER BY posicion" );

		if ( !qryCor.exec() )
			return ;

		if ( !qryCor.first() )
			return ;

		var regExp:RegExp = new RegExp( this.iface.sep );
		regExp.global = true;
		var camposTabla:String = qryCor.value( 0 ).replace( regExp, "-" );
		var posiciones:Array = [];
		var camposFichero:Array = [];
		this.iface.camposPublico = [];
		var tipos:Array = [];

		i = 0;
		if (qryCor.value( 0 ) == pk) indicePK = qryCor.value( 2 );
		camposFichero[ i ] = qryCor.value( 1 );
		this.iface.camposPublico[ i ] = qryCor.value( 0 ).replace( regExp, "-" );
		posiciones[ i ] = qryCor.value( 2 );
		tipos[ i++ ] = qryCor.value( 3 );
		while ( qryCor.next() ) {
		
			if (qryCor.value( 0 ) == pk) indicePK = qryCor.value( 2 );
		
			camposTabla += this.iface.sep + qryCor.value( 0 ).replace( regExp, "-" );
			this.iface.camposPublico[ i ] = qryCor.value( 0 ).replace( regExp, "-" );
			camposFichero[ i ] = qryCor.value( 1 );
			posiciones[ i ] = qryCor.value( 2 );
			tipos[ i++ ] = qryCor.value( 3 );
		}
		
		this.iface.crearValoresDefecto();

		var j:Number = 0;
		var filaCampos:Boolean = util.sqlSelect( "dat_ficheros", "filacampos", "codfichero = '" + curEsquema.valueBuffer( "codfichero" ) + "'" );
		if ( filaCampos )
			j = 1;
		
		// Cargamos las líneas desde el fichero
		
		var linea:Array = [];
		var campos:Array = [];
		campos = camposTabla.split( this.iface.sep );
		var codTabla:String = curEsquema.valueBuffer( "codtabla" );
		var longitud:Number;
		var permiteNulo:Boolean;
		var valor;
		var ignorarRegistro:Boolean;

		this.iface.nuevosAimportar = 0;
		var lineas = this.iface.preprocesarFichero(codTabla, this.iface.fichero, indicePK);
		
		if (this.iface.nuevosAimportar > 0) totalSteps = this.iface.nuevosAimportar;
		util.createProgressDialog( util.translate( "scripts", "Importando datos..." ), totalSteps );
		paso = 0;
		for ( ii = 0; ii < lineas.length; ii++ ) {
			paso++;
			
			ignorarRegistro = false;
			linea = lineas[ ii ].split( this.iface.sep );
			curTabla.setModeAccess( curTabla.Insert );
			curTabla.refreshBuffer();
			
			for ( j = 0; j < campos.length; j++ ) {
				if ( posiciones[ j ] < linea.length ) {

					valor = fldatosppal.iface.pub_datoCampo( tipos[ j ], camposFichero[ j ], linea[ posiciones[ j ] ], linea );
					longitud = util.fieldLength( campos[ j ], codTabla );
					permiteNulo = util.fieldAllowNull( campos[ j ], codTabla );

					if ( ( !permiteNulo ) && valor == "" ) {
						valor = this.iface.consultarNulo( campos[ j ], paso );
						if ( this.iface.valores[ campos[ j ] ][ "ignorar" ] ) {
							ignorarRegistro = true;
							break;
						}
						if ( !valor ) {
							util.destroyProgressDialog();
							return ;
						}
					}
					if ( !valor ) 
							continue;
					if ( longitud > 0 && valor.toString().length > longitud )
						curTabla.setValueBuffer( campos[ j ], valor.left( longitud ) );
					else
						curTabla.setValueBuffer( campos[ j ], valor );
				}
			}
			if (!ignorarRegistro) {
				if ( !curTabla.commitBuffer() ) {
					debug(curTabla.table());
					var res = MessageBox.critical( util.translate( "scripts", "Se produjo un error en la importación\n¿Desea continuar?" ), MessageBox.No, MessageBox.Yes, MessageBox.NoButton );
					if ( res != MessageBox.Yes )
							break;
				}
			}
			util.setProgress( ii );
		}

		util.setProgress( totalSteps );
		util.destroyProgressDialog();

		this.child( "tdbTabla" ).refresh();
	}

	curTabla.setActivatedCommitActions(false);
	this.setDisabled( false );
	this.iface.actualizarControles();
}

function oficial_pbnVaciar_clicked() 
{
	var util:FLUtil = new FLUtil();
	var res = MessageBox.critical( util.translate( "scripts", "Esta acción es peligrosa, se va a proceder a eliminar\ntodos los registros de la tabla.\n\n¿Está realmente seguro?" ), MessageBox.No, MessageBox.Yes, MessageBox.NoButton );

	if ( res != MessageBox.Yes )
		return ;

	var codEsquema:String = this.cursor().valueBuffer( "codesquema" );

	var curEsquema:FLSqlCursor = new FLSqlCursor( "dat_esquemas" );
	curEsquema.select( "codesquema = '" + codEsquema + "'" );
	if ( !curEsquema.first() )
		return ;
	
	
	this.setDisabled( true );

	var curTabla:FLSqlCursor = new FLSqlCursor( curEsquema.valueBuffer( "codtabla" ) );
	var step:Number = 0;

	curTabla.select();
	var totalSteps:Number = curTabla.size();
	util.createProgressDialog( util.translate( "scripts", "Eliminando registros..." ), totalSteps );
	while ( curTabla.next() ) {
		curTabla.setModeAccess( curTabla.Del );
		curTabla.refreshBuffer();
		if ( !curTabla.commitBuffer() )
			break;
		util.setProgress( step++ );
	}
	util.setProgress( totalSteps );
	util.destroyProgressDialog();

	this.child( "tdbTabla" ).refresh();
	this.setDisabled( false );
	this.iface.actualizarControles();
}

function oficial_consultarNulo( campo, registro ):String
{
	if ( this.iface.valores[ campo ][ "ignorar" ] )
			return false;
	
	if ( this.iface.valores[ campo ][ "valor" ] != "" )
			return this.iface.valores[ campo ][ "valor" ];
	
	var util:FLUtil = new FLUtil();
	var dialog = new Dialog;
	dialog.caption = "Valores nulos";
	dialog.okButtonText = "Continuar"
	dialog.cancelButtonText = "Cancelar";
	
	var texto = new Label;
	
	texto.text = util.translate("scripts",
							"Algunos registros del fichero origen para el campo [%1]" + 
							"\ncontienen valores vacíos.").arg(campo);
	texto.text += util.translate("scripts",
							" Se detectó el fallo en el registro nº %1" + 
							"\n\nEscoja una opción:\n\n").arg(registro);
	dialog.add( texto );
	
	var valorD = new LineEdit;
	valorD.label = util.translate("scripts", "1. Introduzca el valor que tomará este campo para los valores vacíos");
	dialog.add( valorD );
	
	var ignorar = new CheckBox;
	ignorar.text = util.translate("scripts", "2. Ignorar todos registros con este campo vacío");
	dialog.add( ignorar );
	
	var texto2 = new Label;
	texto2.text = util.translate("scripts", "3. Pulse Cancelar para detener el proceso\n\n");
	dialog.add( texto2 );
	
	if( dialog.exec() ) {
		if (ignorar.checked) {
			this.iface.valores[ campo ][ "ignorar" ] = true;
			return false;
		}
	}	
	
	var valorDefecto:String	= valorD.text;
	this.iface.valores[ campo ][ "valor" ] = valorDefecto;
	return valorDefecto;
}

function oficial_crearValoresDefecto() 
{
	this.iface.valores = [];
	for ( kj = 0; kj < this.iface.camposPublico.length; kj++ ) {
		this.iface.valores[ this.iface.camposPublico[ kj ] ] = new Array(2);
		this.iface.valores[ this.iface.camposPublico[ kj ] ][ "valor" ] = "";
		this.iface.valores[ this.iface.camposPublico[ kj ] ][ "ignorar" ] = false;
	}
}

function oficial_bufferChanged( fN ) 
{
	switch ( fN ) {
	case "codesquema":
		this.iface.actualizarFichero();
		this.iface.actualizarTabla();
		this.iface.actualizarControles();
		break;
	case "ficherocsv":
		this.iface.actualizarFichero();
		this.iface.actualizarTabla();
		this.iface.actualizarControles();
		break;
	}
}

/** Recorre el fichero buscando registros existentes y devuelve un
array con los registros nuevos
@param indicePK Es el índice (posición del campo clave en la tabla)
*/
function oficial_preprocesarFichero(tabla, fichero, indicePK):Array
{
	var arrayLineas:Array = [];
	
	if ( !File.exists( fichero ) ) {
		MessageBox.warning( util.translate( "scripts", "%1\n\nEl fichero no existe." ).arg( fichero ), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return arrayLineas;
	}

	if ( !File.isFile( fichero ) ) {
		MessageBox.warning( util.translate( "scripts", "%1\n\nNo es un fichero." ).arg( fichero ), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return arrayLineas;
	}

	var file = new File( fichero );

	if ( !file.readable ) {
		MessageBox.warning( util.translate( "scripts", "%1\n\nAcceso de lectura denegado." ).arg( fichero ), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return arrayLineas;
	}

	var i:Number = 0;
	var j:Number = 0;
	var bufferLinea:String;
	var arrayBuffer = [];

	file.open( File.ReadOnly );
	
	var linea:String = file.readLine();
	var campos:Array = linea.split(this.iface.sep);
	var numCampos:Number = campos.length;
	var numLineas:Number = 0;

	// Todas las líneas
	if (!this.cursor().valueBuffer("noexistentes")) {
		while ( !file.eof )
			arrayLineas[numLineas++] = this.iface.leerLinea(file, numCampos);
		return arrayLineas;
	}
	
	// Sólo las nuevas
	var curTabla:FLSqlCursor = new FLSqlCursor(tabla);
	var pk:String = curTabla.primaryKey();
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList(tabla);
	q.setFrom(tabla);
	q.setSelect(pk);
	
	// Para evitar duplicados
	var registrosActuales:String = "";
	
	while ( !file.eof ) {
		linea = this.iface.leerLinea(file, numCampos);
		campos = linea.split(this.iface.sep);
		q.setWhere(pk + " = '" + campos[indicePK] + "'");
		q.exec();
		if (!q.first() && registrosActuales.search(campos[indicePK]) == -1) 
			arrayLineas[numLineas++] = linea;
		
		registrosActuales += this.iface.sep + campos[indicePK];
	}
	
	var util:FLUtil = new FLUtil();
	MessageBox.information( util.translate( "scripts", "Se encontraron %0 nuevos registros para importar. Pulse Aceptar para continuar").arg(numLineas), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
	
	this.iface.nuevosAimportar = numLineas;
	return arrayLineas;
}


// Algunos registros contienen saltos de línea y ocupan
// varias líneas en el fichero csv
function oficial_leerLinea(file, numCampos):String
{
	var regExp:RegExp = new RegExp( "\"" );
	regExp.global = true;
		
	contCampos = 0;
	var linea:String = "";
	
	while (contCampos < numCampos) {
		bufferLinea = file.readLine().replace( regExp, "" );
		if (bufferLinea.left(1) == "#") continue;
		linea += bufferLinea;
		arrayBuffer = bufferLinea.split(this.iface.sep);
		contCampos += arrayBuffer.length;
	}
	
	return linea;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////