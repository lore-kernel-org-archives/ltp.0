From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 29 Mar 2021 19:56:50 +0200
Subject: [LTP] [PATCH 1/2] pec: Convert to the new API
In-Reply-To: <20210315092844.991073-1-lkml@jv-coder.de>
References: <20210315092844.991073-1-lkml@jv-coder.de>
Message-ID: <YGIU4uDm68QSXEk5@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

> +++ b/testcases/kernel/connectors/pec/cn_pec.sh
...
> +	# Run with absolute path, so the generator can exec itself
> +	generator="$(command -v event_generator)"
> +	"$generator" -n $NUM_EVENTS -e $event >gen_$event.log 2>gen_$event.err
> +	gen_rc=$?
...
I suggest to use "p" exec family - event_generator will be always installed into
$LTPROOT/testcases/bin => drop command. And for development (running without
make install), there should be always also test directory in PATH.

> +++ b/testcases/kernel/connectors/pec/event_generator.c
...
> -#include "test.h"
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"

> -	execv(exec_argv[0], exec_argv);
> +	/* Note: This expects the full path to self in exec_argv[0]! */
> +	SAFE_EXECV(exec_argv[0], exec_argv);
We don't have this yet. But I've sent patch [1] which adds SAFE_EXECVP()
because of expecting command to be in PATH.

There are more changes suggested:
* use ROD where possible (cannot be used for wait, because it's not a binary but
  a shell command)
* remove useless exit 0
* add missing local

The rest LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20210329174135.23890-1-pvorel@suse.cz/

--- testcases/kernel/connectors/pec/cn_pec.sh
+++ testcases/kernel/connectors/pec/cn_pec.sh
@@ -23,7 +23,6 @@ setup()
 {
 	if ! grep -q cn_proc /proc/net/connector; then
 		tst_brk TCONF "Process Event Connector is not supported or kernel is below 2.6.26"
-		exit 0;
 	fi
 
 	tst_res TINFO "Test process events connector"
@@ -32,15 +31,15 @@ setup()
 test()
 {
 	local event=$2
-	pec_listener >lis_$event.log 2>lis_$event.err &
+	local expected_events pid
+
+	ROD pec_listener \>lis_$event.log 2\>lis_$event.err &
 	pid=$!
 	# Wait for pec_listener to start listening
 	tst_sleep 100ms
 
-	# Run with absolute path, so the generator can exec itself
-	generator="$(command -v event_generator)"
-	"$generator" -n $NUM_EVENTS -e $event >gen_$event.log 2>gen_$event.err
-	gen_rc=$?
+	# generator must be in PATH
+	ROD event_generator -n $NUM_EVENTS -e $event \>gen_$event.log 2\>gen_$event.err
 
 	# Sleep until pec_listener has seen and handled all of the generated events
 	tst_sleep 100ms
@@ -48,7 +47,7 @@ test()
 	wait $pid
 	lis_rc=$?
 
-	if [ $gen_rc -ne 0 -o ! -s gen_$event.log ]; then
+	if [ ! -s gen_$event.log ]; then
 		tst_brk TBROK "failed to generate process events"
 	fi
 
diff --git testcases/kernel/connectors/pec/event_generator.c testcases/kernel/connectors/pec/event_generator.c
index f041341f9..f374688ba 100644
--- testcases/kernel/connectors/pec/event_generator.c
+++ testcases/kernel/connectors/pec/event_generator.c
@@ -86,7 +86,7 @@ static void gen_exec(void)
 	fflush(stdout);
 
 	/* Note: This expects the full path to self in exec_argv[0]! */
-	SAFE_EXECV(exec_argv[0], exec_argv);
+	SAFE_EXECVP(exec_argv[0], exec_argv);
 }
 
 /*
