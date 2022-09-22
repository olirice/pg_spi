EXTENSION = pg_spi
DATA = pg_spi--0.0.1.sql

PG_CONFIG = pg_config

MODULE_big = pg_spi
OBJS = src/lib.o

TESTS = $(wildcard test/sql/*.sql)
REGRESS = $(patsubst test/sql/%.sql,%,$(TESTS))
REGRESS_OPTS = --use-existing --inputdir=test

PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
