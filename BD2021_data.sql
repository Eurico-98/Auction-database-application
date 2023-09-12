/*
	Cria as tabelas
*/
CREATE TABLE leilao (
	id		 			BIGINT,
	titulo	 			VARCHAR(50) NOT NULL,
	descricao	 		VARCHAR(512) NOT NULL,
	preco_base	 		BIGINT NOT NULL,
	data_fim	 		TIMESTAMP NOT NULL,
	artigo	 			VARCHAR(20) NOT NULL,
	vencedor			VARCHAR(20),
	vendedor			VARCHAR(20),
	cancelado			BOOL,
	terminado			BOOL,
	data_de_criacao		TIMESTAMP NOT NULL,
	PRIMARY KEY(id)
);

CREATE TABLE utilizador (
	username 			VARCHAR(20),
	email	 			VARCHAR(20) NOT NULL,
	password 			VARCHAR(20) NOT NULL,
	admin	 			BOOL NOT NULL,
	banido	 			BOOL,
	PRIMARY KEY(username)
);

CREATE TABLE comentario (
	comentario			VARCHAR(512) NOT NULL,
	destinatario		VARCHAR(20),
	comentador	 		VARCHAR(20) NOT NULL,
	leilao				BIGINT
);

CREATE TABLE artigo (
	codigo		 		VARCHAR(20),
	descricao			VARCHAR(512) NOT NULL,
	utilizador	 		VARCHAR(20) NOT NULL,
	PRIMARY KEY(codigo)
);

CREATE TABLE licitacao (
	valor				BIGINT NOT NULL,
	utilizador	 		VARCHAR(20),
	leilao				BIGINT,
	invalida			BOOL,
	PRIMARY KEY(valor, leilao, utilizador)
);

CREATE TABLE notificacao (
	tipo_de_notificacao VARCHAR(1000) NOT NULL,
	leilao				BIGINT NOT NULL,
	destinatario	 	VARCHAR(20) NOT NULL,
	data_de_rececao		TIMESTAMP NOT NULL
);

CREATE TABLE autenticacao (
	token 				VARCHAR(26) NOT NULL,
	username			VARCHAR(20) NOT NULL,
	validade			TIMESTAMP NOT NULL
);

CREATE TABLE detalhes_anteriores (
	titulo 				VARCHAR(50) NOT NULL,
	descricao			VARCHAR(512) NOT NULL,
	versao_da_edicao	INTEGER NOT NULL,
	leilao				BIGINT NOT NULL,
	PRIMARY KEY(versao_da_edicao, leilao)
);

ALTER TABLE leilao 				ADD CONSTRAINT leilao_fk1 		  	   FOREIGN KEY (artigo) 		 REFERENCES artigo(codigo);
ALTER TABLE comentario 			ADD CONSTRAINT comentario_fk1 		   FOREIGN KEY (comentador) 	 REFERENCES utilizador(username);
ALTER TABLE comentario 			ADD CONSTRAINT comentario_fk2 		   FOREIGN KEY (leilao) 		 REFERENCES leilao(id);
ALTER TABLE artigo 				ADD CONSTRAINT artigo_fk1 		  	   FOREIGN KEY (utilizador) 	 REFERENCES utilizador(username);
ALTER TABLE licitacao 			ADD CONSTRAINT licitacao_fk1 		   FOREIGN KEY (utilizador) 	 REFERENCES utilizador(username);
ALTER TABLE licitacao 			ADD CONSTRAINT licitacao_fk2 		   FOREIGN KEY (leilao) 		 REFERENCES leilao(id);
ALTER TABLE notificacao 		ADD CONSTRAINT notificacao_fk1 		   FOREIGN KEY (destinatario) 	 REFERENCES utilizador(username);
ALTER TABLE detalhes_anteriores ADD CONSTRAINT detalhes_anteriores_fk1 FOREIGN KEY (leilao) 		 REFERENCES leilao(id);

/*
	inserir alguns dados para debug
*/
INSERT INTO utilizador (username, email, password, admin, banido) VALUES ('eurico', 'mail1', 'iyvmgs', true, false);
INSERT INTO utilizador (username, email, password, admin, banido) VALUES ('peasant', 'mail2', 'tiewerx', false, false);
INSERT INTO utilizador (username, email, password, admin, banido) VALUES ('carlos matos', 'mail3', 'fmxgsrrigx', false, false);
INSERT INTO utilizador (username, email, password, admin, banido) VALUES ('jorge jesus', 'mail4', 'nsvkirniwyw', false, false);
INSERT INTO utilizador (username, email, password, admin, banido) VALUES ('gustavo', 'mail5', 'fpyirwgviir', true, false);
INSERT INTO utilizador (username, email, password, admin, banido) VALUES ('J Het', 'mail6', 'Qixeppmge', true, false);


