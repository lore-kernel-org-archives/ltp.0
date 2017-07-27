From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 Jul 2017 11:34:45 +0200
Subject: [LTP] [PATCH] [COMMITTED] lib/tst_test.c: Do not cleanup_ipc() if
	uninitialized
Message-ID: <20170727093445.29964-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We do attempt to cleanup the IPC even if the setup_ipc() function was
not called. That happens if the tst_test structure has missing test
function, if the test needs root and is executed as an user, etc.

We wrongly call msync() and munmap() on a NULL pointer in this case,
while this is mostly harmless it's also wrong, so this commit fixes the
cleanup functions to check if the shm_path and the shm pointer were
initialized before we attempt to remove them.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 51d39438d..ab0404a5e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -117,11 +117,13 @@ static void cleanup_ipc(void)
 	if (ipc_fd > 0 && close(ipc_fd))
 		tst_res(TWARN | TERRNO, "close(ipc_fd) failed");
 
-	if (!access(shm_path, F_OK) && unlink(shm_path))
+	if (shm_path[0] && !access(shm_path, F_OK) && unlink(shm_path))
 		tst_res(TWARN | TERRNO, "unlink(%s) failed", shm_path);
 
-	msync((void*)results, size, MS_SYNC);
-	munmap((void*)results, size);
+	if (results) {
+		msync((void*)results, size, MS_SYNC);
+		munmap((void*)results, size);
+	}
 }
 
 void tst_reinit(void)
-- 
2.13.0

