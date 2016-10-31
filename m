From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Date: Mon, 31 Oct 2016 15:29:43 +0800
Subject: [LTP] [PATCH] syscalls/creat06: Fix the use of unassigned variable
Message-ID: <1477898983-18159-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
---
 testcases/kernel/syscalls/creat/creat06.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index 165c1de..9c60fd0 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
@@ -80,7 +80,6 @@ static void bad_addr_setup(int);
 
 static struct passwd *ltpuser;
 static char long_name[PATH_MAX+2];
-static const char *device;
 static int mount_flag;
 
 static struct test_case_t {
@@ -173,8 +172,10 @@ static void test6_cleanup(void)
 
 static void cleanup(void)
 {
-	if (mount_flag && tst_umount("mntpoint") < 0)
-		tst_brk(TBROK | TERRNO, "umount device:%s failed", device);
+	if (mount_flag && tst_umount("mntpoint") < 0) {
+		tst_brk(TBROK | TERRNO, "umount device:%s failed",
+			tst_device->dev);
+	}
 }
 
 static struct tst_test test = {
-- 
1.8.4.2