INSERT INTO artigo (codigo, descricao, utilizador) VALUES ('1', 'carro', 'eurico');
INSERT INTO artigo (codigo, descricao, utilizador) VALUES ('2', 'mota', 'peasant');
INSERT INTO artigo (codigo, descricao, utilizador) VALUES ('3', 'barco', 'carlos matos');
INSERT INTO artigo (codigo, descricao, utilizador) VALUES ('4', 'aviao', 'jorge jesus');
INSERT INTO artigo (codigo, descricao, utilizador) VALUES ('5', 'PC', 'gustavo');
INSERT INTO artigo (codigo, descricao, utilizador) VALUES ('1a', 'carro', 'eurico');
INSERT INTO artigo (codigo, descricao, utilizador) VALUES ('10', 'papel higienico', 'eurico');
INSERT INTO artigo (codigo, descricao, utilizador) VALUES ('11', 'maca', 'jorge jesus');
INSERT INTO artigo (codigo, descricao, utilizador) VALUES ('12', 'mosca', 'gustavo');


INSERT INTO leilao (id, titulo, descricao, preco_base, data_fim, artigo, cancelado, data_de_criacao, vendedor, terminado) VALUES (1, 'leilao1', 'descricao do leilao', 1000, '2021-1-10 10:10:10', '1', false, current_timestamp, 'eurico', false);
INSERT INTO leilao (id, titulo, descricao, preco_base, data_fim, artigo, cancelado, data_de_criacao, vendedor, terminado) VALUES (2, 'leilao2', 'descricao do leilao', 2000, '2021-7-20 20:10:10', '2', false, current_timestamp, 'peasant', false);
INSERT INTO leilao (id, titulo, descricao, preco_base, data_fim, artigo, cancelado, data_de_criacao, vendedor, terminado) VALUES (68, 'leilao3', 'vender legos', 2000, '2021-8-20 15:13:00', '1a', false, current_timestamp, 'eurico', false);
INSERT INTO leilao (id, titulo, descricao, preco_base, data_fim, artigo, cancelado, data_de_criacao, vendedor, terminado) VALUES (4, 'leilao5', 'vendo aviao de papel', 20000, '2021-6-20 15:13:00', '4', false, current_timestamp, 'jorge jesus', false);
INSERT INTO leilao (id, titulo, descricao, preco_base, data_fim, artigo, cancelado, data_de_criacao, vendedor, terminado) VALUES (6, 'leilao6', 'teste', 100, '2021-8-20 15:13:00', '10', false, current_timestamp, 'eurico', false);
INSERT INTO leilao (id, titulo, descricao, preco_base, data_fim, artigo, cancelado, data_de_criacao, vendedor, terminado) VALUES (3, 'leilao7', 'teste2', 1000, '2021-9-20 15:13:00', '11', false, current_timestamp, 'jorge jesus', false);
INSERT INTO leilao (id, titulo, descricao, preco_base, data_fim, artigo, cancelado, data_de_criacao, vendedor, terminado) VALUES (8, 'leilao8', 'teste3', 1008, '2021-3-20 15:13:00', '12', false, current_timestamp, 'gustavo', false);

INSERT INTO comentario (comentario, destinatario, comentador, leilao) VALUES ('preco muito alto', 'eurico', 'gustavo', 1);
INSERT INTO comentario (comentario, destinatario, comentador, leilao) VALUES ('aioke, levaste cum pau!?', 'eurico', 'jorge jesus', 1);
INSERT INTO comentario (comentario, destinatario, comentador, leilao) VALUES ('aceita bitcoin?', 'eurico', 'carlos matos', 68);
INSERT INTO comentario (comentario, destinatario, comentador, leilao) VALUES ('nao tenho dinheiro quero gratis!', 'eurico', 'peasant', 68);
INSERT INTO comentario (comentario, comentador, leilao) VALUES ('este artigo nao presta', 'eurico', 2);
INSERT INTO comentario (comentario, comentador, leilao) VALUES ('devia ser gratis', 'eurico', 2);

INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (5000, 'jorge jesus', 1, false);
INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (1001, 'gustavo', 1, false);
INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (1002, 'gustavo', 1, false);
INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (1003, 'gustavo', 1, false);
INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (2345, 'peasant', 1, false);
INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (6565, 'carlos matos', 1, false);
INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (30000, 'J Het', 1, false);

INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (30000, 'J Het', 68, false);
INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (6565, 'carlos matos', 68, false);
INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (7001, 'gustavo', 68, false);
INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (2345, 'peasant', 68, false);

INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (30000, 'J Het', 3, false);
INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (100001, 'eurico', 3, false);

INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (2001, 'carlos matos', 2, false);
INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (2003, 'gustavo', 2, false);
INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (2004, 'jorge jesus', 2, false);

INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (2001, 'carlos matos', 8, false);
INSERT INTO licitacao (valor, utilizador, leilao, invalida) VALUES (2001, 'carlos matos', 6, false);

-- validar existencia do username fornecido
create or replace function check_username(nome varchar) returns integer as
$$
	begin
		if exists(select username from utilizador where username = nome) then
			return (1);
		else
			return (0);
		end if;
	end;
$$ language plpgsql;

-- validar se password corresponde ao username fornecido
create or replace function login(nome varchar, pass varchar) returns integer as
$$
	declare
		banido_ bool;
	begin
		if exists(select username from utilizador where username = nome and password = pass) then
			
			-- verifica se o utilizador esta banido
			select banido into banido_ from utilizador where username = nome;
			if(banido_ = true) then
				return (-1);
			else
				return (1);
			end if;
		else
			return (0);
		end if;
	end;
$$ language plpgsql;

-- verificar se o utilizador ja tem um token de login ainda valido 
create or replace function autentica(nome varchar) returns varchar as
$$
	begin

		-- primeiro verificar se o utilizador ja esta logado
		if exists(select username from autenticacao where username = nome) then
			
			-- se ja estiver loggado verificar se o seu token ainda e valido
			if exists(select token from autenticacao where validade > current_timestamp) then

				-- se ainda for valido o token devolve-o
				return concat(nome, '-token');
			
			-- se ja nao for valido apaga a linha correspondente da tabela de autenticacao e devolve -1
			else
				delete from autenticacao where username = nome;
				return ('-1');
			end if;
		else
			return ('0');
		end if;
	end;
$$ language plpgsql;

--  verificar se o token e valido
create or replace function verifica_token(token_ varchar) returns varchar as
$$
	declare
		nome autenticacao.username%type;
		banido_ bool;
	begin
		if exists(select token from autenticacao where token = token_ and validade > current_timestamp) then
			select username into nome from autenticacao where token = token_;
			return (nome);
		else
			return ('0');
		end if;
	end;
$$ language plpgsql;

-- verificar se o codigo inserido ja existe ou nao
create or replace function verifica_codigo(codigo_ varchar) returns integer as
$$
	declare
	begin
		if exists(select codigo from artigo where codigo = codigo_) then
			return (0);
		else
			return (1);
		end if;
	end;
$$ language plpgsql;

-- verificar se o utilizador pode leiloar o artigo que esta a tentar leiloar
create or replace function verifica_artigo(nome varchar, artigo_id varchar) returns BIGINT as
$$
	declare
		leilao_id leilao.id%type;
	begin
		-- verificar se o user e o dono do artigo
		if exists(select 1 from artigo where codigo = artigo_id and utilizador = nome) then

			-- verificar se o artigo nao esta a ser vendido noutro leilao 
			select id into leilao_id from leilao where artigo = artigo_id;

			-- se ja esta a ser vendido devolve o id deesse leilao
			if(leilao_id <> 0) then
				return (leilao_id);

			-- se nao devolve 1
			else
				return (0);
			end if;

		-- se nao for dono devolve 0
		else
			return (-1);
		end if;
	end;
$$ language plpgsql;

