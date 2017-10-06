From: Jan Stancek <jstancek@redhat.com>
Date: Fri,  6 Oct 2017 13:57:48 +0200
Subject: [LTP] [PATCH 1/2 v2] lib: allow checkpoints to be used by any uid
Message-ID: <94518262a76edca533440acb73611eb93184dc90.1507290372.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Allow unprivileged child to synchronize with privileged parent.
Use chmod after open, because effective permissions set by open()
are modified by the process's umask: (mode & ~umask).

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_test.c | 1 +
 1 file changed, 1 insertion(+)

No changes in v2.

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 26414e31ca77..233b370794a6 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -93,6 +93,7 @@ static void setup_ipc(void)
 	ipc_fd = open(shm_path, O_CREAT | O_EXCL | O_RDWR, 0600);
 	if (ipc_fd < 0)
 		tst_brk(TBROK | TERRNO, "open(%s)", shm_path);
+	SAFE_CHMOD(shm_path, 0666);
 
 	SAFE_FTRUNCATE(ipc_fd, size);
 
-- 
1.8.3.1

