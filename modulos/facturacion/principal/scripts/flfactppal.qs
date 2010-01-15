/***************************************************************************
                 flfactppal.qs  -  description
                             -------------------
    begin                : lun abr 26 2004
    copyright            : (C) 2004-2006 by InfoSiAL S.L.
    email                : mail@infosial.com
 ***************************************************************************/
/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/** @file */

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
	var ctx:Object;
	function interna( context ) { this.ctx = context; }
	function init() { this.ctx.interna_init(); }
	function afterCommit_dirclientes(curDirCli:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_dirclientes(curDirCli);
	}
	function afterCommit_dirproveedores(curDirProv:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_dirproveedores(curDirProv);
	}
	function afterCommit_clientes(curCliente:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_clientes(curCliente);
	}
	function beforeCommit_clientes(curCliente:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_clientes(curCliente);
	}
	function afterCommit_proveedores(curProveedor:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_proveedores(curProveedor);
	}
	function beforeCommit_proveedores(curProveedor:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_proveedores(curProveedor);
	}
	function afterCommit_empresa(curEmpresa:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_empresa(curEmpresa);
	}
	function beforeCommit_cuentasbcocli(curCuenta:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_cuentasbcocli(curCuenta);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); }
	function msgNoDisponible(nombreModulo:String) {
		return this.ctx.oficial_msgNoDisponible(nombreModulo);
	}
	function ejecutarQry(tabla:String, campos:String, where:String, listaTablas:String):Array {
		return this.ctx.oficial_ejecutarQry(tabla, campos, where, listaTablas);
	}
	function valorDefectoEmpresa(fN:String):String {
		return this.ctx.oficial_valorDefectoEmpresa(fN);
	}
	function cerosIzquierda(numero:String, totalCifras:Number):String {
		return this.ctx.oficial_cerosIzquierda(numero, totalCifras);
	}
	function espaciosDerecha(texto:String, totalLongitud:Number):String {
		return this.ctx.oficial_espaciosDerecha(texto, totalLongitud);
	}
	function valoresIniciales() {
		return this.ctx.oficial_valoresIniciales();
	}
	function valorQuery(tablas:String, select:String, from:String, where:String):Array {
		return this.ctx.oficial_valorQuery(tablas, select, from, where);
	}
	function crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number {
		return this.ctx.oficial_crearSubcuenta(codSubcuenta, descripcion, idCuentaEsp, codEjercicio);
	}
	function borrarSubcuenta(idSubcuenta:String):Boolean {
		return this.ctx.oficial_borrarSubcuenta(idSubcuenta);
	}
	function ejercicioActual():String {
		return this.ctx.oficial_ejercicioActual();
	}
	function cambiarEjercicioActual(codEjercicio:String):Boolean {
		return this.ctx.oficial_cambiarEjercicioActual(codEjercicio);
	}
	function datosCtaCliente(codCliente:String, valoresDefecto:Array):Array {
		return this.ctx.oficial_datosCtaCliente(codCliente, valoresDefecto);
	}
	function datosCtaProveedor(codProveedor:String, valoresDefecto:Array):Array {
		return this.ctx.oficial_datosCtaProveedor(codProveedor, valoresDefecto);
	}
	function calcularIntervalo(codIntervalo:String):Array {
		return this.ctx.oficial_calcularIntervalo(codIntervalo);
	}
	function crearSubcuentaCli(codSubcuenta:String, idSubcuenta:Number, codCliente:String, codEjercicio:String):Boolean {
		return this.ctx.oficial_crearSubcuentaCli(codSubcuenta, idSubcuenta, codCliente, codEjercicio);
	}
	function rellenarSubcuentasCli(codCliente:String, codSubcuenta:String, nombre:String):Boolean {
		return this.ctx.oficial_rellenarSubcuentasCli(codCliente, codSubcuenta, nombre);
	}
	function crearSubcuentaProv(codSubcuenta:String, idSubcuenta:Number, codProveedor:String, codEjercicio:String):Boolean {
		return this.ctx.oficial_crearSubcuentaProv(codSubcuenta, idSubcuenta, codProveedor, codEjercicio);
	}
	function rellenarSubcuentasProv(codProveedor:String, codSubcuenta:String, nombre:String):Boolean {
		return this.ctx.oficial_rellenarSubcuentasProv(codProveedor, codSubcuenta, nombre);
	}
	function automataActivado():Boolean {
		return this.ctx.oficial_automataActivado();
	}
	function clienteActivo(codCliente:String, fecha:String):Boolean {
		return this.ctx.oficial_clienteActivo(codCliente, fecha);
	}
	function proveedorActivo(codProveedor:String, fecha:String):Boolean {
		return this.ctx.oficial_proveedorActivo(codProveedor, fecha);
	}
	function obtenerProvincia(formulario:Object, campoId:String, campoProvincia:String, campoPais:String) {
		return this.ctx.oficial_obtenerProvincia(formulario, campoId, campoProvincia, campoPais);
	}
	function actualizarContactos20070525():Boolean {
		return this.ctx.oficial_actualizarContactos20070525();
	}
	function lanzarEvento(cursor:FLSqlCursor, evento:String):Boolean {
		return this.ctx.oficial_lanzarEvento(cursor, evento);
	}
	function actualizarContactosDeAgenda20070525(codCliente:String,codContacto:String,nombreCon:String,cargoCon:String,telefonoCon:String,faxCon:String,emailCon:String,idAgenda:Number):String {
		return this.ctx.oficial_actualizarContactosDeAgenda20070525(codCliente,codContacto,nombreCon,cargoCon,telefonoCon,faxCon,emailCon,idAgenda)
	}
	function actualizarContactosProv20070702():Boolean {
		return this.ctx.oficial_actualizarContactosProv20070702();
	}
	function actualizarContactosDeAgendaProv20070702(codProveedor:String,codContacto:String,nombreCon:String,cargoCon:String,telefonoCon:String,faxCon:String,emailCon:String,idAgenda:Number):String {
		return this.ctx.oficial_actualizarContactosDeAgendaProv20070702(codProveedor,codContacto,nombreCon,cargoCon,telefonoCon,faxCon,emailCon,idAgenda)
	}
	function elegirOpcion(opciones:Array):Number {
		return this.ctx.oficial_elegirOpcion(opciones);
	}
	function crearProvinciasArg() {
		return this.ctx.oficial_crearProvinciasArg();
	}
	function setUnLock(tabla:String, pK:Number, unLock:Boolean) {
		return this.ctx.oficial_setUnLock(tabla, pK, unLock);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////
class controlUsuario extends oficial {
    function controlUsuario( context ) { oficial ( context ); }

	function beforeCommit_usuarios(cursor:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_usuarios(cursor);
	}
	function afterCommit_usuarios(cursor:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_afterCommit_usuarios(cursor);
	}
	function crearUsuarioEnConexion(nombreUsuario:String, password:String, conName:String):Boolean {
		return this.ctx.controlUsuario_crearUsuarioEnConexion(nombreUsuario, password, conName);
	}
	function editarUsuarioEnConexion(nombreUsuario:String, password:String, conName:String):Boolean {
		return this.ctx.controlUsuario_editarUsuarioEnConexion(nombreUsuario, password, conName);
	}
	function borrarUsuarioEnConexion(nombreUsuario:String, conName:String):Boolean {
		return this.ctx.controlUsuario_borrarUsuarioEnConexion(nombreUsuario, conName);
	}
	function usuarioCreado(usuario:String):Boolean {
		return this.ctx.controlUsuario_usuarioCreado(usuario);
	}
	function mensajeControlUsuario(error:String, dato:String) {
		return this.ctx.controlUsuario_mensajeControlUsuario(error, dato);
	}
}
//// CONTROL_USUARIO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration cuitDni */
/////////////////////////////////////////////////////////////////
//// CUIT_DNI ///////////////////////////////////////////////////
class cuitDni extends controlUsuario {
    function cuitDni( context ) { controlUsuario ( context ); }

	function validarCUIT(cuit:String):Boolean {
		return this.ctx.cuitDni_validarCUIT(cuit);
	}
}
//// CUIT_DNI ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends cuitDni {
    function head( context ) { cuitDni ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubSilixSeleccion */
/////////////////////////////////////////////////////////////////
//// PUB_SILIXSELECCION /////////////////////////////////////////
class pubSilixSeleccion extends head {
	function pubSilixSeleccion( context ) { head( context ); }
	function pub_seleccionar(tabla:String, campo:String, idCampo:String):Array {
		return this.seleccionar(tabla, campo, idCampo);
	}
}

//// PUB_SILIXSELECCION /////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends pubSilixSeleccion {
	function ifaceCtx( context ) { pubSilixSeleccion( context ); }
	function pub_msgNoDisponible(modulo:String) {
		return this.msgNoDisponible(modulo);
	}
	function pub_ejecutarQry(tabla:String, campos:String, where:String, listaTablas:String):Array {
		return this.ejecutarQry(tabla, campos, where, listaTablas);
	}
	function pub_valorDefectoEmpresa(fN:String):String {
		return this.valorDefectoEmpresa(fN);
	}
	function pub_valorQuery(tablas:String, select:String, from:String, where:String):String {
		return this.valorQuery(tablas, select, from, where);
	}
	function pub_cerosIzquierda(numero:String, totalCifras:Number):String {
		return this.cerosIzquierda(numero, totalCifras);
	}
	function pub_espaciosDerecha(texto:String, totalLongitud:Number):String {
		return this.espaciosDerecha(texto, totalLongitud);
	}
	function pub_ejercicioActual():String {
		return this.ejercicioActual();
	}
	function pub_cambiarEjercicioActual(codEjercicio:String):Boolean {
		return this.cambiarEjercicioActual(codEjercicio);
	}
	function pub_datosCtaCliente(codCliente:String, valoresDefecto:Array):Array {
		return this.datosCtaCliente(codCliente, valoresDefecto);
	}
	function pub_datosCtaProveedor(codProveedor:String, valoresDefecto:Array):Array {
		return this.datosCtaProveedor(codProveedor, valoresDefecto);
	}
	function pub_calcularIntervalo(codIntervalo:String):Array {
		return this.calcularIntervalo(codIntervalo);
	}
	function pub_crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number {
		return this.crearSubcuenta(codSubcuenta, descripcion, idCuentaEsp, codEjercicio);
	}
	function pub_crearSubcuentaCli(codSubcuenta:String, idSubcuenta:Number, codCliente:String, codEjercicio:String):Boolean {
		return this.crearSubcuentaCli(codSubcuenta, idSubcuenta, codCliente, codEjercicio);
	}
	function pub_crearSubcuentaProv(codSubcuenta:String, idSubcuenta:Number, codProveedor:String, codEjercicio:String):Boolean {
		return this.crearSubcuentaProv(codSubcuenta, idSubcuenta, codProveedor, codEjercicio);
	}
	function pub_rellenarSubcuentasCli(codCliente:String, codSubcuenta:String, nombre:String):Boolean {
		return this.rellenarSubcuentasCli(codCliente, codSubcuenta, nombre);
	}
	function pub_rellenarSubcuentasProv(codProveedor:String, codSubcuenta:String, nombre:String):Boolean {
		return this.rellenarSubcuentasProv(codProveedor, codSubcuenta, nombre);
	}
	function pub_automataActivado():Boolean {
		return this.automataActivado();
	}
	function pub_clienteActivo(codCliente:String, fecha:String):Boolean {
		return this.clienteActivo(codCliente, fecha);
	}
	function pub_proveedorActivo(codProveedor:String, fecha:String):Boolean {
		return this.proveedorActivo(codProveedor, fecha);
	}
	function pub_obtenerProvincia(formulario:Object, campoId:String, campoProvincia:String, campoPais:String) {
		return this.obtenerProvincia(formulario, campoId, campoProvincia, campoPais);
	}
	function pub_lanzarEvento(cursor:FLSqlCursor, evento:String):Boolean {
		return this.lanzarEvento(cursor, evento);
	}
	function pub_elegirOpcion(opciones:Array):Number {
		return this.elegirOpcion(opciones);
	}
	function pub_setUnLock(tabla:String, pK:Number, unLock:Boolean) {
		return this.setUnLock(tabla, pK, unLock);
	}
}
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubControlUsuario */
/////////////////////////////////////////////////////////////////
//// PUB_CONTROL_USUARIO ////////////////////////////////////////
class pubControlUsuario extends ifaceCtx {
	function pubControlUsuario( context ) { ifaceCtx ( context ); }
	function pub_usuarioCreado(usuario:String):Boolean {
		return this.usuarioCreado(usuario);
	}
	function pub_mensajeControlUsuario(error:String, dato:String) {
		return this.mensajeControlUsuario(error, dato);
	}
}
//// PUB_CONTROL_USUARIO ////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubCuitDni */
/////////////////////////////////////////////////////////////////
//// PUB_CUIT_DNI ///////////////////////////////////////////////
class pubCuitDni extends pubControlUsuario {
	function pubCuitDni( context ) { pubControlUsuario ( context ); }
	function pub_validarCUIT(cuit:String):Boolean {
		return this.validarCUIT(cuit);
	}
}
//// PUB_CUIT_DNI ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

const iface = new pubCuitDni( this );

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
function interna_init()
{
	var util:FLUtil = new FLUtil();

// -------------------------------- 20070525 -------------------------------------
	var condicion:String = util.sqlSelect("clientes", "codcliente", "(codcontacto = '' OR codcontacto IS NULL) AND (contacto <> '' AND contacto IS NOT NULL)");
	var condicionProv:String = util.sqlSelect("proveedores", "codproveedor", "(codcontacto = '' OR codcontacto IS NULL) AND (contacto <> '' AND contacto IS NOT NULL)");

	if (condicion) {
		var cursor:FLSqlCursor = new FLSqlCursor("clientes");
		cursor.transaction(false);
		try {
			if (this.iface.actualizarContactos20070525()) {
				cursor.commit();
			} else {
				cursor.rollback();
			}
		}
		catch (e) {
			cursor.rollback();
			MessageBox.warning(util.translate("scripts", "Hubo un error al actualizar los datos de contactos del módulo de Facturación:\n" + e), MessageBox.Ok, MessageBox.NoButton);
		}
	}

	if (condicionProv) {
		var cursor:FLSqlCursor = new FLSqlCursor("proveedores");
		cursor.transaction(false);
		try {
			if (this.iface.actualizarContactosProv20070702()) {
				cursor.commit();
			} else {
				cursor.rollback();
			}
		}
		catch (e) {
			cursor.rollback();
			MessageBox.warning(util.translate("scripts", "Hubo un error al actualizar los datos de contactos del módulo de Facturación:\n" + e), MessageBox.Ok, MessageBox.NoButton);
		}
	}
//-------------------------------- 20070525 -------------------------------------

	if (util.sqlSelect("empresa", "id", "1 = 1"))
		return;
	
	var cursor:FLSqlCursor = new FLSqlCursor("empresa");
	cursor.select();
	if (!cursor.first()) {
		MessageBox.information(util.translate("scripts",
			"Se insertará una empresa por defecto y algunos valores iniciales para empezar a trabajar."),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		this.iface.valoresIniciales();
		this.execMainScript("empresa");
	}
}

function interna_afterCommit_dirclientes(curDirCli:FLSqlCursor):Boolean
{
	if (curDirCli.modeAccess() == curDirCli.Del) {
		var domFact:String = curDirCli.valueBuffer("domfacturacion");
		var domEnv:String = curDirCli.valueBuffer("domenvio");
		if (domFact == true || domEnv == true) {
			var cursor:FLSqlCursor = new FLSqlCursor("dirclientes");
			cursor.select("codcliente = '" + curDirCli.valueBuffer("codcliente") + "' AND id <> " + curDirCli.valueBuffer("id"));
			if (cursor.first()) {
				cursor.setModeAccess(cursor.Edit);
				cursor.refreshBuffer();
				if (domFact == true)
					cursor.setValueBuffer("domfacturacion", domFact);
				if (domEnv == true)
					cursor.setValueBuffer("domenvio", domEnv);
				cursor.commitBuffer();
			}
		}
	}
	return true;
}

function interna_afterCommit_dirproveedores(curDirProv:FLSqlCursor):Boolean
{
	if (curDirProv.modeAccess() == curDirProv.Del) {
		var dirPpal:String = curDirProv.valueBuffer("direccionppal");
		if (dirPpal == true) {
			var cursor:FLSqlCursor = new FLSqlCursor("dirproveedores");
			cursor.select("codproveedor = '" + curDirProv.valueBuffer("codproveedor") + "' AND id <> " + curDirProv.valueBuffer("id"));
			if (cursor.first()) {
				cursor.setModeAccess(cursor.Edit);
				cursor.refreshBuffer();
				cursor.setValueBuffer("direccionppal", dirPpal);
				cursor.commitBuffer();
			}
		}
	}
	return true;
}

function interna_afterCommit_clientes(curCliente:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flcontppal"))
		return true;

	var codSubcuenta:String = curCliente.valueBuffer("codsubcuenta");
	var idSubcuenta:Number = parseFloat(curCliente.valueBuffer("idsubcuenta"));
	var codCliente:String = curCliente.valueBuffer("codcliente");
	var idSubcuentaPrevia:Number = parseFloat(curCliente.valueBufferCopy("idsubcuenta"));
	
	switch(curCliente.modeAccess()) {
	/** \C Cuando el cliente se crea, se generan automáticamente las subcuentas para dicho cliente asociadas a los ejercicios con plan general contable creado.
	\end */
		case curCliente.Insert: {
			if (!this.iface.rellenarSubcuentasCli(codCliente, codSubcuenta, curCliente.valueBuffer("nombre")))
				return false;
			break;
		}
		/*
		case curCliente.Del: {
			if (!curCliente.isNull("idsubcuenta")) {
				if (!util.sqlSelect("clientes", "idsubcuenta", "idsubcuenta = " + idSubcuentaPrevia + " AND codcliente <> '" + codCliente + "'")) {
					if (!this.iface.borrarSubcuenta(idSubcuenta))
						return false;
				}
			}
			break;
		}
		*/
	}
	return true;
}

function interna_afterCommit_proveedores(curProveedor:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flcontppal"))
		return true;

	var codSubcuenta:String = curProveedor.valueBuffer("codsubcuenta");
	var idSubcuenta:Number = parseFloat(curProveedor.valueBuffer("idsubcuenta"));
	var codProveedor:String = curProveedor.valueBuffer("codproveedor");
	var idSubcuentaPrevia:Number = parseFloat(curProveedor.valueBufferCopy("idsubcuenta"));

	switch(curProveedor.modeAccess()) {
		/** \C Cuando el proveedor se crea, se generan automáticamente las subcuentas para dicho proveedor asociadas a los ejercicios con plan general contable creado.
		\end */
		case curProveedor.Insert: {
			if (!this.iface.rellenarSubcuentasProv(codProveedor, codSubcuenta, curProveedor.valueBuffer("nombre")))
				return false;
			break;
		}
		/*
		case curProveedor.Del: {
			if (!curProveedor.isNull("idsubcuenta")) {
				if (!util.sqlSelect("proveedores", "idsubcuenta", "idsubcuenta = " + idSubcuentaPrevia + " AND codcliente <> '" + codProveedor + "'")) {
					if (!this.iface.borrarSubcuenta(idSubcuenta))
						return false;
				}
			}
			break;
		}
		*/
	}
	return true;
}

function interna_beforeCommit_proveedores(curProveedor:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flcontppal"))
		return true;

	switch(curProveedor.modeAccess()) {
		/** \C Cuando el proveedor se borra, se borran las subcuentas asociadas si éstas no tienen partidas asociadas ni están vinculadas con otro proveedor
		\end */
		case curProveedor.Del: {
			var qrySubcuentas:FLSqlQuery = new FLSqlQuery();
			qrySubcuentas.setTablesList("co_subcuentasprov,co_subcuentas");
			qrySubcuentas.setSelect("s.codsubcuenta,s.descripcion,s.codejercicio,s.saldo,s.idsubcuenta");
			qrySubcuentas.setFrom("co_subcuentasprov sp INNER JOIN co_subcuentas s ON sp.idsubcuenta = s.idsubcuenta")
			qrySubcuentas.setWhere("sp.codproveedor = '" + curProveedor.valueBuffer("codproveedor") + "'");
			try { qrySubcuentas.setForwardOnly( true ); } catch (e) {}
			if (!qrySubcuentas.exec())
				return false;

			var idSubcuenta:String;
			while (qrySubcuentas.next()) {
				idSubcuenta = qrySubcuentas.value("s.idsubcuenta"); 
				if (parseFloat(qrySubcuentas.value("s.saldo")) != 0)
					continue; 
				if (util.sqlSelect("co_partidas", "idpartida", "idsubcuenta = " + idSubcuenta))
					continue;
				if (util.sqlSelect("co_subcuentasprov", "idsubcuenta", "idsubcuenta = " + idSubcuenta + " AND codproveedor <> '" + curProveedor.valueBuffer("codproveedor") + "'"))
					continue;
				if (!util.sqlDelete("co_subcuentas", "idsubcuenta = " + idSubcuenta))
					return false;
			}
		}
	}
	return true;
}

function interna_beforeCommit_clientes(curCliente:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flcontppal"))
		return true;

	switch(curCliente.modeAccess()) {
		/** \C Cuando el cliente se borra, se borran las subcuentas asociadas si éstas no tienen partidas asociadas ni están vinculadas con otro cliente
		\end */
		case curCliente.Del: {
			var qrySubcuentas:FLSqlQuery = new FLSqlQuery();
			qrySubcuentas.setTablesList("co_subcuentascli,co_subcuentas");
			qrySubcuentas.setSelect("s.codsubcuenta,s.descripcion,s.codejercicio,s.saldo,s.idsubcuenta");
			qrySubcuentas.setFrom("co_subcuentascli sc INNER JOIN co_subcuentas s ON sc.idsubcuenta = s.idsubcuenta")
			qrySubcuentas.setWhere("sc.codcliente = '" + curCliente.valueBuffer("codcliente") + "'");
			try { qrySubcuentas.setForwardOnly( true ); } catch (e) {}
			if (!qrySubcuentas.exec())
				return false;
			
			var idSubcuenta:String;
			while (qrySubcuentas.next()) {
				idSubcuenta = qrySubcuentas.value("s.idsubcuenta"); 
				if (parseFloat(qrySubcuentas.value("s.saldo")) != 0)
					continue; 
				if (util.sqlSelect("co_partidas", "idpartida", "idsubcuenta = " + idSubcuenta))
					continue;
				if (util.sqlSelect("co_subcuentascli", "idsubcuenta", "idsubcuenta = " + idSubcuenta + " AND codcliente <> '" + curCliente.valueBuffer("codcliente") + "'"))
					continue;
				if (!util.sqlDelete("co_subcuentas", "idsubcuenta = " + idSubcuenta))
					return false;
			}
		}
	}
	return true;
}

/** \C Cuando cambia el ejercicio actual se establece el título de las ventanas principales con
el nombre del ejercicio seleccionado
\end */
/** \D Cuando cambia el ejercicio actual se establece una variable global (ver FLVar) con el código
del ejercicio seleccionado. El nombre de esta variable está fomado por el literal "ejerUsr_" seguido
del nombre del usuario actual obtenido con la función sys.nameUser(). Esto significa que por cada usuario
se almacena el ejercicio en el que se encuentra.
\end */
function interna_afterCommit_empresa(curEmpresa:FLSqlCursor):Boolean {
	/*
	var util:FLUtil = new FLUtil();
	var codejercicio:String = curEmpresa.valueBuffer( "codejercicio" );
	var nombreEjercicio:String = util.sqlSelect( "ejercicios", "nombre", "codejercicio='" + codejercicio + "'" );
	sys.setCaptionMainWidget( nombreEjercicio );

	var ejerUsr:FLVar = new FLVar();
	var idVar:String = "ejerUsr_" + sys.nameUser();
	ejerUsr.set( idVar, codejercicio );
	*/
}

function interna_beforeCommit_cuentasbcocli(curCuenta:FLSqlCursor):Boolean
{
	/** \C No se permite borrar la cuenta de un cliente si tiene recibos pendientes de pago asociados a dicha cuenta
	\end */
	switch(curCuenta.modeAccess()) {
	
		case curCuenta.Del:
			var util:FLUtil = new FLUtil;
			var codRecibo:String = util.sqlSelect("reciboscli", "codigo", "codcliente = '" + curCuenta.valueBuffer("codcliente") + "' AND codcuenta = '" + curCuenta.valueBuffer("codcuenta") + "' AND estado <> 'Pagado'");
			if (codRecibo && codRecibo != "") {
				MessageBox.warning(util.translate("scripts", "No puede eliminar la cuenta del cliente porque hay al menos un recibo (%1) pendiente de pago asociado a esta cuenta.\nDebe cambiar la cuenta de los recibos pendientes de este cliente antes de borrarla.").arg(codRecibo), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		break;
	}
	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_msgNoDisponible(nombreModulo:String)
{
	var util:FLUtil = new FLUtil();
	MessageBox.information(util.translate("scripts", "El módulo '") +
		nombreModulo + util.translate("scripts",
		"' sólo está disponible a través de suscripción."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}

/** \D Ejecuta la query especificada y devuelve un array con los datos de los campos seleccionados. Devuelve un campo extra 'result' que es 1 = Ok, 0 = Error, -1 No encontrado
@param	tabla: Nombre de la tabla
@param	campos: Nombre de los campos, separados por comas
@param	where: Cláusula where
@param	listaTablas: Lista de las tablas empleadas en la consulta. Este parámetro es opcional y se usa si la consulta afecta a más de una tabla.
@return	Array con los valores de los campos solicitados, más el campo result.
\end */
function oficial_ejecutarQry(tabla:String, campos:String, where:String, listaTablas:String):Array
{
	var util:FLUtil = new FLUtil;
	var campo:Array = campos.split(",");
	var valor:Array = [];
	valor["result"] = 1;
	var query:FLSqlQuery = new FLSqlQuery();
	if (listaTablas)
		query.setTablesList(listaTablas);
	else
		query.setTablesList(tabla);
	try { query.setForwardOnly( true ); } catch (e) {}
	query.setSelect(campo);
	query.setFrom(tabla);
	query.setWhere(where);
	if (query.exec()) {
		if (query.next()) {
			for (var i:Number = 0; i < campo.length; i++) {
				valor[campo[i]] = query.value(i);
			}
		} else {
			valor.result = -1;
		}
	} else {
		MessageBox.critical(util.translate("scripts", "Falló la consulta") + query.sql(),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		valor.result = 0;
	}

	return valor;
}

function oficial_valorDefectoEmpresa(fN:String):String
{
	var query:FLSqlQuery = new FLSqlQuery();

	query.setTablesList( "empresa" );
	try { query.setForwardOnly( true ); } catch (e) {}
	query.setSelect( fN );
	query.setFrom( "empresa" );
	if ( query.exec() )
		if ( query.next() )
			return query.value( 0 );

	return "";
}

/** \D Devuelve el ejercicio actual para el usuario conectado
@return	codEjercicio: Código del ejercicio actual
\end */
function oficial_ejercicioActual():String
{
	var util:FLUtil = new FLUtil;
	var codEjercicio:String 
	try {
		var settingKey:String = "ejerUsr_" + sys.nameUser();
		codEjercicio = util.readDBSettingEntry(settingKey);
		/*if (!codEjercicio)
			codEjercicio = this.iface.cambiarEjercicioActual(this.iface.valorDefectoEmpresa("codejercicio"));*/
	}
	catch ( e ) {}
	
	if (!codEjercicio)
		codEjercicio = this.iface.valorDefectoEmpresa("codejercicio");
	
	return codEjercicio;
}

/** \D Establece el ejercicio actual para el usuario conectado
Cuando cambia el ejercicio actual se establece un setting de base de datos (tabla flsettings) con el código
del ejercicio seleccionado. El nombre de esta variable está fomado por el literal "ejerUsr_" seguido
del nombre del usuario actual obtenido con la función sys.nameUser(). Esto significa que por cada usuario
se almacena el ejercicio en el que se encuentra.

@param	codEjercicio: Código del ejercicio actual
@return	true si la asignación del ejercicio se realizó correctamente, false en caso contrario
\end */
function oficial_cambiarEjercicioActual(codEjercicio:String):Boolean
{
	var util:FLUtil = new FLUtil();
	var ok:Boolean = false;
	
	try {
		var settingKey:String = "ejerUsr_" + sys.nameUser();
		ok = util.writeDBSettingEntry(settingKey, codEjercicio);
	}
	catch (e) {}
	
	return ok;
}

function oficial_cerosIzquierda(numero:String, totalCifras:Number):String
{
	var ret:String = numero.toString();
	var numCeros:Number = totalCifras - ret.length;
	for ( ; numCeros > 0 ; --numCeros)
		ret = "0" + ret;
	return ret;
}

function oficial_espaciosDerecha(texto:String, totalLongitud:Number):String
{
	var ret:String = texto.toString();
	var numEspacios:Number = totalLongitud - ret.length;
	for ( ; numEspacios > 0 ; --numEspacios)
		ret += " ";
	return ret;
}

function oficial_valoresIniciales()
{
	var util:FLUtil = new FLUtil();
	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Cargando valores iniciales..." ), 16 );

	var cursor:FLSqlCursor = new FLSqlCursor("bancos");
	var bancos:Array = [
		["005", "A.B.N. AMRO BANK N.V."], ["007", "BANCO DE GALICIA Y BUENOS AIRES S.A."],
		["011", "BANCO DE LA NACION ARGENTINA"], ["014", "BANCO DE LA PROVINCIA DE BUENOS AIRES"],
		["015", "STANDARD BANK ARGENTINA S.A."], ["016", "CITIBANK N.A."], ["017", "BBVA BANCO FRANCES S.A."],
		["018", "THE BANK OF TOKYO - MITSUBISHI UFJ, LTD."], ["020", "BANCO DE LA PROVINCIA DE CORDOBA S.A."],
		["027", "BANCO SUPERVIELLE S.A."], ["029", "BANCO DE LA CIUDAD DE BUENOS AIRES"],
		["034", "BANCO PATAGONIA S.A."], ["044", "BANCO HIPOTECARIO S.A."], ["045", "BANCO DE SAN JUAN S.A."],
		["046", "BANCO DO BRASIL S.A."], ["060", "BANCO DEL TUCUMAN S.A."], ["065", "BANCO MUNICIPAL DE ROSARIO"],
		["072", "BANCO SANTANDER RIO S.A."], ["079", "BANCO REGIONAL DE CUYO S.A."], ["083", "BANCO DEL CHUBUT S.A."],
		["086", "BANCO DE SANTA CRUZ S.A."], ["093", "BANCO DE LA PAMPA SOCIEDAD DE ECONOMIA MIXTA"],
		["094", "BANCO DE CORRIENTES S.A."], ["097", "BANCO PROVINCIA DEL NEUQUEN S.A."],
		["147", "BANCO B. I. CREDITANSTALT S.A."], ["150", "HSBC BANK ARGENTINA S.A."],
		["165", "J P MORGAN CHASE BANK, NATIONAL ASSOCIATION (SUCURSAL BUENOS AIRES)"],
		["191", "BANCO CREDICOOP COOPERATIVO LIMITADO"], ["198", "BANCO DE VALORES S.A."], ["247", "BANCO ROELA S.A."],
		["254", "BANCO MARIVA S.A."], ["259", "BANCO ITAU BUEN AYRE S.A."], ["262", "BANK OF AMERICA, NATIONAL ASSOCIATION"],
		["266", "BNP PARIBAS"], ["268", "BANCO PROVINCIA DE TIERRA DEL FUEGO"], ["269", "BANCO DE LA REPUBLICA ORIENTAL DEL URUGUAY"],
		["277", "BANCO SAENZ S.A."], ["281", "BANCO MERIDIAN S.A."], ["285", "BANCO MACRO S.A."], ["293", "BANCO MERCURIO S.A."],
		["295", "AMERICAN EXPRESS BANK LTD. S.A."], ["299", "BANCO COMAFI S.A."], ["300", "BANCO DE INVERSION Y COMERCIO EXTERIOR S.A."],
		["301", "BANCO PIANO S.A."], ["303", "BANCO FINANSUR S.A."], ["305", "BANCO JULIO S.A."], ["306", "BANCO PRIVADO DE INVERSIONES S.A."],
		["309", "NUEVO BANCO DE LA RIOJA S.A."], ["310", "BANCO DEL SOL S.A."], ["311", "NUEVO BANCO DEL CHACO S.A."],
		["312", "M.B.A. BANCO DE INVERSIONES S.A."], ["315", "BANCO DE FORMOSA S.A."], ["319", "BANCO CMF S.A."],
		["321", "BANCO DE SANTIAGO DEL ESTERO S.A."], ["322", "NUEVO BANCO INDUSTRIAL DE AZUL S.A."], ["325", "DEUTSCHE BANK S.A."],
		["330", "NUEVO BANCO DE SANTA FE S.A."], ["331", "BANCO CETELEM ARGENTINA S.A."], ["332", "BANCO DE SERVICIOS FINANCIEROS S.A."],
		["335", "BANCO COFIDIS S.A."], ["336", "BANCO BRADESCO ARGENTINA S.A."], ["338", "BANCO DE SERVICIOS Y TRANSACCIONES S.A."],
		["339", "RCI BANQUE"], ["340", "BACS BANCO DE CREDITO Y SECURITIZACION S.A."], ["386", "NUEVO BANCO DE ENTRE RIOS S.A."],
		["387", "NUEVO BANCO SUQUIA S.A."], ["388", "NUEVO BANCO BISEL S.A."], ["389", "BANCO COLUMBIA S.A."] ];
	for (var i:Number = 0; i < bancos.length; i++) {
		with(cursor) {
			setModeAccess(cursor.Insert);
			refreshBuffer();
			setValueBuffer("entidad", bancos[i][0]);
			setValueBuffer("nombre", bancos[i][1]);
			commitBuffer();
		}
	}
	delete cursor;
	util.setProgress( ++paso );

	cursor = new FLSqlCursor("impuestos");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codimpuesto", "EXENTO");
		setValueBuffer("descripcion", "I.V.A. EXENTO");
		setValueBuffer("iva", "0");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codimpuesto", "REDUCIDO");
		setValueBuffer("descripcion", "I.V.A. 10,5%");
		setValueBuffer("iva", "10.5");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codimpuesto", "GRAVADO");
		setValueBuffer("descripcion", "I.V.A. 21%");
		setValueBuffer("iva", "21");
		commitBuffer();
	}
	delete cursor;
	util.setProgress( ++paso );

	cursor = new FLSqlCursor("tiposretencion");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codtipo", "IIBB");
		setValueBuffer("descripcion", "Ingresos Brutos");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codtipo", "GANA");
		setValueBuffer("descripcion", "Ganancias");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codtipo", "EMPL");
		setValueBuffer("descripcion", "Empleadores");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codtipo", "IVA");
		setValueBuffer("descripcion", "IVA");
		commitBuffer();
	}
	delete cursor;
	util.setProgress( ++paso );

	cursor = new FLSqlCursor("piedocumentos");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpie", "PERCIIBB");
		setValueBuffer("descripcion", "PERCEPCIÓN DE ING. BRUTOS");
		setValueBuffer("tipoincremento", "Porcentual");
		setValueBuffer("decompra", true);
		setValueBuffer("deventa", true);
		setValueBuffer("incluidoneto", false);
		commitBuffer();
	}
	delete cursor;
	util.setProgress( ++paso );

	cursor = new FLSqlCursor("paises");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpais", "ARG");
		setValueBuffer("nombre", "Argentina");
		setValueBuffer("bandera", "/* XPM */\nstatic char *arg_xpm[]={\n\"30 16 4 1\",\n\". c #a8dcff\",\n\"b c #ffff00\",\n\"a c #ffffc0\",\n\"# c #ffffff\",\n\"..............................\",\n\"..............................\",\n\"..............................\",\n\"..............................\",\n\"..............................\",\n\"##############aa##############\",\n\"#############abba#############\",\n\"############abbbba############\",\n\"############abbbba############\",\n\"#############abba#############\",\n\"##############aa##############\",\n\"..............................\",\n\"..............................\",\n\"..............................\",\n\"..............................\",\n\"..............................\"};\n");
		setValueBuffer("codiso", "AR");
		commitBuffer();
	}
	delete cursor;
	util.setProgress( ++paso );

	cursor = new FLSqlCursor("divisas");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "EUR");
		setValueBuffer("descripcion", "EUROS");
		setValueBuffer("tasaconv", "1");
		setValueBuffer("codiso", "EUR");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "U$D");
		setValueBuffer("descripcion", "DÓLARES ESTADOUNIDENSES");
		setValueBuffer("tasaconv", "1");
		setValueBuffer("codiso", "USD");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("coddivisa", "$");
		setValueBuffer("descripcion", "PESOS");
		setValueBuffer("tasaconv", "1");
		setValueBuffer("codiso", "ARS");
		commitBuffer();
	}
	delete cursor;
	util.setProgress( ++paso );

	cursor = new FLSqlCursor("formaspago");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpago", "CONTADO");
		setValueBuffer("descripcion", "PAGO AL CONTADO");
		setValueBuffer("genrecibos", "Pagados");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpago", "CTACTE");
		setValueBuffer("descripcion", "PAGO EN CUENTA CORRIENTE");
		setValueBuffer("genrecibos", "Emitidos");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpago", "TARJETA");
		setValueBuffer("descripcion", "PAGO CON TARJETA");
		setValueBuffer("genrecibos", "Pagados");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpago", "VALE");
		setValueBuffer("descripcion", "PAGO CON VALE");
		setValueBuffer("genrecibos", "Pagados");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpago", "CHEQUE");
		setValueBuffer("descripcion", "PAGO CON CHEQUE");
		setValueBuffer("genrecibos", "Pagados");
		commitBuffer();
	}
	delete cursor;
	util.setProgress( ++paso );

	cursor = new FLSqlCursor("plazos");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpago", "CONTADO");
		setValueBuffer("dias", "0");
		setValueBuffer("aplazado", "100");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpago", "CTACTE");
		setValueBuffer("dias", "30");
		setValueBuffer("aplazado", "100");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpago", "TARJETA");
		setValueBuffer("dias", "0");
		setValueBuffer("aplazado", "100");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpago", "VALE");
		setValueBuffer("dias", "0");
		setValueBuffer("aplazado", "100");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codpago", "CHEQUE");
		setValueBuffer("dias", "0");
		setValueBuffer("aplazado", "100");
		commitBuffer();
	}
	delete cursor;
	util.setProgress( ++paso );

	cursor = new FLSqlCursor("ejercicios");
	var hoy:Date = new Date()
	var fechaInicio:Date = new Date(hoy.getYear(), 1, 1);
	var fechaFin:Date = new Date(hoy.getYear(), 12, 31);
	var codEjercicio:String = hoy.getYear();
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("nombre", "EJERCICIO " + codEjercicio);
		setValueBuffer("fechainicio", fechaInicio);
		setValueBuffer("fechafin", fechaFin);
		setValueBuffer("estado", "ABIERTO");
		commitBuffer();
	}
	delete cursor;
	util.setProgress( ++paso );

	this.iface.cambiarEjercicioActual( codEjercicio );
	util.setProgress( ++paso );

	cursor = new FLSqlCursor("periodos");
	fechaInicio = new Date(hoy.getYear(), hoy.getMonth(), 1);
	fechaFin = new Date(hoy.getYear(), hoy.getMonth() + 1, 1);
	fechaFin = util.addDays(fechaFin, -1);
	var codPeriodo:String = hoy.getYear() + "" + this.iface.cerosIzquierda(hoy.getMonth(),2);
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codperiodo", codPeriodo);
		setValueBuffer("nombre", "EJERCICIO " + codEjercicio);
		setValueBuffer("fechainicio", fechaInicio);
		setValueBuffer("fechafin", fechaFin);
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("estado", "ABIERTO");
		commitBuffer();
	}
	delete cursor;
	util.setProgress( ++paso );

	cursor = new FLSqlCursor("series");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codserie", "A001");
		setValueBuffer("descripcion", "Serie A Punto de Venta 1");
		setValueBuffer("serie", "A");
		setValueBuffer("puntoventa", "0001");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codserie", "B001");
		setValueBuffer("descripcion", "Serie B Punto de Venta 1");
		setValueBuffer("serie", "B");
		setValueBuffer("puntoventa", "0001");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codserie", "R001");
		setValueBuffer("descripcion", "Serie R - Remitos");
		setValueBuffer("serie", "R");
		setValueBuffer("puntoventa", "0001");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codserie", "P001");
		setValueBuffer("descripcion", "Serie P - Pedidos");
		setValueBuffer("serie", "P");
		setValueBuffer("puntoventa", "0001");
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codserie", "X001");
		setValueBuffer("descripcion", "Serie X - Presupuestos");
		setValueBuffer("serie", "X");
		setValueBuffer("puntoventa", "0001");
		commitBuffer();
	}
	delete cursor;
	util.setProgress( ++paso );

	cursor = new FLSqlCursor("secuenciasejercicios");
	var idSec1:Number;
	var idSec2:Number;
	var idSec3:Number;
	var idSec4:Number;
	var idSec5:Number;
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codserie", "A001");
		setValueBuffer("codejercicio", hoy.getYear().toString());
		idSec1 = valueBuffer( "id" );
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codserie", "B001");
		setValueBuffer("codejercicio", hoy.getYear().toString());
		idSec2 = valueBuffer( "id" );
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codserie", "R001");
		setValueBuffer("codejercicio", hoy.getYear().toString());
		idSec3 = valueBuffer( "id" );
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codserie", "P001");
		setValueBuffer("codejercicio", hoy.getYear().toString());
		idSec4 = valueBuffer( "id" );
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("codserie", "X001");
		setValueBuffer("codejercicio", hoy.getYear().toString());
		idSec5 = valueBuffer( "id" );
		commitBuffer();
	}
	delete cursor;
	util.setProgress( ++paso );

	cursor = new FLSqlCursor("secuencias");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("id", idSec1);
		setValueBuffer("nombre", "nfacturacli");
		setValueBuffer("valor", 1);
		setValueBuffer("valorout", 1);
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("id", idSec1);
		setValueBuffer("nombre", "nfacturaprov");
		setValueBuffer("valor", 1);
		setValueBuffer("valorout", 1);
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("id", idSec2);
		setValueBuffer("nombre", "nfacturacli");
		setValueBuffer("valor", 1);
		setValueBuffer("valorout", 1);
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("id", idSec2);
		setValueBuffer("nombre", "nfacturaprov");
		setValueBuffer("valor", 1);
		setValueBuffer("valorout", 1);
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("id", idSec3);
		setValueBuffer("nombre", "nalbarancli");
		setValueBuffer("valor", 1);
		setValueBuffer("valorout", 1);
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("id", idSec3);
		setValueBuffer("nombre", "nalbaranprov");
		setValueBuffer("valor", 1);
		setValueBuffer("valorout", 1);
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("id", idSec4);
		setValueBuffer("nombre", "npedidocli");
		setValueBuffer("valor", 1);
		setValueBuffer("valorout", 1);
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("id", idSec4);
		setValueBuffer("nombre", "npedidoprov");
		setValueBuffer("valor", 1);
		setValueBuffer("valorout", 1);
		commitBuffer();
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("id", idSec5);
		setValueBuffer("nombre", "npresupuestocli");
		setValueBuffer("valor", 1);
		setValueBuffer("valorout", 1);
		commitBuffer();
	}
	delete cursor;
	util.setProgress( ++paso );
	
	cursor = new FLSqlCursor("empresa");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("nombre", "SILIX, Soluciones Informáticas Libres");
		setValueBuffer("cifnif", "00-00000000-0");
		setValueBuffer("administrador", "Silix");
		setValueBuffer("direccion", "4 de Enero 576");
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("coddivisa", "$");
		setValueBuffer("codpago", "CONTADO");
		setValueBuffer("codserie_a", "A001");
		setValueBuffer("codserie_b", "B001");
		setValueBuffer("codserie_remito", "R001");
		setValueBuffer("codserie_pedido", "P001");
		setValueBuffer("codserie_presupuesto", "X001");
		setValueBuffer("codpostal", "3100");
		setValueBuffer("ciudad", "PARANÁ");
		setValueBuffer("provincia", "ENTRE RÍOS");
		setValueBuffer("telefono", "0343 4975860");
		setValueBuffer("email", "contacto@silix.com.ar");
		setValueBuffer("web", "http://www.silix.com.ar");
		setValueBuffer("codpais", "ARG");
		setValueBuffer("logo", "/* XPM */\nstatic char *g____[] = {\n\"125 43 172 2\",\n \"   c #555555\",\n \".  c #565656\",\n \"X  c gray34\",\n \"o  c #585858\",\n \"O  c gray35\",\n \"+  c #5A5A5A\",\n \"@  c #5B5B5B\",\n \"#  c gray36\",\n \"$  c gray37\",\n \"%  c #5F5F5F\",\n \"&  c #606060\",\n \"*  c gray38\",\n \"=  c #626262\",\n \"-  c gray39\",\n \";  c #646464\",\n \":  c #656565\",\n \">  c gray40\",\n \",  c #676767\",\n \"<  c #686868\",\n \"1  c DimGray\",\n \"2  c #6A6A6A\",\n \"3  c gray42\",\n \"4  c #6C6C6C\",\n \"5  c #6D6D6D\",\n \"6  c #6F6F6F\",\n \"7  c gray44\",\n \"8  c #717171\",\n \"9  c #727272\",\n \"0  c gray45\",\n \"q  c #747474\",\n \"w  c gray46\",\n \"e  c #767676\",\n \"r  c #797979\",\n \"t  c gray48\",\n \"y  c #7B7B7B\",\n \"u  c #7C7C7C\",\n \"i  c gray49\",\n \"p  c #7E7E7E\",\n \"a  c #7F7F7F\",\n \"s  c #164891\",\n \"d  c #808080\",\n \"f  c #818181\",\n \"g  c gray51\",\n \"h  c #838383\",\n \"j  c #848484\",\n \"k  c gray52\",\n \"l  c #868686\",\n \"z  c gray53\",\n \"x  c #888888\",\n \"c  c #898989\",\n \"v  c gray54\",\n \"b  c #8B8B8B\",\n \"n  c gray55\",\n \"m  c #8D8D8D\",\n \"M  c #8E8E8E\",\n \"N  c #909090\",\n \"B  c gray57\",\n \"V  c #929292\",\n \"C  c #939393\",\n \"Z  c gray58\",\n \"A  c #959595\",\n \"S  c gray59\",\n \"D  c #979797\",\n \"F  c #989898\",\n \"G  c gray60\",\n \"H  c #9A9A9A\",\n \"J  c #9B9B9B\",\n \"K  c gray61\",\n \"L  c #9D9D9D\",\n \"P  c gray62\",\n \"I  c #9F9F9F\",\n \"U  c #A0A0A0\",\n \"Y  c gray63\",\n \"T  c #A2A2A2\",\n \"R  c gray64\",\n \"E  c #A4A4A4\",\n \"W  c #A5A5A5\",\n \"Q  c gray65\",\n \"!  c #A7A7A7\",\n \"~  c gray66\",\n \"^  c #A9A9A9\",\n \"/  c #AAAAAA\",\n \"(  c gray67\",\n \")  c #ACACAC\",\n \"_  c gray68\",\n \"`  c #AEAEAE\",\n \"'  c #AFAFAF\",\n \"]  c gray69\",\n \"[  c #B1B1B1\",\n \"{  c #B2B2B2\",\n \"}  c #B4B4B4\",\n \"|  c gray71\",\n \" . c #B6B6B6\",\n \".. c #B7B7B7\",\n \"X. c gray72\",\n \"o. c #B9B9B9\",\n \"O. c gray73\",\n \"+. c #BBBBBB\",\n \"@. c #BCBCBC\",\n \"#. c gray74\",\n \"$. c gray\",\n \"%. c gray75\",\n \"&. c #8AA3C8\",\n \"*. c #8BA4C8\",\n \"=. c #95ABCD\",\n \"-. c #95ACCD\",\n \";. c #97ADCE\",\n \":. c #9DB2D1\",\n \">. c #9EB3D2\",\n \",. c #ABBDD8\",\n \"<. c #C0C0C0\",\n \"1. c gray76\",\n \"2. c #C3C3C3\",\n \"3. c gray77\",\n \"4. c #C5C5C5\",\n \"5. c #C6C6C6\",\n \"6. c gray78\",\n \"7. c #C8C8C8\",\n \"8. c gray79\",\n \"9. c #CACACA\",\n \"0. c #CBCBCB\",\n \"q. c gray80\",\n \"w. c #CDCDCD\",\n \"e. c #CECECE\",\n \"r. c gray81\",\n \"t. c #D0D0D0\",\n \"y. c gray82\",\n \"u. c #D2D2D2\",\n \"i. c LightGray\",\n \"p. c gray83\",\n \"a. c #D5D5D5\",\n \"s. c gray84\",\n \"d. c #D7D7D7\",\n \"f. c #D8D8D8\",\n \"g. c gray85\",\n \"h. c #DADADA\",\n \"j. c gray86\",\n \"k. c gainsboro\",\n \"l. c gray87\",\n \"z. c #DFDFDF\",\n \"x. c #C5D1E4\",\n \"c. c gray88\",\n \"v. c #E1E1E1\",\n \"b. c #E2E2E2\",\n \"n. c gray89\",\n \"m. c #E4E4E4\",\n \"M. c gray90\",\n \"N. c #E6E6E6\",\n \"B. c #E7E7E7\",\n \"V. c gray91\",\n \"C. c #E9E9E9\",\n \"Z. c #EAEAEA\",\n \"A. c gray92\",\n \"S. c #ECECEC\",\n \"D. c gray93\",\n \"F. c #EEEEEE\",\n \"G. c #EFEFEF\",\n \"H. c gray94\",\n \"J. c #F1F1F1\",\n \"K. c gray95\",\n \"L. c #F3F3F3\",\n \"P. c #F4F4F4\",\n \"I. c gray96\",\n \"U. c #F6F6F6\",\n \"Y. c #F8F8F8\",\n \"T. c #F9F9F9\",\n \"R. c gray98\",\n \"E. c #FBFBFB\",\n \"W. c gray99\",\n \"Q. c #FDFDFD\",\n \"!. c #FEFEFE\",\n \"~. c gray100\",\n \"s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s \",\n \"s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s \",\n \"&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.\",\n \"~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.I.s.8.@.| } } } } } } } } } } } } } } } } { } } } } } } } } Q F } } } } } } } } } N.~.~.~.~.~.~.~.~.~.~.~.~.~.n.} } } } ( v v v v v ^ } } } } } } } N.~.~.~.~.~.~.~.~.~.~.5.} } } } } } } } } } } } 5.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.~.~.~.~.Q. .t X                                         +                                       3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.                                    e W.~.~.~.~.~.~.~.~.u..                       o d.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.~.~.~.k.e         + 7 j k k k k k k k k k k k k k a     +   ; f f f f f 4       q f f f f f @   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    w f f f f f o . i f f f f f f -   ~ ~.~.~.~.~.~.~.U.1   * f f f f f f i .     { ~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.~.W.P .     m t.C.!.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.Z.    +   f ~.~.~.~.~.S       [ ~.~.~.~.E.<   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   M Q.~.~.~.~.~.|   X j.~.~.~.~.~.~.D     [ ~.~.~.~.~.!.B     n ~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.~.{     4 r.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.Z.    +   f ~.~.~.~.~.S       [ ~.~.~.~.E.<   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   . / ~.~.~.~.~.!.n   6 T.~.~.~.~.e.    x Q.~.~.~.~.~.'     5 U.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.A.#   6 Y.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.Z.    +   f ~.~.~.~.~.S       [ ~.~.~.~.E.<   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$     $ 0.~.~.~.~.~.V.3   P ~.~.~.P.>   , n.~.~.~.~.~.e.&   @ c.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.c   . g.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.Z.    +   f ~.~.~.~.~.S       [ ~.~.~.~.E.<   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$       7 B.~.~.~.~.~.#.X . p.~.~.V   .  .~.~.~.~.~.Z.0     %.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.C.    K ~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.Z.    +   f ~.~.~.~.~.S       [ ~.~.~.~.E.<   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   @     z E.~.~.~.~.~.V   1 U.7.    m !.~.~.~.~.W.v     F ~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.0.    9.~.~.~.~.~.U._ M v v v v v v v v v v v v v v j     +   f ~.~.~.~.~.S       [ ~.~.~.~.E.<   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   !       R ~.~.~.~.~.F.7   m ;   4 V.~.~.~.~.~.W     e R.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.`     V.~.~.~.~.R.9                                       +   f ~.~.~.~.~.S       [ ~.~.~.~.E.<   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   r.I     O 2.~.~.~.~.~.4.O     o @.~.~.~.~.~.4.@   & V.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.N   o !.~.~.~.~.s.                                        +   f ~.~.~.~.~.S       [ ~.~.~.~.E.<   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   r.W.t     2 v.~.~.~.~.~.G     V ~.~.~.~.~.n.3   . 0.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.v     G.~.~.~.~.A.+                           + A %.%.%.%.+   f ~.~.~.~.~.S       [ ~.~.~.~.E.<   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   r.~.S.=     d Y.~.~.~.~.L.e 6 D.~.~.~.~.T.g     E ~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.U     u.~.~.~.~.~.y.q o                           q <.~.~.+   f ~.~.~.~.~.S       [ ~.~.~.~.E.<   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   r.~.~.r..     J ~.~.~.~.~.i.w.~.~.~.~.~.K     a Q.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~...    / ~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.W.B.t.X.C o     H !.+   f ~.~.~.~.~.S       [ ~.~.~.~.E.<   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   r.~.~.~.~     o +.~.~.~.~.~.~.~.~.~.~.@.o   : G.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.h.    $ F.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.V.Z X   M +   f ~.~.~.~.~.S       [ ~.~.~.~.E.<   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   r.~.~.~.Q.f     ; h.~.~.~.~.~.~.~.~.j.:   X a.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.u     B ~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    X   f ~.~.~.~.~.S       [ ~.~.~.~.E.<   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   r.~.~.~.~.H.>     c ~.~.~.~.~.~.~.~.c     ] ~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.q.      H I.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.N   .   f ~.~.~.~.~.S       [ ~.~.~.~.E.<   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   r.~.~.~.~.Y.7   # 9.~.~.~.~.~.~.~.~.9.#   2.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.!.z       : 5.!.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.U.-     f ~.~.~.~.~.S       ` ~.~.~.~.W.2   3.~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   r.~.~.~.~.F     E ~.~.~.~.~.~.~.~.~.~.E   $ V.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.~.E.b         + 9 n W o.O.O.O.O.O.O.O.1.S.~.~.~.~.~.~.x     f ~.~.~.~.~.S       L ~.~.~.~.~.i   | ~.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   r.~.~.~.7.    h E.~.~.~.~.~.~.~.~.~.~.E.h   r W.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.~.~.W.A .                               o 3.~.~.~.~.~.~     f ~.~.~.~.~.S       l ~.~.~.~.~.Z   d !.~.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   r.~.~.A.&   < v.~.~.~.~.~.) T ~.~.~.~.~.b.<   R ~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.~.~.~.~.V.E ;                             5 ~.~.~.~.~.7.    f ~.~.~.~.~.S       8 !.~.~.~.~.w.#   V Z.~.~.~.~.~.~.~.~.~.~.~.%.    ..~.~.~.~.U.$   r.~.Q.p   o @.~.~.~.~.~.s.* # 0.~.~.~.~.~.$.X . t.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.h.v v v v v l @                           t ~.~.~.~.~.q.    f ~.~.~.~.~.S   X   + B.~.~.~.~.~.W .   X 6 g v v v v v v v v v e     ..~.~.~.~.U.$   r.~./     D ~.~.~.~.~.R.a     e L.~.~.~.~.~.G   ; H.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.9.                                      O 5.~.~.~.~.~.`     f ~.~.~.~.~.S   -      .~.~.~.~.~.Q.$.i .                             ..~.~.~.~.U.$   r.d.X   r L.~.~.~.~.~.Q         J ~.~.~.~.~.I.t   j !.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.9.    M ] ] ] ] ] ] ] ] ] ] ] ] ] ] ] $.L.~.~.~.~.~.~.N     f ~.~.~.~.~.S   8     4 C.~.~.~.~.~.~.Q.i.%._ T T T T T T T T T <     ..~.~.~.~.U.$   7.1   * a.~.~.~.~.~.p.&   O     # 9.~.~.~.~.~.s.-   [ ~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.9.    <.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.W.3     f ~.~.~.~.~.S   k @     B ~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.w     ..~.~.~.~.U.$   i   . ` ~.~.~.~.~.T.p     2.j     w L.~.~.~.~.~.{   o k.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.9.    <.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.E       f ~.~.~.~.~.S   v Y     X $.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.w     ..~.~.~.~.U.$       m Q.~.~.~.~.~.W     b ~.S.$     J ~.~.~.~.~.!.M   4 U.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.9.    <.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.t..   .   f ~.~.~.~.~.S   v K.<     % H A.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.w     ..~.~.~.~.U.$     6 Z.~.~.~.~.~.u.%   = H.~.~.#.    + 9.~.~.~.~.~.D.9   B ~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.9.    <.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.J.E #   . o   f ~.~.~.~.~.S   v ~.z.#       < ^ Y.~.~.~.~.~.~.~.~.~.~.~.~.~.~.w     ..~.~.~.~.U.$   @ 6.~.~.~.~.~.Y.u     3.~.~.~.~.k     w K.~.~.~.~.~.0.#   %.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.9.    <.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.H.h.1.P #       P +   f U.U.U.U.U.S   v ~.~.y.*         7 m U { 3.v.U.U.U.U.U.U.U.U.U.w     | U.U.U.U.F.$   I U.U.U.U.U.U.T     n ~.~.~.~.~.S.%     H U.U.U.U.U.U.T   # N.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.9.    # & & & & & & & & & & & & & & @             . N R.+   + ; ; ; ; ; #   v ~.~.~.S.y                 X = ; ; ; ; ; ; ; ; O     & ; ; ; ; ; . . - ; ; ; ; ; ; o   = H.~.~.~.~.~.~.$.    X ; ; ; ; ; ; - .   e E.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.9.                                              g l.~.~.+                   v ~.~.~.~.!.0.p                                                                         5.~.~.~.~.~.~.~.~.l                         I ~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.9.                                    % e m E u.~.~.~.~.+                   v ~.~.~.~.~.~.~.m.O.B 5 $                                                             m ~.~.~.~.~.~.~.~.~.D.&                         q.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.Y.Z.Z.Z.Z.Z.Z.Z.Z.Z.Z.Z.Z.Z.Z.Z.Z.Z.K.~.~.~.~.~.~.~.~.~.Z.Z.Z.Z.Z.Z.Z.Z.Z.Z.H.~.~.~.~.~.~.~.~.~.~.~.~.W.J.Z.Z.Z.Z.Z.Z.Z.Z.Z.n.f.b.Z.Z.V.f.f.f.f.f.M.Z.Z.Z.Z.Z.Z.Z.T.~.~.~.~.~.~.~.~.~.~.J.Z.Z.Z.Z.Z.Z.Z.Z.Z.Z.Z.Z.H.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.~.\",\n \"&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.&.\",\n \"s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s \",\n \"s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s s \"};\n");
		commitBuffer();
	}
	delete cursor;
	util.setProgress( ++paso );

	this.iface.crearProvinciasArg();
	util.setProgress( ++paso );
	util.destroyProgressDialog();
}

