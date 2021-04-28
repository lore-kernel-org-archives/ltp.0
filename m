From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Wed, 28 Apr 2021 10:50:39 +0800
Subject: [LTP] [PATCH] Set exfat file system to skip symlink
Message-ID: <20210428025039.14351-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If the kernel configuration CONF_EXFAT_FS=m, then the exfat test
result is TCONF. If the kernel is not configured with CONF_EXFAT_FS=m,
then the exfat test result will be TBROK (TBROK makes subsequent tests
impossible). Because the exfat file system does not support symlink,
the test should skip calling symlink.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
---
 testcases/kernel/syscalls/chdir/chdir01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
index 23cd455d6..aa25adf6a 100644
--- a/testcases/kernel/syscalls/chdir/chdir01.c
+++ b/testcases/kernel/syscalls/chdir/chdir01.c
@@ -69,7 +69,7 @@ static void setup(void)

 	if (!TST_RET)
 		SAFE_SYMLINK(LINK_NAME2, LINK_NAME1);
-	else if (TST_RET == -1 && TST_ERR == EPERM)
+	else if (TST_RET == -1 && (TST_ERR == EPERM || TST_ERR == ENOSYS))
 		skip_symlinks = 1;
 	else
 		tst_brk(TBROK | TTERRNO, "Cannot create symlinks");
--
2.20.1



