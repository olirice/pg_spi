#include "postgres.h"

#include "executor/spi.h"
#include "utils/builtins.h"

PG_MODULE_MAGIC;

PG_FUNCTION_INFO_V1(execute_and_commit);

Datum
execute_and_commit(PG_FUNCTION_ARGS)
{
    char *command;

    // Read text argument
    command = text_to_cstring(PG_GETARG_TEXT_PP(0));

    // Connect to SPI enabling non-atomic
    SPI_connect_ext(1);

    // Execute the command, allowing any number of returned rows
    SPI_exec(command, 0);

    // Finsh txn
    SPI_finish();

    //release
    pfree(command);

    PG_RETURN_INT64(1);
}

PG_FUNCTION_INFO_V1(execute_and_rollback);

Datum
execute_and_rollback(PG_FUNCTION_ARGS)
{
    char *command;

    // Read text argument
    command = text_to_cstring(PG_GETARG_TEXT_PP(0));

    // Connect to SPI enabling non-atomic
    SPI_connect_ext(1);

    // Execute the command, allowing any number of returned rows
    SPI_exec(command, 0);

    // Rollback the transaction
    // THIS LINE RAISES AN EXCEPTION
    // ERROR:  portal snapshots (0) did not account for all active snapshots (1)
    // THROWN: https://doxygen.postgresql.org/portalmem_8c.html#adff1d814f372297d6531cb6c1f403dd6
    SPI_rollback_and_chain();

    // Finsh txn
    SPI_finish();

    //release
    pfree(command);

    PG_RETURN_INT64(1);
}
