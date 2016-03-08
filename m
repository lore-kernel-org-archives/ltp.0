From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Date: Tue, 8 Mar 2016 11:02:04 +0530
Subject: [LTP] [PATCH] sort the open posix tests before executing
Message-ID: <1457415124-5023-1-git-send-email-vgupta@synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Helps do a simple diff of output logs !

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
index 0477bd7059bc..7cf2b09a47d2 100755
--- a/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
+++ b/testcases/open_posix_testsuite/bin/run-posix-option-group-test.sh
@@ -22,7 +22,7 @@ EOF
 
 run_option_group_tests()
 {
-	for test_script in $(find $1 -name run.sh); do
+	for test_script in $(find $1 -name run.sh | sort); do
 		(cd "$(dirname "$test_script")" && ./$(basename "$test_script"))
 	done
 }
-- 
2.5.0

