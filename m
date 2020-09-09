From: Amir Goldstein <amir73il@gmail.com>
Date: Wed,  9 Sep 2020 20:57:01 +0300
Subject: [LTP] [PATCH 04/10] syscalls/fanotify16: Add test cases more init
 flag combinations
In-Reply-To: <20200909175707.10670-1-amir73il@gmail.com>
References: <20200909175707.10670-1-amir73il@gmail.com>
Message-ID: <20200909175707.10670-5-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test more combination of flags FAN_REPORT_DIR_FID, FAN_REPORT_FID
and FAN_REPORT_NAME.

Reporting different information per event may result in different event
merging.  For example, with FAN_REPORT_DFID_NAME, create/open/moved_from
of "file1" are merged and moved_to/delete/close of "file2" are merged.
With FAN_REPORT_DIR_FID, open/close of the file are merged (dir fid +
child fid info are the same) and create/move/delete of file are merged
(dir fid info is the same).

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h |   8 ++
 .../kernel/syscalls/fanotify/fanotify16.c     | 110 ++++++++++++++++--
 2 files changed, 108 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 91535718b..a9154f993 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -52,6 +52,14 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
 #define FAN_REPORT_DFID_NAME     (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
 #endif
 
+/* Non-uapi convenience macros */
+#ifndef FAN_REPORT_DFID_NAME_FID
+#define FAN_REPORT_DFID_NAME_FID (FAN_REPORT_DFID_NAME | FAN_REPORT_FID)
+#endif
+#ifndef FAN_REPORT_DFID_FID
+#define FAN_REPORT_DFID_FID      (FAN_REPORT_DIR_FID | FAN_REPORT_FID)
+#endif
+
 #ifndef FAN_MARK_INODE
 #define FAN_MARK_INODE		0
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index 76f053fd7..c8c7a9ee8 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -6,7 +6,11 @@
  *
  * DESCRIPTION
  *     Check fanotify directory entry modification events, events on child and
- *     on self with group init flags FAN_REPORT_DFID_NAME (dir fid + name)
+ *     on self with group init flags:
+ *     - FAN_REPORT_DFID_NAME (dir fid + name)
+ *     - FAN_REPORT_DIR_FID   (dir fid)
+ *     - FAN_REPORT_DIR_FID | FAN_REPORT_FID   (dir fid + child fid)
+ *     - FAN_REPORT_DFID_NAME | FAN_REPORT_FID (dir fid + name + child fid)
  */
 #define _GNU_SOURCE
 #include "config.h"
@@ -84,6 +88,63 @@ static struct test_case_t {
 		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
 		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
 	},
+	{
+		"FAN_REPORT_DIR_FID monitor filesystem for create/delete/move/open/close",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DIR_FID),
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR,
+		/* Mount watch for events possible on children */
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
+	},
+	{
+		"FAN_REPORT_DIR_FID monitor directories for create/delete/move/open/close",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DIR_FID),
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_ONDIR,
+		/* Watches for self events on subdir and events on subdir's children */
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
+		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
+	},
+	{
+		"FAN_REPORT_DFID_FID monitor filesystem for create/delete/move/open/close",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_FID),
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR,
+		/* Mount watch for events possible on children */
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
+	},
+	{
+		"FAN_REPORT_DFID_FID monitor directories for create/delete/move/open/close",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_FID),
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_ONDIR,
+		/* Watches for self events on subdir and events on subdir's children */
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
+		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
+	},
+	{
+		"FAN_REPORT_DFID_NAME_FID monitor filesystem for create/delete/move/open/close",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_NAME_FID),
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR,
+		/* Mount watch for events possible on children */
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
+	},
+	{
+		"FAN_REPORT_DFID_NAME_FID monitor directories for create/delete/move/open/close",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_NAME_FID),
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_ONDIR,
+		/* Watches for self events on subdir and events on subdir's children */
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
+		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
+	},
 };
 
 static void do_test(unsigned int number)
@@ -174,17 +235,31 @@ static void do_test(unsigned int number)
 	/*
 	 * Event on non-dir child with the same name may be merged with the
 	 * directory entry modification events above, unless FAN_REPORT_FID is
-	 * set and child fid is reported.
+	 * set and child fid is reported. If FAN_REPORT_FID is set but
+	 * FAN_REPORT_NAME is not set, then FAN_CREATE above is merged with
+	 * FAN_DELETE below and FAN_OPEN will be merged with FAN_CLOSE.
 	 */
-	event_set[tst_count].mask = FAN_OPEN;
-	event_set[tst_count].fid = &dir_fid;
-	strcpy(event_set[tst_count].name, FILE_NAME1);
-	tst_count++;
+	if (group->flag & FAN_REPORT_NAME) {
+		event_set[tst_count].mask = FAN_OPEN;
+		event_set[tst_count].fid = &dir_fid;
+		strcpy(event_set[tst_count].name, FILE_NAME1);
+		tst_count++;
+	}
 
 	event_set[tst_count].mask = FAN_DELETE | FAN_MOVED_TO;
 	event_set[tst_count].fid = &dir_fid;
 	strcpy(event_set[tst_count].name, FILE_NAME2);
 	tst_count++;
+	/*
+	 * When not reporting name, open of FILE_NAME1 is merged
+	 * with close of FILE_NAME2.
+	 */
+	if (!(group->flag & FAN_REPORT_NAME)) {
+		event_set[tst_count].mask = FAN_OPEN | FAN_CLOSE_WRITE;
+		event_set[tst_count].fid = &dir_fid;
+		strcpy(event_set[tst_count].name, "");
+		tst_count++;
+	}
 	/*
 	 * Directory watch does not get self events on children.
 	 * Filesystem watch gets self event w/o name info if FAN_REPORT_FID
@@ -196,10 +271,17 @@ static void do_test(unsigned int number)
 		strcpy(event_set[tst_count].name, "");
 		tst_count++;
 	}
-	event_set[tst_count].mask = FAN_CLOSE_WRITE;
-	event_set[tst_count].fid = &dir_fid;
-	strcpy(event_set[tst_count].name, FILE_NAME2);
-	tst_count++;
+	/*
+	 * When reporting name, close of FILE_NAME2 is not merged with
+	 * open of FILE_NAME1 and it is received after the merged self
+	 * events.
+	 */
+	if (group->flag & FAN_REPORT_NAME) {
+		event_set[tst_count].mask = FAN_CLOSE_WRITE;
+		event_set[tst_count].fid = &dir_fid;
+		strcpy(event_set[tst_count].name, FILE_NAME2);
+		tst_count++;
+	}
 
 	dirfd = SAFE_OPEN(dname1, O_RDONLY | O_DIRECTORY);
 	SAFE_CLOSE(dirfd);
@@ -269,8 +351,16 @@ static void do_test(unsigned int number)
 			namelen = 0;
 		}
 
+		if (!(group->flag & FAN_REPORT_NAME))
+			expected->name[0] = 0;
+
 		if (expected->name[0]) {
 			info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
+		} else if (expected->mask & FAN_ONDIR) {
+			info_type = FAN_EVENT_INFO_TYPE_DFID;
+		} else if (expected->mask & (FAN_DELETE_SELF | FAN_MOVE_SELF)) {
+			/* Self event on non-dir has only child fid */
+			info_type = FAN_EVENT_INFO_TYPE_FID;
 		} else {
 			info_type = FAN_EVENT_INFO_TYPE_DFID;
 		}
-- 
2.17.1

