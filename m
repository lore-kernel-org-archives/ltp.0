From: Cedric Hnyda <chnyda@suse.com>
Date: Tue,  3 Nov 2015 10:57:04 +0100
Subject: [LTP]  [PATCH] syscall/ustat: cleanup
Message-ID: <1446544624-24257-1-git-send-email-chnyda@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Removed empty cleanup function

Signed-off-by: Cedric Hnyda <chnyda@suse.com>
---
 testcases/kernel/syscalls/ustat/ustat01.c | 12 +++---------
 testcases/kernel/syscalls/ustat/ustat02.c | 12 +++---------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/ustat/ustat01.c b/testcases/kernel/syscalls/ustat/ustat01.c
index 053ab75..01b7688 100644
--- a/testcases/kernel/syscalls/ustat/ustat01.c
+++ b/testcases/kernel/syscalls/ustat/ustat01.c
@@ -28,7 +28,6 @@
 #include "safe_macros.h"
 
 static void setup(void);
-static void cleanup(void);
 
 char *TCID = "ustat01";
 int TST_TOTAL = 1;
@@ -52,7 +51,7 @@ int main(int argc, char *argv[])
 			TEST(ustat(dev_num, &ubuf));
 
 			if (TEST_RETURN == -1 && TEST_ERRNO == ENOSYS)
-				tst_brkm(TCONF, cleanup, "ustat not supported");
+				tst_brkm(TCONF, NULL, "ustat not supported");
 
 			if (TEST_RETURN == -1) {
 				tst_resm(TFAIL, "ustat(2) failed and set"
@@ -64,7 +63,6 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	cleanup();
 	tst_exit();
 }
 
@@ -72,16 +70,12 @@ static void setup(void)
 {
 	struct stat buf;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, NULL);
 
 	TEST_PAUSE;
 
 	/* Find a valid device number */
-	SAFE_STAT(cleanup, "/", &buf);
+	SAFE_STAT(NULL, "/", &buf);
 
 	dev_num = buf.st_dev;
 }
-
-static void cleanup(void)
-{
-}
diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
index c76bd52..4e66236 100644
--- a/testcases/kernel/syscalls/ustat/ustat02.c
+++ b/testcases/kernel/syscalls/ustat/ustat02.c
@@ -29,7 +29,6 @@
 #include "safe_macros.h"
 
 static void setup(void);
-static void cleanup(void);
 
 char *TCID = "ustat02";
 
@@ -68,7 +67,7 @@ int main(int ac, char **av)
 			TEST(ustat(*tc[i].dev, tc[i].buf));
 
 			if (TEST_RETURN == -1 && TEST_ERRNO == ENOSYS)
-				tst_brkm(TCONF, cleanup, "ustat not supported");
+				tst_brkm(TCONF, NULL, "ustat not supported");
 
 			if ((TEST_RETURN == -1)
 			    && (TEST_ERRNO == tc[i].exp_errno)) {
@@ -86,7 +85,6 @@ int main(int ac, char **av)
 		}
 	}
 
-	cleanup();
 	tst_exit();
 }
 
@@ -94,16 +92,12 @@ static void setup(void)
 {
 	struct stat buf;
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_sig(NOFORK, DEF_HANDLER, NULL);
 
 	TEST_PAUSE;
 
 	/* Find a valid device number */
-	SAFE_STAT(cleanup, "/", &buf);
+	SAFE_STAT(NULL, "/", &buf);
 
 	root_dev = buf.st_dev;
 }
-
-static void cleanup(void)
-{
-}
-- 
2.1.4

