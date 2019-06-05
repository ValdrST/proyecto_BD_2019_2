$(document).ready(function () {

    index();

    function index() {
        response = ajax_request("core/controller/get_index.php", "GET", { sesion: true });
        if (response.status_sesion == false) {
            $(".user-dropdown").hide();
            $(".btn-user-menu").hide();
            set_text_tag(".titulo-h1", "");
            $(".main-panel").load("core/view/login.html", function () {
                entrar();
            });

        } else {
            if (sessionStorage.getItem("email") == 'undefined')
                iniciar_sesion();
            $(".user-dropdown").show();
            $(".btn-user-menu").show();
            set_active_class(this);
            set_text_tag(".title-head", "POLARIS - Inicio");
            set_text_tag(".titulo-h1", "Inicio");
            $(".main-panel").load("core/view/inicio.html");
            set_text_tag(".usuario-h4", sessionStorage.getItem("email"));
            $(".modal-container-usuario").load("core/view/usuario.html");
        }
    }

    function load_modal_equipo() {
        equipo_id = get_id_tag(this);
        equipo = get_equipo(equipo_id);
        procesos = get_procesos_equipo(equipo.proceso_id);
        usuarios = get_usuarios_equipo(equipo.usuarios_id);
        set_text_tag(".equipo-nombre-equipo", equipo.nombre);
        set_text_tag(".equipo-texto-descripcion", equipo.descripcion);
        cont = 0;
        if (procesos[0].tarea[0] != "") {
            console.log(procesos);
            procesos = add_options(procesos, 'proceso_id', ["<button class='btn btn-sm btn-info btn-modal-proceso der' type='button'>Ir al proyecto</button>", "<button class='btn btn-sm btn-danger btn-delete-proceso' type='button'>Eliminar proceso</button>"]);
            console.log(procesos);
            $("#table-proceso").DataTable({
                destroy: true,
                info: false,
                data: procesos,
                columns: [
                    { data: 'titulo' },
                    { data: 'options' }
                ]
            });
        } else {
            $("#table-proceso").DataTable({
                destroy: true,
                info: false,
                searching: false,
                paging: false
            });
        }
        cont = 0;
        if (usuarios[0] == false) {
            $(".tbody-usuario-equipo").append("<tr class='blanco'><td class='equipo-miembro-usuario'></td><td class='equipo-miembro-nombre'></td><td class='equipo-miembro-rol'>Sin usuarios asignados</td><td class='equipo-miembro-acciones'></td></tr>");
        } else
            usuarios.forEach(usuario => {
                cont++;
                if (cont % 2 == 0) {
                    $(".tbody-usuario-equipo").append("<tr class='blanco'><td class='equipo-miembro-usuario'>" + usuario.usuario + "</td><td class='equipo-miembro-nombre'>" + usuario.nombre + "</td><td class='equipo-miembro-rol'>" + (usuario.rol == null ? "sin rol" : usuario.rol.replace(/,/g, '<br>')) + "</td><td class='equipo-miembro-acciones'><span class='equipo-btn-elimina-miembro'><button class='btn btn-sm btn-danger'>Eliminar</button></span><span class='equipo-btn-edita-miembro'><button id=" + usuario.usuario_id + " class='btn btn-sm btn-ver-usuario btn-info'>ver</button></span></td></tr>");
                } else {
                    $(".tbody-usuario-equipo").append("<tr class='plata'><td class='equipo-miembro-usuario'>" + usuario.usuario + "</td><td class='equipo-miembro-nombre'>" + usuario.nombre + "</td><td class='equipo-miembro-rol'>" + (usuario.rol == null ? "sin rol" : usuario.rol.replace(/,/g, '<br>')) + "</td><td class='equipo-miembro-acciones'><span class='equipo-btn-elimina-miembro'><button class='btn btn-sm btn-danger'>Eliminar</button></span><span class='equipo-btn-edita-miembro'><button id=" + usuario.usuario_id + " class='btn btn-sm btn-ver-usuario btn-info'>ver</button></span></td></tr>");
                }

            });
        $("#modal-equipo").modal('toggle');
    }

    function get_rol_usuario(usuario_id) {
        return ajax_request("core/controller/get_rol_usuario.php", "GET", { usuario_id: usuario_id });
    }


    function get_proceso(proceso_id) {
        procesos = [];
        return ajax_request("core/controller/get_proceso.php", "GET", { proceso_id: proceso_id });
    }

    function load_modal_add_equipo() {
        usuario_id = $(this).attr('id');
        modal_options = {
            tags: {
                div_modal: ".modal-container-equipo",
                id_modal: "#modal-add-equipo",
                title: ''
            },
            data: {
                view_modal: "core/view/add_equipo.html",
                title: "Añadir equipo"
            }
        };
        load_modal(modal_options, function () {
            set_id_tag(".btn-set-equipo-usuario", usuario_id);
            equipos_usuario = get_equipo_usuario(usuario_id);
            equipos = get_equipos_all();
            equipos_temp = equipos;
            equipos = [];
            equipos_temp.forEach(equipo => {
                equipo.options = "<div class='form-check'><input type='checkbox' class='form-check-input chk-equipo-id' id='" + equipo.org_equipo_id + "'></div>";
                equipos_usuario.forEach(equipo_usuario => {
                    if (equipo.org_equipo_id == equipo_usuario.org_equipo_id)
                        equipo.options = "<div class='form-check'><input type='checkbox' class='form-check-input chk-equipo-id' id='" + equipo.org_equipo_id + "' checked></div>";
                });
                equipos.push(equipo);
            });
            $("#table-equipo-add").DataTable({
                paging: false,
                searching: false,
                info: false,
                destroy: true,
                data: equipos,
                columns: [
                    { data: 'nombre' },
                    { data: 'descripcion' },
                    { data: 'options' }
                ]
            });
        });
    }

    function load_modal_add_rol() {
        usuario_id = get_id_tag(this);
        modal_options = {
            tags: {
                div_modal: ".modal-container-rol",
                id_modal: "#modal-add-rol",
                title: ''
            },
            data: {
                view_modal: "core/view/add_rol.html",
                title: "Modificar rol"
            }
        };
        load_modal(modal_options, function () {
            set_id_tag(".btn-set-rol", usuario_id);
            roles = get_rol();
            roles_temp = roles;
            roles = [];
            rol_usuario = get_rol_usuario(usuario_id);
            roles_temp.forEach(rol => {
                if (rol_usuario.includes(rol.clave_rol.toString()))
                    if (rol.clave_rol == 3)
                        rol.options = "<div class='form-check'><input type='checkbox' class='form-check-input chk-clave-rol' id='" + rol.clave_rol + "' checked disabled></div>";
                    else
                        rol.options = "<div class='form-check'><input type='checkbox' class='form-check-input chk-clave-rol' id='" + rol.clave_rol + "' checked></div>";
                else
                    rol.options = "<div class='form-check'><input type='checkbox' class='form-check-input chk-clave-rol' id='" + rol.clave_rol + "'></div>";
                roles.push(rol);
            });
            $("#table-rol-add").DataTable({
                paging: false,
                searching: false,
                info: false,
                destroy: true,
                data: roles,
                columns: [
                    { data: 'nombre' },
                    { data: 'options' }
                ]
            });
        });
    }



    function set_equipo_usuario() {
        usuario_id = $(this).attr('id');
        org_equipos_id = get_checklist_selected(".chk-equipo-id");
        data = {
            usuario_id: usuario_id,
            org_equipos_id: org_equipos_id
        };
        response = ajax_request("core/controller/set_equipo_usuario.php", "POST", data);
        if (response.resultado == true) {
            alert("exito en el registro de roles");
            $("#modal-add-equipo").modal('toggle');
            $("#modal-usuario").modal('toggle');
            load_panel_usuarios();
        } else {
            $("#modal-add-equipo").modal('toggle');
            alert("Error en el registro de equipo");
        }
    }

    function set_rol() {
        usuario_id = $(this).attr('id');
        claves_rol = get_checklist_selected(".chk-clave-rol");
        data = {
            usuario_id: usuario_id,
            claves_rol: claves_rol
        }
        response = ajax_request("core/controller/set_rol_usuario.php", "POST", data);
        if (response.resultado == true) {
            alert("exito en el registro de roles");
            $("#modal-add-rol").modal('toggle');
            $("#modal-usuario").modal('toggle');
            load_panel_usuarios();
        } else {
            $("#modal-add-rol").modal('toggle');
            alert("Error en el registro de roles");
        }
    }

    function get_rol() {
        return ajax_request("core/controller/get_rol.php", "GET", {});
    }

    function load_modal_usuario() {
        usuario_id = $(this).attr('id');
        usuario = get_usuario(usuario_id);
        equipos = get_equipo_usuario(usuario_id);
        set_input(".usuario-usuario-text", usuario.usuario);
        set_input(".usuario-nombre-text", usuario.nombre);
        set_input(".usuario-apellidos-text", usuario.apellidos);
        tareas = get_tareas_usuario(usuario_id);
        $("#table-equipo").DataTable({
            paging: false,
            searching: false,
            info: false,
            destroy: true,
            data: equipos,
            columns: [
                { data: 'nombre' },
                { data: 'descripcion' }
            ]
        });
        cont = 0;
        roles = [];
        usuario['clave_rol'].forEach(clave => {
            roles.push({ clave: clave, nombre: usuario['rol'][cont], options: (usuario['clave_rol'][cont] == 3 ? "Sin acciones" : "<button id='" + clave + "' class='btn btn-sm btn-danger btn-rol-delete' type='button'>Eliminar</button>") });
            cont++;
        });
        $("#table-rol").DataTable({
            paging: false,
            searching: false,
            info: false,
            destroy: true,
            data: roles,
            columns: [
                { data: 'nombre' }
            ]
        });
        $(".btn-rol-add").attr("id", usuario_id);
        $(".btn-equipo-add").attr("id", usuario_id);
        $(".modal-container-rol").load("core/view/add_rol.html");
        $(".modal-container-equipo-view").load("core/view/equipo.html");
        tareas = get_tareas_usuario(usuario_id);
        tareas_temp = tareas;
        tareas = [];
        tareas_temp.forEach(tarea => {
            tarea.options = "<button class='btn btn-sm btn-ver-tarea btn-info' id='" + tarea.tarea_id + "'>ver tarea</button>";
            tareas.push(tarea);
        });
        $("#table-tarea").DataTable({
            paging: true,
            searching: true,
            destroy: true,
            data: tareas,
            columns: [
                { data: 'nombre' },
                { data: 'titulo' },
                { data: 'fecha_inicio' },
                { data: 'fecha_fin' },
                { data: 'clave_estado' },
                { data: 'options' }
            ]
        });
        $("#modal-usuario").modal();
    }

    function cerrar_equipo() {
        $(".tbody-usuario-equipo").text("");
        $(".tabProyectos").text("");
    }

    function entrar() {
        document.body.addEventListener("keydown", acceso);
    }

    function acceso(event) {
        var codigo = event.keyCode || event.wich;
        if (codigo == 13) {
            iniciar_sesion();
        }
    }

    function iniciar_sesion() {
        data = {
            email: get_value_input("#input-email"),
            password: get_value_input("#input-password")
        }
        respuesta = ajax_request("core/controller/get_sesion.php", "POST", data);
        sessionStorage.setItem("email", respuesta.email);
        sessionStorage.setItem("tipo", respuesta.tipo);
        sessionStorage.setItem("id", respuesta.id);
        set_text_tag(".usuario-h4", sessionStorage.getItem("email"));
        document.body.removeEventListener("keydown", acceso);
        location.href = "index.php";
    }

    function get_equipo_usuario(usuario_id) {
        equipos = [];
        data = {
            usuario_id: usuario_id
        }
        return ajax_request("core/controller/get_equipo_usuario.php", "GET", data);
    }

    function get_usuario(usuario_id) {
        usuario = [];
        return ajax_request("core/controller/get_usuario.php", "GET", { usuario_id: usuario_id });
    }

    function get_usuarios_all() {
        usuarios = []
        usuarios_get = ajax_request("core/controller/get_usuarios_all.php", "GET", {});
        usuarios_get.forEach(usuario => {
            usuario = parse_strings_to_array_values(usuario, ["clave_rol", "rol"]);
            usuarios.push(usuario);
        });
        return usuarios;
    }

    function get_equipos_all() {
        equipos = [];
        equipos_get = ajax_request("core/controller/get_equipos_all.php", "GET", {});
        equipos_get.forEach(equipo => {
            equipo = parse_strings_to_array_values(equipo, ["usuarios", "usuarios_id"]);
            equipos.push(equipo);
        });
        return equipos;
    }

    function get_procesos_equipo(procesos_id) {
        return ajax_request("core/controller/get_procesos_equipo.php", "GET", { procesos_id: procesos_id });
    }

    function get_equipo(org_equipo_id) {
        return ajax_request("core/controller/get_equipo.php", "GET", { org_equipo_id: org_equipo_id });
    }

    function get_tareas_usuario(usuario_id) {
        return ajax_request("core/controller/get_tarea_usuario.php", "GET", { usuario_id: usuario_id });
    }

    function get_usuarios_equipo(usuarios_id) {
        return ajax_request("core/controller/get_usuarios_equipo.php", "GET", { usuarios_id: usuarios_id });
    }

    function get_procesos_all() {
        return ajax_request("core/controller/get_procesos_all.php", "GET", {});
    }

    function get_servicios_renta_usuario(usuario_id) {
        return ajax_request("core/controller/get_servicios_renta_usuario.php", "GET", { usuario_id: usuario_id });
    }

    function get_servicios_viaje_usuario(usuario_id) {
        return ajax_request("core/controller/get_servicios_viaje_usuario.php", "GET", { usuario_id: usuario_id });
    }

    function load_panel_servicios() {
        set_active_class(this);
        $(".title-head").text("Scooter anywhere - Servicios");
        $(".titulo-h1").text("Servicios");
        $(".main-panel").load("core/view/servicios.html", function () {
            usuario_id = sessionStorage.getItem("id");
            servicios_renta = get_servicios_renta_usuario(usuario_id);
            servicios_viaje = get_servicios_viaje_usuario(usuario_id);
            if (servicios_viaje != []) {
                add_options(servicios_viaje, 'SERVICIO_ID', ["<button class='btn btn-sm btn-info btn-modal-detalle-viaje' type='button'>Ver detalles</button>"]);
                $("#table-viaje").DataTable({
                    destroy: true,
                    data: servicios_viaje,
                    columns: [
                        { data: 'INICIO' },
                        { data: 'FIN' },
                        { data: 'FOLIO' },
                        { data: 'options' }
                    ]
                });
            } else {
                $("#table-viaje").DataTable({ destroy: true });
            }
            if (servicios_renta != []) {
                add_options(servicios_renta, 'SERVICIO_ID', ["<button class='btn btn-sm btn-info btn-modal-detalle-renta' type='button'>Ver detalles</button>"]);
                $("#table-renta").DataTable({
                    destroy: true,
                    data: servicios_renta,
                    columns: [
                        { data: 'INICIO' },
                        { data: 'DIAS_CUSTODIO' },
                        { data: 'DIRECCION' },
                        { data: 'options' }
                    ]
                });
            } else {
                $("#table-renta").DataTable({ destroy: true });
            }

        });
    }

    function load_panel_usuarios() {
        $(".active").removeClass("active");
        $(this).addClass("active");
        $(".title-head").text("POLARIS - Usuarios");
        $(".titulo-h1").text("Usuarios");
        $(".main-panel").load("core/view/usuarios.html", function () {
            usuarios = get_usuarios_all();
            usuarios_temp = usuarios;
            usuarios = [];
            usuarios_temp.forEach(usuario => {
                //usuario.rol = (usuario.rol == null ? "sin rol asignado" : usuario.rol.replace(/,/g, '<br>'));
                usuario.equipo = (usuario.equipo == null ? "sin equipo" : usuario.equipo.replace(/,/g, '<br>'));
                usuario.options = "<button class='btn-ver-usuario btn btn-success btn-block' id=" + usuario.usuario_id + ">ver perfil</button>";
                usuarios.push(usuario);
            });
            usuarios_temp = [];
            $("#table-usuarios").DataTable({
                paging: false,
                info: false,
                scrollX: true,
                data: usuarios,
                columns: [
                    { data: 'usuario' },
                    { data: 'nombre' },
                    { data: 'apellidos' },
                    { data: 'equipo' },
                    { data: 'rol' },
                    { data: 'options' }
                ]
            });
        });
    }

    function load_tabla(id_tabla, tabla, id_objeto, objetos, opciones) {
        add_options(objetos, id_objeto, opciones);
        tabla.data = objetos;
        return $(id_tabla).DataTable(tabla);
    }

    function load_modal_registro_usuario() {
        modal_options = {
            tags: {
                div_modal: ".modal-container-registro-usuario",
                id_modal: "#modal-registro-usuario",
                title: ".modal-title"
            },
            data: {
                view_modal: "core/view/registro_usuario.html",
                title: "Registrar nuevo usuario"
            }
        };
        load_modal(modal_options, function () { });
    }

    function set_usuario() {
        if (get_value_input(".txt-usuario-password") == get_value_input(".txt-usuario-password")) {
            data = {
                email: get_value_input(".txt-usuario-email"),
                nombre: get_value_input(".txt-usuario-nombre"),
                apellidos: get_value_input(".txt-usuario-apellidos"),
                contraseña: get_value_input(".txt-usuario-password")
            }
            res = ajax_request("core/controller/set_usuario.php", "POST", data);
            if (res.resultado == true) {
                alert("Exito en el registro del usuario");
                $("#modal-registro-usuario").modal('toggle');
            } else {
                alert("Error en el registro del usuario");
            }
        } else {
            alert("Las contraseñas no coinciden");
            return false;
        }
    }

    function get_aparatos_all() {
        return ajax_request("core/controller/get_aparatos_all.php", "GET", {});
    }

    function get_aparato(aparato_id) {
        return ajax_request("core/controller/get_aparato.php", "GET", {aparato_id:aparato_id});
    }

    function load_modal_registro_viaje() {
        modal_options = {
            tags: {
                div_modal: ".modal-container-registro-viaje",
                id_modal: "#modal-registro-viaje",
                title: ".modal-title"
            },
            data: {
                view_modal: "core/view/registro_viaje.html",
                title: "Registrar nuevo viaje"
            }
        };
        load_modal(modal_options, function () {
            aparatos = get_aparatos_all();
            add_options(aparatos, 'APARATO_ID', ["<button class='btn btn-sm btn-info btn-set-viaje' id=0 type='button'>Seleccionar</button>"]);
            $("#table-aparato-viaje").DataTable({
                destroy: true,
                data: aparatos,
                columns: [
                    { data: 'NUMERO_MATRICULA' },
                    { data: 'CODIGO_ACCESO' },
                    { data: 'CAPACIDAD' },
                    { data: 'PORCENTAJE_CARGA' },
                    { data: 'NOMBRE' },
                    { data: 'options' }
                ]
            });
        });
    }

    function load_modal_registro_aparato_viaje() {
        aparato_id = $(this).attr('id');
        aparato = get_aparato(aparato_id);
        if(aparato.CLAVE != 'ENSP'){
            alert("Este aparato no puede realizar viajes");
            return;
        }
        modal_options = {
            tags: {
                div_modal: ".modal-container-registro-aparato-viaje",
                id_modal: "#modal-registro-aparato-viaje",
                title: ".modal-title"
            },
            data: {
                view_modal: "core/view/registro_aparato_viaje.html",
                title: "Registrar datos de viaje"
            }
        };
        
        load_modal(modal_options, function () {
            date_picker_load(["#datetimepicker1"]);
            set_options_date_picker(["#datetimepicker1"]);
            set_text_tag(".h4-matricula",aparato.NUMERO_MATRICULA);
            set_text_tag(".h4-carga",aparato.PORCENTAJE_CARGA+"%");
            set_id_tag(".btn-set-viaje-commit",aparato_id);
        });
    }

    function load_modal_registro_aparato_renta() {
        aparato_id = $(this).attr('id');
        aparato = get_aparato(aparato_id);
        if(aparato.CLAVE != 'ENSP'){
            alert("Este aparato no puede ser rentado");
            return;
        }
        modal_options = {
            tags: {
                div_modal: ".modal-container-registro-aparato-renta",
                id_modal: "#modal-registro-aparato-renta",
                title: ".modal-title"
            },
            data: {
                view_modal: "core/view/registro_aparato_renta.html",
                title: "Registrar datos de renta"
            }
        };
        load_modal(modal_options, function () {
            set_text_tag(".h4-matricula",aparato.NUMERO_MATRICULA);
            set_id_tag(".btn-set-renta-commit",aparato_id);
        });
    }

    function set_viaje() {
        data = {
            usuario_id: sessionStorage.getItem("id"),
            fin: get_value_input(".viaje-fin"),
            folio: random_generator(13),
            aparato_id: get_id_tag(this)
        };
        res = ajax_request("core/controller/set_servicio_viaje_usuario.php", "POST", data);
        if (res.resultado == true) {
            alert("Exito en el registro del viaje");
            $("#modal-registro-aparato-viaje").modal('toggle');
            $("#modal-registro-viaje").modal('toggle');
            load_panel_servicios();
        } else {
            alert("Error en el registro del viaje");
        }
    }

    function set_renta() {
        data = {
            usuario_id: sessionStorage.getItem("id"),
            dias_custodio: get_value_input(".renta-dias-custodio"),
            direccion: get_value_input(".renta-direccion"),
            aparato_id: get_id_tag(this)
        };
        res = ajax_request("core/controller/set_servicio_renta_usuario.php", "POST", data);
        if (res.resultado == true) {
            alert("Exito en el registro de la renta");
            $("#modal-registro-aparato-renta").modal('toggle');
            $("#modal-registro-renta").modal('toggle');
            load_panel_servicios();
        } else {
            alert("Error en el registro de la renta");
        }
    }

    function get_servicio_renta_id(servicio_id){
        ajax_request("core/controller/get_servicio_renta_id.php","GET",{servicio_id:servicio_id});
    }

    function get_servicio_viaje_id(servicio_id){
        ajax_request("core/controller/get_servicio_viaje_id.php","GET",{servicio_id:servicio_id});
    }

    function load_modal_detalle_renta(){
        servicio_id = get_id_tag(this);
        servicio = get_servicio_renta_id(servicio_id);
        console.log(servicio);
        modal_options = {
            tags: {
                div_modal: ".modal-container-detalle-renta",
                id_modal: "#modal-detale-renta",
                title: ".modal-title"
            },
            data: {
                view_modal: "core/view/detalle_renta.html",
                title: "Detalle renta"
            }
        };
        load_modal(modal_options, function () {
            aparatos = get_aparatos_all();
            add_options(aparatos, 'APARATO_ID', ["<button class='btn btn-sm btn-danger btn-terminar-renta' id=0 type='button'>Terminar</button>"]);
            $("#table-aparato-renta").DataTable({
                destroy: true,
                data: aparatos,
                columns: [
                    { data: 'NUMERO_MATRICULA' },
                    { data: 'CODIGO_ACCESO' },
                    { data: 'CAPACIDAD' },
                    { data: 'PORCENTAJE_CARGA' },
                    { data: 'NOMBRE' },
                    { data: 'options' }
                ]
            });
        });
    }

    function load_modal_detalle_viaje(){
        servicio_id = get_id_tag(this);
        servicio = get_servicio_renta_id(servicio_id);
        console.log(servicio);
        modal_options = {
            tags: {
                div_modal: ".modal-container-detalle-viaje",
                id_modal: "#modal-detale-viaje",
                title: ".modal-title"
            },
            data: {
                view_modal: "core/view/detalle_viaje.html",
                title: "Detalle viaje"
            }
        };
        load_modal(modal_options, function () {
            aparatos = get_aparatos_all();
            add_options(aparatos, 'APARATO_ID', ["<button class='btn btn-sm btn-danger btn-terminar-viaje' id=0 type='button'>Terminar</button>"]);
            $("#table-aparato-renta").DataTable({
                destroy: true,
                data: aparatos,
                columns: [
                    { data: 'NUMERO_MATRICULA' },
                    { data: 'CODIGO_ACCESO' },
                    { data: 'CAPACIDAD' },
                    { data: 'PORCENTAJE_CARGA' },
                    { data: 'NOMBRE' },
                    { data: 'options' }
                ]
            });
        });
    }



    function load_modal_registro_renta() {
        modal_options = {
            tags: {
                div_modal: ".modal-container-registro-renta",
                id_modal: "#modal-registro-renta",
                title: ".modal-title"
            },
            data: {
                view_modal: "core/view/registro_renta.html",
                title: "Rentar aparato"
            }
        };
        load_modal(modal_options, function () {
            aparatos = get_aparatos_all();
            add_options(aparatos, 'APARATO_ID', ["<button class='btn btn-sm btn-info btn-set-renta' id=0 type='button'>Seleccionar</button>"]);
            $("#table-aparato-renta").DataTable({
                destroy: true,
                data: aparatos,
                columns: [
                    { data: 'NUMERO_MATRICULA' },
                    { data: 'CODIGO_ACCESO' },
                    { data: 'CAPACIDAD' },
                    { data: 'PORCENTAJE_CARGA' },
                    { data: 'NOMBRE' },
                    { data: 'options' }
                ]
            });
        });
    }

    function cerrar_sesion() {
        ajax_request("core/controller/cerrar_sesion.php", "GET", {});
        sessionStorage.clear();
        alert("Sesion cerrada");
        location.href = "index.php";
    }

    $("#wrapper").on("click", ".btn-index", index);
    $("#wrapper").on("click", ".btn-usuarios", load_panel_usuarios);
    $("#wrapper").on("click", ".btn-servicios", load_panel_servicios);
    $(".main-panel").on("click", ".btn-iniciar-sesion", iniciar_sesion);
    $("#wrapper").on("click", ".btn-logout", cerrar_sesion);
    $("#wrapper").on("click", ".btn-ver-usuario", load_modal_usuario);
    $("#wrapper").on("click", ".btn-registro-usuario", load_modal_registro_usuario);
    $("#wrapper").on("click", ".btn-set-usuario", set_usuario);
    $("#wrapper").on("click", ".btn-registro-viaje", load_modal_registro_viaje);
    $("#wrapper").on("click", ".btn-registro-renta", load_modal_registro_renta);
    $("#wrapper").on("click", ".btn-set-renta", load_modal_registro_aparato_renta);
    $("#wrapper").on("click", ".btn-set-viaje", load_modal_registro_aparato_viaje);
    $("#wrapper").on("click", ".btn-set-viaje-commit", set_viaje);
    $("#wrapper").on("click", ".btn-set-renta-commit", set_renta);
    $("#wrapper").on("click", ".btn-modal-detalle-renta", load_modal_detalle_renta);
    $("#wrapper").on("click", ".btn-modal-detalle-viaje", load_modal_detalle_viaje);
    
});