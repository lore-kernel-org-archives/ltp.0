From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 7 Jun 2018 10:40:00 +0800
Subject: [LTP] [PATCH] syscalls/fallocate05: Add missing FALLOC_FL_KEEP_SIZE
	flag
Message-ID: <1528339200-15655-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

According to fallocate(2) manpage and kernel source code, if fallocate(2)
only specify FALLOC_FL_PUNCH_HOLE flag, it always gets EOPNOTSUPP.  We
should specify both FALLOC_FL_PUNCH_HOLE and FALLOC_FL_KEEP_SIZE.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fallocate/fallocate05.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index 1fac26a..a358e67 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -69,7 +69,7 @@ static void run(void)
 
 	tst_res(TPASS | TERRNO, "fallocate() on full FS");
 
-	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE, 0, FALLOCATE_SIZE);
+	ret = fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, FALLOCATE_SIZE);
 	if (ret == -1) {
 		if (errno == EOPNOTSUPP)
 			tst_brk(TCONF, "fallocate(FALLOC_FL_PUNCH_HOLE)");
-- 
1.8.3.1



