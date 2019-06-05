//Inicio funciones para subir y agregar archivos
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function barra_progreso(elemento){
    var e = document.getElementsByClassName("b-progreso")[contador];
    var fr = new FileReader();
    archivo = new Object();

    fr.onloadstart = (ev) =>{
        console.log("inicio");
    }

    fr.onloadend = (ev) =>{
        var resumen = CryptoJS.MD5(fr.result);
        e.value = (ev.loaded*100)/ev.total;
        e.style.display = "none";
        arr.push(window.btoa(fr.result));
        nombres.push(elemento.name);
        sumas.push("MD5:" + resumen);
        
    }

    fr.onprogress = (ev) => {
        e.value = (ev.loaded*100)/ev.total;
    }

    fr.readAsDataURL(elemento);
}

//----------------------------------------------------------------------------------------

function crear(event){
    var fr = new FileReader();
	var nuevo = document.createElement("div");
    var contenedor = document.createElement("div");
    contenedor.className += "progress progreso";
    nuevo.className = "row archivo-elemento";
    nuevo.innerHTML = "<div class=\"archivo-nombre-archivo\">" + event.target.files[0].name + "</div>" + 
    "<div class=\"progreso\">" + 
        "<progress class=\"b-progreso\"  value=\"0\" max=\"100\"></progress>" + 
    "</div>" +
    "<a id=\"elimina" + contador + "\" class=\"btn btn-primary btn-sm\" href=\"#\" role=\"button\"><i class=\"fa fa-times\" aria-hidden=\"true\"></i></a>";

    nuevo.lastChild.onclick = (event) => {
        var objetivo;
        if(event.target.tagName === "I"){
            objetivo = event.target.parentNode;
        }else{
            objetivo = event.target;
        }
        var indice = nombres.indexOf(objetivo.parentNode.innerText); 
        var padre = objetivo.parentNode.parentNode;
        
        nombres.splice(indice,1);
        arr.splice(indice,1);
        sumas.splice(indice,1); 
        

        padre.removeChild(objetivo.parentNode);
        console.log(objetivo.parentNode);
        contador--;
        
        if(arr.length == 0){
            document.getElementById("cartel-modal-subir").innerHTML="Presione para subir sus archivos";
            document.getElementById("modal-campo-subir").style.textAlign = "center";
        }
    }
    return nuevo;
}

//----------------------------------------------------------------------------------------

