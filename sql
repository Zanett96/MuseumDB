CREATE TYPE categop AS enum ('scultura ', 'quadro ');

CREATE TABLE opera
  (
     codice    SMALLINT,
     dataf     SMALLINT,
     datai     SMALLINT,
     nome      VARCHAR (25),
     presente  BOOLEAN DEFAULT true,
     larghezza INTEGER NOT NULL,
     altezza   INTEGER NOT NULL,
     categoria CATEGOP NOT NULL,
     sala      SMALLINT NOT NULL,
     CHECK (codice >=0),
     CONSTRAINT datafineinizio CHECK (dataf >= datai ),
     CHECK ( larghezza >0),
     CHECK ( altezza >0),
     CHECK ( spessore >=0),
     CHECK (sala >0),
     FOREIGN KEY ( sala ) REFERENCES sala ( numero ) ON DELETE NO action ON
     UPDATE cascade,
     PRIMARY KEY ( codice )
  ); 
  
  
CREATE TABLE restauro
  (
     datair DATE,
     datafr DATE,
     descrr VARCHAR (1000),
     tipo   VARCHAR (40) NOT NULL,
     opera  SMALLINT NOT NULL,
     CONSTRAINT datafir CHECK (datafr > datair ),
     FOREIGN KEY ( opera ) REFERENCES opera ( codice ) ON DELETE no action ON
     UPDATE CASCADE,
     PRIMARY KEY (datair, opera )
  );

CREATE TABLE sala
  (
     numero     SMALLINT,
     superficie SMALLINT NOT NULL,
     CHECK (numero >0),
     CHECK ( superficie >0),
     PRIMARY KEY ( numero )
  );

CREATE TABLE tecnica
  (
     nome    VARCHAR (30),
     descrte VARCHAR (1000),
     PRIMARY KEY ( nome )
  ); 
  
CREATE TABLE realizzatacon
  (
     tecnica VARCHAR (30) NOT NULL,
     opera   SMALLINT NOT NULL,
     CHECK (opera >=0),
     FOREIGN KEY ( tecnica ) REFERENCES tecnica ( nome ) ON DELETE no action ON
     UPDATE CASCADE,
     FOREIGN KEY ( opera ) REFERENCES opera ( codice ) ON DELETE no action ON
     UPDATE CASCADE,
     PRIMARY KEY ( tecnica, opera )
  );

CREATE TABLE contiene
  (
     sala  SMALLINT NOT NULL,
     stile VARCHAR (30) NOT NULL,
     CHECK (sala >0),
     FOREIGN KEY ( sala ) REFERENCES sala ( numero ) ON DELETE no action ON
     UPDATE CASCADE,
     FOREIGN KEY ( stile ) REFERENCES stile ( nome ) ON DELETE no action ON
     UPDATE CASCADE,
     PRIMARY KEY(sala, stile )
  );

CREATE TABLE stile
  (
     nome   VARCHAR (30),
     descrs VARCHAR (1000),
     PRIMARY KEY( nome )
  );

CREATE TABLE materiale
  (
     nome VARCHAR (25),
     PRIMARY KEY( nome )
  ); 
  CREATE TABLE realizzatain
  (
     materiale VARCHAR (25),
     opera     SMALLINT,
     CHECK (opera >=0),
     FOREIGN KEY ( materiale ) REFERENCES materiale ( nome ) ON DELETE no action
     ON UPDATE CASCADE,
     FOREIGN KEY ( opera ) REFERENCES opera ( codice ) ON DELETE no action ON
     UPDATE CASCADE,
     PRIMARY KEY ( materiale, opera )
  );

CREATE TABLE elencoprestiti
  (
     dataip    DATE,
     opera     SMALLINT,
     datafp    DATE,
     ricevente VARCHAR (30) NOT NULL,
     CHECK (opera >=0),
     CONSTRAINT datafip CHECK (datafp > dataip ),
     FOREIGN KEY ( opera ) REFERENCES opera ( codice ) ON DELETE no action ON
     UPDATE CASCADE,
     PRIMARY KEY(dataip, opera )
  );

