From: Petr Vorel <pvorel@suse.cz>
Date: Sat, 26 May 2018 13:15:42 +0200
Subject: [LTP] [PATCH 1/4] tst_net.sh: Simplify ipver settings code
Message-ID: <20180526111545.20521-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index dc612a794..fd2eacf2f 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -29,11 +29,12 @@ TST_SETUP="tst_net_setup"
 
 # Blank for an IPV4 test; 6 for an IPV6 test.
 TST_IPV6=${TST_IPV6:-}
+ipver=${TST_IPV6:-4}
 
 tst_net_parse_args()
 {
 	case $1 in
-	6) TST_IPV6=6;;
+	6) TST_IPV6=6 ipver=6;;
 	*) $TST_PARSE_ARGS_CALLER "$1" "$2";;
 	esac
 }
@@ -68,7 +69,6 @@ tst_net_remote_tmpdir()
 
 tst_net_setup()
 {
-	ipver=${TST_IPV6:-4}
 	tst_net_remote_tmpdir
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 }
@@ -79,7 +79,6 @@ fi
 
 if [ -n "$TST_USE_LEGACY_API" ]; then
 	tst_net_read_opts "$@"
-	ipver=${TST_IPV6:-4}
 fi
 
 # old vs. new API compatibility layer
-- 
2.16.3

