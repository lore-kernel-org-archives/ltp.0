From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 May 2020 22:14:16 +0200
Subject: [LTP] [PATCH v2 1/1] rpc: TCONF when tests aren't compiled + remove
 kill warning
Message-ID: <20200512201416.8299-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Without this test failure was wrongly reported:
rpc_test 1 TFAIL: tirpc_rpcb_getaddr 10.0.0.2 536875000 failed unexpectedly

Also make sure with variable that server has started before trying to
kill it.

Kill server with SIGPIPE, should be enough and SIGKILL
produced warning, which might be confused:
/opt/ltp/testcases/bin/rpc_test.sh: line 61: 3827 Killed  $SERVER $PROGNUMNOSVC

Reviewed-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

with this implementation (suggested by Alexey), we get TCONF twice. It's
a bit strange, but I'll keep it, because I like that required binary is
printed:
rpc_test 1 TCONF: 'tirpc_rpcb_getaddr' not found
rpc_test 1 TCONF: LTP compiled without TI-RPC support?

Also added proper detection if kill is needed (related to the change in
the commit) and kill with SIGPIPE (unrelated change, I can add it as
separate commit).

Kind regards,
Petr

 testcases/network/rpc/rpc-tirpc/rpc_test.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
index 30cfd2564..dc97213d0 100755
--- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -54,12 +54,13 @@ setup()
 	fi
 
 	[ -n "$CLIENT" ] || tst_brk TBROK "client program not set"
+	tst_check_cmds $CLIENT $SERVER || tst_brk TCONF "LTP compiled without TI-RPC support?"
 }
 
 cleanup()
 {
-	if [ ! -z "$SERVER" ]; then
-		pkill -9 $SERVER > /dev/null 2>&1
+	if [ "$SERVER_STARTED" ]; then
+		pkill -13 -x $SERVER
 		$CLEANER $PROGNUMNOSVC
 	fi
 }
@@ -70,6 +71,7 @@ do_test()
 
 	if [ -n "$SERVER" ]; then
 		$SERVER $PROGNUMNOSVC &
+		SERVER_STARTED=1
 
 		for i in $(seq 1 10); do
 			rpcinfo -p localhost | grep -q $PROGNUMNOSVC && break
-- 
2.26.2