function oficial_crearProvinciasArg()
{
	var cursor:FLSqlCursor = new FLSqlCursor("provincias");
	var provincias:Array =
			[[1, "ARG", "..."],[2, "ARG", "CIUDAD AUTÓNOMA DE BUENOS AIRES"],[3, "ARG", "PROVINCIA DE BUENOS AIRES"],[4, "ARG", "CATAMARCA"],[5, "ARG", "CHACO"],[6, "ARG", "CHUBUT"],[7, "ARG", "CÓRDOBA"],[8, "ARG", "CORRIENTES"],[9, "ARG", "ENTRE RÍOS"],[10, "ARG", "FORMOSA"],[11, "ARG", "JUJUY"],[12, "ARG", "LA PAMPA"],[13, "ARG", "LA RIOJA"],[14, "ARG", "MENDOZA"],[15, "ARG", "MISIONES"],[16, "ARG", "NEUQUÉN"],[17, "ARG", "RÍO NEGRO"],[18, "ARG", "SALTA"],[19, "ARG", "SAN JUAN"],[20, "ARG", "SAN LUIS"],[21, "ARG", "SANTA CRUZ"],[22, "ARG", "SANTA FE"],[23, "ARG", "SANTIAGO DEL ESTERO"],[24, "ARG", "TIERRA DEL FUEGO"],[25,"ARG", "TUCUMÁN"]];
	for (var i:Number = 0; i < provincias.length; i++) {
		with(cursor) {
			setModeAccess(cursor.Insert);
			refreshBuffer();
			setValueBuffer("idprovincia", provincias[i][0]);
			setValueBuffer("codpais", provincias[i][1]);
			setValueBuffer("provincia", provincias[i][2]);
			commitBuffer();
		}
	}
}

