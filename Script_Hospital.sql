#CRIANDO DATABASE#

create database Fast_DESAFIO_2

#CRIANDO AS TABELAS#

create table if not exists `Exames`(
`ID_Numero` int,
`Descricao` varchar(500) not null,
`Nome` varchar(100) not null,
`Preparo` varchar(200) not null,
primary key (`ID_Numero`)
)

create table if not exists `Hospital` (
`ID_Hospital` int,
`CNPJ` int,
`Nome` varchar(200),
`ID_MedicoChefe` int,
primary key (`ID_Hospital`)
)

#TABELAS COM CHAVE ESTRANGEIRAS#

create table if not exists `Medicos` (
`ID_Matricula` int,
`CRM` int,
`Nome` varchar(200) not null,
`Especialidade` varchar(200) not null,
`Rua` varchar(200) not null,
`Numero` int not null,
`Bairro` varchar(200) not null,
`ID_HospitalAlocado` int,
primary key (`ID_Matricula`),
foreign key (`ID_HospitalAlocado`) references `Hospital`(`ID_Hospital`)
)

create table if not exists `Paciente`(
`CPF` int,
`Nome` varchar(200) not null,
`Telefone` int not null,
`Telefone_Celular` int,
`Data_Nascimento` date not null,
`Tipo_Sangue` varchar(5) not null,
`Numero_Prontuario` int not null,
`Data_Atendimento` date,
`ID_MedicoAcompanhante` int,
`ID_ExameDoPaciente` int,
`ID_HospitalDoPaciente` int,
primary key (`CPF`),
foreign key (`ID_MedicoAcompanhante`) references `Medicos`(`ID_Matricula`),
foreign key (`ID_ExameDoPaciente`) references `Exames` (`ID_Numero`),
foreign key (`ID_HospitalDoPaciente`) references `Hospital` (`ID_Hospital`)
)

# INSERINDO DADOS NA TABELA

insert into Exames (ID_Numero, Descricao, Nome, Preparo) values (001, "Uma endoscopia é um procedimento usado na medicina para olhar dentro do corpo. O procedimento de endoscopia usa um endoscópio para examinar o interior de um órgão oco ou cavidade corporal.", "Endoscopia", "Jejum alimentar de 8 horas."),
(002, "A colonoscopia é um exame que avalia o intestino grosso e a parte final do intestino delgado.", "Colonoscopia", "Jeju alimentar de 12 horas."),
(003, "Hemograma é um exame que avalia as células sanguíneas de um paciente, ou seja, as da série branca e vermelha, contagem de plaquetas, reticulócitos e índices hematológicos.", "Hemograma", "Não é necessário jejum."),
(004, "Radiografia é uma técnica de exame de imagem que utiliza raios X para ver um material cuja composição não é uniforme como o corpo humano.", "Raio X", "Não é necessário jejum."),
(005, "A glicemia é a concentração de glicose no sangue ou mais precisamente no plasma.", "Glicemia", "Jejum alimentar de 12 horas.");

insert into Hospital(ID_Hospital, CNPJ, Nome, ID_MedicoChefe) values (001, 12971000, "Hospital do Amor", 020),
(002, 98670000, "Cuidar da Vida", 013),
(003, 13776000, "Hospital Cuidando das Pessoas", 006),
(004, 29843000, "Laboratório Unidade de Saúde", 010),
(005, 11095000, "Exames e Laboratório Unidade da Vida", 015);

insert into Medicos(ID_Matricula, CRM, Nome, Especialidade, Rua, Numero, Bairro, ID_HospitalAlocado) values(333435, 98765, "Felipe da Silva", "Cardiologista", "Rua dos Bobos", 0, "Springfield", 004),
(324675, 23457, "Julianny Ferreira", "Neurologista", "Rua Eterna", 45, "Novo", 002),
(234567, 12345, "Carlos Andrade", "Ortopedista", "Rua dos Ossos", 23, "Tancredo Neves", 001),
(317865, 85643, "Joana Brasil", "Otorrinolaringologista", "Rua dos Falantes", 76, "Rua dos Médicos", 003);

