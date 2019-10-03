From: Pengfei Xu <pengfei.xu@intel.com>
Date: Thu,  3 Oct 2019 23:50:01 +0800
Subject: [LTP] [PATCH v2] umip_basic_test.c: update umip basic test for new
 kernel v5.4
Message-ID: <20191003155001.17751-1-pengfei.xu@intel.com>
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
 testcases/kernel/security/umip/umip_basic_test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/testcases/kernel/security/umip/umip_basic_test.c b/testcases/kernel/security/umip/umip_basic_test.c
index 37850ef9f..5a2b71013 100644
--- a/testcases/kernel/security/umip/umip_basic_test.c
+++ b/testcases/kernel/security/umip/umip_basic_test.c
@@ -112,6 +112,25 @@ static void verify_umip_instruction(unsigned int n)
 
 	SAFE_WAITPID(pid, &status, 0);
 
+	switch (n) {
+	case 0:
+	case 1:
+	case 3:
+		/* after linux kernel v5.4 mainline, 64bit SGDT SIDT SMSW will return
+		   dummy value and not trigger SIGSEGV due to kernel code change */
+		if ((tst_kvercmp(5, 4, 0)) >= 0) {
+			tst_res(TINFO, "Linux kernel version is v5.4 or after than v5.4");
+			if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+				tst_res(TFAIL, "Got SIGSEGV");
+				return;
+			}
+			tst_res(TPASS, "Didn't receive SIGSEGV, child exited with %s",
+				tst_strstatus(status));
+			return;
+		} else
+			tst_res(TINFO, "Linux kernel version is before than v5.4");
+	}
+
 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
 		tst_res(TPASS, "Got SIGSEGV");
 		return;
-- 
2.14.1

