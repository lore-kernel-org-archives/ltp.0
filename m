From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu, 19 Nov 2020 15:28:27 -0500
Subject: [LTP] [PATCH] kernel/security/umip: update umip basic test for
 kernel v5.10 update
Message-ID: <20201119202827.5783-1-pengfei.xu@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

After linux kernel v5.10 mainline, SLDT and STR will return
dummy value and not trigger SIGSEGV due to v5.10 kernel code change.
For detailed kernel update info, you could search below in v5.10 git log:
"x86/umip: Add emulation/spoofing for SLDT and STR instructions"
Commit link info: https://lkml.org/lkml/2020/7/10/1206
Update umip basic test to match with expected results.

Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
---
 .../kernel/security/umip/umip_basic_test.c      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/testcases/kernel/security/umip/umip_basic_test.c b/testcases/kernel/security/umip/umip_basic_test.c
index 13c317022..d581c5bf1 100644
--- a/testcases/kernel/security/umip/umip_basic_test.c
+++ b/testcases/kernel/security/umip/umip_basic_test.c
@@ -129,6 +129,23 @@ static void verify_umip_instruction(unsigned int n)
 			return;
 		} else
 			tst_res(TINFO, "Linux kernel version is before than v5.4");
+		break;
+	case 2:
+	case 4:
+		/* after Linux kernel v5.10 mainline, SLDT and STR will return
+		   dummy value and not trigger SIGSEGV due to kernel code change */
+		if ((tst_kvercmp(5, 10, 0)) >= 0) {
+			tst_res(TINFO, "Linux kernel version is v5.10 or higher");
+			if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+				tst_res(TFAIL, "Got SIGSEGV");
+				return;
+			}
+			tst_res(TPASS, "Didn't receive SIGSEGV, child exited with %s",
+				tst_strstatus(status));
+			return;
+		} else
+			tst_res(TINFO, "Linux kernel version is earlier than v5.10");
+		break;
 	}
 
 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
-- 
2.20.1

