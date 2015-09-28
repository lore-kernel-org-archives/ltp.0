From: Yuan Sun <sunyuan3@huawei.com>
Date: Mon, 28 Sep 2015 12:57:56 +0800
Subject: [LTP] [PATCH] userns03: setgroups can't be reenabled
Message-ID: <1443416276-12224-1-git-send-email-sunyuan3@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If the setgroups file has the value "deny", then the setgroups(2) system
call can't subsequently be reenabled (by writing "allow" to the file) in
this user namespace.  (Attempts to do so will fail with the error
EPERM.)

Signed-off-by: Yuan Sun <sunyuan3@huawei.com>
---
 testcases/kernel/containers/userns/userns03.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/containers/userns/userns03.c b/testcases/kernel/containers/userns/userns03.c
index 26a710d..0602689 100644
--- a/testcases/kernel/containers/userns/userns03.c
+++ b/testcases/kernel/containers/userns/userns03.c
@@ -61,7 +61,6 @@
 char *TCID = "user_namespace3";
 int TST_TOTAL = 1;
 static int cpid1, parentuid, parentgid;
-static bool setgroupstag = true;
 
 /*
  * child_fn1() - Inside a new user namespace
@@ -158,8 +157,6 @@ static void setup(void)
 	check_newuser();
 	tst_tmpdir();
 	TST_CHECKPOINT_INIT(NULL);
-	if (access("/proc/self/setgroups", F_OK) == 0)
-		setgroupstag = false;
 }
 
 int main(int argc, char *argv[])
@@ -168,6 +165,7 @@ int main(int argc, char *argv[])
 	char path[BUFSIZ];
 	int lc;
 	int fd;
+	int ret;
 
 	tst_parse_opts(argc, argv, NULL, NULL);
 	setup();
@@ -190,11 +188,30 @@ int main(int argc, char *argv[])
 			tst_brkm(TBROK | TERRNO, cleanup,
 				"cpid2 clone failed");
 
-		if (setgroupstag == false) {
+		if (access("/proc/self/setgroups", F_OK) == 0) {
 			sprintf(path, "/proc/%d/setgroups", cpid1);
 			fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
 			SAFE_WRITE(cleanup, 1, fd, "deny", 4);
 			SAFE_CLOSE(cleanup, fd);
+			/* If the setgroups file has the value "deny",
+			 * then the setgroups(2) system call can't
+			 * subsequently be reenabled (by writing "allow" to
+			 * the file) in this user namespace.  (Attempts to
+			 * do so will fail with the error EPERM.)
+			*/
+			fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
+			ret = write(fd, "allow", 5);
+
+			if (ret != -1) {
+				tst_brkm(TBROK | TERRNO, cleanup,
+					"write action should be failed");
+			} else if (errno != EPERM) {
+				tst_brkm(TBROK | TERRNO, cleanup,
+					"unexpected error: (%d) %s\n",
+					errno, strerror(errno));
+			}
+
+			SAFE_CLOSE(cleanup, fd);
 
 			sprintf(path, "/proc/%d/setgroups", cpid2);
 			fd = SAFE_OPEN(cleanup, path, O_WRONLY, 0644);
-- 
1.9.1

