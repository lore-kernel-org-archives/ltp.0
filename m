From: Amir Goldstein <amir73il@gmail.com>
Date: Wed,  9 Sep 2020 20:56:59 +0300
Subject: [LTP] [PATCH 02/10] syscalls/fanotify16: Adjust test to use
 FAN_REPORT_DFID_NAME
In-Reply-To: <20200909175707.10670-1-amir73il@gmail.com>
References: <20200909175707.10670-1-amir73il@gmail.com>
Message-ID: <20200909175707.10670-3-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The new FAN_DIR_MODIFY event was removed before final v5.7 release
and will be replaced with a new group flag FAN_REPORT_DFID_NAME to
report name info for FAN_CREATE, FAN_DELETE and FAN_MOVE events.
Adjust the test to use this new API.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 11 ++-
 .../kernel/syscalls/fanotify/fanotify16.c     | 69 ++++++++++---------
 2 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 4a7959989..91535718b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -89,9 +89,6 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
 #ifndef FAN_OPEN_EXEC_PERM
 #define FAN_OPEN_EXEC_PERM	0x00040000
 #endif
-#ifndef FAN_DIR_MODIFY
-#define FAN_DIR_MODIFY		0x00080000
-#endif
 
 /*
  * FAN_ALL_PERM_EVENTS has been deprecated, so any new permission events
@@ -103,6 +100,11 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
 #define LTP_ALL_PERM_EVENTS	(FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
 				 FAN_ACCESS_PERM)
 
+struct fanotify_group_type {
+	unsigned int flag;
+	const char * name;
+};
+
 struct fanotify_mark_type {
 	unsigned int flag;
 	const char * name;
@@ -201,6 +203,9 @@ static inline void fanotify_save_fid(const char *path,
 }
 #endif /* HAVE_NAME_TO_HANDLE_AT */
 
+#define INIT_FANOTIFY_GROUP_TYPE(t) \
+	{ FAN_ ## t, "FAN_" #t }
+
 #define INIT_FANOTIFY_MARK_TYPE(t) \
 	{ FAN_MARK_ ## t, "FAN_MARK_" #t }
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index d366a455f..f3fbd3bc0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -5,7 +5,8 @@
  * Started by Amir Goldstein <amir73il@gmail.com>
  *
  * DESCRIPTION
- *     Check FAN_DIR_MODIFY events with name info
+ *     Check fanotify directory entry modification events with group
+ *     init flags FAN_REPORT_DFID_NAME (dir fid + name)
  */
 #define _GNU_SOURCE
 #include "config.h"
@@ -23,7 +24,6 @@
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
-#include <sys/inotify.h>
 
 #define EVENT_MAX 10
 
@@ -59,27 +59,30 @@ static char event_buf[EVENT_BUF_LEN];
 
 static struct test_case_t {
 	const char *tname;
+	struct fanotify_group_type group;
 	struct fanotify_mark_type mark;
 	unsigned long mask;
 	struct fanotify_mark_type sub_mark;
 	unsigned long sub_mask;
 } test_cases[] = {
 	{
-		/* Filesystem watch for dir modify and delete self events */
-		"FAN_REPORT_FID on filesystem with FAN_DIR_MODIFY",
+		/* Filesystem watch for directory entry modification events */
+		"FAN_REPORT_DFID_NAME monitor filesystem for create/delete/move",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_NAME),
 		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
-		FAN_DIR_MODIFY | FAN_DELETE_SELF | FAN_ONDIR,
+		FAN_CREATE | FAN_DELETE| FAN_MOVE | FAN_DELETE_SELF | FAN_ONDIR,
 		{},
 		0,
 	},
 	{
-		/* Recursive watches for dir modify events */
-		"FAN_REPORT_FID on directories with FAN_DIR_MODIFY",
+		/* Recursive watches for directory entry modification events */
+		"FAN_REPORT_DFID_NAME monitor directories for create/delete/move",
+		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_NAME),
 		INIT_FANOTIFY_MARK_TYPE(INODE),
-		FAN_DIR_MODIFY,
-		/* Watches for delete self event on subdir */
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_ONDIR,
+		/* Watches for directory entry modification events on subdir */
 		INIT_FANOTIFY_MARK_TYPE(INODE),
-		FAN_DIR_MODIFY | FAN_DELETE_SELF | FAN_ONDIR,
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_ONDIR,
 	},
 };
 
