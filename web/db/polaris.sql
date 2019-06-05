--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: documento; Type: TABLE; Schema: public; Owner: vromero; Tablespace: 
--

CREATE TABLE documento (
    documento_id integer NOT NULL,
    nombre character varying(200) NOT NULL,
    documento bytea NOT NULL,
    tarea_id integer NOT NULL
);


ALTER TABLE public.documento OWNER TO vromero;

--
-- Name: documento_documento_id_seq; Type: SEQUENCE; Schema: public; Owner: vromero
--

CREATE SEQUENCE documento_documento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.documento_documento_id_seq OWNER TO vromero;

--
-- Name: documento_documento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vromero
--

ALTER SEQUENCE documento_documento_id_seq OWNED BY documento.documento_id;


--
-- Name: doc; Type: TABLE; Schema: public; Owner: vromero; Tablespace: 
--

CREATE TABLE doc (
    documento_id integer DEFAULT nextval('documento_documento_id_seq'::regclass) NOT NULL,
    nombre character varying(200) NOT NULL,
    tarea_id integer NOT NULL,
    documennto character varying(200)
);


ALTER TABLE public.doc OWNER TO vromero;

--
-- Name: estado; Type: TABLE; Schema: public; Owner: vromero; Tablespace: 
--

CREATE TABLE estado (
    estado_id integer NOT NULL,
    nombre character varying NOT NULL,
    clave_estado character(2) NOT NULL
);


ALTER TABLE public.estado OWNER TO vromero;

--
-- Name: estado_estado_id_seq; Type: SEQUENCE; Schema: public; Owner: vromero
--

CREATE SEQUENCE estado_estado_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estado_estado_id_seq OWNER TO vromero;

--
-- Name: estado_estado_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vromero
--

ALTER SEQUENCE estado_estado_id_seq OWNED BY estado.estado_id;


--
-- Name: estado_tarea; Type: TABLE; Schema: public; Owner: vromero; Tablespace: 
--

CREATE TABLE estado_tarea (
    estado_tarea_id integer NOT NULL,
    tarea_id integer,
    clave_estado character(2) NOT NULL,
    fecha_estado timestamp without time zone NOT NULL
);


ALTER TABLE public.estado_tarea OWNER TO vromero;

--
-- Name: estado_tarea_estado_tarea_id_seq; Type: SEQUENCE; Schema: public; Owner: vromero
--

CREATE SEQUENCE estado_tarea_estado_tarea_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estado_tarea_estado_tarea_id_seq OWNER TO vromero;

--
-- Name: estado_tarea_estado_tarea_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vromero
--

ALTER SEQUENCE estado_tarea_estado_tarea_id_seq OWNED BY estado_tarea.estado_tarea_id;


--
-- Name: org_equipo; Type: TABLE; Schema: public; Owner: vromero; Tablespace: 
--

CREATE TABLE org_equipo (
    org_equipo_id integer NOT NULL,
    nombre character varying(30) NOT NULL,
    descripcion character varying(300) NOT NULL
);


ALTER TABLE public.org_equipo OWNER TO vromero;

--
-- Name: org_equipo_org_equipo_id_seq; Type: SEQUENCE; Schema: public; Owner: vromero
--

CREATE SEQUENCE org_equipo_org_equipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.org_equipo_org_equipo_id_seq OWNER TO vromero;

--
-- Name: org_equipo_org_equipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vromero
--

ALTER SEQUENCE org_equipo_org_equipo_id_seq OWNED BY org_equipo.org_equipo_id;


--
-- Name: proceso; Type: TABLE; Schema: public; Owner: vromero; Tablespace: 
--

CREATE TABLE proceso (
    proceso_id integer NOT NULL,
    titulo character varying(30) NOT NULL,
    org_equipo_id integer NOT NULL,
    porcentaje_total numeric(4,2) DEFAULT 0 NOT NULL,
    descripcion character varying(400)
);


ALTER TABLE public.proceso OWNER TO vromero;

--
-- Name: proceso_proceso_id_seq; Type: SEQUENCE; Schema: public; Owner: vromero
--

