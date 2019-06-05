

function cierra_subir_tareas(){
    $('#myModal').modal('hide');
    document.getElementById("modal-de-tareas").style.overflow="auto";
    
}

document.getElementById("cierra-modal-proceso").onclick = (event) => {
    
    $('#modal-proceso').modal('hide');
}

document.getElementById("cierra-modal-tarea").onclick = (event) => {
    
    $('#modal-de-tareas').modal('hide');
    
}

document.getElementById("cierra-modal-subir-tareas").onclick = (event) => {
    
    cierra_subir_tareas();
}

document.getElementById("btn-cerrar-sub-archivos").onclick = (event) => {
    cierra_subir_tareas();
}