function oficial_valorQuery(tablas:String, select:String, from:String, where:String):String
{
	var qry:FLSqlQuery = new FLSqlQuery();
	try { qry.setForwardOnly( true ); } catch (e) {}
	qry.setTablesList(tablas);
	qry.setSelect(select);
	qry.setFrom(from);
	qry.setWhere(where);
	qry.exec();
	if (qry.next())
		return qry.value(0);
	else
		return "";
}

/** \D
Crea una subcuenta contable, si no existe ya la combinación Código de subcuenta - Ejercicio actual
@param	codSubcuenta: Código de la subcuenta a crear
@param	descripcion: Descripción de la subcuenta a crear
@param	idCuentaEsp: Indicador del tipo de cuenta especial (CLIENT = cliente, PROVEE = proveedor)
@param	codEjercicio: Código del ejercicio en el que se va a crear la subcuenta
@return	id de la subcuenta creada o ya existente.
\end */
function oficial_crearSubcuenta(codSubcuenta:String, descripcion:String, idCuentaEsp:String, codEjercicio:String):Number
{
	var util:FLUtil = new FLUtil();

	var datosEmpresa:Array;
	if (!codEjercicio) {
		datosEmpresa["codejercicio"] = this.iface.ejercicioActual();
	} else {
		datosEmpresa["codejercicio"] = codEjercicio;
	}
	datosEmpresa["coddivisa"] = this.iface.valorDefectoEmpresa("coddivisa");
	
	var idSubcuenta:String = util.sqlSelect("co_subcuentas", "idsubcuenta","codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + datosEmpresa.codejercicio + "'");
	if (idSubcuenta) {
		return idSubcuenta;
	}
	var codCuenta3:String = codSubcuenta.left(3);
	var codCuenta4:String = codSubcuenta.left(4);
	var datosCuenta:Array = this.iface.ejecutarQry("co_cuentas", "codcuenta,idcuenta",
		"idcuentaesp = '" + idCuentaEsp + "'" +
		" AND codcuenta = '" + codCuenta4 + "'" + 
		" AND codejercicio = '" + datosEmpresa.codejercicio + "' ORDER BY codcuenta");

	if (datosCuenta.result == -1) {
		datosCuenta = this.iface.ejecutarQry("co_cuentas", "codcuenta,idcuenta", "idcuentaesp = '" + idCuentaEsp + "'" + " AND codcuenta = '" + codCuenta3 + "'" + " AND codejercicio = '" + datosEmpresa.codejercicio + "' ORDER BY codcuenta");
		if (datosCuenta.result == -1)  {
			return true;
		}
	}
	var curSubcuenta:FLSqlCursor = new FLSqlCursor("co_subcuentas");
	with (curSubcuenta) {
		setModeAccess(curSubcuenta.Insert);
		refreshBuffer();
		setValueBuffer("codsubcuenta", codSubcuenta);
		setValueBuffer("descripcion", descripcion);
		setValueBuffer("idcuenta", datosCuenta.idcuenta);
		setValueBuffer("codcuenta", datosCuenta.codcuenta);
		setValueBuffer("coddivisa", datosEmpresa.coddivisa);
		setValueBuffer("codejercicio", datosEmpresa.codejercicio);
	}
	if (!curSubcuenta.commitBuffer()) {
		return false;
	}

	return curSubcuenta.valueBuffer("idsubcuenta");
}

/** \D Borra una subcuenta contable en el caso de que no existan partidas asociadas
@param	idSubcuenta: Identificador de la subcuenta a borrar
@return	True si no hay error, False en otro caso
\end */
function oficial_borrarSubcuenta(idSubcuenta:Number):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!util.sqlSelect("co_partidas", "idpartida",
		"idsubcuenta = " + idSubcuenta)) {
		var curSubcuenta:FLSqlCursor = new FLSqlCursor("co_subcuentas");
		curSubcuenta.select("idsubcuenta = " + idSubcuenta);
		curSubcuenta.first();
		curSubcuenta.setModeAccess(curSubcuenta.Del);
		curSubcuenta.refreshBuffer();
		if (!curSubcuenta.commitBuffer()) {
			return false;
		}
	}
	return true;
}

