create table persona(
	id_persona serial4 not null,
	ci char(10),
	nombres varchar(60),
	paterno varchar(60), 
	matenro varchar(60), 
	fecha_nacimiento date, 
	sexo char(1),
	fecha_reg timestamp default current_timestamp,
	usuario_reg varchar(20),
	ip_reg cidr,
	estado_reg char(1),
	constraint pk_persona primary key (id_persona)
);
comment on column persona.fecha_reg is 'Es la fecha de creacion del registro';
comment on column persona.estado_reg is 'Es el estado del registro V=vigente, E=eliminado ';
comment on column persona.sexo is 'M=Masculino, F=Femenino, N=No determinado';

create table estudiante(
	id_estudiante serial4 not null,
	id_persona int,
	semestre varchar(10) not null,
	ru int not null,
	estado_reg char(1),
	constraint pk_estudiante primary key (id_estudiante),
	constraint fk_persona_estudiante foreign key(id_persona) references public.persona(id_persona)
);
comment on column estudiante.estado_reg is 'Es el estado del registro V=vigente, E=Eliminado';

create table empleado(
	id_empleado serial4 not null,
	id_persona int,
	fecha_ingreso time,
	codigo_marcado int,
	trato varchar(10),
	estado_reg char(1),
	constraint pk_empleado primary key(id_empleado),
	constraint fk_persona_empleado foreign key(id_persona) references public.persona(id_persona)
);
comment on column empleado.estado_reg is 'Es el estado del registro V=vigente, E=Eliminado';


create table paciente( 
	id_paciente serial4 not null,
	id_persona int, 
	peso decimal(6,3),
	talla decimal(6,3),
	estado_civil char(2),
	nivel_instruccion char(2), 
	estado_reg char(1),
	constraint pk_paciente primary key(id_paciente),
	constraint fk_persona_paciente foreign key(id_persona) references public.persona(id_persona)
);
comment on column paciente.estado_reg is 'Es el estado del registro: V=vigente, E=Eliminado';
comment on column paciente.estado_civil is 'CA = Casado(a), SO=Soltero(a), VI=Viudo(a), DI=Divorsiado(a)';
comment on column paciente.nivel_instruccion is 'AN=Analfabeto, EI=Educacion Iniclal, PR=Primaria, SE=Secundaria, UN=Universitario PF=Profesional, SU=Superiores';
comment on column paciente.estado_reg is 'Es el estado del registro V=vigente, E=Eliminado';

create table telefono(
	id_telefono serial4 not null,
	tipo char(2),
	numero varchar(12),
	idpersona int,
	tipo_persona char(1), 
	estado_reg char(1),
	constraint pk_telefono primary key(id_telefono)
);
comment on column telefono.estado_reg is 'Es el estado del registro V=vigente, E=Eliminado';
comment on column telefono.tipo is 'PE=Personal, CE=Celular, HG=Hogar, TR=Trabajo';
comment on column telefono.idpersona is 'Es el identificador de la persona del telefono, puede ser de la tabla persona o empresa';
comment on column telefono.tipo_persona is 'Puede ser N=Natural o J=Juridica';

create table email( 
	id_email serial4 not null,
	tipo char(2),
	correo varchar(200),
	idpersona int,
	tipo_persona char(1),
	estado_reg char(1),
	constraint pk_email primary key(id_email)
);
comment on column email.estado_reg is 'Es el estado del registro V=vigente, E=Eliminado';
comment on column email.tipo is 'PE=Personal,  HG=Hogar, TR=Trabajo, OT=Otro';
comment on column email.idpersona is 'Es el identificador de la persona del telefono, puede ser de la tabla persona o empresa';
comment on column email.tipo_persona is 'Puede ser N=Natural o J=Juridica';


create table direccion( 
	id_direccion serial4 not null,
	calle varchar(60),
	numero_puerta varchar(5),
	zona varchar(60),
	ciudad varchar(40),
	cord point, 
	idpersona int,
	tipo_persona varchar(4), 
	estado_reg char(1),
	constraint pk_direccion primary key(id_direccion)
);
comment on column direccion.estado_reg is 'Es el estado del registro V=vigente, E=Eliminado';
comment on column direccion.idpersona is 'Es el identificador de la persona del telefono, puede ser de la tabla persona o empresa';
comment on column direccion.tipo_persona is 'Puede ser N=Natural o J=Juridica';

create table empresa( 
	id_empresa serial4 not null,
	nombre varchar(100),
	sigla varchar(10),
	nit varchar(12),
	fecha_reg timestamp default current_timestamp,
	usuario_reg varchar(20),
	ip_reg cidr,
	estado_reg char(1),
	constraint pk_empresa primary key(id_empresa)
);


create table servicio( 
	id_servicio serial4 not null,
	id_empresa int,
	id_jefe int,
	id_padre int,
	nombre varchar(40),
	tipo varchar(2),
	ubicacion varchar(200),
	fecha_reg timestamp default current_timestamp,
	usuario_reg varchar(20),
	ip_reg cidr,
	estado_reg char(1),
	constraint pk_servicio primary key (id_servicio),
	constraint fk_empresa foreign key(id_empresa) references public.empresa(id_empresa),
	constraint fk_jefe_servicio foreign key(id_jefe) references public.empleado(id_empleado),
	constraint fk_nodo_padre foreign key(id_padre) references public.servicio(id_servicio)
);

create table item( 
	id_item serial4 not null,
	id_servicio int,
	cargo varchar(20),
	tipo char(2), 
	salario_basico decimal(10, 3),
	fecha_reg timestamp default current_timestamp,
	usuario_reg varchar(20),
	ip_reg cidr,
	estado_reg char(1),
	constraint pk_item primary key (id_item),
	constraint fk_servicio_item foreign key(id_servicio) references public.servicio(id_servicio) 
);

create table acceso( 
	id_acceso serial4 not null,
	id_item int,
	nombre_acceso varchar(50),
	ruta varchar(200),
	fecha_reg timestamp default current_timestamp,
	usuario_reg varchar(20),
	ip_reg cidr,
	estado_reg char(1),
	constraint pk_acceso primary key(id_acceso),
	constraint fk_item_acceso foreign key(id_item) references public.item(id_item)
);
create table contrato(
	id_contrato serial4 not null,
	fecha date default current_date,
	id_item int,
	idempleado int,
	tipo_empleado char(1),
	fecha_inicio date,
	fecha_fin date,
	fecha_reg timestamp default current_timestamp,
	usuario_reg varchar(20),
	ip_reg cidr,
	estado_reg char(1),
	
	constraint pk_contrato primary key(id_contrato),
	constraint fk_item_contrato foreign key(id_item) references public.item(id_item)
);

create table usuario(
	id_usuario serial4 not null,
	nombre_usuario varchar(20),
	clave_usuario varchar(250),
	id_contrato int,
	fecha_reg timestamp default current_timestamp,
	usuario_reg varchar(20),
	ip_reg cidr,
	estado_reg char(1),
	
	constraint pk_usuario primary key(id_usuario),
	constraint fk_contrato_usuario foreign key(id_contrato) references public.contrato(id_contrato)
);

create table lista( 
	id_lista serial4 not null,
	codigo_texto char(2),
	grupo varchar(20),
	orden smallint,
	descripcion varchar(200),
	estado_reg char(1)
);




--constraint fk_persona_paciente foreign key(id_persona) references public.persona(id_persona)