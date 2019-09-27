From: Pengfei Xu <pengfei.xu@intel.com>
Date: Fri, 27 Sep 2019 11:46:35 +0800
Subject: [LTP] [PATCH] umip_basic_test.c: update umip basic test for new
 kernel v5.4
Message-ID: <20190927034635.28521-1-pengfei.xu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

After linux kernel v5.4 mainline, 64bit SGDT SIDT SMSW will return
dummy value and not trigger SIGSEGV due to kernel code change.
For detailed kernel update info, you could check v5.4 commit:
x86/umip: Add emulation (spoofing) for UMIP covered instructions in
64-bit processes as well

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 testcases/kernel/security/umip/umip_basic_test.c | 25 ++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/umip/umip_basic_test.c b/testcases/kernel/security/umip/umip_basic_test.c
index 37850ef9f..278ae92f6 100644
--- a/testcases/kernel/security/umip/umip_basic_test.c
+++ b/testcases/kernel/security/umip/umip_basic_test.c
@@ -21,6 +21,7 @@
 #include <string.h>
 #include <sys/wait.h>
 #include <signal.h>
+#include <linux/version.h>
 
 #include "tst_test.h"
 #include "tst_safe_stdio.h"
@@ -112,11 +113,31 @@ static void verify_umip_instruction(unsigned int n)
 
 	SAFE_WAITPID(pid, &status, 0);
 
+	switch (n) {
+	case 0:
+	case 1:
+	case 3:
+		/* after linux kernel v5.4 mainline, 64bit SGDT SIDT SMSW will return
+		   dummy value and not trigger SIGSEGV due to kernel code change */
+		#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,4,0)
+			tst_res(TINFO, "Linux kernel version is after than v5.4");
+			if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+				tst_res(TFAIL, "Got SIGSEGV\n\n");
+				return;
+			}
+			tst_res(TPASS, "Didn't receive SIGSEGV, child exited with %s\n\n",
+				tst_strstatus(status));
+				return;
+		#else
+			tst_res(TINFO, "Linux kernel version is before than v5.4");
+		#endif
+	}
+
 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
-		tst_res(TPASS, "Got SIGSEGV");
+		tst_res(TPASS, "Got SIGSEGV\n\n");
 		return;
 	}
-	tst_res(TFAIL, "Didn't receive SIGSEGV, child exited with %s",
+	tst_res(TFAIL, "Didn't receive SIGSEGV, child exited with %s\n\n",
 		tst_strstatus(status));
 }
 
-- 
2.14.1

