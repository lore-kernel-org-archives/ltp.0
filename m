From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Mon, 13 Sep 2021 15:39:34 +0300
Subject: [LTP] [PATCH 1/2] lib/tst_net.sh: ignore errors on rhost with -i
 option in tst_net_run()
Message-ID: <20210913123935.10761-1-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Unfortanetly busysbox/sysctl with -e option only suppresses the
warning about unknown keys and still returns exit code 1:
    sysctl -h
    ...
    -e don't warn about unknown keys

As a result busy_poll01 fails on this error:

    busy_poll01.sh
    busy_poll01 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
    ...
    busy_poll01 1 TINFO: set low latency busy poll to 50
    busy_poll01 1 TBROK: 'sysctl -q -w '-e' net.core.busy_read=50' failed on '': ''

So let's add a new option (-i) in tst_net_run() to ignore the
error when running the command on "rhost".

Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/lib/tst_net.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 958d71e3d..7f2a1bab3 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -212,6 +212,7 @@ tst_rhost_run()
 # -l LPARAM: parameter passed to CMD in lhost
 # -r RPARAM: parameter passed to CMD in rhost
 # -q: quiet mode (suppress failure warnings)
+# -i: ignore errors on rhost
 # CMD: command to run (this must be binary, not shell builtin/function due
 # tst_rhost_run() limitation)
 # RETURN: 0 on success, 1 on missing CMD or exit code on lhost or rhost
@@ -227,12 +228,13 @@ tst_net_run()
 	local quiet
 
 	local OPTIND
-	while getopts l:qr:s opt; do
+	while getopts l:qr:si opt; do
 		case "$opt" in
 		l) lparams="$OPTARG" ;;
 		q) quiet=1 ;;
 		r) rparams="$OPTARG" ;;
 		s) lsafe="ROD"; rsafe="-s" ;;
+		i) rsafe="" ;;
 		*) tst_brk_ TBROK "tst_net_run: unknown option: $OPTARG" ;;
 		esac
 	done
@@ -916,9 +918,9 @@ tst_set_sysctl()
 	[ "$3" = "safe" ] && safe="-s"
 
 	local rparam=
-	[ "$TST_USE_NETNS" = "yes" ] && rparam="-r '-e'"
+	[ "$TST_USE_NETNS" = "yes" ] && rparam="-i -r '-e'"
 
-	tst_net_run $safe $rparam "sysctl" "-q -w $name=$value"
+	tst_net_run $safe -q $rparam "sysctl" "-q -w $name=$value"
 }
 
 tst_cleanup_rhost()
-- 
2.25.1