CREATE SEQUENCE proceso_proceso_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proceso_proceso_id_seq OWNER TO vromero;

--
-- Name: proceso_proceso_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vromero
--

ALTER SEQUENCE proceso_proceso_id_seq OWNED BY proceso.proceso_id;


--
-- Name: rol; Type: TABLE; Schema: public; Owner: vromero; Tablespace: 
--

CREATE TABLE rol (
    rol_id integer NOT NULL,
    clave_rol integer NOT NULL,
    nombre character varying(40) NOT NULL
);


ALTER TABLE public.rol OWNER TO vromero;

--
-- Name: rol_usuario; Type: TABLE; Schema: public; Owner: vromero; Tablespace: 
--

CREATE TABLE rol_usuario (
    rol_usuario_id integer NOT NULL,
    usuario_id integer NOT NULL,
    clave_rol integer NOT NULL
);


ALTER TABLE public.rol_usuario OWNER TO vromero;

--
-- Name: tarea; Type: TABLE; Schema: public; Owner: vromero; Tablespace: 
--

CREATE TABLE tarea (
    tarea_id integer NOT NULL,
    fecha_inicio timestamp without time zone DEFAULT now() NOT NULL,
    fecha_fin timestamp without time zone,
    proceso_id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    clave_estado character(2) NOT NULL,
    descripcion character varying(400)
);


ALTER TABLE public.tarea OWNER TO vromero;

--
-- Name: tarea_tarea_id_seq; Type: SEQUENCE; Schema: public; Owner: vromero
--

CREATE SEQUENCE tarea_tarea_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tarea_tarea_id_seq OWNER TO vromero;

--
-- Name: tarea_tarea_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vromero
--

ALTER SEQUENCE tarea_tarea_id_seq OWNED BY tarea.tarea_id;


--
-- Name: tipo_usuario_tipo_id_seq; Type: SEQUENCE; Schema: public; Owner: vromero
--

CREATE SEQUENCE tipo_usuario_tipo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_usuario_tipo_id_seq OWNER TO vromero;

--
-- Name: tipo_usuario_tipo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vromero
--

ALTER SEQUENCE tipo_usuario_tipo_id_seq OWNED BY rol.rol_id;


--
-- Name: usuario; Type: TABLE; Schema: public; Owner: vromero; Tablespace: 
--

CREATE TABLE usuario (
    usuario_id integer NOT NULL,
    usuario character varying(40) NOT NULL,
    nombre character varying(40) NOT NULL,
    apellidos character varying(40) NOT NULL
);


ALTER TABLE public.usuario OWNER TO vromero;

--
-- Name: usuario_final_usuario_final_id_seq; Type: SEQUENCE; Schema: public; Owner: vromero
--

CREATE SEQUENCE usuario_final_usuario_final_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_final_usuario_final_id_seq OWNER TO vromero;

--
-- Name: usuario_final_usuario_final_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vromero
--

ALTER SEQUENCE usuario_final_usuario_final_id_seq OWNED BY rol_usuario.rol_usuario_id;


--
-- Name: usuario_org_equipo; Type: TABLE; Schema: public; Owner: vromero; Tablespace: 
--

CREATE TABLE usuario_org_equipo (
    usuario_org_equipo integer NOT NULL,
    usuario_id integer NOT NULL,
    org_equipo_id integer NOT NULL
);


ALTER TABLE public.usuario_org_equipo OWNER TO vromero;

--
-- Name: usuario_org_equipo_usuario_org_equipo_seq; Type: SEQUENCE; Schema: public; Owner: vromero
--

CREATE SEQUENCE usuario_org_equipo_usuario_org_equipo_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_org_equipo_usuario_org_equipo_seq OWNER TO vromero;

--
-- Name: usuario_org_equipo_usuario_org_equipo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vromero
--

ALTER SEQUENCE usuario_org_equipo_usuario_org_equipo_seq OWNED BY usuario_org_equipo.usuario_org_equipo;


