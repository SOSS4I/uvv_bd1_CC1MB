-- Remover database 
DROP DATABASE IF EXISTS uvv;

-- REMOVER USUARIO joao_vitor_sossai
drop role if exists joao_vitor_sossai;

-- REMOVER SCHEMA lojas
DROP schema if exists lojas;




-- CRIAR USUARIO
create user joao_vitor_sossai with createdb createrole encrypted password '1987';

 

-- CRIAR DATABASE uvv
CREATE DATABASE uvv
  OWNER joao_vitor_sossai
  TEMPLATE template0
  ENCODING 'UTF8'
  LC_COLLATE 'pt_BR.UTF-8'
  LC_CTYPE 'pt_BR.UTF-8'
  allow_connections true;

  

COMMENT on database uvv is 'Banco de Dados lojas uvv';
 
 --CONECTAR NO BANCO DE DADOS UVV COMO caio_silva

\c "dbname=uvv user=joao_vitor_sossai password=1987"


-- CRIAR SCHEMA 
CREATE SCHEMA lojas AUTHORIZATION joao_vitor_sossai;
SET SEARCH_PATH TO lojas, "$user", public;


-- DAR PERMISSÃO
GRANT ALL PRIVILEGES ON DATABASE uvv TO joao_vitor_sossai;

-- CRIAÇÃO DA TABELA PRODUTOS
CREATE TABLE Produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome_produtos VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem_produtos BYTEA,
                mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT pk_produtos PRIMARY KEY (produto_id)
);
COMMENT ON TABLE Produtos IS 'Tabela que armazena as informações dos produtos ';
COMMENT ON COLUMN Produtos.produto_id IS 'id dos produtos';
COMMENT ON COLUMN Produtos.nome_produtos IS 'armazena o nome dos produtos';
COMMENT ON COLUMN Produtos.preco_unitario IS 'Detalhes';
COMMENT ON COLUMN Produtos.detalhes IS 'Detalhes dos produtos';
COMMENT ON COLUMN Produtos.imagem_produtos IS 'imagens dos produtos';
COMMENT ON COLUMN Produtos.mime_type IS 'tipo de arquivo da imagem';
COMMENT ON COLUMN Produtos.imagem_arquivo IS 'arquivo da imagem';
COMMENT ON COLUMN Produtos.imagem_charset IS 'charset das imagens';
COMMENT ON COLUMN Produtos.imagem_ultima_atualizacao IS 'data da ultima atualizacao da imagem';

-- CRIAÇÃO DA TABELA LOJAS
CREATE TABLE Lojas (
                loja_id NUMERIC(38) NOT NULL,
                Nome VARCHAR(255) NOT NULL,
                endereco_fisico VARCHAR(512),
                endereco_web VARCHAR(100),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT pk_lojas PRIMARY KEY (loja_id)
);
COMMENT ON TABLE Lojas IS 'Esta é a tabela que armazena as informações das lojas';
COMMENT ON COLUMN Lojas.loja_id IS 'id das lojas';
COMMENT ON COLUMN Lojas.Nome IS 'nome das lojas';
COMMENT ON COLUMN Lojas.endereco_fisico IS 'endereço das lojas';
COMMENT ON COLUMN Lojas.endereco_web IS 'site das lojas';
COMMENT ON COLUMN Lojas.latitude IS 'latitude das lojas';
COMMENT ON COLUMN Lojas.longitude IS 'longitude das lojas';
COMMENT ON COLUMN Lojas.logo IS 'logo das lojas';
COMMENT ON COLUMN Lojas.logo_mime_type IS 'tipo de arquivo da logo';
COMMENT ON COLUMN Lojas.logo_arquivo IS 'arquivo da logo';
COMMENT ON COLUMN Lojas.logo_charset IS 'charset da logo';
COMMENT ON COLUMN Lojas.logo_ultima_atualizacao IS 'data da ultima atualização da logo';