/* \D Devuelve el código e id de la subcuenta de cliente según su código
@param codCliente: Código del cliente
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: Código de la subcuenta
\end */
function oficial_datosCtaCliente(codCliente:String, valoresDefecto:Array):Array
{
	/* \C En caso de que el código de cliente sea vacío, la subcuenta de clientes será la primera que depende de la cuenta especial de clientes (generalmente 430...0)
	\end */
	if ( !codCliente || codCliente == "" )
		return flfacturac.iface.pub_datosCtaEspecial("CLIENT", valoresDefecto.codejercicio);

	var util:FLUtil = new FLUtil();
	var ctaCliente:Array = [];
	ctaCliente["codsubcuenta"] = "";
	ctaCliente["idsubcuenta"] = "";
	if (!codCliente.toString().isEmpty()) {
		var qrySubcuenta:FLSqlQuery = new FLSqlQuery();
		try { qrySubcuenta.setForwardOnly( true ); } catch (e) {}
		qrySubcuenta.setTablesList("co_subcuentascli");
		qrySubcuenta.setSelect("idsubcuenta, codsubcuenta");
		qrySubcuenta.setFrom("co_subcuentascli");
		qrySubcuenta.setWhere("codcliente = '" + codCliente + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
		if (!qrySubcuenta.exec()) {
			ctaCliente.error = 2;
			return ctaCliente;
		}
		if (!qrySubcuenta.first()) {
			MessageBox.critical(util.translate("scripts", "No hay ninguna subcuenta asociada al cliente ") + codCliente + util.translate("scripts", " para el ejercicio ") + valoresDefecto.codejercicio + ".\n" + util.translate("scripts", "Debe crear la subcuenta en el formulario de clientes."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			ctaCliente.error = 1;
			return ctaCliente;
		}
		ctaCliente.idsubcuenta = qrySubcuenta.value(0);
		ctaCliente.codsubcuenta = qrySubcuenta.value(1);
	}
	ctaCliente.error = 0;
	return ctaCliente;
}

/* \D Devuelve el código e id de la subcuenta de proveedor según su código
@param codProveedor: Código del proveedor
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: Código de la subcuenta
\end */
function oficial_datosCtaProveedor(codProveedor:String, valoresDefecto:Array):Array
{
	/* \C En caso de que el código de proveedor sea vacío, la subcuenta de proveedores será la primera que depende de la cuenta especial de proveedores (generalmente 400...0)
	\end */
	if ( !codProveedor || codProveedor == "" )
		return flfacturac.iface.pub_datosCtaEspecial("PROVEE", valoresDefecto.codejercicio);

	var util:FLUtil = new FLUtil();
	var ctaProveedor:Array = [];
	ctaProveedor["codsubcuenta"] = "";
	ctaProveedor["idsubcuenta"] = "";
	if (!codProveedor.toString().isEmpty()) {
		var qrySubcuenta:FLSqlQuery = new FLSqlQuery();
		qrySubcuenta.setTablesList("co_subcuentasprov");
		qrySubcuenta.setSelect("idsubcuenta, codsubcuenta");
		qrySubcuenta.setFrom("co_subcuentasprov");
		qrySubcuenta.setWhere("codproveedor = '" + codProveedor + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
		if (!qrySubcuenta.exec()) {
			ctaProveedor.error = 1;
			return ctaProveedor;
		}
		if (!qrySubcuenta.first()) {
			MessageBox.critical(util.translate("scripts", "No hay ninguna subcuenta asociada al proveedor ") + codProveedor + util.translate("scripts", " para el ejercicio ") + valoresDefecto.codejercicio + ".\n" + util.translate("scripts", "Debe crear la subcuenta en el formulario de proveedores."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			ctaProveedor.error = 1;
			return ctaProveedor;
		}
		ctaProveedor.idsubcuenta = qrySubcuenta.value(0);
		ctaProveedor.codsubcuenta = qrySubcuenta.value(1);
	}
	ctaProveedor.error = 0;
	return ctaProveedor;
}

/** \D Calcula la fecha inicial y la fecha final del intervalo
@param	codIntervalo: código del intervalo.
@return	 intervalo: array con las fechas inicial y final del intervalo
\end */
function oficial_calcularIntervalo(codIntervalo:String):Array 
{
	var util:FLUtil = new FLUtil();
	var intervalo:Array = [];

	var textoFun:String = util.sqlSelect("intervalos", "funcionintervalo", "codigo = '" + codIntervalo + "'");

	var funcionVal = new Function(textoFun);
	var resultado = funcionVal();
	if (resultado)
		return resultado;

	intervalo["desde"] = false;
	intervalo["hasta"] = false;

	var fechaDesde:Date = new Date();
	var fechaHasta:Date = new Date();
	var mes:Number;
	var anio:Number;
	
	switch(codIntervalo) {
		case "000001": {
			intervalo.desde = fechaDesde;
			intervalo.hasta = fechaHasta;
			break;
		}

		case "000002": {
			intervalo.desde = util.addDays(fechaDesde,-1);
			intervalo.hasta = util.addDays(fechaHasta,-1);
			break;
		}
		
		case "000003": {
			var dias:Number = fechaDesde.getDay() -1;
			dias = dias * -1;
			intervalo.desde = util.addDays(fechaDesde, dias);
			intervalo.hasta = util.addDays(intervalo.desde,6);
			break;
		}
		
		case "000004": {
			var dias:Number = fechaHasta.getDay() -1;
			dias = dias * -1;
			intervalo.hasta = util.addDays(fechaHasta, dias -1);
			intervalo.desde = util.addDays(intervalo.hasta,-6);
			break;
		}
			
		case "000005": {
			mes = fechaDesde.getMonth();
			fechaDesde.setDate(1);
			intervalo.desde = fechaDesde;
			fechaHasta.setDate(1);
			fechaHasta = util.addMonths(fechaHasta, 1);;
			fechaHasta = util.addDays(fechaHasta,-1);
			intervalo.hasta = fechaHasta;
			break;
		}
		
		case "000006": {
			fechaDesde.setDate(1);
			fechaDesde = util.addMonths(fechaDesde, -1);
			intervalo.desde = fechaDesde;
			fechaHasta.setDate(1);
			fechaHasta = util.addDays(fechaHasta,-1);
			intervalo.hasta = fechaHasta;
			break;
		}
		
		case "000007": {
			fechaDesde.setDate(1);
			fechaDesde.setMonth(1);
			intervalo.desde = fechaDesde;
			fechaHasta.setMonth(12)
			fechaHasta.setDate(31);
			intervalo.hasta = fechaHasta;
			break;
		}
		
		case "000008": {
			anio = fechaDesde.getYear() - 1;
			fechaDesde.setDate(1);
			fechaDesde.setMonth(1);
			fechaDesde.setYear(anio);
			intervalo.desde = fechaDesde;
			fechaHasta.setDate(31);
			fechaHasta.setMonth(12)
			fechaHasta.setYear(anio);
			intervalo.hasta = fechaHasta;
			break;
		}
		
		case "000009": {
			intervalo.desde = "1970-01-01";
			intervalo.hasta = "3000-01-01";
			break;
		}
		
		case "000010": {
			intervalo.desde = "1970-01-01";
			intervalo.hasta = fechaHasta;
			break;
		}
	}

	return intervalo;
}

/** \D
Crea una subcuenta contable, si no existe ya la combinación Código de subcuenta - Ejercicio actual
@param	codSubcuenta: Código de la subcuenta a crear
@param	idSubcuenta: Identificador de la subcuenta a crear
@param	codCliente: Cliente para el que se crea la subcuenta
@param	codEjercicio: Código del ejercicio en el que se va a crear la subcuenta
@return	Verdadero si no hay error, Falso en otro caso
\end */
function oficial_crearSubcuentaCli(codSubcuenta:String, idSubcuenta:Number, codCliente:String, codEjercicio:String):Boolean
{
	var curSubcuentaCli:FLSqlCursor = new FLSqlCursor("co_subcuentascli");
	with (curSubcuentaCli) {
		setModeAccess(curSubcuentaCli.Insert);
		refreshBuffer();
		setValueBuffer("codsubcuenta", codSubcuenta);
		setValueBuffer("idSubcuenta", idSubcuenta);
		setValueBuffer("codcliente", codCliente);
		setValueBuffer("codejercicio", codEjercicio);
	}
	if (!curSubcuentaCli.commitBuffer())
		return false;

	return true;
}

/** \D
Crea una subcuenta contable, si no existe ya la combinación Código de subcuenta - Ejercicio actual
@param	codSubcuenta: Código de la subcuenta a crear
@param	idSubcuenta: Identificador de la subcuenta a crear
@param	codProveedor: Proveedor para el que se crea la subcuenta
@param	codEjercicio: Código del ejercicio en el que se va a crear la subcuenta
@return	Verdadero si no hay error, Falso en otro caso
\end */
function oficial_crearSubcuentaProv(codSubcuenta:String, idSubcuenta:Number, codProveedor:String, codEjercicio:String):Boolean
{
	var curSubcuentaProv:FLSqlCursor = new FLSqlCursor("co_subcuentasprov");
	with (curSubcuentaProv) {
		setModeAccess(curSubcuentaProv.Insert);
		refreshBuffer();
		setValueBuffer("codsubcuenta", codSubcuenta);
		setValueBuffer("idSubcuenta", idSubcuenta);
		setValueBuffer("codproveedor", codProveedor);
		setValueBuffer("codejercicio", codEjercicio);
	}
	if (!curSubcuentaProv.commitBuffer())
		return false;

	return true;
}

/** \D Crea las subcuentas  asociadas a un cliente que todavía no existen en los ejercicios con plan general contable 
@param codCliente: Código de cliente
@param codSubcuenta: Código de subcuenta
@param nombre: Nombre del cliente
@return True si la generación de subcuentas finaliza correctamente, falso en caso contrario
*/
function oficial_rellenarSubcuentasCli(codCliente:String, codSubcuenta:String, nombre:String):Boolean
{
	if (!sys.isLoadedModule("flcontppal"))
		return true;
	if (!codSubcuenta)
		return true;
	
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	qry.setTablesList("ejercicios,co_subcuentascli");
	qry.setSelect("e.codejercicio");
	qry.setFrom("ejercicios e LEFT OUTER JOIN co_subcuentascli s ON e.codejercicio = s.codejercicio AND s.codcliente = '" + codCliente + "'");
	qry.setWhere("s.id IS NULL");
	if (!qry.exec())
		return false;
	
	var idSubcuenta:Number;
	var codEjercicio:String;
	while (qry.next()) {
		codEjercicio = qry.value(0);
		if (!util.sqlSelect("co_epigrafes", "codepigrafe", "codejercicio = '" + codEjercicio + "'"))
			continue;
		idSubcuenta = this.iface.crearSubcuenta(codSubcuenta, nombre, "CLIENT", codEjercicio);
		if (!idSubcuenta)
			return false;
		
		if (idSubcuenta == true)
			continue;
		
		if (!this.iface.crearSubcuentaCli(codSubcuenta, idSubcuenta, codCliente, codEjercicio))
			return false;
	}
	
	return true;
}

/** \D Crea las subcuentas  asociadas a un proveedor que todavía no existen en los ejercicios con plan general contable 
@param codProveedor: Código de proveedor
@param codSubcuenta: Código de subcuenta
@param nombre: Nombre del proveedor
@return True si la generación de subcuentas finaliza correctamente, falso en caso contrario
*/
function oficial_rellenarSubcuentasProv(codProveedor:String, codSubcuenta:String, nombre:String):Boolean
{
	if (!sys.isLoadedModule("flcontppal"))
		return;
	
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	qry.setTablesList("ejercicios,co_subcuentasprov");
	qry.setSelect("e.codejercicio");
	qry.setFrom("ejercicios e LEFT OUTER JOIN co_subcuentasprov s ON e.codejercicio = s.codejercicio AND s.codproveedor = '" + codProveedor + "'");
	qry.setWhere("s.id IS NULL");
	if (!qry.exec())
		return false;
	
	var idSubcuenta:Number;
	var codEjercicio:String;
	while (qry.next()) {
		codEjercicio = qry.value(0);
		if (!util.sqlSelect("co_epigrafes", "codepigrafe", "codejercicio = '" + codEjercicio + "'"))
			continue;
		idSubcuenta = this.iface.crearSubcuenta(codSubcuenta, nombre, "PROVEE", codEjercicio);
		if (!idSubcuenta)
			return false;
		
		if (idSubcuenta == true) 
			continue;
		
		if (!this.iface.crearSubcuentaProv(codSubcuenta, idSubcuenta, codProveedor, codEjercicio))
			return false;
	}
	
	return true;
}

/** \D Indica si el módulo de autómata está instalado y activado
@return	true si está activado, false en caso contrario
\end */
function oficial_automataActivado():Boolean
{
	if (!sys.isLoadedModule("flautomata"))
		return false;
	
	if (formau_automata.iface.pub_activado())
		return true;
	
	return false;
}


/** \D Indica si el cliente está activo (no está de baja) para la fecha especificada
@param	codCliente: Código de cliente
@param	fecha: Fecha a considerar
@return	true si está activo, false en caso contrario o si hay error
\end */
function oficial_clienteActivo(codCliente:String, fecha:String):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!codCliente || codCliente == "")
		return true;
	
	var qryBaja:FLSqlQuery = new FLSqlQuery();
	qryBaja.setTablesList("clientes");
	qryBaja.setSelect("debaja, fechabaja");
	qryBaja.setFrom("clientes");
	qryBaja.setWhere("codcliente = '" + codCliente + "'");
	qryBaja.setForwardOnly(true);
	if (!qryBaja.exec())
		return false;
	
	if (!qryBaja.first())
		return false;
	
	if (!qryBaja.value("debaja"))
		return true;
		
	if (util.daysTo(fecha, qryBaja.value("fechabaja")) <= 0) {
		if (!this.iface.automataActivado()) {
			var fechaDdMmAaaa:String = util.dateAMDtoDMA(fecha);
			MessageBox.warning(util.translate("scripts", "El cliente está de baja para la fecha especificada (%1)").arg(fechaDdMmAaaa), MessageBox.Ok, MessageBox.NoButton);
		}
		return false;
	}
	return true;
}

/** \D Indica si el proveedor está activo (no está de baja) para la fecha especificada
@param	codProveedor: Código de proveedor
@param	fecha: Fecha a considerar
@return	true si está activo, false en caso contrario o si hay error
\end */
function oficial_proveedorActivo(codProveedor:String, fecha:String):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!codProveedor || codProveedor == "")
		return true;
	
	var qryBaja:FLSqlQuery = new FLSqlQuery();
	qryBaja.setTablesList("proveedores");
	qryBaja.setSelect("debaja, fechabaja");
	qryBaja.setFrom("proveedores");
	qryBaja.setWhere("codproveedor = '" + codProveedor + "'");
	qryBaja.setForwardOnly(true);
	if (!qryBaja.exec())
		return false;
	
	if (!qryBaja.first())
		return false;
	
	if (!qryBaja.value("debaja"))
		return true;
		
	if (util.daysTo(fecha, qryBaja.value("fechabaja")) <= 0) {
		if (!this.iface.automataActivado()) {
			var fechaDdMmAaaa:String = util.dateAMDtoDMA(fecha);
			MessageBox.warning(util.translate("scripts", "El proveedor está de baja para la fecha especificada (%1)").arg(fechaDdMmAaaa), MessageBox.Ok, MessageBox.NoButton);
		}
		return false;
	}
	return true;
}

/** \D Autocompleta la provincia cuando el usuario pulsa . u ofrece la lista de provincias que comienzan por el valor actual del campo para que el usuario elija
@param	formulario	Formulario que contiene el campo de provincia
@param	campoId Campo del id de provincia en base de datos
@param	campoProvincia Campo del valor de la provincia en base de datos
@param	campoPais Campo del código de país en base de datos
\end */
function oficial_obtenerProvincia(formulario:Object, campoId:String, campoProvincia:String, campoPais:String)
{
	var util:FLUtil = new FLUtil;
	if (!campoId)
		campoId = "idprovincia";

	if (!campoProvincia)
		campoProvincia = "provincia";

	if (!campoPais)
		campoPais = "codpais";

	var provincia:String = formulario.cursor().valueBuffer(campoProvincia);
	if (!provincia || provincia == "") {
		return;
	}
	if (provincia.endsWith(".")) {
		formulario.cursor().setNull(campoId);
		//provincia = util.utf8(provincia);

		provincia = provincia.left(provincia.length - 1);
		provincia = provincia.toUpperCase();
		
		var where:String = "UPPER(provincia) LIKE '" + provincia + "%'";
		var codPais:String = formulario.cursor().valueBuffer(campoPais);
		if (codPais && codPais != "")
			where += " AND codpais = '" + codPais + "'";
		
		var qryProvincia:FLSqlQuery = new FLSqlQuery;
		with (qryProvincia) {
			setTablesList("provincias");
			setSelect("idprovincia");
			setFrom("provincias");
			setForwardOnly(true);
		}
		qryProvincia.setWhere(where);

		if (!qryProvincia.exec())
			return false;

		switch (qryProvincia.size()) {
			case 0: {
				return;
			}
			case 1: {
				if (!qryProvincia.first()) {
					return false;
				}
				formulario.cursor().setValueBuffer(campoId, qryProvincia.value("idprovincia"));
				break;
			}
			default: {
				var listaProvincias:String = "";
				while (qryProvincia.next()) {
					if (listaProvincias != "")
						listaProvincias += ", ";
					listaProvincias += qryProvincia.value("idprovincia");
				}
				var f:Object = new FLFormSearchDB("provincias");
				var curProvincias:FLSqlCursor = f.cursor();
				curProvincias.setMainFilter("idprovincia IN (" + listaProvincias + ")");
	
				f.setMainWidget();
				var idProvincia:String = f.exec("idprovincia");

				if (idProvincia)
					formulario.cursor().setValueBuffer(campoId, idProvincia);
				break;
			}
		}
	}
}


function oficial_actualizarContactos20070525():Boolean
{
	var util:FLUtil;

	var qryClientes:FLSqlQuery = new FLSqlQuery();
	qryClientes.setTablesList("clientes");
	qryClientes.setFrom("clientes");
	qryClientes.setSelect("codcliente,codcontacto,contacto");
	qryClientes.setWhere("");
	if (!qryClientes.exec()) 
		return false;

	util.createProgressDialog(util.translate("scripts", "Reorganizando Contactos"), qryClientes.size());
	util.setProgress(0);

	var cont:Number = 1;
	
	while (qryClientes.next()) {
		util.setProgress(cont);
		cont += 1;
		var codCliente:String = qryClientes.value("codcliente");
		
		if(!codCliente) {
			util.destroyProgressDialog();
			return false;
		}
			
		var qryAgenda:FLSqlQuery = new FLSqlQuery();
		qryAgenda.setTablesList("contactosclientes");
		qryAgenda.setFrom("contactosclientes");
		qryAgenda.setSelect("contacto,cargo,telefono,fax,email,id,codcliente");
		qryAgenda.setWhere("codcliente = '" + codCliente + "'");
		if (!qryAgenda.exec()) {
			util.destroyProgressDialog();
			return false;
		}

		if (sys.isLoadedModule("flcrm_ppal")) {
			var qryClientesContactos:FLSqlQuery = new FLSqlQuery();
			qryClientesContactos.setTablesList("crm_clientescontactos");
			qryClientesContactos.setFrom("crm_clientescontactos");
			qryClientesContactos.setSelect("codcontacto");
			qryClientesContactos.setWhere("codcliente = '" + codCliente + "' AND codcontacto NOT IN(SELECT codcontacto FROM contactosclientes WHERE codcliente = '" + codCliente + "')");
			if (!qryClientesContactos.exec()) {
				util.destroyProgressDialog();
				return false;
			}
				
	
			while (qryClientesContactos.next())
				this.iface.actualizarContactosDeAgenda20070525(codCliente,qryClientesContactos.value("codcontacto"));
		}

		while (qryAgenda.next()) {
			var nombreCon:String = qryAgenda.value("contacto");
			var cargoCon:String = qryAgenda.value("cargo");
			var telefonoCon:String = qryAgenda.value("telefono");
			var faxCon:String = qryAgenda.value("fax");
			var emailCon:String = qryAgenda.value("email");
			var idAgenda:Number = qryAgenda.value("id");
			if (!idAgenda || idAgenda == 0) {
				util.destroyProgressDialog();
				return false;
			}
			
			var qryContactos:FLSqlQuery = new FLSqlQuery();
			qryContactos.setTablesList("crm_contactos,contactosclientes");
			qryContactos.setFrom("crm_contactos INNER JOIN contactosclientes ON crm_contactos.codcontacto = contactosclientes.codcontacto");
			qryContactos.setSelect("crm_contactos.codcontacto");
			qryContactos.setWhere("crm_contactos.nombre = '" + nombreCon + "' AND (contactosclientes.codcliente = '" + codCliente + "' AND (crm_contactos.email = '" + emailCon + "' AND crm_contactos.telefono1 = '" + telefonoCon + "'))");
			if (!qryContactos.exec()) {
				util.destroyProgressDialog();
				return false;
			}
			
			var codContacto:String = "";

			if (qryContactos.first())
				codContacto = qryContactos.value("crm_contactos.codcontacto");

			if(!this.iface.actualizarContactosDeAgenda20070525(codCliente,codContacto,nombreCon,cargoCon,telefonoCon,faxCon,emailCon,idAgenda)) {
				util.destroyProgressDialog();
				return false;
			}
		}

		if ((qryClientes.value("contacto") && qryClientes.value("contacto") != "") && (!qryClientes.value("codcontacto") || qryClientes.value("codcontacto") == "")) {
				codContacto = util.sqlSelect("crm_contactos", "codcontacto", "nombre = '" + qryClientes.value("contacto") + "'");
				if (codContacto)
					this.iface.actualizarContactosDeAgenda20070525(codCliente,codContacto,qryClientes.value("contacto"));
				else
					codContacto = this.iface.actualizarContactosDeAgenda20070525(codCliente,"",qryClientes.value("contacto"));

				if(!codContacto) {
					util.destroyProgressDialog();
					return false;
				}
			
				var curCliente:FLSqlCursor = new FLSqlCursor("clientes");
				curCliente.select("codcliente = '" + codCliente + "'");
				curCliente.setModeAccess(curCliente.Edit);
				if (!curCliente.first()) {
					util.destroyProgressDialog();
					return false;
				}
				curCliente.refreshBuffer();
				curCliente.setValueBuffer("codcontacto", codContacto);
			
				if (!curCliente.commitBuffer()) {
					util.destroyProgressDialog();
					return false;
				}
		}
	}
	util.setProgress(qryClientes.size());
	util.destroyProgressDialog();
	return true;
}

function oficial_actualizarContactosProv20070702():Boolean
{
	var util:FLUtil;

	var qryProveedores:FLSqlQuery = new FLSqlQuery();
	qryProveedores.setTablesList("proveedores");
	qryProveedores.setFrom("proveedores");
	qryProveedores.setSelect("codproveedor,codcontacto,contacto");
	qryProveedores.setWhere("");
	if (!qryProveedores.exec()) 
		return false;

	util.createProgressDialog(util.translate("scripts", "Reorganizando Contactos"), qryProveedores.size());
	util.setProgress(0);

	var cont:Number = 1;
	
	while (qryProveedores.next()) {
		util.setProgress(cont);
		cont += 1;
		var codProveedor:String = qryProveedores.value("codproveedor");
		
		if(!codProveedor) {
			util.destroyProgressDialog();
			return false;
		}
			
		var qryAgenda:FLSqlQuery = new FLSqlQuery();
		qryAgenda.setTablesList("contactosproveedores");
		qryAgenda.setFrom("contactosproveedores");
		qryAgenda.setSelect("contacto,cargo,telefono,fax,email,id,codproveedor");
		qryAgenda.setWhere("codproveedor = '" + codProveedor + "'");
		if (!qryAgenda.exec()) {
			util.destroyProgressDialog();
			return false;
		}

		while (qryAgenda.next()) {
			var nombreCon:String = qryAgenda.value("contacto");
			var cargoCon:String = qryAgenda.value("cargo");
			var telefonoCon:String = qryAgenda.value("telefono");
			var faxCon:String = qryAgenda.value("fax");
			var emailCon:String = qryAgenda.value("email");
			var idAgenda:Number = qryAgenda.value("id");
			if (!idAgenda || idAgenda == 0) {
				util.destroyProgressDialog();
				return false;
			}
			
			var qryContactos:FLSqlQuery = new FLSqlQuery();
			qryContactos.setTablesList("crm_contactos,contactosproveedores");
			qryContactos.setFrom("crm_contactos INNER JOIN contactosproveedores ON crm_contactos.codcontacto = contactosproveedores.codcontacto");
			qryContactos.setSelect("crm_contactos.codcontacto");
			qryContactos.setWhere("crm_contactos.nombre = '" + nombreCon + "' AND (contactosproveedores.codproveedor = '" + codProveedor + "' AND (crm_contactos.email = '" + emailCon + "' AND crm_contactos.telefono1 = '" + telefonoCon + "'))");
			if (!qryContactos.exec()) {
				util.destroyProgressDialog();
				return false;
			}
			
			var codContacto:String = "";

			if (qryContactos.first())
				codContacto = qryContactos.value("crm_contactos.codcontacto");

			if(!this.iface.actualizarContactosDeAgendaProv20070702(codProveedor,codContacto,nombreCon,cargoCon,telefonoCon,faxCon,emailCon,idAgenda)) {
				util.destroyProgressDialog();
				return false;
			}
		}

		if ((qryProveedores.value("contacto") && qryProveedores.value("contacto") != "") && (!qryProveedores.value("codcontacto") || qryProveedores.value("codcontacto") == "")) {
				codContacto = util.sqlSelect("crm_contactos", "codcontacto", "nombre = '" + qryProveedores.value("contacto") + "'");
				if (codContacto)
					this.iface.actualizarContactosDeAgendaProv20070702(codProveedor,codContacto,qryProveedores.value("contacto"));
				else
					codContacto = this.iface.actualizarContactosDeAgendaProv20070702(codProveedor,"",qryProveedores.value("contacto"));

				if(!codContacto) {
					util.destroyProgressDialog();
					return false;
				}
			
				var curProveedor:FLSqlCursor = new FLSqlCursor("proveedores");
				curProveedor.select("codproveedor = '" + codProveedor + "'");
				curProveedor.setModeAccess(curProveedor.Edit);
				if (!curProveedor.first()) {
					util.destroyProgressDialog();
					return false;
				}
				curProveedor.refreshBuffer();
				curProveedor.setValueBuffer("codcontacto", codContacto);
			
				if (!curProveedor.commitBuffer()) {
					util.destroyProgressDialog();
					return false;
				}
		}
	}
	util.setProgress(qryProveedores.size());
	util.destroyProgressDialog();
	return true;
}

function oficial_actualizarContactosDeAgenda20070525(codCliente:String,codContacto:String,nombreCon:String,cargoCon:String,telefonoCon:String,faxCon:String,emailCon:String,idAgenda:Number):String {

	var util:FLUtil;
	var curContactos:FLSqlCursor = new FLSqlCursor("crm_contactos");
	var curAgenda:FLSqlCursor = new FLSqlCursor("contactosclientes");

	if (codContacto && codContacto != "") {
		curContactos.select("codcontacto = '" + codContacto + "'");
		if (!curContactos.first())
			return false;
		curContactos.setModeAccess(curContactos.Edit);
		curContactos.refreshBuffer();
		if (!curContactos.valueBuffer("cargo") || curContactos.valueBuffer("cargo") == "") {
			curContactos.setValueBuffer("cargo", cargoCon);
		}
		
		if (!curContactos.valueBuffer("telefono1") || curContactos.valueBuffer("telefono1") == "") {
			curContactos.setValueBuffer("telefono1", telefonoCon);
		}
		else {
			if (!curContactos.valueBuffer("telefono2") || 		curContactos.valueBuffer("telefono2") == "") {
				curContactos.setValueBuffer("telefono2", telefonoCon);
			}
		}
		if (!curContactos.valueBuffer("fax") || curContactos.valueBuffer("fax") == "") {
			curContactos.setValueBuffer("fax", faxCon);
		}
		if (!curContactos.valueBuffer("email") || curContactos.valueBuffer("email") == "") {
			curContactos.setValueBuffer("email", emailCon);
		}
	}
	else {
		with (curContactos) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("codcontacto", util.nextCounter("codcontacto", this));
			setValueBuffer("nombre",nombreCon);
			setValueBuffer("email",emailCon);
			setValueBuffer("telefono1",telefonoCon);
			setValueBuffer("cargo",cargoCon);
			setValueBuffer("fax",faxCon);
		}
	
		if (!curContactos.commitBuffer())
			return false;

		codContacto = curContactos.valueBuffer("codcontacto");
		if(!codContacto)
			return false;
	}
	if (!idAgenda || idAgenda == 0) {
		if (!util.sqlSelect("contactosclientes","id","codcontacto = '" + codContacto + "' AND codcliente = '" + codCliente + "'")) {
			curAgenda.setModeAccess(curAgenda.Insert);
			curAgenda.refreshBuffer();
			curAgenda.setValueBuffer("codcliente",codCliente);
			curAgenda.setValueBuffer("codcontacto",codContacto);
			if (!curAgenda.commitBuffer())
				return false;
		}
	}
	else {
		curAgenda.select("id = " + idAgenda);
		if (!curAgenda.first())
			return false;
		curAgenda.setModeAccess(curAgenda.Edit);
		curAgenda.refreshBuffer();
		curAgenda.setValueBuffer("codcontacto",codContacto);
		if (!curAgenda.commitBuffer())
			return false;
	}

	

	return codContacto;
}

function oficial_lanzarEvento(cursor:FLSqlCursor, evento:String):Boolean
{
	var datosEvento:Array = [];
	datosEvento["tipoobjeto"] = cursor.table();
	datosEvento["idobjeto"] = cursor.valueBuffer(cursor.primaryKey());
	datosEvento["evento"] = evento;
	if (!flcolaproc.iface.pub_procesarEvento(datosEvento))
		return false;

	return true;
}

function oficial_actualizarContactosDeAgendaProv20070702(codProveedor:String,codContacto:String,nombreCon:String,cargoCon:String,telefonoCon:String,faxCon:String,emailCon:String,idAgenda:Number):String 
{
	var util:FLUtil;
	var curContactos:FLSqlCursor = new FLSqlCursor("crm_contactos");
	var curAgenda:FLSqlCursor = new FLSqlCursor("contactosproveedores");

	if (codContacto && codContacto != "") {
		curContactos.select("codcontacto = '" + codContacto + "'");
		if (!curContactos.first())
			return false;
		curContactos.setModeAccess(curContactos.Edit);
		curContactos.refreshBuffer();
		if (!curContactos.valueBuffer("cargo") || curContactos.valueBuffer("cargo") == "") {
			curContactos.setValueBuffer("cargo", cargoCon);
		}
		
		if (!curContactos.valueBuffer("telefono1") || curContactos.valueBuffer("telefono1") == "") {
			curContactos.setValueBuffer("telefono1", telefonoCon);
		}
		else {
			if (!curContactos.valueBuffer("telefono2") || 		curContactos.valueBuffer("telefono2") == "") {
				curContactos.setValueBuffer("telefono2", telefonoCon);
			}
		}
		if (!curContactos.valueBuffer("fax") || curContactos.valueBuffer("fax") == "") {
			curContactos.setValueBuffer("fax", faxCon);
		}
		if (!curContactos.valueBuffer("email") || curContactos.valueBuffer("email") == "") {
			curContactos.setValueBuffer("email", emailCon);
		}
	}
	else {
		with (curContactos) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("codcontacto", util.nextCounter("codcontacto", this));
			setValueBuffer("nombre",nombreCon);
			setValueBuffer("email",emailCon);
			setValueBuffer("telefono1",telefonoCon);
			setValueBuffer("cargo",cargoCon);
			setValueBuffer("fax",faxCon);
		}
	
		if (!curContactos.commitBuffer())
			return false;

		codContacto = curContactos.valueBuffer("codcontacto");
		if(!codContacto)
			return false;
	}
	if (!idAgenda || idAgenda == 0) {
		if (!util.sqlSelect("contactosproveedores","id","codcontacto = '" + codContacto + "' AND codproveedor = '" + codProveedor + "'")) {
			curAgenda.setModeAccess(curAgenda.Insert);
			curAgenda.refreshBuffer();
			curAgenda.setValueBuffer("codproveedor",codProveedor);
			curAgenda.setValueBuffer("codcontacto",codContacto);
			if (!curAgenda.commitBuffer())
				return false;
		}
	}
	else {
		curAgenda.select("id = " + idAgenda);
		if (!curAgenda.first())
			return false;
		curAgenda.setModeAccess(curAgenda.Edit);
		curAgenda.refreshBuffer();
		curAgenda.setValueBuffer("codcontacto",codContacto);
		if (!curAgenda.commitBuffer())
			return false;
	}

	

	return codContacto;
}