--
-- Name: usuario_tarea; Type: TABLE; Schema: public; Owner: vromero; Tablespace: 
--

CREATE TABLE usuario_tarea (
    usuario_tarea_id integer NOT NULL,
    usuario_id integer NOT NULL,
    tarea_id integer NOT NULL
);


ALTER TABLE public.usuario_tarea OWNER TO vromero;

--
-- Name: usuario_tarea_usuario_tarea_id_seq; Type: SEQUENCE; Schema: public; Owner: vromero
--

CREATE SEQUENCE usuario_tarea_usuario_tarea_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_tarea_usuario_tarea_id_seq OWNER TO vromero;

--
-- Name: usuario_tarea_usuario_tarea_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vromero
--

ALTER SEQUENCE usuario_tarea_usuario_tarea_id_seq OWNED BY usuario_tarea.usuario_tarea_id;


--
-- Name: usuario_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: vromero
--

CREATE SEQUENCE usuario_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_usuario_id_seq OWNER TO vromero;

--
-- Name: usuario_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: vromero
--

ALTER SEQUENCE usuario_usuario_id_seq OWNED BY usuario.usuario_id;


--
-- Name: documento_id; Type: DEFAULT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY documento ALTER COLUMN documento_id SET DEFAULT nextval('documento_documento_id_seq'::regclass);


--
-- Name: estado_id; Type: DEFAULT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY estado ALTER COLUMN estado_id SET DEFAULT nextval('estado_estado_id_seq'::regclass);


--
-- Name: estado_tarea_id; Type: DEFAULT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY estado_tarea ALTER COLUMN estado_tarea_id SET DEFAULT nextval('estado_tarea_estado_tarea_id_seq'::regclass);


--
-- Name: org_equipo_id; Type: DEFAULT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY org_equipo ALTER COLUMN org_equipo_id SET DEFAULT nextval('org_equipo_org_equipo_id_seq'::regclass);


--
-- Name: proceso_id; Type: DEFAULT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY proceso ALTER COLUMN proceso_id SET DEFAULT nextval('proceso_proceso_id_seq'::regclass);


--
-- Name: rol_id; Type: DEFAULT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY rol ALTER COLUMN rol_id SET DEFAULT nextval('tipo_usuario_tipo_id_seq'::regclass);


--
-- Name: rol_usuario_id; Type: DEFAULT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY rol_usuario ALTER COLUMN rol_usuario_id SET DEFAULT nextval('usuario_final_usuario_final_id_seq'::regclass);


--
-- Name: tarea_id; Type: DEFAULT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY tarea ALTER COLUMN tarea_id SET DEFAULT nextval('tarea_tarea_id_seq'::regclass);


--
-- Name: usuario_id; Type: DEFAULT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY usuario ALTER COLUMN usuario_id SET DEFAULT nextval('usuario_usuario_id_seq'::regclass);


--
-- Name: usuario_org_equipo; Type: DEFAULT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY usuario_org_equipo ALTER COLUMN usuario_org_equipo SET DEFAULT nextval('usuario_org_equipo_usuario_org_equipo_seq'::regclass);


--
-- Name: usuario_tarea_id; Type: DEFAULT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY usuario_tarea ALTER COLUMN usuario_tarea_id SET DEFAULT nextval('usuario_tarea_usuario_tarea_id_seq'::regclass);


--
-- Data for Name: doc; Type: TABLE DATA; Schema: public; Owner: vromero
--



--
-- Data for Name: documento; Type: TABLE DATA; Schema: public; Owner: vromero
--



--
-- Name: documento_documento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vromero
--

SELECT pg_catalog.setval('documento_documento_id_seq', 1, false);


--
-- Data for Name: estado; Type: TABLE DATA; Schema: public; Owner: vromero
--

INSERT INTO estado VALUES (5, 'creada', 'CR');
INSERT INTO estado VALUES (6, 'Asignada', 'AS');
INSERT INTO estado VALUES (7, 'Terminada', 'TE');
INSERT INTO estado VALUES (8, 'Cancelada', 'CA');


