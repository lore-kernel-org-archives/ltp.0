From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  8 Nov 2018 15:24:08 +0100
Subject: [LTP] [PATCH v3 1/2] net: Add tst_net_run helper
Message-ID: <20181108142409.4955-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and use it in tst_set_sysctl

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* Add -l and -r params and use it in tst_set_sysctl
Escape '>' (ROD foo \> bar.log) can be used for this, but it'd be better
to do it automatically.

Changes v1->v2:
* tst_net_driver removed and created generic command tst_net_run

TODO: For ROD it does not handle escape for >. E.g. it'd be nice to
handle this:
ROD foo \> bar.log
as passing the escape will not work for sh (non-safe local) and for
tst_rhost_run. Do we care?

Kind regards,
Petr
---
 testcases/lib/tst_net.sh | 43 +++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index d1206e285..aa5a05825 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -191,6 +191,37 @@ tst_rhost_run()
 	return $ret
 }
 
+# Run command on both lhost and rhost.
+# tst_net_run [-s] [-l LPARAM] [-r RPARAM] CMD [ARG [ARG2]]
+# LPARAM: parameter passed to $1 in lhost
+# RPARAM: parameter passed to $1 in rhost
+tst_net_run()
+{
+	local cmd
+	local lparams
+	local rparams
+	local safe
+
+	local OPTIND
+	while getopts l:r:s opt; do
+		case "$opt" in
+		l) lparams="$OPTARG" ;;
+		r) rparams="$OPTARG" ;;
+		s) safe="-s" ;;
+		*) tst_brk_ TBROK "tst_net_run: unknown option: $OPTARG" ;;
+		esac
+	done
+	shift $((OPTIND - 1))
+
+	cmd="$1"
+	shift
+	cmd="$cmd $lparams $@"
+	[ -n "$safe" ] && ROD $cmd || sh -c "$cmd"
+
+	cmd="$cmd $rparams $@"
+	tst_rhost_run $safe -c "$cmd"
+}
+
 EXPECT_RHOST_PASS()
 {
 	tst_rhost_run -c "$*" > /dev/null
@@ -642,16 +673,10 @@ tst_set_sysctl()
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