-- verificar se o utilizador nao esta a licitar um valor invalido
create or replace function licitar(leilao_id bigint, licitacao_ bigint, nome varchar) returns varchar as
$$
	declare
		artigo_leiloado artigo.codigo%type;
		licitacao_mais_alta licitacao.valor%type;
		preco_min leilao.preco_base%type;
		valor_ varchar;
		best_user varchar;
	begin

		-- verificar se o leilao existe e se ainda esta a decorrer
		if exists (select 1 from leilao where id = leilao_id and data_fim > date_trunc('day',current_timestamp)) then
			
			-- verificar se o utilizador nao e o vendedor do leilao
			select artigo into artigo_leiloado from leilao  where id = leilao_id;

			if exists (select 1 from artigo where codigo = artigo_leiloado and utilizador = nome) then
				return ('Nao pode licitar no seu proprio leilao!');
			else

				-- verificar se a sua licitacao e superior ao preco base
				select preco_base into preco_min from leilao where id = leilao_id;

				if(licitacao_ > preco_min) then

					-- verificar se ja existe alguma licitacao
					if exists(select valor from licitacao where leilao = leilao_id) then
					
						-- se existir ir buscar a mais alta 
						select max(valor) into licitacao_mais_alta from licitacao where leilao = leilao_id;

						-- ir buscar o utilizador que a efetuou
						select utilizador into best_user from licitacao where valor = licitacao_mais_alta;
			
						-- se a licitacao mais elevada ja pertencer ao user nao deixa licitar novamente
						if(best_user <> nome) then

							-- verificar se a licitacao e superior a licitacao mais alta
							if(licitacao_ <= licitacao_mais_alta) then

								valor_ = cast (licitacao_mais_alta as varchar);
								return (concat('O valor da licitacao tem de ser superior a licitacao mais alta: ', valor_));
							else
								return ('Licitacao efetuada!');
							end if;
						else
							return ('A licitacao mais alta ja e a sua!');			
						end if;
					
					-- se nao existir nenhuma licitacao ainda entao efetua a licitacao do user
					else
						return ('Licitacao efetuada!');
					end if;
				else
					valor_ = cast (preco_min as varchar);
					return (concat('O valor da licitacao tem de ser superior ao preco base: ', valor_));
				end if;
			end if;
		else
			return ('O leilao selecionado nao esta activo!');
		end if;
	end;

$$ language plpgsql;

-- notificar o utilizador que tinha a licitacao mais alta que ja foi ultrapassada
create or replace function notificar_licitacao_ultrapassada() returns trigger as
$$
	declare
		old_best_user varchar;
		old_max bigint;
	begin
		if exists(select valor from licitacao where leilao = new.leilao and utilizador <> new.utilizador) then
			select max(valor) into old_max from licitacao where leilao = new.leilao and utilizador <> new.utilizador;
			select utilizador into old_best_user from licitacao where valor = old_max;
			insert into notificacao (tipo_de_notificacao, destinatario, leilao, data_de_rececao) values ('Licitacao ultrapassada', old_best_user, new.leilao, current_timestamp);
		end if;
		return new;
	end;

$$ language plpgsql;
create trigger notifica_1 after insert on licitacao for each row execute procedure notificar_licitacao_ultrapassada();

-- verificar se o utilizador e o dono do leilao que esta a tentar editar / terminar e se o leilao nao foi terminado
create or replace function verifica_dono(nome varchar, leilao_id bigint) returns integer as
$$
	declare
		artigo_id artigo.codigo%type;
		vendedor artigo.utilizador%type;
	begin
		if exists (select 1 from leilao where id = leilao_id and terminado = false) then
			
			select artigo into artigo_id from leilao where id = leilao_id;
			select utilizador into vendedor from artigo where codigo = artigo_id;
			if(vendedor = nome) then
				return (1);
			else
				return (0);
			end if;
		else
			return (-1);
		end if;
	end;
$$ language plpgsql;

-- guardar as versoes anteriores dos detalhes do leilao
create or replace function guardar_detalhes_antigos() returns trigger as
$$
	declare
		old_titulo varchar;
		old_descricao varchar;
		versao_ detalhes_anteriores.versao_da_edicao%type;
	begin

		-- obter titulo descricao e versao anterior do leilao
		select titulo into old_titulo from leilao where id = old.id;
		select descricao into old_descricao from leilao where id = old.id;
		
		if exists( select versao_da_edicao from detalhes_anteriores where leilao = old.id) then
			select max(versao_da_edicao) into versao_ from detalhes_anteriores where leilao = old.id;
			versao_ = versao_ + 1;
		else
			versao_ = 1;
		end if;

		insert into detalhes_anteriores (titulo, descricao, versao_da_edicao, leilao) values (old_titulo, old_descricao, versao_, old.id);
		return new;
	end;

$$ language plpgsql;
create trigger guardar_detalhes before update of titulo, descricao on leilao for each row execute procedure guardar_detalhes_antigos();