@@ -87,20 +90,23 @@ static void do_test(unsigned int number)
 {
 	int fd, len = 0, i = 0, test_num = 0, tst_count = 0;
 	struct test_case_t *tc = &test_cases[number];
+	struct fanotify_group_type *group = &tc->group;
 	struct fanotify_mark_type *mark = &tc->mark;
 	struct fanotify_mark_type *sub_mark = &tc->sub_mark;
 	struct fanotify_fid_t root_fid, dir_fid, file_fid;
 
 	tst_res(TINFO, "Test #%d: %s", number, tc->tname);
 
-	fd_notify = fanotify_init(FAN_REPORT_FID, 0);
+	fd_notify = fanotify_init(group->flag, 0);
 	if (fd_notify == -1) {
-		if (errno == EINVAL)
-			tst_brk(TCONF,
-				"FAN_REPORT_FID not supported by kernel");
+		if (errno == EINVAL) {
+			tst_res(TCONF,
+				"%s not supported by kernel", group->name);
+			return;
+		}
 
 		tst_brk(TBROK | TERRNO,
-			"fanotify_init(FAN_REPORT_FID, 0) failed");
+			"fanotify_init(%s, 0) failed", group->name);
 	}
 
 	/*
@@ -108,10 +114,6 @@ static void do_test(unsigned int number)
 	 */
 	if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag, tc->mask,
 			  AT_FDCWD, MOUNT_PATH) < 0) {
-		if (errno == EINVAL)
-			tst_brk(TCONF,
-				"FAN_DIR_MODIFY not supported by kernel");
-
 		tst_brk(TBROK | TERRNO,
 		    "fanotify_mark (%d, FAN_MARK_ADD | %s, 0x%lx, "
 		    "AT_FDCWD, '"MOUNT_PATH"') failed",
@@ -138,7 +140,7 @@ static void do_test(unsigned int number)
 		    fd_notify, sub_mark->name, tc->sub_mask, dname1);
 	}
 
-	event_set[tst_count].mask = FAN_DIR_MODIFY;
+	event_set[tst_count].mask = FAN_CREATE | FAN_ONDIR;
 	event_set[tst_count].fid = &root_fid;
 	strcpy(event_set[tst_count].name, DIR_NAME1);
 	tst_count++;
@@ -160,22 +162,22 @@ static void do_test(unsigned int number)
 	len += SAFE_READ(0, fd_notify, event_buf + len, EVENT_BUF_LEN - len);
 
 	/*
-	 * FAN_DIR_MODIFY events with the same name are merged.
+	 * FAN_CREATE|FAN_DELETE|FAN_MOVE events with the same name are merged.
 	 */
-	event_set[tst_count].mask = FAN_DIR_MODIFY;
+	event_set[tst_count].mask = FAN_CREATE | FAN_MOVED_FROM;
 	event_set[tst_count].fid = &dir_fid;
 	strcpy(event_set[tst_count].name, FILE_NAME1);
 	tst_count++;
-	event_set[tst_count].mask = FAN_DIR_MODIFY;
+	event_set[tst_count].mask = FAN_DELETE | FAN_MOVED_TO;
 	event_set[tst_count].fid = &dir_fid;
 	strcpy(event_set[tst_count].name, FILE_NAME2);
 	tst_count++;
-
 	/*
 	 * Directory watch does not get self events on children.
-	 * Filesystem watch gets self event w/o name info.
+	 * Filesystem watch gets self event w/o name info if FAN_REPORT_FID
+	 * is set.
 	 */
-	if (mark->flag == FAN_MARK_FILESYSTEM) {
+	if (mark->flag == FAN_MARK_FILESYSTEM && (group->flag & FAN_REPORT_FID)) {
 		event_set[tst_count].mask = FAN_DELETE_SELF;
 		event_set[tst_count].fid = &file_fid;
 		strcpy(event_set[tst_count].name, "");
@@ -188,19 +190,20 @@ static void do_test(unsigned int number)
 	/* Read more events on dirs */
 	len += SAFE_READ(0, fd_notify, event_buf + len, EVENT_BUF_LEN - len);
 
-	event_set[tst_count].mask = FAN_DIR_MODIFY;
+	event_set[tst_count].mask = FAN_MOVED_FROM | FAN_ONDIR;
 	event_set[tst_count].fid = &root_fid;
 	strcpy(event_set[tst_count].name, DIR_NAME1);
 	tst_count++;
-	event_set[tst_count].mask = FAN_DIR_MODIFY;
+	event_set[tst_count].mask = FAN_DELETE | FAN_MOVED_TO | FAN_ONDIR;
 	event_set[tst_count].fid = &root_fid;
 	strcpy(event_set[tst_count].name, DIR_NAME2);
 	tst_count++;
 	/*
-	 * Directory watch gets self event on itself w/o name info.
+	 * Directory watch gets self event on itself and filesystem watch gets
+	 * self event on all directories with name ".".
 	 */
 	event_set[tst_count].mask = FAN_DELETE_SELF | FAN_ONDIR;
-	strcpy(event_set[tst_count].name, "");
+	strcpy(event_set[tst_count].name, ".");
 	event_set[tst_count].fid = &dir_fid;
 	tst_count++;
 
@@ -224,8 +227,8 @@ static void do_test(unsigned int number)
 		file_handle = (struct file_handle *)event_fid->handle;
 		fhlen = file_handle->handle_bytes;
 		filename = (char *)file_handle->f_handle + fhlen;
-		namelen = ((char *)event + event->event_len) - filename;
-		/* End of event could have name, zero padding, both or none */
+		namelen = ((char *)event_fid + event_fid->hdr.len) - filename;
+		/* End of event_fid could have name, zero padding, both or none */
 		if (namelen > 0) {
 			namelen = strlen(filename);
 		} else {
@@ -236,7 +239,7 @@ static void do_test(unsigned int number)
 		if (expected->name[0]) {
 			info_type = FAN_EVENT_INFO_TYPE_DFID_NAME;
 		} else {
-			info_type = FAN_EVENT_INFO_TYPE_FID;
+			info_type = FAN_EVENT_INFO_TYPE_DFID;
 		}
 
 		if (test_num >= tst_count) {
-- 
2.17.1