/** \D
Da a elegir al usuario entre una serie de opciones
@param	opciones: Array con las n opciones a elegir
@return	El índice de la opción elegida si se pulsa Aceptar
		-1 si se pulsa Cancelar
		-2 si hay error
\end */
function oficial_elegirOpcion(opciones:Array):Number
{
	var util:FLUtil = new FLUtil();
	var dialog:Dialog = new Dialog;
	dialog.okButtonText = util.translate("scripts","Aceptar");
	dialog.cancelButtonText = util.translate("scripts","Cancelar");
	var bgroup:GroupBox = new GroupBox;
	dialog.add(bgroup);
	var rB:Array = [];
	for (var i:Number = 0; i < opciones.length; i++) {
		rB[i] = new RadioButton;
		bgroup.add(rB[i]);
		rB[i].text = opciones[i];
		if (i == 0) {
			rB[i].checked = true;
		} else {
			rB[i].checked = false;
		}
	}

	if (dialog.exec()) {
		for (var i:Number = 0; i < opciones.length; i++) {
			if (rB[i].checked == true) {
				return i;
			}
		}
	} else {
		return -1;
	}
}

function oficial_setUnLock(tabla:String, pK:Number, unLock:Boolean)
{
	var campoUnLock:String = "";
	var campoPK:String = "";

	switch (tabla) {
		case "presupuestoscli": {
			campoUnLock = "editable";
			campoPK = "idpresupuesto";
			break;
		}
		case "pedidosprov":
		case "pedidoscli": {
			campoUnLock = "editable";
			campoPK = "idpedido";
			break;
		}
		case "albaranesprov":
		case "albaranescli": {
			campoUnLock = "ptefactura";
			campoPK = "idalbaran";
			break;
		}
		case "facturasprov":
		case "facturascli": {
			campoUnLock = "editable";
			campoPK = "idfactura";
			break;
		}
		break;
	}

	if ( !unLock) {
		var util:FLUtil = new FLUtil();
		util.sqlUpdate(tabla, campoUnLock, false, campoPK + " = " + pK );
	}

	var curTablaUnLock:FLSqlCursor;
	curTablaUnLock = new FLSqlCursor(tabla);
	curTablaUnLock.setActivatedCommitActions(false);
	curTablaUnLock.select(campoPK + " = " + pK);
	curTablaUnLock.first();
	curTablaUnLock.setUnLock(campoUnLock, unLock);

}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////

