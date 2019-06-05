function load_modal(modal = { tags: { div_modal: '.modal-container' }, data: { option_modal: '', title: 'modal' } }, func = function () { return }) {
    $(modal.tags.div_modal).load(modal.data.view_modal, function () {
        $(modal.tags.id_modal).modal(modal.data.option_modal);
        set_text_tag(modal.tags.title,modal.data.title);
        func();
    });
}

function select_picker_load(selects_id) {
    selects_id.forEach(select_id => {
        $(select_id).selectpicker();
    });
}
/*card = { 
    tags: {
        container: '.card-deck', 
        title: '.card-title', 
        description: '.card-text', 
        options: '.card-options' 
    }, 
    data: {
        view_source: '', 
        title: '', 
        description: '', 
        options: { 
            input: [''], 
            id_value: '-1' 
        } 
    } 
}*/
function load_card(card = { tags: { container: '.card-deck', title: '.card-title', description: '.card-text', options: '.card-options' }, data: { view_source:'', title: '', description: '', options: { input: [''], id_value: '-1' } } }) {
    data = ajax_request(card.data.view_source, 'GET');
    data_html = $.parseHTML(data.responseText)[0];
    data_html.id = "card-"+card.data.options.id_value;
    id_tag_parent = "#card-"+card.data.options.id_value + " ";
    $(card.tags.container).append(data_html);
    set_text_tag(id_tag_parent + card.tags.title, card.data.title);
    set_text_tag(id_tag_parent + card.tags.description, card.data.description);
    card.data.options.input.forEach(input => {
        input = $.parseHTML(input);
        input[0].id = card.data.options.id_value;
        $(id_tag_parent + card.tags.options).append(input);
    });
}

function random_generator(length) {
    var result = '';
    var characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    var charactersLength = characters.length;
    for (var i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
}

function add_options(objetos, id, options) {
    objetos_temp = objetos;
    objetos = [];
    options.forEach(option => {
        objetos_temp.forEach(objeto => {
            html = $.parseHTML(option);
            html[0].id = objeto[id];
            option = html[0].outerHTML;
            if (objeto.options == undefined)
                objeto.options = "";
            objeto.options = objeto.options + (option);
            objetos.push(objeto);
        });
    });
    return objetos;
}

function date_picker_load(divs_id) {
    divs_id.forEach(div_id => {
        $(div_id).datetimepicker({
            format: 'YYYY-MM-DD HH:mm',
            locale: 'es'
        });
        $(div_id).datetimepicker('format', 'YYYY-MM-DD HH:mm');
    });
}
function set_options_date_picker(divs_id) {
    divs_id.forEach(div_id => {
        $(div_id).datetimepicker('format', 'YYYY-MM-DD HH:mm');
    });
}

function load_tabla(id_tabla, tabla, id_objeto, objetos, opciones) {
    add_options(objetos, id_objeto, opciones);
    tabla.data = objetos;
    return $(id_tabla).DataTable(tabla);
}

function disable_input(tag) {
    $(tag).prop('disabled', true);
}

function set_input(tag, value) {
    $(tag).val(value);
}

function parse_strings_to_array_values(object, id_strings) {
    id_strings.forEach(id_string => {
        object[id_string] = parse_string_array_list(object[id_string]);
    });
    return object;
}

function set_html_tag(tag, html) {
    $(tag).html(html);
}

function add_timeline(tag, data_source, content) {
    data = ajax_request(data_source, 'GET');
    data_html = $.parseHTML(data.responseText);
    data_html[0].id = content.id;
    $(tag.timeline_ul).append(data_html[0].outerHTML);
    console.log("#" + content.id + " " + tag.body);
    set_html_tag("#" + content.id + " " + tag.body, content.text);
}

function get_id_tag(tag) {
    return $(tag).attr('id');
}

function set_id_tag(tag, value) {
    $(tag).attr('id', value);
}

function set_text_tag(tag, text) {
    $(tag).text(text);
}

function select_option(tag) {
    $(tag).attr('selected', 'selected');
}

function get_selected_options(tag) {
    selected_options = [];
    $(tag + ' option').each(function (i) {
        if (this.selected == true) {
            selected_options.push(this.value);
        }
    });
    return selected_options;
}

function swap_class(tag, old_class, new_class) {
    $(tag).removeClass(old_class);
    $(tag).addClass(new_class);
}

function set_active_class(tag) {
    $(".active").removeClass("active");
    $(tag).addClass("active");
}

function add_option_select(tag, tag_id, value, text, disabled = false) {
    if (disabled)
        $(tag).append("<option id='" + tag_id + "' value='" + value + "' disabled>" + text + "</option>");
    else
        $(tag).append("<option id='" + tag_id + "' value='" + value + "'>" + text + "</option>");
}

function parse_string_array_list(string_array) {
    string = string_array.replace('{', '');
    string = string.replace('}', '');
    return string.split(',');
}

function error_server() {
    alert("El servidor esta teniendo problemas con esta peticion");
}

function no_session_server() {
    alert("tu sesion expiro o no tienes permisos para realizar esto");
    location.href = "index.php";
}

function get_value_input(tag) {
    return $(tag).val();
}

function invalid_login() {
    alert("usuario o contraseña invalidos");
}

function ordenar_z_index(ids) {
    cont = 3000;
    ids.forEach(id => {
        $(id).css("z-index", cont);
        cont--;
    });
}

function get_checklist_selected(tag) {
    return $(tag + ":checked").map(function () {
        return this.id;
    }).get();
}

function get_option_selected(tag) {
    options = [];
    $(tag + ' option:selected').each(function (i) {
        if (this.selected == true) {
            options.push(this.value);
        }
    });
    return options;
}

function ajax_request(url, type, data = {}) {
    response = [];
    $.ajax({
        type: type,
        url: url,
        data: data,
        dataType: "json",
        async: false,
        statusCode: {
            200: function (XHTMLHttpRequest) {
                response = XHTMLHttpRequest;
            },
            401: no_session_server,
            403: invalid_login,
            500: error_server
        }
    });
    return response;
}