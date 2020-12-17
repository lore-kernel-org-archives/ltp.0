From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 17 Dec 2020 15:44:24 +0100
Subject: [LTP] [PATCH v4 3/3] tst_test.sh: Exit when setup declared but not
 defined
In-Reply-To: <20201217144424.19414-1-pvorel@suse.cz>
References: <20201217144424.19414-1-pvorel@suse.cz>
Message-ID: <20201217144424.19414-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It can lead to fail positive when just warn about
TST_SETUP declared but not defined (or cmd not found).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index dbf1d2a97..1b05c1036 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -586,7 +586,11 @@ tst_run()
 	[ -n "$TST_NEEDS_MODULE" ] && tst_require_module "$TST_NEEDS_MODULE"
 
 	if [ -n "$TST_SETUP" ]; then
-		$TST_SETUP
+		if type $TST_SETUP >/dev/null 2>/dev/null; then
+			$TST_SETUP
+		else
+			tst_brk TBROK "TST_SETUP=$TST_SETUP declared, but function not defined (or cmd not found)"
+		fi
 	fi
 
 	#TODO check that test reports some results for each test function call
-- 
2.29.2

