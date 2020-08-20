From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Thu, 20 Aug 2020 09:52:11 +0800
Subject: [LTP] [PATCH] setxattr03: TCONF if failed to set immutable flag
Message-ID: <20200820015211.u7xdye5ggbe34fsp@xzhoux.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Instead of TBROK, probably the underlying filesystem not support this flag.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 testcases/kernel/syscalls/setxattr/setxattr03.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr03.c b/testcases/kernel/syscalls/setxattr/setxattr03.c
index 58ee0f880..b2de3bc79 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr03.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr03.c
@@ -138,8 +138,8 @@ static void setup(void)
 	/* Create test files and set file immutable or append-only */
 	immu_fd = SAFE_CREAT(IMMU_FILE, 0644);
 	if (set_immutable_on(immu_fd))
-		tst_brk(TBROK | TERRNO, "Set %s immutable failed",
-			 IMMU_FILE);
+		tst_brk(TCONF | TERRNO, "Set %s immutable failed, "
+			 " maybe it's unsupported", IMMU_FILE);
 
 	append_fd = SAFE_CREAT(APPEND_FILE, 0644);
 	if (set_append_on(append_fd))
-- 
2.20.1
