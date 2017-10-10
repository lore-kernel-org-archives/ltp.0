From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 10 Oct 2017 17:05:09 +0200
Subject: [LTP] [PATCH 1/6] lib: add LTP_IPC_PATH to env. variables by default
Message-ID: <7fe9947329b48673f7f9ee2e0b127619fdfe0c34.1507647255.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Child started by exec() that needs to do tst_reinit() in order
to use checkpoints will inherit LTP_IPC_PATH by default.
Parent can choose to override/omit it in envp array when calling
exec[lvp]e().

Also fix couple places to use LTP_IPC_PATH define.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_test.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 26414e31ca77..25cb234425ab 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -99,10 +99,12 @@ static void setup_ipc(void)
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
 
@@ -130,13 +132,13 @@ static void cleanup_ipc(void)
 
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

