From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 Apr 2020 09:50:00 +0300
Subject: [LTP] [PATCH 2/4] syscalls/fanotify15: Minor corrections
In-Reply-To: <20200421065002.12417-1-amir73il@gmail.com>
References: <20200421065002.12417-1-amir73il@gmail.com>
Message-ID: <20200421065002.12417-3-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Fix calculation of events buffer size
- Read file events and dir events in two batches
- Generate FAN_MODIFY event explicitly with truncate() operation
  instead of FAN_ATTRIB event implicitly with create() operation
- FAN_MODIFY and FAN_DELETE_SELF may or may not be merged

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify15.c     | 58 ++++++++++++++-----
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index e0d513025..454441bfe 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -25,8 +25,14 @@
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
 
-#define BUF_SIZE 256
-#define EVENT_MAX 256
+#define EVENT_MAX 10
+
+/* Size of the event structure, not including file handle */
+#define EVENT_SIZE (sizeof(struct fanotify_event_metadata) + \
+		    sizeof(struct fanotify_event_info_fid))
+/* Double events buffer size to account for file handles */
+#define EVENT_BUF_LEN (EVENT_MAX * EVENT_SIZE * 2)
+
 
 #define MOUNT_POINT "mntpoint"
 #define TEST_DIR MOUNT_POINT"/test_dir"
@@ -44,7 +50,7 @@ struct event_t {
 };
 
 static int fanotify_fd;
-static char events_buf[BUF_SIZE];
+static char events_buf[EVENT_BUF_LEN];
 static struct event_t event_set[EVENT_MAX];
 
 static void do_test(void)
@@ -55,23 +61,24 @@ static void do_test(void)
 	struct fanotify_event_metadata *metadata;
 	struct fanotify_event_info_fid *event_fid;
 
+
 	if (fanotify_mark(fanotify_fd, FAN_MARK_ADD | FAN_MARK_FILESYSTEM,
-				FAN_CREATE | FAN_DELETE | FAN_ATTRIB |
-				FAN_MOVED_FROM | FAN_MOVED_TO |
-				FAN_DELETE_SELF | FAN_ONDIR,
+				FAN_CREATE | FAN_DELETE | FAN_MOVE |
+				FAN_MODIFY | FAN_DELETE_SELF | FAN_ONDIR,
 				AT_FDCWD, TEST_DIR) == -1) {
 		if (errno == ENODEV)
 			tst_brk(TCONF,
 				"FAN_REPORT_FID not supported on %s "
 				"filesystem", tst_device->fs_type);
 		tst_brk(TBROK | TERRNO,
-			"fanotify_mark(%d, FAN_MARK_ADD, FAN_CREATE | "
-			"FAN_DELETE | FAN_MOVED_FROM | FAN_MOVED_TO | "
-			"FAN_DELETE_SELF | FAN_ONDIR, AT_FDCWD, %s) failed",
+			"fanotify_mark(%d, FAN_MARK_ADD | FAN_MARK_FILESYSTEM, "
+			"FAN_CREATE | FAN_DELETE | FAN_MOVE | "
+			"FAN_MODIFY | FAN_DELETE_SELF | FAN_ONDIR, "
+			"AT_FDCWD, %s) failed",
 			fanotify_fd, TEST_DIR);
 	}
 
-	/* Generate a sequence of events */
+	/* All dirent events on testdir are merged */
 	event_set[count].mask = FAN_CREATE | FAN_MOVED_FROM | FAN_MOVED_TO | \
 				FAN_DELETE;
 	event_set[count].handle.handle_bytes = MAX_HANDLE_SZ;
@@ -82,9 +89,22 @@ static void do_test(void)
 	fd = SAFE_CREAT(FILE1, 0644);
 	SAFE_CLOSE(fd);
 
+	/*
+	 * Event on child file is not merged with dirent events.
+	 */
+	event_set[count].mask = FAN_MODIFY;
+	event_set[count].handle.handle_bytes = MAX_HANDLE_SZ;
+	fanotify_get_fid(FILE1, &event_set[count].fsid,
+			 &event_set[count].handle);
+	count++;
+
+	SAFE_TRUNCATE(FILE1, 1);
 	SAFE_RENAME(FILE1, FILE2);
 
-	event_set[count].mask = FAN_ATTRIB | FAN_DELETE_SELF;
+	/*
+	 * FAN_DELETE_SELF may be merged with FAN_MODIFY event above.
+	 */
+	event_set[count].mask = FAN_DELETE_SELF;
 	event_set[count].handle.handle_bytes = MAX_HANDLE_SZ;
 	fanotify_get_fid(FILE2, &event_set[count].fsid,
 			 &event_set[count].handle);
@@ -92,6 +112,9 @@ static void do_test(void)
 
 	SAFE_UNLINK(FILE2);
 
+	/* Read file events from the event queue */
+	len = SAFE_READ(0, fanotify_fd, events_buf, EVENT_BUF_LEN);
+
 	/*
 	 * Generate a sequence of events on a directory. Subsequent events
 	 * are merged, so it's required that we set FAN_ONDIR once in
@@ -118,13 +141,12 @@ static void do_test(void)
 
 	SAFE_RMDIR(DIR2);
 
-	/* Read events from the event queue */
-	len = SAFE_READ(0, fanotify_fd, events_buf, BUF_SIZE);
+	/* Read dir events from the event queue */
+	len += SAFE_READ(0, fanotify_fd, events_buf + len, EVENT_BUF_LEN - len);
 
 	/* Process each event in buffer */
 	for (i = 0, metadata = (struct fanotify_event_metadata *) events_buf;
-		FAN_EVENT_OK(metadata, len);
-		metadata = FAN_EVENT_NEXT(metadata,len), i++) {
+		FAN_EVENT_OK(metadata, len); i++) {
 		event_fid = (struct fanotify_event_info_fid *) (metadata + 1);
 		event_file_handle = (struct file_handle *) event_fid->handle;
 
@@ -141,7 +163,7 @@ static void do_test(void)
 				"Received unexpected file descriptor %d in "
 				"event. Expected to get FAN_NOFD(%d)",
 				metadata->fd, FAN_NOFD);
-		} else if (metadata->mask != event_set[i].mask) {
+		} else if (!(metadata->mask & event_set[i].mask)) {
 			tst_res(TFAIL,
 				"Got event: mask=%llx (expected %llx) "
 				"pid=%u fd=%d",
@@ -197,6 +219,10 @@ static void do_test(void)
 				*(unsigned long *)
 				event_file_handle->f_handle);
 		}
+		metadata->mask  &= ~event_set[i].mask;
+		/* No events left in current mask? Go for next event */
+		if (metadata->mask == 0)
+			metadata = FAN_EVENT_NEXT(metadata, len);
 	}
 
 	for (; i < count; i++)
-- 
2.17.1

