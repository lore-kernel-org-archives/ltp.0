From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Nov 2018 17:30:07 +0100
Subject: [LTP] [PATCH v4 1/2] net: Add tst_net_run helper
Message-ID: <20181113163008.9093-1-pvorel@suse.cz>
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
Hi,

Maybe we could signal where error occurred:
* return 0: ok on both lhost and rhost
* return 1: failure on lhost
* return 2: failure on rhost
* return 3: failure on both lhost and rhost

But instead I'd be for tst_rhost_run return real exit code, not always 1
for any error.

Workaround for sh -c requiring binary could be to create temporary file
which would source tst_net.sh and than run the command. Maybe a bit
complicated.

Kind regards,
Petr
---
 testcases/lib/tst_net.sh | 61 +++++++++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index d1206e285..f8f7be0f2 100644
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
@@ -191,6 +192,52 @@ tst_rhost_run()
 	return $ret
 }
 
+# Run command on both lhost and rhost.
+# tst_net_run [-s] [-l LPARAM] [-r RPARAM] CMD [ARG [ARG2]]
+# Options:
+# LPARAM: parameter passed to CMD in lhost
+# RPARAM: parameter passed to CMD in rhost
+# CMD: command to run (this must be binary, not shell buildin/function due
+# tst_rhost_run() limitation)
+# RETURN: 0 on success, 1 on missing CMD or exit code of cmd failure of on lhost or rhost
+tst_net_run()
+{
+	local cmd
+	local lparams
+	local rparams
+	local lsafe
+	local rsafe
+	local lret
+	local rret
+
+	local OPTIND
+	while getopts l:r:s opt; do
+		case "$opt" in
+		l) lparams="$OPTARG" ;;
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
+	[ $lret -ne 0 ] && return $lret
+	return $rret
+}
+
 EXPECT_RHOST_PASS()
 {
 	tst_rhost_run -c "$*" > /dev/null
@@ -642,16 +689,10 @@ tst_set_sysctl()
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
+	tst_net_run $safe -r $rparam sysctl -q -w $name=$value
 }
 
 tst_cleanup_rhost()
-- 
2.19.1

