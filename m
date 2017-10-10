From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Oct 2017 14:36:12 +0200
Subject: [LTP] [PATCH/RFC] lib: add LTP_IPC_PATH to env. variables by default
Message-ID: <928440776c092e8a6da22c42b83606a142d90887.1507638841.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Child started by exec() that needs to do tst_reinit() in order
to use checkpoints will inherit LTP_IPC_PATH by default.
Parent can choose to override/omit it in envp array when calling
exec[lvp]e().

Also fix couple places to use IPC_ENV_VAR define.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 233b370794a6..27a0b7c36679 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -100,10 +100,12 @@ static void setup_ipc(void)
 	results = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, ipc_fd, 0);
 
 	/* Checkpoints needs to be accessible from processes started by exec() */
-	if (tst_test->needs_checkpoints)
+	if (tst_test->needs_checkpoints) {
 		sprintf(ipc_path, IPC_ENV_VAR "=%s", shm_path);
-	else
+		putenv(ipc_path);
+	} else {
 		SAFE_UNLINK(shm_path);
+	}
 
 	SAFE_CLOSE(ipc_fd);
 
@@ -131,13 +133,13 @@ static void cleanup_ipc(void)
 
 void tst_reinit(void)
 {
-	const char *path = getenv("LTP_IPC_PATH");
+	const char *path = getenv(IPC_ENV_VAR);
 	size_t size = getpagesize();
 	int fd;
 	void *ptr;
 
 	if (!path)
-		tst_brk(TBROK, "LTP_IPC_PATH is not defined");
+		tst_brk(TBROK, IPC_ENV_VAR" is not defined");
 
 	if (access(path, F_OK))
 		tst_brk(TBROK, "File %s does not exist!", path);
-- 
1.8.3.1