--
-- Name: estado_estado_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vromero
--

SELECT pg_catalog.setval('estado_estado_id_seq', 8, true);


--
-- Data for Name: estado_tarea; Type: TABLE DATA; Schema: public; Owner: vromero
--

INSERT INTO estado_tarea VALUES (63, 59, 'CR', '2019-04-29 12:59:08.453196');
INSERT INTO estado_tarea VALUES (64, 59, 'AS', '2019-04-29 12:59:08.519814');
INSERT INTO estado_tarea VALUES (67, 62, 'CR', '2019-04-30 10:18:18.274458');
INSERT INTO estado_tarea VALUES (74, 68, 'CR', '2019-04-30 10:34:36.215501');
INSERT INTO estado_tarea VALUES (75, 68, 'AS', '2019-04-30 10:34:36.290458');
INSERT INTO estado_tarea VALUES (76, 69, 'CR', '2019-04-30 10:35:56.697637');
INSERT INTO estado_tarea VALUES (15, 25, 'CR', '2019-04-09 11:21:08.07483');
INSERT INTO estado_tarea VALUES (77, 69, 'AS', '2019-04-30 10:35:56.755891');
INSERT INTO estado_tarea VALUES (86, 77, 'CR', '2019-05-07 13:21:34.92112');
INSERT INTO estado_tarea VALUES (87, 77, 'AS', '2019-05-07 13:21:35.012761');
INSERT INTO estado_tarea VALUES (88, 78, 'CR', '2019-05-07 13:24:01.08305');
INSERT INTO estado_tarea VALUES (89, 78, 'AS', '2019-05-07 13:24:01.182917');
INSERT INTO estado_tarea VALUES (49, 52, 'CR', '2019-04-29 12:24:07.192726');
INSERT INTO estado_tarea VALUES (50, 52, 'AS', '2019-04-29 12:24:07.317614');


--
-- Name: estado_tarea_estado_tarea_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vromero
--

SELECT pg_catalog.setval('estado_tarea_estado_tarea_id_seq', 91, true);


--
-- Data for Name: org_equipo; Type: TABLE DATA; Schema: public; Owner: vromero
--

INSERT INTO org_equipo VALUES (1, 'gamma V', 'equipo bueno');
INSERT INTO org_equipo VALUES (2, 'gamma C', 'equipo chino');
INSERT INTO org_equipo VALUES (3, 'alfa', '');


--
-- Name: org_equipo_org_equipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vromero
--

SELECT pg_catalog.setval('org_equipo_org_equipo_id_seq', 3, true);


--
-- Data for Name: proceso; Type: TABLE DATA; Schema: public; Owner: vromero
--

INSERT INTO proceso VALUES (1, 'Proceso de procesar', 1, 0.00, NULL);
INSERT INTO proceso VALUES (2, 'proceso 2', 2, 0.00, NULL);
INSERT INTO proceso VALUES (5, 'Proceso 3', 2, 0.00, NULL);
INSERT INTO proceso VALUES (6, 'Proceso 4', 2, 0.00, NULL);
INSERT INTO proceso VALUES (7, 'Proceso maravilla', 2, 0.00, NULL);


--
-- Name: proceso_proceso_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vromero
--

SELECT pg_catalog.setval('proceso_proceso_id_seq', 7, true);


--
-- Data for Name: rol; Type: TABLE DATA; Schema: public; Owner: vromero
--

INSERT INTO rol VALUES (1, 1, 'administrador');
INSERT INTO rol VALUES (2, 2, 'observador');
INSERT INTO rol VALUES (3, 3, 'usuario');


--
-- Data for Name: rol_usuario; Type: TABLE DATA; Schema: public; Owner: vromero
--

INSERT INTO rol_usuario VALUES (35, 26, 2);
INSERT INTO rol_usuario VALUES (36, 26, 3);
INSERT INTO rol_usuario VALUES (37, 25, 1);
INSERT INTO rol_usuario VALUES (38, 25, 2);
INSERT INTO rol_usuario VALUES (39, 25, 3);
INSERT INTO rol_usuario VALUES (42, 19, 3);


