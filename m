From: Jan Stancek <jstancek@redhat.com>
Date: Fri,  6 Oct 2017 13:57:49 +0200
Subject: [LTP] [PATCH 2/2 v2] security/dirtyc0w: synchronize parent and child
In-Reply-To: <94518262a76edca533440acb73611eb93184dc90.1507290372.git.jstancek@redhat.com>
References: <94518262a76edca533440acb73611eb93184dc90.1507290372.git.jstancek@redhat.com>
Message-ID: <0d87a0f1b598e710e21ebbabf316c39610e5d47f.1507290372.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add checkpoint to guarantee that parent doesn't send
signal to child before it sets up signal handler.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/security/dirtyc0w/dirtyc0w.c       | 9 ++++++++-
 testcases/kernel/security/dirtyc0w/dirtyc0w_child.c | 3 +++
 2 files changed, 11 insertions(+), 1 deletion(-)

changes in v2:
  don't copy child executable, use execvpe instead.

diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
index b8094ba977ab..b145838ecac7 100644
--- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
@@ -36,6 +36,8 @@
  *   mm: remove gup_flags FOLL_WRITE games from __get_user_pages()
  */
 
+#define _GNU_SOURCE
+#include <errno.h>
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <pthread.h>
@@ -49,6 +51,7 @@
 
 #define FNAME "test"
 #define STR   "this is not a test\n"
+#define TEST_APP "dirtyc0w_child"
 
 static uid_t nobody_uid;
 static gid_t nobody_gid;
@@ -67,6 +70,7 @@ void dirtyc0w_test(void)
 {
 	int i, fd, pid, fail = 0;
 	char c;
+	char *av[] = {TEST_APP, NULL};
 
 	/* Create file */
 	fd = SAFE_OPEN(FNAME, O_WRONLY|O_CREAT|O_EXCL, 0444);
@@ -78,9 +82,11 @@ void dirtyc0w_test(void)
 	if (!pid) {
 		SAFE_SETGID(nobody_gid);
 		SAFE_SETUID(nobody_uid);
-		SAFE_EXECLP("dirtyc0w_child", "dirtyc0w_child", NULL);
+		(void)execvpe(TEST_APP, av, tst_ipc_envp);
+		tst_brk(TBROK|TERRNO, "exec failed");
 	}
 
+	TST_CHECKPOINT_WAIT(0);
 	for (i = 0; i < 100; i++)  {
 		usleep(10000);
 
@@ -104,6 +110,7 @@ void dirtyc0w_test(void)
 
 static struct tst_test test = {
 	.needs_tmpdir = 1,
+	.needs_checkpoints = 1,
 	.forks_child = 1,
 	.needs_root = 1,
 	.setup = setup,
diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c b/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
index 49abdd6ba52e..bb93c62cb979 100644
--- a/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
@@ -104,7 +104,10 @@ int main(void)
 	int fd;
 	struct stat st;
 
+	tst_reinit();
+
 	SAFE_SIGNAL(SIGUSR1, sighandler);
+	TST_CHECKPOINT_WAKE(0);
 
 	/* Open it read only and map */
 	fd = SAFE_OPEN(FNAME, O_RDONLY);
-- 
1.8.3.1