CREATE TABLE artista
  (
     codice       SMALLINT,
     nome         VARCHAR (35),
     datan        SMALLINT,
     datam        SMALLINT,
     nazionalità  VARCHAR (20),
     luogon       VARCHAR (20),
     luogom       VARCHAR (20),
     CHECK (codice >=0),
     PRIMARY KEY ( codice )
  );

CREATE TABLE creata
  (
     stile   VARCHAR (30),
     opera   SMALLINT,
     artista SMALLINT,
     CHECK (opera >=0),
     CHECK ( artista >=0),
     FOREIGN KEY ( stile ) REFERENCES stile ( nome ) ON DELETE no action ON
     UPDATE CASCADE,
     FOREIGN KEY ( opera ) REFERENCES opera ( codice ) ON DELETE no action ON
     UPDATE CASCADE,
     FOREIGN KEY ( artista ) REFERENCES artista ( codice ) ON DELETE no action
     ON UPDATE CASCADE,
     PRIMARY KEY (stile, opera, artista )
  ); 
  
  
CREATE TABLE lingua
  (
     nome VARCHAR (20),
     PRIMARY KEY( nome )
  );

CREATE TABLE guida
  (
     matr      SMALLINT,
     nome      VARCHAR (15) NOT NULL,
     cognome   VARCHAR (20) NOT NULL,
     datan     DATE NOT NULL,
     qualifica VARCHAR (100) NOT NULL,
     CHECK (matr >0),
     PRIMARY KEY ( matr )
  );

CREATE TABLE tour
  (
     nome   VARCHAR (20),
     prezzo SMALLINT NOT NULL,
     descrt VARCHAR (500),
     nmax   SMALLINT NOT NULL,
     lingua VARCHAR (20) NOT NULL,
     guida  SMALLINT NOT NULL,
     CHECK (prezzo >=0),
     CHECK (nmax >0),
     CHECK (guida >0),
     FOREIGN KEY ( lingua ) REFERENCES lingua ( nome ) ON DELETE NO action ON
     UPDATE cascade,
     FOREIGN KEY ( guida ) REFERENCES guida ( matr ) ON DELETE NO action ON
     UPDATE cascade,
     PRIMARY KEY ( nome )
  );

CREATE TYPE DAY AS enum ('lunedì', 'martedì', 'mercoledì', 'giovedì',
'venerdì', 'sabato', 'domenica');

CREATE TABLE orario
  (
     giorno DAY,
     orai   TIME [4],
     tour   VARCHAR (20),
     oraf   TIME [4] NOT NULL,
     CONSTRAINT orafio CHECK (oraf > orai ),
     FOREIGN KEY ( tour ) REFERENCES tour ( nome ) ON DELETE NO action ON UPDATE
     cascade,
     PRIMARY KEY (giorno, orai, tour )
  ); 
  
  CREATE TABLE parla
  (
     lingua VARCHAR (20),
     guida  SMALLINT,
     CHECK (guida >0),
     FOREIGN KEY ( lingua ) REFERENCES lingua ( nome ) ON DELETE no action ON
     UPDATE CASCADE,
     FOREIGN KEY ( guida ) REFERENCES guida ( matr ) ON DELETE no action ON
     UPDATE CASCADE,
     PRIMARY KEY (lingua, guida )
  );

CREATE TABLE riguardo
  (
     stile VARCHAR (30),
     tour  VARCHAR (20),
     FOREIGN KEY ( stile ) REFERENCES stile ( nome ) ON DELETE no action ON
     UPDATE CASCADE,
     FOREIGN KEY ( tour ) REFERENCES tour ( nome ) ON DELETE no action ON UPDATE
     CASCADE,
     PRIMARY KEY (stile, tour )
  ); 