function controlUsuario_beforeCommit_usuarios(cursor:FLSqlCursor):Boolean
{
	switch (cursor.modeAccess()) {
		case cursor.Insert: {
 			if ( !cursor.valueBuffer("usuariocreado") && sys.version().startsWith("2.3-") ) {
				if ( !this.iface.crearUsuarioEnConexion(cursor.valueBuffer("idusuario"), cursor.valueBuffer("password"), "default") ) {
					this.iface.mensajeControlUsuario("NO_CREAR_USUARIO", cursor.valueBuffer("idusuario"));
					return false;
				}
			}

			var util:FLUtil = new FLUtil();
			cursor.setValueBuffer( "hash", util.sha1( cursor.valueBuffer("password") ) );
			cursor.setValueBuffer( "usuariocreado", true );
			cursor.setNull("password");
			break;
		}
		case cursor.Edit: {
 			if ( cursor.valueBuffer("password") ) {
				if ( sys.version().startsWith("2.3-") ) {
					if ( !this.iface.editarUsuarioEnConexion(cursor.valueBuffer("idusuario"), cursor.valueBuffer("password"), "default") ) {
						this.iface.mensajeControlUsuario("NO_EDITAR_USUARIO", cursor.valueBuffer("idusuario"));
						return false;
					}
				}

				var util:FLUtil = new FLUtil();
				cursor.setValueBuffer(  "hash", util.sha1( cursor.valueBuffer("password") ) );
				cursor.setNull("password");
			}
			break;
		}
		case cursor.Del: {
			if ( cursor.valueBuffer("idusuario") == sys.nameUser() ) {
				this.iface.mensajeControlUsuario("NO_BORRAR_USUARIO_PROPIO", "");
				return false;
			}
			if ( sys.version().startsWith("2.3-") ) {
				if ( !this.iface.borrarUsuarioEnConexion(cursor.valueBuffer("idusuario"), "default") ) {
					this.iface.mensajeControlUsuario("NO_BORRAR_USUARIO", cursor.valueBuffer("idusuario"));
					return false;
				}
			}
			break;
		}
	}

	return true;
}

