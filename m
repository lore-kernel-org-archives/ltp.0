From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 19 Jan 2017 15:32:15 +0800
Subject: [LTP] [PATCH] utimensat_tests: Make use of tst_kvcmp again
Message-ID: <1484811135-26369-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_kvercmp* binaries have been removed in:

commit 4847f1c13dabbfadd612aa812e2c99973f35f230
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Mon Nov 14 13:44:45 2016 +0100

apicmd: Get rid of tst_kvercmp* binaries.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/utimensat/utimensat_tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
index 4ae8651..2af99f5 100755
--- a/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
+++ b/testcases/kernel/syscalls/utimensat/utimensat_tests.sh
@@ -26,7 +26,7 @@ export TST_TOTAL=99
 export TST_COUNT=0
 . test.sh
 
-if tst_kvercmp 2 6 22 ; then
+if tst_kvcmp -lt "2.6.22"; then
 	tst_brkm TCONF "System kernel version is less than 2.6.22,cannot execute test"
 fi
 
-- 
1.8.3.1



