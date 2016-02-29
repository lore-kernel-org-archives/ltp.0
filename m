From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Mon, 29 Feb 2016 14:34:40 +0530
Subject: [LTP] [PATCH] run-posix-option-group-test: replace CWD qith PWD
Message-ID: <1456736680-8968-1-git-send-email-vgupta@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When running LTP on a mininal Busybox + uClibc env, see lot of prints like
this:

| Usage: basename FILE [SUFFIX]
|
| Strip directory path and .SUFFIX from FILE
|
| *******************
| Testing
| *******************

This is because $CDW env variable is not provided by Busybox shell.

I understand PWD is not same as CWD, but should suffice here !

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 testcases/open_posix_testsuite/bin/run-tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/bin/run-tests.sh b/testcases/open_posix_testsuite/bin/run-tests.sh
index d4bd9884efbf..5ee568775a44 100755
--- a/testcases/open_posix_testsuite/bin/run-tests.sh
+++ b/testcases/open_posix_testsuite/bin/run-tests.sh
@@ -29,7 +29,7 @@ run_test_loop() {
 
 	cat <<EOF
 *******************
-Testing $(basename $CWD)
+Testing $(basename $PWD)
 *******************
 $(printf "PASS\t\t%3d" $NUM_PASS)
 $(printf "FAIL\t\t%3d" $NUM_FAIL)
-- 
2.5.0

