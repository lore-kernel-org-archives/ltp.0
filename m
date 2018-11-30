From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 30 Nov 2018 21:37:51 +0100
Subject: [LTP] [PATCH v5 1/3] net: Add tst_net_run helper
Message-ID: <20181130203753.19765-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and use it in tst_set_sysctl

+ improve doc of tst_rhost_run()

Signed-off-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
Changes v4->v5:
* Add -q mode (default off) in tst_net_run()
* Fix in tst_set_sysctl() for rhost (passed everything as single command
to avoid processing -w in tst_net_run() as getopt.
---
 testcases/lib/tst_net.sh | 70 ++++++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index d1206e285..953ae68ab 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -131,7 +131,8 @@ init_ltp_netspace()
 # -b run in background
 # -B run in background and save output to $TST_TMPDIR/bg.cmd
 # -s safe option, if something goes wrong, will exit with TBROK
-# -c specify command to run
+# -c specify command to run (this must be binary, not shell buildin/function)
+# RETURN: 0 on success, 1 on failure
 tst_rhost_run()
 {
 	local pre_cmd=
@@ -191,6 +192,61 @@ tst_rhost_run()
 	return $ret
 }
 
+# Run command on both lhost and rhost.
+# tst_net_run [-s] [-l LPARAM] [-r RPARAM] [ -q ] CMD [ARG [ARG2]]
+# Options:
+# -l LPARAM: parameter passed to CMD in lhost
+# -r RPARAM: parameter passed to CMD in rhost
+# -q: quiet mode (suppress failure warnings)
+# CMD: command to run (this must be binary, not shell buildin/function due
+# tst_rhost_run() limitation)
+# RETURN: 0 on success, 1 on missing CMD or exit code on lhost or rhost
+tst_net_run()
+{
+	local cmd
+	local lparams
+	local rparams
+	local lsafe
+	local rsafe
+	local lret
+	local rret
+	local quiet
+
+	local OPTIND
+	while getopts l:qr:s opt; do
+		case "$opt" in
+		l) lparams="$OPTARG" ;;
+		q) quiet=1 ;;
+		r) rparams="$OPTARG" ;;
+		s) lsafe="ROD"; rsafe="-s" ;;
+		*) tst_brk_ TBROK "tst_net_run: unknown option: $OPTARG" ;;
+		esac
+	done
+	shift $((OPTIND - 1))
+	cmd="$1"
+	shift
+
+	if [ -z "$cmd" ]; then
+		[ -n "$lsafe" ] && \
+			tst_brk_ TBROK "tst_net_run: command not defined"
+		tst_res_ TWARN "tst_net_run: command not defined"
+		return 1
+	fi
+
+	$lsafe $cmd $lparams $@
+	lret=$?
+	tst_rhost_run $rsafe -c "$cmd $rparams $@"
+	rret=$?
+
+	if [ -z "$quiet" ]; then
+		[ $lret -ne 0 ] && tst_res_ TWARN "tst_net_run: lhost command failed: $lret"
+		[ $rret -ne 0 ] && tst_res_ TWARN "tst_net_run: rhost command failed: $rret"
+	fi
+
+	[ $lret -ne 0 ] && return $lret
+	return $rret
+}
+
 EXPECT_RHOST_PASS()
 {
 	tst_rhost_run -c "$*" > /dev/null
@@ -642,16 +698,10 @@ tst_set_sysctl()
 	local safe=
 	[ "$3" = "safe" ] && safe="-s"
 
-	local add_opt=
-	[ "$TST_USE_NETNS" = "yes" ] && add_opt="-e"
-
-	if [ "$safe" ]; then
-		ROD sysctl -q -w $name=$value
-	else
-		sysctl -q -w $name=$value
-	fi
+	local rparam=
+	[ "$TST_USE_NETNS" = "yes" ] && rparam="-e"
 
-	tst_rhost_run $safe -c "sysctl -q -w $add_opt $name=$value"
+	tst_net_run $safe -r $rparam "sysctl -q -w $name=$value"
 }
 
 tst_cleanup_rhost()
-- 
2.19.1

