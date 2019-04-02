From: Amir Goldstein <mbobrowski@mbobrowski.org>
Date: Tue, 2 Apr 2019 21:01:55 +1100
Subject: [LTP] [PATCH 1/4] syscalls/fanotify01: add FAN_REPORT_FID test cases
In-Reply-To: <cover.1554197461.git.mbobrowski@mbobrowski.org>
References: <cover.1554197461.git.mbobrowski@mbobrowski.org>
Message-ID: <d45386d98f40a9a9f0163964796c1d60e3032aa1.1554197461.git.mbobrowski@mbobrowski.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For now, only check that event->fd is FAN_NOFD.
On old kernels the new test with result in TCONF.

tmpfs doesn't support FAN_REPORT_FID (it has zero fsid), so use a
blockdev filesystem. It is better to use a blockdev filesystem for
the rest of the test cases anyway to get more diversity in testing.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h   |  3 ++
 testcases/kernel/syscalls/fanotify/fanotify01.c | 41 +++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index e5cc59232..14654b7c7 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -57,6 +57,9 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
 #ifndef FAN_REPORT_TID
 #define FAN_REPORT_TID		0x00000100
 #endif
+#ifndef FAN_REPORT_FID
+#define FAN_REPORT_FID		0x00000200
+#endif
 
 #ifndef FAN_MARK_INODE
 #define FAN_MARK_INODE		0
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 9b590746e..44966dce5 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -37,18 +37,37 @@
 static struct tcase {
 	const char *tname;
 	struct fanotify_mark_type mark;
+	unsigned int init_flags;
 } tcases[] = {
 	{
 		"inode mark events",
 		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CLASS_NOTIF
 	},
 	{
 		"mount mark events",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_CLASS_NOTIF
 	},
 	{
 		"filesystem mark events",
 		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+		FAN_CLASS_NOTIF
+	},
+	{
+		"inode mark events (FAN_REPORT_FID)",
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CLASS_NOTIF|FAN_REPORT_FID
+	},
+	{
+		"mount mark events (FAN_REPORT_FID)",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_CLASS_NOTIF|FAN_REPORT_FID
+	},
+	{
+		"filesystem mark events (FAN_REPORT_FID)",
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+		FAN_CLASS_NOTIF|FAN_REPORT_FID
 	},
 };
 
@@ -69,7 +88,18 @@ static void test_fanotify(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
-	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
+	fd_notify = fanotify_init(tc->init_flags, O_RDONLY);
+	if (fd_notify < 0) {
+		if (errno == EINVAL &&
+		    (tc->init_flags & FAN_REPORT_FID)) {
+			tst_res(TCONF,
+				"FAN_REPORT_FID not supported in kernel?");
+			return;
+		}
+		tst_brk(TBROK | TERRNO,
+			"fanotify_init (0x%x, O_RDONLY) "
+			"failed", tc->init_flags);
+	}
 
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
 			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
@@ -265,7 +295,8 @@ static void test_fanotify(unsigned int n)
 				(unsigned)getpid(),
 				event->fd);
 		} else {
-			if (event->fd == -2)
+			if (event->fd == -2 || (event->fd == FAN_NOFD &&
+			    (tc->init_flags & FAN_REPORT_FID)))
 				goto pass;
 			ret = read(event->fd, buf, BUF_SIZE);
 			if (ret != (int)strlen(fname)) {
@@ -327,6 +358,12 @@ pass:
 
 static void setup(void)
 {
+	int fd;
+
+	/* Check for kernel fanotify support */
+	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
+	SAFE_CLOSE(fd);
+
 	sprintf(fname, MOUNT_PATH"/tfile_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
 }
-- 
2.16.4


-- 
Matthew Bobrowski
