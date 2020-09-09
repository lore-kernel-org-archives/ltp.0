From: Amir Goldstein <amir73il@gmail.com>
Date: Wed,  9 Sep 2020 20:56:58 +0300
Subject: [LTP] [PATCH 01/10] syscalls/fanotify14: Test cases for
 FAN_REPORT_DFID_NAME
In-Reply-To: <20200909175707.10670-1-amir73il@gmail.com>
References: <20200909175707.10670-1-amir73il@gmail.com>
Message-ID: <20200909175707.10670-2-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check invalid combinations for the new flags.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h   | 10 ++++++++++
 testcases/kernel/syscalls/fanotify/fanotify14.c | 10 +++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index d271578e9..4a7959989 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -44,6 +44,13 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
 #ifndef FAN_REPORT_FID
 #define FAN_REPORT_FID		0x00000200
 #endif
+#ifndef FAN_REPORT_DIR_FID
+#define FAN_REPORT_DIR_FID	0x00000400
+#endif
+#ifndef FAN_REPORT_NAME
+#define FAN_REPORT_NAME		0x00000800
+#define FAN_REPORT_DFID_NAME     (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
+#endif
 
 #ifndef FAN_MARK_INODE
 #define FAN_MARK_INODE		0
@@ -114,6 +121,9 @@ typedef struct {
 #ifndef FAN_EVENT_INFO_TYPE_DFID_NAME
 #define FAN_EVENT_INFO_TYPE_DFID_NAME	2
 #endif
+#ifndef FAN_EVENT_INFO_TYPE_DFID
+#define FAN_EVENT_INFO_TYPE_DFID	3
+#endif
 
 #ifndef HAVE_STRUCT_FANOTIFY_EVENT_INFO_HEADER
 struct fanotify_event_info_header {
diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
index 3ca38d1e7..349177d9a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify14.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
@@ -52,7 +52,15 @@ static struct test_case_t {
 	},
 	{
 		FAN_CLASS_NOTIF | FAN_REPORT_FID, FAN_MARK_MOUNT, INODE_EVENTS
-	}
+	},
+	{
+		/* FAN_REPORT_NAME without FAN_REPORT_DIR_FID is not valid */
+		FAN_CLASS_NOTIF | FAN_REPORT_NAME, 0, 0
+	},
+	{
+		/* FAN_REPORT_NAME without FAN_REPORT_DIR_FID is not valid */
+		FAN_CLASS_NOTIF | FAN_REPORT_FID | FAN_REPORT_NAME, 0, 0
+	},
 };
 
 static void do_test(unsigned int number)
-- 
2.17.1

