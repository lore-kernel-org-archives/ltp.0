From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 19 Feb 2020 14:57:58 +0530
Subject: [LTP] [PATCH V2 02/10] lapi/fsmount.h: Add
 fsopen_supported_by_kernel()
In-Reply-To: <cover.1582104018.git.viresh.kumar@linaro.org>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
Message-ID: <8d552688d85a7acc62d654832ab7ce270a70cf77.1582104018.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a helper to check if the fsmount() related syscalls are supported by
the kernel or not.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/lapi/fsmount.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 87f2f229c371..e23b52e3733b 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -130,5 +130,14 @@ enum fsconfig_command {
 
 #endif /* OPEN_TREE_CLONE */
 
+void fsopen_supported_by_kernel(void)
+{
+	if ((tst_kvercmp(5, 2, 0)) < 0) {
+		/* Check if the syscall is backported on an older kernel */
+		TEST(syscall(__NR_fsopen, NULL, 0));
+		if (TST_RET == -1 && TST_ERR == ENOSYS)
+			tst_brk(TCONF, "Test not supporter on kernel version < v5.2");
+	}
+}
 
 #endif /* FSMOUNT_H__ */
-- 
2.21.0.rc0.269.g1a574e7a288b