function controlUsuario_afterCommit_usuarios(cursor:FLSqlCursor):Boolean
{
	switch (cursor.modeAccess()) {
		case cursor.Insert: {
			break;
		}
		case cursor.Edit: {
			break;
		}
		case cursor.Del: {
			break;
		}
	}

	return true;
}

function controlUsuario_crearUsuarioEnConexion(nombreUsuario:String, password:String, conName:String):Boolean
{
	if ( (nombreUsuario=="")||(password=="") ) {
		debug("no se puede crear un usuario con nombre o contrasena nula");
		return false;
	}

	var tipoDriver:String, tarea:String;
	if (sys.nameDriver(conName).search("PSQL") > -1) tipoDriver = "PostgreSQL";
	else tipoDriver = "MySQL";

	switch ( tipoDriver ) {
		case "PostgreSQL":
			tarea = "CREATE USER " + nombreUsuario + " WITH SUPERUSER PASSWORD '" + password + "';";
		break;
		case "MySQL":
			tarea = "GRANT ALL PRIVILEGES ON " + sys.nameBD(conName) + ".* TO '" + nombreUsuario + "'@'%' IDENTIFIED BY '" + password + "' WITH GRANT OPTION;";
			tarea += "GRANT ALL PRIVILEGES ON " + sys.nameBD(conName) + ".* TO '" + nombreUsuario + "'@'localhost' IDENTIFIED BY '" + password + "' WITH GRANT OPTION;";
			tarea += "GRANT ALL PRIVILEGES ON mysql.* TO '" + nombreUsuario + "'@'%';";
			tarea += "GRANT ALL PRIVILEGES ON mysql.* TO '" + nombreUsuario + "'@'localhost';";
		break;
	}

	var util:FLUtil = new FLUtil();
	var result:Boolean;
	try { result = util.ejecutarTarea( tarea , conName ); }
	catch (e) { result = false; }

	return result;
}