# INSERINDO PACIENTES QUE SÓ VÃO FAZER EXAMES

insert into Paciente(CPF, Nome, Telefone, Telefone_Celular, Data_Nascimento, Tipo_Sangue, Numero_Prontuario, Data_Atendimento, ID_ExameDoPaciente, ID_HospitalDoPaciente) values (14168426, "Marcelo Costa", 22221111, 888772233, "1980-12-01", "A", 234, "2023-08-06", 003, 005),
(16015841, "Filipina Felipa", 22345500, 878782456, "2000-03-04", "AB", 233, "2023-01-07", 002, 001),
(86247416, "Carlota Joaquina", 111112222, 876540123, "1990-10-02", "B", 102, "2023-04-05", 001, 002);

# INSERINDO PACIENTES SÓ COM CONSULTA MÉDICA

insert into Paciente(CPF, Nome, Telefone, Telefone_Celular, Data_Nascimento, Tipo_Sangue, Numero_Prontuario, Data_Atendimento, ID_MedicoAcompanhante, ID_HospitalDoPaciente) values (57157546, "Carolina Ferreira", 222324455, 765458990, "1992-02-03", "AB", 333, "2023-03-04", 234567, 003),
(87452464, "José Carlos", 345552333, 899906565, "1983-05-06", "B", 122, "2023-11-03", 324675, 001);

# INSERINDO PACIENTES COM CONSULTA MÉDICA E EXAME NO MESMO DIA

insert into Paciente(CPF, Nome, Telefone, Telefone_Celular, Data_Nascimento, Tipo_Sangue, Numero_Prontuario, Data_Atendimento, ID_MedicoAcompanhante, ID_ExameDoPaciente, ID_HospitalDoPaciente) values (45411676, "Maria da Graça", 34222000, 765458909, "1970-04-11", "A", 789, "2023-01-03", 317865, 005, 001);

# SELEÇÃO DE DADOS EM UMA TABELA

select Nome, Data_Atendimento, ID_ExameDoPaciente from Paciente;

select * from Hospital where ID_MedicoChefe = 015;

select distinct m.CRM, m.Nome, m.Especialidade from Medicos m;

# OR/AND

select distinct p.Nome, p.Tipo_Sangue from Paciente p where p.Nome like "José%" or p.Nome like "Felipa%";

select distinct p.Nome, p.Tipo_Sangue from Paciente p where p.Nome like "José%" or p.Nome like "%Felipa";

select distinct p.Nome, p.Tipo_Sangue from Paciente p where p.Nome like "José%" and p.Nome like "%Felipa";

# IN

select distinct e.ID_Numero, e.Nome, e.Descricao from Exames e where e.nome in ("Endoscopia", "Colonoscopia");

# INNER JOIN

select p.Nome, p.Tipo_Sangue, e.Descricao, e.Nome from Paciente p inner join Exames e on p.ID_ExameDoPaciente = e.ID_Numero;

select m.ID_Matricula, m.Nome, m.Especialidade, h.ID_Hospital, h.Nome, h.ID_MedicoChefe from Medicos m inner join Hospital h on m.ID_HospitalAlocado  = h.ID_Hospital;

# COUNT

select * from exames e;

select count(ID_ExameDoPaciente) as "Quantidade de Exames", p.Nome from paciente p group by p.Nome;

# UPDATE
# Assim, o ideial é que você indique o registro da tabela que deseja atualizar, conforme mostra abaixo.

update paciente set Nome = "José Carlos Albino" where CPF = 87452464;

select Nome from paciente p where CPF = 87452464;

# DELETE 
# O comando delete nunca deve ser utilizado sem a clasula WHERE. Caso contrário, irá deletar todos os registros da tabela. Sempre que você deseja apagar um registro, provalvelmente quer apagar um em espeficio. Assim, sempre é importante usar o WHERE, conforme o exemplo abaixo.

delete from Paciente where CPF = 16015841;

select * from Paciente;
