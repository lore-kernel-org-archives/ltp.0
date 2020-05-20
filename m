From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 May 2020 10:26:07 +0200
Subject: [LTP] [PATCH v3 2/2] tst_test.sh: Warn about setup/cleanup function
 not loaded
In-Reply-To: <20200520082607.25776-1-pvorel@suse.cz>
References: <20200520082607.25776-1-pvorel@suse.cz>
Message-ID: <20200520082607.25776-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Inspired by regression fixed by previous commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Maybe this sanity check is not needed any more.

Kind regards,
Petr

 testcases/lib/tst_test.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 4f966df17..b04db103b 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -30,8 +30,11 @@ _tst_do_exit()
 
 	if [ -n "$TST_RUN_STARTED" -a -n "$TST_CLEANUP" -a \
 		-z "$TST_NO_CLEANUP" ]; then
-
-		$TST_CLEANUP
+		if type "$TST_CLEANUP" >/dev/null 2>&1; then
+			$TST_CLEANUP
+		else
+			tst_brk TBROK "cleanup function set (TST_CLEANUP='$TST_CLEANUP'), but not found (test bug)"
+		fi
 	fi
 
 	if [ "$TST_NEEDS_DEVICE" = 1 -a "$TST_DEVICE_FLAG" = 1 ]; then
@@ -587,6 +590,11 @@ tst_run()
 
 	if [ -n "$TST_SETUP" ]; then
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