function controlUsuario_editarUsuarioEnConexion(nombreUsuario:String, password:String, conName:String):Boolean
{
	if ( (nombreUsuario=="")||(password=="") ) {
		debug("no se puede editar un usuario con nombre o contrasena nula");
		return false;
	}

	var tipoDriver:String, tarea:String;
	if (sys.nameDriver(conName).search("PSQL") > -1) tipoDriver = "PostgreSQL";
	else tipoDriver = "MySQL";

	switch ( tipoDriver ) {
		case "PostgreSQL":
			tarea = "ALTER USER " + nombreUsuario + " WITH PASSWORD '" + password + "';";
		break;
		case "MySQL":
			tarea = "SET PASSWORD FOR '" + nombreUsuario + "'@'%' = PASSWORD('" + password + "');";
			tarea += "SET PASSWORD FOR '" + nombreUsuario + "'@'localhost' = PASSWORD('" + password + "');";
		break;
	}

	var util:FLUtil = new FLUtil();
	var result:Boolean;
	try { result = util.ejecutarTarea( tarea , conName ); }
	catch (e) { result = false; }

	return result;
}

function controlUsuario_borrarUsuarioEnConexion(nombreUsuario:String, conName:String):Boolean
{
	if ( (nombreUsuario=="")||(conName=="") ) {
		debug("no se puede borrar un usuario con nombre nulo");
		return false;
	}

	var tipoDriver:String, tarea:String;
	if (sys.nameDriver(conName).search("PSQL") > -1) tipoDriver = "PostgreSQL";
	else tipoDriver = "MySQL";

	switch ( tipoDriver ) {
		case "PostgreSQL":
			tarea = "DROP ROLE " + nombreUsuario + ";";
		break;
		case "MySQL":
			tarea = "DROP USER '" + nombreUsuario + "'@'%';";
			tarea += "DROP USER '" + nombreUsuario + "'@'localhost';";
		break;
	}

	var util:FLUtil = new FLUtil();
	var result:Boolean;
	try { result = util.ejecutarTarea( tarea , conName ); }
	catch (e) { result = false; }

	return result;
}

function controlUsuario_usuarioCreado(usuario:String):Boolean
{
	var util:FLUtil = new FLUtil();

	if ( !util.sqlSelect("usuarios", "idusuario", "idusuario = '" + usuario + "'") )
		return false;

	return true;
}

function controlUsuario_mensajeControlUsuario(error:String, dato:String)
{
	var util:FLUtil = new FLUtil();
	switch (error) {
		case "NO_USUARIO": {
			MessageBox.critical(util.translate("scripts",
				"Usted no está registrado como usuario del sistema.\nDebe estarlo para crear %1").arg(dato),
				MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			break;
		}
		case "NO_CREAR_USUARIO": {
			MessageBox.critical(util.translate("scripts",
				"Error al crear el usuario %1 en la base de datos.\nLa operación no puede ser terminada.").arg(dato),
				MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			break;
		}
		case "NO_EDITAR_USUARIO": {
			MessageBox.critical(util.translate("scripts",
				"Error al editar el usuario %1 en la base de datos.\nLa operación no puede ser terminada.").arg(dato),
				MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			break;
		}
		case "NO_BORRAR_USUARIO": {
			MessageBox.critical(util.translate("scripts",
				"Error al borrar el usuario %1 en la base de datos.\nLa operación no puede ser terminada.").arg(dato),
				MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			break;
		}
		case "NO_BORRAR_USUARIO_PROPIO": {
			MessageBox.critical(util.translate("scripts",
				"No puede borrar su propio usuario."),
				MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			break;
		}
		break;
	}
}

//// CONTROL_USUARIO //////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition cuitDni */
/////////////////////////////////////////////////////////////////
//// CUIT_DNI ///////////////////////////////////////////////////

function cuitDni_validarCUIT(cuit:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var partes:Array = cuit.split("-");

	if (partes.length != 3) {
		MessageBox.warning(util.translate("scripts", "El número de CUIT no puede estar vacío."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	cuit = partes[0] + partes[1] + partes[2];

	if ( cuit.length != 11 ) {
		var ans = MessageBox.warning(util.translate("scripts", "El número de CUIT está incompleto. Continuar de cualquier modo?"), MessageBox.Yes, MessageBox.No);
		if (ans == MessageBox.Yes) {
    			return true;
		} else
			return false;
	}

	var cifras = new Array(11);
	for (var i = 0; i < 11; i++) {
		cifras[i] = cuit.charAt(i);
	}
	var suma:Number = parseInt(cifras[0], 10) * 5 + parseInt(cifras[1], 10) * 4 + parseInt(cifras[2], 10) * 3 + parseInt(cifras[3], 10) * 2 + parseInt(cifras[4], 10) * 7 + parseInt(cifras[5], 10) * 6 + parseInt(cifras[6], 10) * 5 + parseInt(cifras[7], 10) * 4 + parseInt(cifras[8], 10) * 3 + parseInt(cifras[9], 10) * 2;

	var modulo:Number = suma % 11;
	var verificacion:Number = 11 - modulo;
	if (verificacion == 11)
		verificacion = 0;
	else if (verificacion == 10)
		verificacion = 9;

	if ( verificacion != parseInt(cifras[10], 10) ) {
		var ans = MessageBox.warning(util.translate("scripts", "El número de CUIT no es válido. Continuar de cualquier modo?"), MessageBox.Yes, MessageBox.No);
		if (ans == MessageBox.Yes) {
    			return true;
		} else {
			return false;
		}
	}

	return true;
}

//// CUIT_DNI ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////