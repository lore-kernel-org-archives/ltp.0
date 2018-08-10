From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 10 Aug 2018 10:53:42 +0800
Subject: [LTP] [PATCH] syscalls/fgetxattr02.c: Fix errno EPERM on older
	kernels
Message-ID: <1533869622-23362-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

According to commit 3d2ae5e in LTP, fgetxattr()/getxattr() will set
errno to 'EPERM' when fd/file is not a regular file and directory
before kernel 3.0.0.  This errno is changed to ENODATA by commit
55b23bd in kernel, so we accept EPERM in older kernels.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fgetxattr/fgetxattr02.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c b/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
index 98a141b..888e29a 100644
--- a/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
+++ b/testcases/kernel/syscalls/fgetxattr/fgetxattr02.c
@@ -185,6 +185,14 @@ static void verify_fgetxattr(unsigned int i)
 				tc[i].fname + OFFSET);
 	}
 
+	/*
+	 * Before kernel 3.0.0, fgetxattr(2) will set errno with 'EPERM'
+	 * when the file is not a regular file and directory, refer to
+	 * commitid 55b23bd
+	 */
+	if (tc[i].exp_err == ENODATA && tst_kvercmp(3, 0, 0) < 0)
+		tc[i].exp_err = EPERM;
+
 	if (tc[i].exp_err == TST_ERR) {
 		tst_res(TPASS | TTERRNO, "fgetxattr(2) on %s passed",
 				tc[i].fname + OFFSET);
-- 
1.8.3.1



