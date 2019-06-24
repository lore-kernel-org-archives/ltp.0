From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 24 Jun 2019 11:52:41 +0300
Subject: [LTP] [PATCH] syscalls/fanotify13: add test coverage for fsid cache
	bug
Message-ID: <20190624085241.32276-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This bug was reported by syzbot:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxhsnOXXVCuOT4p4c_koBMFfprWwdtCPGNGhzprFaJZwRA@mail.gmail.com/T/#t

And fixed by kernel commit
c285a2f01d69 ("fanotify: update connector fsid cache on add mark")

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Cyril,

Here is a re-send of the patch you missed.
I also added the kernel fix commit for reference.

Thanks,
Amir.

 .../kernel/syscalls/fanotify/fanotify13.c     | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 3e4778e68..e5681c804 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -85,6 +85,7 @@ static struct test_case_t {
 	}
 };
 
+static int nofid_fd;
 static int fanotify_fd;
 static char events_buf[BUF_SIZE];
 static struct event_t event_set[EVENT_MAX];
@@ -281,21 +282,32 @@ out:
 
 static void do_setup(void)
 {
-	int fd;
-
 	/* Check for kernel fanotify support */
-	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
-	SAFE_CLOSE(fd);
+	nofid_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 
 	/* Create file and directory objects for testing */
 	create_objects();
 
+	/*
+	 * Create a mark on first inode without FAN_REPORT_FID, to test
+	 * uninitialized connector->fsid cache. This mark remains for all test
+	 * cases and is not expected to get any events (no writes in this test).
+	 */
+	if (fanotify_mark(nofid_fd, FAN_MARK_ADD, FAN_CLOSE_WRITE, AT_FDCWD,
+			  FILE_PATH_ONE) == -1) {
+		tst_brk(TBROK | TERRNO,
+			"fanotify_mark(%d, FAN_MARK_ADD, FAN_CLOSE_WRITE, "
+			"AT_FDCWD, "FILE_PATH_ONE") failed",
+			nofid_fd);
+	}
+
 	/* Get the filesystem fsid and file handle for each created object */
 	get_object_stats();
 }
 
 static void do_cleanup(void)
 {
+	SAFE_CLOSE(nofid_fd);
 	if (fanotify_fd > 0)
 		SAFE_CLOSE(fanotify_fd);
 }
-- 
2.17.1

