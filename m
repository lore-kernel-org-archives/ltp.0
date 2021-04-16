From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 Apr 2021 19:22:25 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Use 'command -v' instead of 'which'
Message-ID: <20210416172225.14524-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

to avoid unnecessary dependency.

'which' is a binary file, which might not be installed (common on
containers). 'command' is a shell builtin, available everywhere, we
already use non-standard -v option commonly supported (bash, dash,
busybox ash).

Fixes: 7783ac3a0 ("lib/tst_test.sh: Add new shell library")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 7f98e06bf..95ece42f6 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -685,7 +685,7 @@ else
 fi
 
 if [ -z "$TST_NO_DEFAULT_RUN" ]; then
-	if TST_TEST_PATH=$(which $0) 2>/dev/null; then
+	if TST_TEST_PATH=$(command -v $0) 2>/dev/null; then
 		if ! grep -q tst_run "$TST_TEST_PATH"; then
 			tst_brk TBROK "Test $0 must call tst_run!"
 		fi
-- 
2.31.1