function add_archivo_tarea(){//Funcion que inicia el agregado de archivos (polaris.js, lin.705)
    var ar = document.getElementById("ma-file-upload");
    contador = 0;
    arr = new Array();
    nombres = new Array();
    sumas = new Array();

    ar.onchange = (event) => {
        var punteado = document.getElementById("modal-campo-subir");
        var nuevo = crear(event);
        punteado.style.padding = "0";
        punteado.style.textAlign = "left";
        punteado.style.padding = "10px 30px";

        document.getElementById("cartel-modal-subir").innerHTML="";

        
        punteado.appendChild(nuevo);
        barra_progreso(event.target.files[0]);
        contador ++;
}

//Final funciones para subir y agregar archivos
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

//Inicio funciones para el caso en el que los archivos se repiten
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

function prepara_envio(nuevos_nombres,indices_archivos,sobrescritura){
    nuevos_nombres.shift();

    nombres = nuevos_nombres;
    nuevo_arr = new Array();
    nuevas_sumas = new Array();

    for(var i = 0;i<indices_archivos.length;i++){
        nuevo_arr.push(arr[indices_archivos[i]]);
        nuevas_sumas.push(sumas[[indices_archivos[i]]]);
    }

    arr = nuevo_arr;
    sumas = nuevas_sumas;

    nuevo_arr = null;
    nuevas_sumas = null;
    nuevos_nombres = null;
    indices_archivos = null;
    
    envio(sobrescritura);
}

//----------------------------------------------------------------------------------------
function sobrescribe_nombre(ret){
    var indices_archivos = new Array();
    for(var i = 1;i<ret.length;i++){
        indices_archivos.push(nombres.indexOf(ret[i]));
    }
    
    prepara_envio(ret,indices_archivos,true);
}
//----------------------------------------------------------------------------------------
function define_extension(nuevo_nombre,extension){
    var name = nuevo_nombre;
    if(nuevo_nombre.indexOf(".") == -1){
        name = nuevo_nombre + "." + extension.split(".")[1];
    }else{
        if(nuevo_nombre.split(".")[1] !== extension.split(".")[1]){
            name = nuevo_nombre.split(".")[0] + "." + extension.split(".")[1];
        }
    }
    return name;
}

//----------------------------------------------------------------------------------------

function sobrescribe(nombre){
        var separado = nombre.split(".");
        separado[0]+="(copia)";
        return separado[0] + "." + separado[1];
    }

//----------------------------------------------------------------------------------------
    
function cambia_nombres(ret){
    var campos = document.getElementsByClassName("form-nuevos-nombres");
        var nuevos_nombres = Array("nuevos nombres");
        var indices_archivos = new Array();
        for (var i = 0;i<campos.length;i++){
            nuevos_nombres.push(campos.item(i).value);
            
        }
        for(var i = 1;i<nuevos_nombres.length;i++){
            indices_archivos.push(nombres.indexOf(ret[i]));
            if(nuevos_nombres[i]===""){
                nuevos_nombres[i] = sobrescribe(ret[i]);
            }else{
                
                nuevos_nombres[i] = define_extension(nuevos_nombres[i],ret[i]);
                
            }
        }
        prepara_envio(nuevos_nombres,indices_archivos,false);
}

//----------------------------------------------------------------------------------------

function boton_cambia_nombres(ret){
    $("#estado-archivos").html('<div id="campos-nuevos-nombres"></div>');
    
    var cadena = "";
    ret.forEach(function(elementos){
        if(elementos !== "archivos repetidos"){
            cadena += '<br><input type="text" class="form-control form-nuevos-nombres" placeholder="Nuevo nombre para ' + elementos +'">';
        }   
        
    });

    cadena += '<br><button type="button" class="btn btn-primary btn-sm" id="btn-cambiar-nombre">cambiar nombre</button>'; 
    $("#campos-nuevos-nombres").html(cadena);
    document.getElementById("cartel-modal-subir").innerHTML="escriba nuevo nombre para sus archivos";
    document.getElementById("modal-campo-subir").style.textAlign = "center";

    cadena = null;
}

//----------------------------------------------------------------------------------------

function prepara_label(ret){
    document.getElementById("cartel-modal-subir").innerHTML="";

    $("#estado-archivos").html("<br><h5>Los Siguientes archivos ya existen: </h5>"+
                        "<p id=\"notificacion\"><ul class=\"list-group\" id = \"lista-repetidos\"></ul></p><p id=\"pregunta\"></p><div id = \"botones-pregunta\"></div>");
    var cadena = "";
                    
    ret.forEach(function(elementos){
        if(elementos !== "archivos repetidos"){
            cadena+="<li class=\"list-group-item\">" + elementos + "</li>";
        }    
    });

    $("#lista-repetidos").html(cadena);

    $("#pregunta").text("¿Desea sobrescribirlos o cambiar nombre?");
    
    $("#botones-pregunta").html('<button type="button" class="btn btn-primary btn-sm" id="btn-cambiar-nombre">cambiar nombre</button> <button type="button" class="btn btn-primary btn-sm" id="btn-sobrescribe">Sobrescribir</button>');
    
    $("#btn-sobrescribe").on('click',function(){
        sobrescribe_nombre(ret);
    });
   
    $("#btn-cambiar-nombre").on("click", function () {
        boton_cambia_nombres(ret);

        $("#btn-cambiar-nombre").on('click',function(){
            
            cambia_nombres(ret);
        });

        

    });

}

//----------------------------------------------------------------------------------------

function archivos_repetidos(ret){
   prepara_label(ret);
}

//----------------------------------------------------------------------------------------

function limpiaLabel(){
    var padre = document.getElementById("modal-campo-subir");
    var clases = document.getElementsByClassName("archivo-elemento").length;
    for(var i = 0; i < clases; i++){
        padre.removeChild(padre.lastChild);
        contador--;
    }
    document.getElementById("modal-campo-subir").style.textAlign = "center";
    $("#modal-campo-subir").prop('disabled', true);
    $("#modal-campo-subir").css({'cursor':'auto'});
    $("input").prop('disabled', true);

}

//----------------------------------------------------------------------------------------

function envio_correcto(){
    while(arr.length > 0){
        arr.pop();
        nombres.pop();
        sumas.pop();
    }
    limpiaLabel();
    $("#modal-campo-subir").prop('disabled', false);
    $("input").prop('disabled', false);
    document.getElementById("cartel-modal-subir").innerHTML="Presione para subir sus archivos";
    document.getElementById("modal-campo-subir").style.textAlign = "center";
    $("#modal-campo-subir").css({'cursor':'pointer'});
    $("#estado-archivos").html('<div id="envio-correcto" style="display:none;background:green;color:#fff;text-align:center;" >envio exitoso</div>');
    setTimeout(function() {
        $("#envio-correcto").fadeIn(700);
    },300);
    setTimeout(function() {
        $("#envio-correcto").fadeOut(1500);
    },3000);
    contador = 0;
}

//-----------------------------------------------------------------------------------------

function envio(tipo_envio){
    archivo.arr_docs = arr;
    archivo.arr_name = nombres;
    archivo.arr_sum = sumas;
    archivo.tareaId = tarea_id;
    archivo.sobrescribir = tipo_envio;
    var paq = JSON.stringify(archivo); 

    $.ajax({
        data: {"data" : paq},
        type: "POST",
        url: "core/controller/servidor.php",
        success: function(info){
            var retorno = JSON.parse(info);
            if(retorno.length > 1){
                limpiaLabel();
                
                archivos_repetidos(retorno);
                                        
            }else{
                envio_correcto();
            }
        },
        error: function(err){
            $("#estado-archivos").html('<div id="envio-correcto" style="display:none;background:green;color:#fff;text-align:center;" >error en el servidor, intentelo mas tarde</div>');
    setTimeout(function() {
        $("#envio-correcto").fadeIn(700);
    },300);
    setTimeout(function() {
        $("#envio-correcto").fadeOut(1500);
    },3000);
        }
    });
}

//-----------------------------------------------------------------------------------------

document.getElementById("form-subir").onsubmit = (event) => {
    
    event.preventDefault();
    if(ar.files.length == 0 || arr.length==0){
        document.getElementById("cartel-modal-subir").innerHTML = "coloque un archivo antes de subir";
    }else{
        envio(false);
    }
}
    
}
//Final funciones para el caso en el que los archivos se repiten
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

        /*
        var conexion = new XMLHttpRequest();
        conexion.open('POST','core/controller/servidor.php');
        conexion.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        conexion.onload = () => {
            if(conexion.status == 200){

                envio_correcto();
                $('#modal-archivo-tarea').modal('hide');
                console.log("Envio exitoso");

            }else{
                console.log("Error");
            }
        }
        conexion.send('data=' + paq);*/