--  esta funcao devolve o utilizador que fez a licitacao mais alta se existir
create or replace function devolve_vencedor(leilao_id bigint) returns varchar as
$$
	declare
		vencedor_ leilao.vencedor%type;
		licitacao_ licitacao.valor%type;
	begin
		-- se existir pelo menos uma licitacao ver qual a maior seleciona-a e devolve esse valor
		if exists(select valor from licitacao where leilao = leilao_id and invalida = false) then
			select max(valor) into licitacao_ from licitacao where leilao = leilao_id;

			select utilizador into vencedor_ from licitacao where valor = licitacao_;
			return vencedor_;
		
		-- se nao existir devolve 'isto'
		else
			return 'nao ha licitacoes';
		end if;
	end;
$$ language plpgsql;

-- notificar os utilizadores de mensagens publicadas no mural do leilao onde escreveram tambem mensagens
create or replace function notificar_mensagem_recebida() returns trigger as
$$
	declare
		comentadores cursor for select distinct comentador from comentario where leilao = new.leilao;
		vendedor_ utilizador.username%type;
		artigo_ leilao.artigo%type;
		banido_ utilizador.banido%type;
	begin

		-- buscar o vendedor do leilao em causa
		select artigo into artigo_ from leilao where id = new.leilao;
		select utilizador into vendedor_ from artigo where codigo = artigo_;

		-- para cada comentador obtido com o cursor notifica-lo se nao for o vendedor
		for destinatario_ in comentadores loop
			select banido into banido_ from utilizador where username = destinatario_.comentador;
			if(destinatario_.comentador <> vendedor_ and destinatario_.comentador <> new.comentador and banido_ = false) then
				insert into notificacao (tipo_de_notificacao, destinatario, leilao, data_de_rececao) values (concat('Nova mensagem no leilao ', new.leilao), destinatario_.comentador, new.leilao, current_timestamp);
			end if;
		end loop;

		-- notificar o vendedor
		if(vendedor_ <> new.comentador) then
			insert into notificacao (tipo_de_notificacao, destinatario, leilao, data_de_rececao) values (concat('Nova mensagem no leilao ', new.leilao), vendedor_, new.leilao, current_timestamp);
		end if;

		return new;
	end;

$$ language plpgsql;
create trigger notifica_2 after insert on comentario for each row execute procedure notificar_mensagem_recebida();

-- verificar se o utilizador e admin
create or replace function verifica_admin(nome varchar) returns integer as
$$
	begin
		if exists(select username from utilizador where username = nome and admin = true) then
			return (1);
		else
			return (0);
		end if;
	end;
$$ language plpgsql;

-- verificar se o leilao esta cancelado
create or replace function verifica_cancelado(leilao_id bigint) returns integer as
$$
	begin
		if exists(select id from leilao where id = leilao_id and cancelado = true) then
			return (1);
		else
			return (0);
		end if;
	end;
$$ language plpgsql;

-- notificar os participantes de um leilao de que foi cancelado
create or replace function notificar_leilao_cancelado() returns trigger as
$$
	declare
		-- obter todos os utilizadores que participaram como licitadores e ou comentadores no leilao
		comentadores cursor for select distinct comentador from comentario where leilao = new.id;
		licitadores cursor for select distinct utilizador from licitacao where leilao = new.id;
		vendedor_ utilizador.username%type;
		artigo_ leilao.artigo%type;
		aux integer;
	begin

		-- buscar o vendedor do leilao em causa
		select artigo into artigo_ from leilao where id = new.id;
		select utilizador into vendedor_ from artigo where codigo = artigo_;

		-- eviar todas as notificacoes
		for participante in comentadores loop

			if(participante.comentador <> vendedor_) then
				insert into notificacao (tipo_de_notificacao, destinatario, leilao, data_de_rececao) values (concat('Leilao ', new.id, ' cancelado'), participante.comentador, new.id, current_timestamp);
			end if;
		end loop;

		for participante in licitadores loop

			-- verificar se ja foi notificado ou nao
			if exists(select destinatario from notificacao where destinatario = participante.utilizador and leilao = new.id and tipo_de_notificacao = concat('Leilao ', new.id, ' cancelado')) then
				aux := 0;
			else
				if(participante.utilizador <> vendedor_) then
					insert into notificacao (tipo_de_notificacao, destinatario, leilao, data_de_rececao) values (concat('Leilao ', new.id, ' cancelado'), participante.utilizador, new.id, current_timestamp);
				end if;
			end if;
		end loop;

		-- notificar o vendedor
		insert into notificacao (tipo_de_notificacao, destinatario, leilao, data_de_rececao) values (concat('Leilao ', new.id, ' cancelado'), vendedor_, new.id, current_timestamp);
		return new;
	end;