--
-- Data for Name: tarea; Type: TABLE DATA; Schema: public; Owner: vromero
--

INSERT INTO tarea VALUES (59, '2019-04-29 12:59:00', '2019-04-30 12:59:00', 6, 'asdasd', 'AS', 'asfasfasf');
INSERT INTO tarea VALUES (25, '2019-04-10 12:00:00', '2019-04-10 13:00:00', 2, 'tarea nueva', 'CR', 'algo esta pasando');
INSERT INTO tarea VALUES (62, '2019-04-30 10:18:00', '2019-05-01 10:18:00', 1, '1234567', 'CR', 'asdasd');
INSERT INTO tarea VALUES (68, '2019-04-30 10:34:00', '2019-05-02 10:34:00', 5, '123123', 'AS', 'asdfasd');
INSERT INTO tarea VALUES (69, '2019-04-30 10:35:00', '2019-05-04 10:35:00', 2, '3123', 'AS', 'asdasd');
INSERT INTO tarea VALUES (77, '2019-05-07 13:21:00', '2019-05-07 13:21:00', 2, '4123123', 'AS', '12312312');
INSERT INTO tarea VALUES (78, '2019-05-07 13:24:00', '2019-05-24 13:24:00', 2, 'tarea asignada', 'AS', 'descripcion');
INSERT INTO tarea VALUES (52, '2019-04-29 12:24:00', '2019-04-30 12:24:00', 7, 'Tarea', 'AS', 'asdasdasd');


--
-- Name: tarea_tarea_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vromero
--

SELECT pg_catalog.setval('tarea_tarea_id_seq', 79, true);


--
-- Name: tipo_usuario_tipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vromero
--

SELECT pg_catalog.setval('tipo_usuario_tipo_id_seq', 3, true);


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: vromero
--

INSERT INTO usuario VALUES (19, 'dmontiel', 'Luis Javier', 'Montiel Martinez');
INSERT INTO usuario VALUES (25, 'vromero', 'Vicente', 'Romero Andrade');
INSERT INTO usuario VALUES (26, 'cromero', 'Cristian', 'Romero');


--
-- Name: usuario_final_usuario_final_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vromero
--

SELECT pg_catalog.setval('usuario_final_usuario_final_id_seq', 42, true);


--
-- Data for Name: usuario_org_equipo; Type: TABLE DATA; Schema: public; Owner: vromero
--

INSERT INTO usuario_org_equipo VALUES (18, 26, 2);
INSERT INTO usuario_org_equipo VALUES (20, 19, 3);
INSERT INTO usuario_org_equipo VALUES (21, 19, 1);
INSERT INTO usuario_org_equipo VALUES (22, 25, 2);
INSERT INTO usuario_org_equipo VALUES (23, 25, 1);


--
-- Name: usuario_org_equipo_usuario_org_equipo_seq; Type: SEQUENCE SET; Schema: public; Owner: vromero
--

SELECT pg_catalog.setval('usuario_org_equipo_usuario_org_equipo_seq', 23, true);


--
-- Data for Name: usuario_tarea; Type: TABLE DATA; Schema: public; Owner: vromero
--

INSERT INTO usuario_tarea VALUES (19, 26, 52);
INSERT INTO usuario_tarea VALUES (32, 26, 59);
INSERT INTO usuario_tarea VALUES (35, 26, 68);
INSERT INTO usuario_tarea VALUES (36, 26, 69);
INSERT INTO usuario_tarea VALUES (38, 26, 77);
INSERT INTO usuario_tarea VALUES (39, 26, 78);


--
-- Name: usuario_tarea_usuario_tarea_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vromero
--

SELECT pg_catalog.setval('usuario_tarea_usuario_tarea_id_seq', 41, true);


--
-- Name: usuario_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: vromero
--

SELECT pg_catalog.setval('usuario_usuario_id_seq', 26, true);


--
-- Name: doc_pkey; Type: CONSTRAINT; Schema: public; Owner: vromero; Tablespace: 
--

