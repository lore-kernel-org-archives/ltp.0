From: Jan Stancek <jstancek@redhat.com>
Date: Wed,  4 Oct 2017 12:42:43 +0200
Subject: [LTP] [PATCH 2/2] security/dirtyc0w: synchronize parent and child
In-Reply-To: <94518262a76edca533440acb73611eb93184dc90.1507113734.git.jstancek@redhat.com>
References: <94518262a76edca533440acb73611eb93184dc90.1507113734.git.jstancek@redhat.com>
Message-ID: <1300ca0b5103f4f145af3be1a0295974a04dcae8.1507113734.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add checkpoint to guarantee that parent doesn't send
signal to child before it sets up signal handler.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/security/dirtyc0w/dirtyc0w.c       | 14 +++++++++++++-
 testcases/kernel/security/dirtyc0w/dirtyc0w_child.c |  3 +++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w.c b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
index b8094ba977ab..5658f3233f59 100644
--- a/testcases/kernel/security/dirtyc0w/dirtyc0w.c
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w.c
@@ -36,6 +36,7 @@
  *   mm: remove gup_flags FOLL_WRITE games from __get_user_pages()
  */
 
+#include <errno.h>
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <pthread.h>
@@ -49,6 +50,7 @@
 
 #define FNAME "test"
 #define STR   "this is not a test\n"
+#define TEST_APP "dirtyc0w_child"
 
 static uid_t nobody_uid;
 static gid_t nobody_gid;
@@ -67,6 +69,7 @@ void dirtyc0w_test(void)
 {
 	int i, fd, pid, fail = 0;
 	char c;
+	char *av[] = {TEST_APP, NULL};
 
 	/* Create file */
 	fd = SAFE_OPEN(FNAME, O_WRONLY|O_CREAT|O_EXCL, 0444);
@@ -78,9 +81,11 @@ void dirtyc0w_test(void)
 	if (!pid) {
 		SAFE_SETGID(nobody_gid);
 		SAFE_SETUID(nobody_uid);
-		SAFE_EXECLP("dirtyc0w_child", "dirtyc0w_child", NULL);
+		(void)execve(TEST_APP, av, tst_ipc_envp);
+		tst_brk(TBROK|TERRNO, "execve failed");
 	}
 
+	TST_CHECKPOINT_WAIT(0);
 	for (i = 0; i < 100; i++)  {
 		usleep(10000);
 
@@ -102,10 +107,17 @@ void dirtyc0w_test(void)
 		tst_res(TPASS, "Bug not reproduced");
 }
 
+static const char *const resource_files[] = {
+	TEST_APP,
+	NULL,
+};
+
 static struct tst_test test = {
 	.needs_tmpdir = 1,
+	.needs_checkpoints = 1,
 	.forks_child = 1,
 	.needs_root = 1,
 	.setup = setup,
 	.test_all = dirtyc0w_test,
+	.resource_files = resource_files,
 };
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