$$ language plpgsql;
create trigger notifica_3 after update of cancelado on leilao for each row execute procedure notificar_leilao_cancelado();

create or replace function cancela_leilao() returns trigger as
$$
	declare
		artigos cursor for select codigo from artigo where utilizador = new.username for update;
	begin

		for i in artigos loop
			update leilao set cancelado = true where artigo = i.codigo and cancelado = false;
		end loop;

		return new;
	end;

$$ language plpgsql;
create trigger cancelar after update of banido on utilizador for each row execute procedure cancela_leilao();

create or replace function invalidar_licitacoes() returns trigger as
$$
	declare
		-- ir buscar todas as licitacoes feitas pelo utilizador
		licitacoes_ cursor for select valor from licitacao where utilizador = new.username for update;

		-- ir buscar todos os leiloes distintos onde o utilizador licitou
		leiloes_ cursor for select distinct leilao from licitacao where utilizador = new.username;

		-- buscar todos os licitadores de todos os leiloes
		licitadores_gloais cursor for select distinct utilizador, leilao from licitacao where utilizador <> new.username;

		max_banido licitacao.valor%type;
		max_licitacao licitacao.valor%type;
		max_utilizador licitacao.utilizador%type;
	begin

		-- ivalidar todas as licitacoes do utilizador banido
		for i in licitacoes_ loop
			update licitacao set invalida = true where valor = i.valor;
		end loop;

		-- para cada leilao onde ele licitou
		for l in leiloes_ loop

			-- ir buscar a licitacao mais alta do utilizador banido
			select max(valor) into max_banido from licitacao where leilao = l.leilao and utilizador = new.username;

			-- ir buscar a licitacao mais alta do leilao e o respetivo licitador
			select max(valor) into max_licitacao from licitacao where leilao = l.leilao;
			select utilizador into max_utilizador from licitacao where leilao = l.leilao and valor = max_licitacao;

			-- se a licitacao mais alta do leilao nao for a do utilizador banido
			if(max_utilizador <> new.username) then

				-- ivalidar todas as licitacoes superiores a max_banido exceto licitacao mais alta
				update licitacao set invalida = true where leilao = l.leilao and valor > max_banido and valor < max_licitacao;

				-- atualizar o valor da licitacao mais alta que nao pertence ao utilizador banido
				update licitacao set valor = max_banido where leilao = l.leilao and valor = max_licitacao;
			end if;

			-- escrever a mensagem no mural
			insert into comentario (comentario, comentador, leilao) values ('Altercoes nas licitacoes efetuadas!', new.username, l.leilao);
		end loop;

		-- como o trigger que notifica todos os utilizadores que escreveram no mural so notifica esses mesmos e preciso notificar os que licitaram tabmem
		for j in licitadores_gloais loop

			-- se ainda nao existir uma notificacao na tabela de notificaoes para o licitador de que houve alteracoesntifica-o
			if exists(select destinatario from notificacao where leilao = j.leilao and destinatario = j.utilizador) then
				max_banido := 0;
			else
				insert into notificacao (tipo_de_notificacao, destinatario, leilao, data_de_rececao) values (concat('Nova mensagem no leilao ', j.leilao), j.utilizador, j.leilao, current_timestamp);
			end if;

		end loop;

		-- apagar todas as notificacoes do utilizador banido
		delete from notificacao where destinatario = new.username;
		return new;
	end;

$$ language plpgsql;
create trigger invalidar after update of banido on utilizador for each row execute procedure invalidar_licitacoes();

-- atualizar os vencedores dos leiloes terminados
create or replace function atualiza_vencedores() returns void as
$$
	declare
		leiloes_terminados cursor for select id from leilao where data_fim < date_trunc('day',current_timestamp) for update;
		vencedor_ leilao.vencedor%type;
		licitacao_ licitacao.valor%type;
	begin

		for i in leiloes_terminados loop

			-- se existir pelo menos uma licitacao valida ver qual a maior seleciona-a
			if exists(select valor from licitacao where leilao = i.id and invalida = false) then
				
				select max(valor) into licitacao_ from licitacao where leilao = i.id;

				-- buscar o utilizador que fez a licitacao valida mais alta
				select utilizador into vencedor_ from licitacao where valor = licitacao_;
				
				update leilao set vencedor = vencedor_ where id = i.id;
				
			end if;
		end loop;
	end;
$$ language plpgsql;

\set AUTOCOMMIT off