From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  8 Nov 2018 14:58:03 +0100
Subject: [LTP] [RFC PATCH 1/2] net: Add tst_net_run helper
Message-ID: <20181108135804.32448-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
tst_net_driver removed and created generic command tst_net_run

TODO: For ROD it does not handle escape for >. E.g. it'd be nice to
handle this:
ROD foo \> bar.log
as passing the escape will not work for sh (non-safe local) and for
tst_rhost_run. Do we care?

Kind regards,
Petr
---
 testcases/lib/tst_net.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index d1206e285..ff5c58c3c 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -191,6 +191,23 @@ tst_rhost_run()
 	return $ret
 }
 
+# Run command on both lhost and rhost.
+# tst_net_run [-s] CMD [ARG [ARG2]]
+tst_net_run()
+{
+	local safe
+	local OPTIND
+	while getopts s opt; do
+		case "$opt" in
+		s) safe="-s" ;;
+		*) tst_brk_ TBROK "tst_net_run: unknown option: $OPTARG" ;;
+		esac
+	done
+	shift $((OPTIND - 1))
+	[ -n "$safe" ] && ROD $@ || sh -c $@
+	tst_rhost_run $safe -c "$@"
+}
+
 EXPECT_RHOST_PASS()
 {
 	tst_rhost_run -c "$*" > /dev/null
-- 
2.19.1

