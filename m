From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 27 Aug 2019 16:42:00 +0200
Subject: [LTP] [COMMITTED][PATCH] net/if-lib.sh: Use ip command as default
Message-ID: <20190827144200.22794-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

instead of requiring to specify command with -c.
It makes sense to have it as the default as ifconfig and route
(alternative commands from net-tools) has been deprecated long time ago.

This also fixes misleading TBROK message when -c was not set:
"IF_CMD variable not defined"

+ move test variables to the top.

Fixes: d1291fda8 ("network/interface: Split tests to test only one command per test")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/interface/if-lib.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/network/stress/interface/if-lib.sh b/testcases/network/stress/interface/if-lib.sh
index 9bf36e421..90030a146 100644
--- a/testcases/network/stress/interface/if-lib.sh
+++ b/testcases/network/stress/interface/if-lib.sh
@@ -3,6 +3,15 @@
 # Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
 # Author: Petr Vorel <pvorel@suse.cz>
 
+CMD="${CMD:-ip}"
+
+TST_SETUP="${TST_SETUP:-if_setup}"
+TST_TESTFUNC="test_body"
+TST_PARSE_ARGS="if_parse_args"
+TST_USAGE="if_usage"
+TST_OPTS="c:"
+. tst_net_stress.sh
+
 if_usage()
 {
 	echo "-c      Test command (ip, $IF_CMD)"
@@ -17,7 +26,6 @@ if_parse_args()
 
 if_setup()
 {
-	[ -n "$CMD" ] || tst_brk TBROK "IF_CMD variable not defined"
 	if [ "$CMD" != 'ip' -a "$CMD" != "$IF_CMD" ]; then
 		tst_brk TBROK "Missing or wrong -c parameter: '$CMD', use 'ip' or '$IF_CMD'"
 	fi
@@ -33,11 +41,3 @@ if_cleanup_restore()
 	restore_ipaddr
 	restore_ipaddr rhost
 }
-
-TST_SETUP="${TST_SETUP:-if_setup}"
-TST_TESTFUNC="test_body"
-TST_PARSE_ARGS="if_parse_args"
-TST_USAGE="if_usage"
-TST_OPTS="c:"
-
-. tst_net_stress.sh
-- 
2.22.0