-- CRIAÇÃO DA TABELA ESTOQUES
CREATE TABLE Estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_estoques PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE Estoques IS 'Esta Tabela armazena as informações sobre o estoque dos produtos';
COMMENT ON COLUMN Estoques.estoque_id IS 'id do estoque';
COMMENT ON COLUMN Estoques.loja_id IS 'id das lojas';
COMMENT ON COLUMN Estoques.quantidade IS 'quantidade dos produtos que estão no estoque';
COMMENT ON COLUMN Estoques.produto_id IS 'id dos produtos';

-- CRIAÇÃO DA TABELA CLIENTES
CREATE TABLE Clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT pk_clientes PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE Clientes IS 'Esta é a tabela para armazenar os dados de todos os clientes';
COMMENT ON COLUMN Clientes.cliente_id IS 'coluna sobre os id dos clientes';
COMMENT ON COLUMN Clientes.email IS 'email dos clientes';
COMMENT ON COLUMN Clientes.nome IS 'nome dos clientes';
COMMENT ON COLUMN Clientes.telefone1 IS 'numeros de telefone dos clientes';
COMMENT ON COLUMN Clientes.telefone2 IS 'outro numero de telefone dos clientes';
COMMENT ON COLUMN Clientes.telefone3 IS 'numero alternativo de telefone dos clientes';

-- CRIAÇÃO DA TABELA ENVIOS
CREATE TABLE Envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT pk_envios PRIMARY KEY (envio_id)
);
COMMENT ON TABLE Envios IS 'Esta é a tabela que armazena informações dos envios';
COMMENT ON COLUMN Envios.envio_id IS 'id do envio';
COMMENT ON COLUMN Envios.loja_id IS 'id das lojas';
COMMENT ON COLUMN Envios.cliente_id IS 'coluna sobre os id dos clientes';
COMMENT ON COLUMN Envios.endereco_entrega IS 'endereço de entrega';
COMMENT ON COLUMN Envios.status IS 'status do envio';

-- CRIAÇÃO DA TABELA PEDIDOS
CREATE TABLE Pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                status VARCHAR(15) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pk_pedidos PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE Pedidos IS 'Esta é a tabela que armazena todos os pedidos, das lojas';
COMMENT ON COLUMN Pedidos.pedido_id IS 'id dos pedidos';
COMMENT ON COLUMN Pedidos.data_hora IS 'data e hora em que os pedidos foram realizados';
COMMENT ON COLUMN Pedidos.status IS 'status dos pedidos';
COMMENT ON COLUMN Pedidos.cliente_id IS 'coluna sobre os id dos clientes';
COMMENT ON COLUMN Pedidos.loja_id IS 'id das lojas';

-- CRIAÇÃO DA TABELA PEDIDOS_ITENS
CREATE TABLE pedidos_itens (
                produto_id NUMERIC(38) NOT NULL,
                pedido_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pk_pedidos_itens PRIMARY KEY (produto_id, pedido_id)
);
COMMENT ON TABLE pedidos_itens IS 'itens dos pedidos';
COMMENT ON COLUMN pedidos_itens.produto_id IS 'id dos produtos';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 'id dos pedidos';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'numero da linha dos items do pedido';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'preco dos items';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'id do envio';

-- CRIAÇÃO DAS PKS E FKS
ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES Produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES Produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES Clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES Clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES Envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES Pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
-- CONSTRAINTS DE CHECAGEM
alter table pedidos add constraint check_status_pedidos
check (status in ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

alter table envios add constraint check_status_envios
check (status in ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

ALTER TABLE lojas
ADD CONSTRAINT check_enderecos
CHECK ((endereco_fisico IS NOT NULL AND endereco_web IS NULL) OR
       (endereco_fisico IS NULL AND endereco_web IS NOT NULL));

      
ALTER TABLE produtos
add constraint check_preco
CHECK (preco_unitario >= 0);

ALTER TABLE Estoques
ADD CONSTRAINT check_quantidade_estoques
CHECK (quantidade >= 0);

ALTER TABLE pedidos_itens
ADD CONSTRAINT check_quantidade_pedidos_itens
CHECK (quantidade >= 0);