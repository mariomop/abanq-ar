/***************************************************************************
                                  sys.qs
                            -------------------
   begin                : lun abr 26 2004
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

function init() {

	var util:FLUtil = new FLUtil();
	util.writeSettingEntry("DBA/password", "");

	if (isLoadedModule("flfactppal")) {
		var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
		var nombreEmpresa:String = util.sqlSelect("empresa", "nombre", "1 = 1");
		var nombreEjercicio:String = util.sqlSelect("ejercicios", "nombre", "codejercicio='" + codEjercicio + "'");
		setCaptionMainWidget(nombreEmpresa + " - " + nombreEjercicio);
	}
	//return;
	if (sys.mainWidget() != undefined) {
		var curFiles = new FLSqlCursor("flfiles");
		curFiles.select();
		if (!curFiles.size()) {
			var continuar = MessageBox.warning(util.translate("scripts", "No hay módulos cargados en esta base de datos,\nAbanQ puede cargar automáticamente la base de módulos\nde Facturación y Financiera incluidos en la instalación.\n\n¿Desea cargar ahora estos módulos base?\n"), MessageBox.Yes, MessageBox.No);
			if (continuar == MessageBox.Yes) {
				var dirModsFact = sys.installPrefix() + "/share/facturalux/modulos/facturacion/";
				var dirModsCont = sys.installPrefix() + "/share/facturalux/modulos/contabilidad/";
				formflreloadbatch.iface.pub_cargarModulo(Dir.cleanDirPath(dirModsFact + "principal/flfactppal.mod"));
				while (formRecordflmodules.child("log"))
				sys.processEvents();
				formflreloadbatch.iface.pub_cargarModulo(Dir.cleanDirPath(dirModsFact + "almacen/flfactalma.mod"));
				while (formRecordflmodules.child("log"))
				sys.processEvents();
				formflreloadbatch.iface.pub_cargarModulo(Dir.cleanDirPath(dirModsFact + "facturacion/flfacturac.mod"));
				while (formRecordflmodules.child("log"))
				sys.processEvents();
				formflreloadbatch.iface.pub_cargarModulo(Dir.cleanDirPath(dirModsFact + "tesoreria/flfactteso.mod"));
				while (formRecordflmodules.child("log"))
				sys.processEvents();
				formflreloadbatch.iface.pub_cargarModulo(Dir.cleanDirPath(dirModsFact + "informes/flfactinfo.mod"));
				while (formRecordflmodules.child("log"))
				sys.processEvents();
				formflreloadbatch.iface.pub_cargarModulo(Dir.cleanDirPath(dirModsCont + "principal/flcontppal.mod"));
				while (formRecordflmodules.child("log"))
				sys.processEvents();
				formflreloadbatch.iface.pub_cargarModulo(Dir.cleanDirPath(dirModsCont + "informes/flcontinfo.mod"));
				while (formRecordflmodules.child("log"))
				sys.processEvents();
				sys.reinit();
			}
		}
	}
}

function afterCommit_flfiles(curFiles) {
  if (curFiles.modeAccess() != curFiles.Browse) {
    var qry = new FLSqlQuery();
    qry.setTablesList("flserial");
    qry.setSelect("sha");
    qry.setFrom("flfiles");
    qry.setForwardOnly(true);
    if (qry.exec()) {
      if (qry.first()) {
        var util = new FLUtil();
        var v = util.sha1(qry.value(0));
        while (qry.next())
        v = util.sha1(v + qry.value(0));
        var curSerial = new FLSqlCursor("flserial");
        curSerial.select();
        if (!curSerial.first()) curSerial.setModeAccess(curSerial.Insert);
        else curSerial.setModeAccess(curSerial.Edit);
        curSerial.refreshBuffer();
        curSerial.setValueBuffer("sha", v);
        curSerial.commitBuffer();
      }
    } else {
      var curSerial = new FLSqlCursor("flserial");
      curSerial.select();
      if (!curSerial.first()) curSerial.setModeAccess(curSerial.Insert);
      else curSerial.setModeAccess(curSerial.Edit);
      curSerial.refreshBuffer();
      curSerial.setValueBuffer("sha", curFiles.valueBuffer("sha"));
      curSerial.commitBuffer();
    }
  }

  return true;
}

function statusDbLocksDialog( locks ) {
  var util = new FLUtil;
  var diag = new Dialog;
  var txtEdit = new TextEdit;

  diag.caption = util.translate( "scripts", "Bloqueos de la base de datos" );
  diag.width = 500;

  var html = "<html><table border=\"1\">";
      
  if ( locks != undefined && locks.length ) {
    var i = 0;
    var j = 0;
    var item = "";
    var fields = locks[0].split( "@" );
    var closeInfo = false;
    var closeRecord = false;
        
    var headInfo = "<table border=\"1\"><tr>";
    for ( i = 0; i < fields.length; ++i )
      headInfo += "<td><b>" + fields[i] + "</b></td>";
    headInfo += "</tr>";
    
    var headRecord = "<table border=\"1\"><tr><td><b>" + util.translate( "scripts", "Registro bloqueado" ) + "</b></td></tr>";
    
    for ( i = 1; i < locks.length; ++i ) {
        item = locks[i];
        
        if ( item.left( 2 ) == "##" ) {
            if ( closeInfo )
                html += "</table>";
            if ( !closeRecord )
                html += headRecord;
            
            html += "<tr><td>" + item.right( item.length - 2 ) + "</td></tr>";
            
            closeRecord = true;
            closeInfo = false
        } else {
            if ( closeRecord )
                html += "</table>";
            if ( !closeInfo )
                html += headInfo;
            
            html += "<tr>";
            fields = item.split( "@" );
            for ( j = 0; j < fields.length; ++j )
              html += "<td>" + fields[j] + "</td>";
            html += "</tr>";
            
            closeRecord = false;
            closeInfo = true
        }
    }
  }

  html += "</table></table></html>";
  
  txtEdit.text = html;
  diag.add( txtEdit );
  diag.exec();
}

function terminateChecksLocks( sqlCursor ) {
   if ( sqlCursor != undefined )
    sqlCursor.checkRisksLocks( true );
}