ALTER TABLE ONLY doc
    ADD CONSTRAINT doc_pkey PRIMARY KEY (documento_id);


--
-- Name: documento_pk; Type: CONSTRAINT; Schema: public; Owner: vromero; Tablespace: 
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT documento_pk PRIMARY KEY (documento_id);


--
-- Name: estado_pk; Type: CONSTRAINT; Schema: public; Owner: vromero; Tablespace: 
--

ALTER TABLE ONLY estado
    ADD CONSTRAINT estado_pk PRIMARY KEY (estado_id);


--
-- Name: estado_tarea_pk; Type: CONSTRAINT; Schema: public; Owner: vromero; Tablespace: 
--

ALTER TABLE ONLY estado_tarea
    ADD CONSTRAINT estado_tarea_pk PRIMARY KEY (estado_tarea_id);


--
-- Name: org_equipo_pk; Type: CONSTRAINT; Schema: public; Owner: vromero; Tablespace: 
--

ALTER TABLE ONLY org_equipo
    ADD CONSTRAINT org_equipo_pk PRIMARY KEY (org_equipo_id);


--
-- Name: proceso_pk; Type: CONSTRAINT; Schema: public; Owner: vromero; Tablespace: 
--

ALTER TABLE ONLY proceso
    ADD CONSTRAINT proceso_pk PRIMARY KEY (proceso_id);


--
-- Name: tarea_pk; Type: CONSTRAINT; Schema: public; Owner: vromero; Tablespace: 
--

ALTER TABLE ONLY tarea
    ADD CONSTRAINT tarea_pk PRIMARY KEY (tarea_id);


--
-- Name: tarea_proceso_nombre_iux; Type: CONSTRAINT; Schema: public; Owner: vromero; Tablespace: 
--

ALTER TABLE ONLY tarea
    ADD CONSTRAINT tarea_proceso_nombre_iux UNIQUE (nombre, proceso_id);


--
-- Name: tipo_usuario_pk; Type: CONSTRAINT; Schema: public; Owner: vromero; Tablespace: 
--

ALTER TABLE ONLY rol
    ADD CONSTRAINT tipo_usuario_pk PRIMARY KEY (rol_id);


--
-- Name: usuario_final_pk; Type: CONSTRAINT; Schema: public; Owner: vromero; Tablespace: 
--

ALTER TABLE ONLY rol_usuario
    ADD CONSTRAINT usuario_final_pk PRIMARY KEY (rol_usuario_id);


--
-- Name: usuario_org_equipo_pk; Type: CONSTRAINT; Schema: public; Owner: vromero; Tablespace: 
--

ALTER TABLE ONLY usuario_org_equipo
    ADD CONSTRAINT usuario_org_equipo_pk PRIMARY KEY (usuario_org_equipo);


--
-- Name: usuario_pk; Type: CONSTRAINT; Schema: public; Owner: vromero; Tablespace: 
--

ALTER TABLE ONLY usuario
    ADD CONSTRAINT usuario_pk PRIMARY KEY (usuario_id);


--
-- Name: usuario_tarea_pk; Type: CONSTRAINT; Schema: public; Owner: vromero; Tablespace: 
--

ALTER TABLE ONLY usuario_tarea
    ADD CONSTRAINT usuario_tarea_pk PRIMARY KEY (usuario_tarea_id);


--
-- Name: estado_clave_estado_uindex; Type: INDEX; Schema: public; Owner: vromero; Tablespace: 
--

CREATE UNIQUE INDEX estado_clave_estado_uindex ON estado USING btree (clave_estado);


--
-- Name: estado_nombre_uindex; Type: INDEX; Schema: public; Owner: vromero; Tablespace: 
--

CREATE UNIQUE INDEX estado_nombre_uindex ON estado USING btree (nombre);


--
-- Name: rol_usuario_rol_id_usuario_id_iux; Type: INDEX; Schema: public; Owner: vromero; Tablespace: 
--

