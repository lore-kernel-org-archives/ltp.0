From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Thu, 3 Nov 2016 14:19:18 +0800
Subject: [LTP] [PATCH] syscalls/creat06: Fix the use of tst_brk() in cleanup
Message-ID: <1478153958-18075-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Calling tst_brk() from the test cleanup would cause infinite
loop and segfault, we should call tst_res(TWARN) instead, and
the tst_umount() calls tst_res(TWARN) already, so we just use
the tst_umount() here.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/creat/creat06.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index 9c60fd0..73913cd 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
@@ -172,10 +172,8 @@ static void test6_cleanup(void)
 
 static void cleanup(void)
 {
-	if (mount_flag && tst_umount("mntpoint") < 0) {
-		tst_brk(TBROK | TERRNO, "umount device:%s failed",
-			tst_device->dev);
-	}
+	if (mount_flag)
+		tst_umount("mntpoint");
 }
 
 static struct tst_test test = {
-- 
1.8.4.2



