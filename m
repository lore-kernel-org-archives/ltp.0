From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Nov 2018 08:51:17 +0200
Subject: [LTP] [PATCH 3/5] syscalls/fanotify01: add test for
	FAN_MARK_FILESYSTEM events
In-Reply-To: <20181116065119.6912-1-amir73il@gmail.com>
References: <20181116065119.6912-1-amir73il@gmail.com>
Message-ID: <20181116065119.6912-4-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h   | 3 +++
 testcases/kernel/syscalls/fanotify/fanotify01.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 5adef54d7..535f1cef2 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -57,6 +57,9 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
 #ifndef FAN_MARK_INODE
 #define FAN_MARK_INODE		0
 #endif
+#ifndef FAN_MARK_FILESYSTEM
+#define FAN_MARK_FILESYSTEM	0x00000100
+#endif
 
 struct fanotify_mark_type {
 	unsigned int flag;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify01.c b/testcases/kernel/syscalls/fanotify/fanotify01.c
index 5dfb67b61..c3d299474 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify01.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify01.c
@@ -44,6 +44,10 @@ static struct tcase {
 		"mount mark events",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 	},
+	{
+		"filesystem mark events",
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+	},
 };
 
 static char fname[BUF_SIZE];
@@ -68,6 +72,11 @@ static void test_fanotify(unsigned int n)
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
 			  FAN_ACCESS | FAN_MODIFY | FAN_CLOSE | FAN_OPEN,
 			  AT_FDCWD, fname) < 0) {
+		if (errno == EINVAL && mark->flag == FAN_MARK_FILESYSTEM) {
+			tst_res(TCONF,
+				"FAN_MARK_FILESYSTEM not supported in kernel?");
+			return;
+		}
 		tst_brk(TBROK | TERRNO,
 			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS | %s | "
 			"FAN_MODIFY | FAN_CLOSE | FAN_OPEN, AT_FDCWD, %s) "
-- 
2.17.1