CREATE UNIQUE INDEX rol_usuario_rol_id_usuario_id_iux ON rol_usuario USING btree (clave_rol, usuario_id);


--
-- Name: tipo_usuario_clave_tipo_uindex; Type: INDEX; Schema: public; Owner: vromero; Tablespace: 
--

CREATE UNIQUE INDEX tipo_usuario_clave_tipo_uindex ON rol USING btree (clave_rol);


--
-- Name: usuario_org_equipo_usuario_equipo_uix; Type: INDEX; Schema: public; Owner: vromero; Tablespace: 
--

CREATE UNIQUE INDEX usuario_org_equipo_usuario_equipo_uix ON usuario_org_equipo USING btree (org_equipo_id, usuario_id);


--
-- Name: usuario_tarea_usuario_id_tarea_id_iux; Type: INDEX; Schema: public; Owner: vromero; Tablespace: 
--

CREATE UNIQUE INDEX usuario_tarea_usuario_id_tarea_id_iux ON usuario_tarea USING btree (usuario_id, tarea_id);


--
-- Name: usuario_usuario_uindex; Type: INDEX; Schema: public; Owner: vromero; Tablespace: 
--

CREATE UNIQUE INDEX usuario_usuario_uindex ON usuario USING btree (usuario);


--
-- Name: documento_tarea_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT documento_tarea_id_fk FOREIGN KEY (tarea_id) REFERENCES tarea(tarea_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: estado_tarea_clave_estado_fk; Type: FK CONSTRAINT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY estado_tarea
    ADD CONSTRAINT estado_tarea_clave_estado_fk FOREIGN KEY (clave_estado) REFERENCES estado(clave_estado) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: estado_tarea_tarea_tarea_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY estado_tarea
    ADD CONSTRAINT estado_tarea_tarea_tarea_id_fk FOREIGN KEY (tarea_id) REFERENCES tarea(tarea_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: fk_tarea; Type: FK CONSTRAINT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY doc
    ADD CONSTRAINT fk_tarea FOREIGN KEY (tarea_id) REFERENCES tarea(tarea_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: org_equipo_org_equipo_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY usuario_org_equipo
    ADD CONSTRAINT org_equipo_org_equipo_id_fk FOREIGN KEY (org_equipo_id) REFERENCES org_equipo(org_equipo_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: proceso_org_equipo_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY proceso
    ADD CONSTRAINT proceso_org_equipo_id_fk FOREIGN KEY (org_equipo_id) REFERENCES org_equipo(org_equipo_id);


--
-- Name: tarea_clave_estado_fk; Type: FK CONSTRAINT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY tarea
    ADD CONSTRAINT tarea_clave_estado_fk FOREIGN KEY (clave_estado) REFERENCES estado(clave_estado) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tarea_proceso_proceso_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY tarea
    ADD CONSTRAINT tarea_proceso_proceso_id_fk FOREIGN KEY (proceso_id) REFERENCES proceso(proceso_id);


--
-- Name: usuario_final_clave_tipo_fk; Type: FK CONSTRAINT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY rol_usuario
    ADD CONSTRAINT usuario_final_clave_tipo_fk FOREIGN KEY (clave_rol) REFERENCES rol(clave_rol) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: usuario_final_usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY rol_usuario
    ADD CONSTRAINT usuario_final_usuario_fk FOREIGN KEY (usuario_id) REFERENCES usuario(usuario_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: usuario_oe_usuario_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY usuario_org_equipo
    ADD CONSTRAINT usuario_oe_usuario_id_fk FOREIGN KEY (usuario_id) REFERENCES usuario(usuario_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: usuario_tarea_tarea_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY usuario_tarea
    ADD CONSTRAINT usuario_tarea_tarea_id_fk FOREIGN KEY (tarea_id) REFERENCES tarea(tarea_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: usuario_tarea_usuario_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: vromero
--

ALTER TABLE ONLY usuario_tarea
    ADD CONSTRAINT usuario_tarea_usuario_id_fk FOREIGN KEY (usuario_id) REFERENCES usuario(usuario_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

