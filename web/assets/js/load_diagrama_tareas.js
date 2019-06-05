function prepara_diagrama_tareas(las_tareas){
    las_tareas.forEach(element => {
        console.log(element.nombre);
    });
}

function load_diagrama_tareas(json){
    var tasks = JSON.parse(json);
    console.log(tasks.data[0].id);
    //gantt.config.readonly = true;
    gantt.init("gantt_here");
    
    
    gantt.parse(tasks);
}

/* haz que los datos de las tareas se almacenen como la estructura de abajo */

//estructura para el json
/*
{
		data: [
			{
				id: 1, text: "Project #2", start_date: "01-04-2018", duration: 18, order: 10,
				progress: 0.4, open: true
			},
			{
				id: 2, text: "Task #1", start_date: "02-04-2018", duration: 8, order: 10,
				progress: 0.6, parent: 1
			},
			{
				id: 3, text: "Task #2", start_date: "11-04-2018", duration: 8, order: 20,
				progress: 0.6, parent: 1
			}
		],
		links: [
			{id: 1, source: 1, target: 2, type: "1"},
			{id: 2, source: 2, target: 3, type: "0"}
		]
	};
*/ 