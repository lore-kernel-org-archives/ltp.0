From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 12 Mar 2020 17:31:02 +0530
Subject: [LTP] [PATCH V6 02/10] lapi/fsmount.h: Add
 fsopen_supported_by_kernel()
In-Reply-To: <cover.1584014172.git.viresh.kumar@linaro.org>
References: <cover.1584014172.git.viresh.kumar@linaro.org>
Message-ID: <30703bd273dc225749871cd8ea3d2c177a0ca353.1584014172.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a helper to check if the fsmount() related syscalls are supported by
the kernel or not.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Li Wang <liwang@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/lapi/fsmount.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index 87f2f229c371..94adec2fb609 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -130,5 +130,16 @@ enum fsconfig_command {
 
 #endif /* OPEN_TREE_CLONE */
 
+void fsopen_supported_by_kernel(void)
+{
+	if ((tst_kvercmp(5, 2, 0)) < 0) {
+		/* Check if the syscall is backported on an older kernel */
+		TEST(syscall(__NR_fsopen, NULL, 0));
+		if (TST_RET != -1)
+			SAFE_CLOSE(TST_RET);
+		else if (TST_ERR == ENOSYS)
+			tst_brk(TCONF, "Test not supported on kernel version < v5.2");
+	}
+}
 
 #endif /* FSMOUNT_H__ */
-- 
2.21.0.rc0.269.g1a574e7a288b

