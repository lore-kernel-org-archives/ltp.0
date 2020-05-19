From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 May 2020 08:52:01 +0200
Subject: [LTP] [PATCH v2 2/2] tst_test.sh: Warn about setup/cleanup function
 not loaded
In-Reply-To: <20200519065201.23295-1-pvorel@suse.cz>
References: <20200519065201.23295-1-pvorel@suse.cz>
Message-ID: <20200519065201.23295-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Inspired by regression fixed by previous commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* use tst_brk TBROK instead of tst_res TWARN
* fixed variable name TST_CLEANUP in tst_brk
(both Joerg)

Kind regards,
Petr

 testcases/lib/tst_test.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index e76a31509..b1fc96401 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -30,7 +30,11 @@ _tst_do_exit()
 
 	if [ -n "$TST_SETUP_STARTED" -o -n "$TST_RUN_STARTED" ] && \
 		[ -n "$TST_CLEANUP" -a -z "$TST_NO_CLEANUP" ]; then
-		$TST_CLEANUP
+		if type "$TST_CLEANUP" >/dev/null 2>&1; then
+			$TST_CLEANUP
+		else
+			tst_brk TBROK "cleanup function set (TST_CLEANUP='$TST_CLEANUP'), but not found (test bug)"
+		fi
 	fi
 
 	if [ "$TST_NEEDS_DEVICE" = 1 -a "$TST_DEVICE_FLAG" = 1 ]; then
@@ -585,6 +589,11 @@ tst_run()
 	if [ -n "$TST_SETUP" ]; then
 		TST_SETUP_STARTED=1
 		$TST_SETUP
+		if type "$TST_SETUP" >/dev/null 2>&1; then
+			$TST_SETUP
+		else
+			tst_brk TBROK "setup function set (TST_SETUP='$TST_SETUP'), but not found (test bug)"
+		fi
 	fi
 
 	#TODO check that test reports some results for each test function call
-- 
2.26.2

