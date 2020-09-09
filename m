From: Amir Goldstein <amir73il@gmail.com>
Date: Wed,  9 Sep 2020 20:57:00 +0300
Subject: [LTP] [PATCH 03/10] syscalls/fanotify16: Test more event types with
 name
In-Reply-To: <20200909175707.10670-1-amir73il@gmail.com>
References: <20200909175707.10670-1-amir73il@gmail.com>
Message-ID: <20200909175707.10670-4-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Test events "on child" reported with name
- Test events on directory itself reported with name "."
- Test move self event on directory and file

Events open/close are not supported on filesystem mark, so they are set
on either a subdir inode mark or mount mark.

Events "on child" may or may not be merged with directory modification
events with same file name, depending on group init flags, so relax the
exact check to event mask and instead, just expect that all execpted
event types will arrive.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify16.c     | 102 +++++++++++++-----
 1 file changed, 77 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index f3fbd3bc0..76f053fd7 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -5,8 +5,8 @@
  * Started by Amir Goldstein <amir73il@gmail.com>
  *
  * DESCRIPTION
- *     Check fanotify directory entry modification events with group
- *     init flags FAN_REPORT_DFID_NAME (dir fid + name)
+ *     Check fanotify directory entry modification events, events on child and
+ *     on self with group init flags FAN_REPORT_DFID_NAME (dir fid + name)
  */
 #define _GNU_SOURCE
 #include "config.h"
@@ -25,7 +25,7 @@
 #if defined(HAVE_SYS_FANOTIFY_H)
 #include <sys/fanotify.h>
 
-#define EVENT_MAX 10
+#define EVENT_MAX 20
 
 /* Size of the event structure, not including file handle */
 #define EVENT_SIZE (sizeof(struct fanotify_event_metadata) + \
@@ -66,29 +66,29 @@ static struct test_case_t {
 	unsigned long sub_mask;
 } test_cases[] = {
 	{
-		/* Filesystem watch for directory entry modification events */
-		"FAN_REPORT_DFID_NAME monitor filesystem for create/delete/move",
+		"FAN_REPORT_DFID_NAME monitor filesystem for create/delete/move/open/close",
 		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_NAME),
 		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
-		FAN_CREATE | FAN_DELETE| FAN_MOVE | FAN_DELETE_SELF | FAN_ONDIR,
-		{},
-		0,
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR,
+		/* Mount watch for events possible on children */
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_OPEN | FAN_CLOSE | FAN_ONDIR,
 	},
 	{
-		/* Recursive watches for directory entry modification events */
-		"FAN_REPORT_DFID_NAME monitor directories for create/delete/move",
+		"FAN_REPORT_DFID_NAME monitor directories for create/delete/move/open/close",
 		INIT_FANOTIFY_GROUP_TYPE(REPORT_DFID_NAME),
 		INIT_FANOTIFY_MARK_TYPE(INODE),
 		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_ONDIR,
-		/* Watches for directory entry modification events on subdir */
+		/* Watches for self events on subdir and events on subdir's children */
 		INIT_FANOTIFY_MARK_TYPE(INODE),
-		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_ONDIR,
+		FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR |
+		FAN_OPEN | FAN_CLOSE | FAN_EVENT_ON_CHILD,
 	},
 };
 
 static void do_test(unsigned int number)
 {
-	int fd, len = 0, i = 0, test_num = 0, tst_count = 0;
+	int fd, dirfd, len = 0, i = 0, test_num = 0, tst_count = 0;
 	struct test_case_t *tc = &test_cases[number];
 	struct fanotify_group_type *group = &tc->group;
 	struct fanotify_mark_type *mark = &tc->mark;
@@ -125,8 +125,10 @@ static void do_test(unsigned int number)
 
 	/*
 	 * Create subdir and watch open events "on children" with name.
+	 * Make it a mount root.
 	 */
 	SAFE_MKDIR(dname1, 0755);
+	SAFE_MOUNT(dname1, dname1, "none", MS_BIND, NULL);
 
 	/* Save the subdir fid */
 	fanotify_save_fid(dname1, &dir_fid);
@@ -153,6 +155,7 @@ static void do_test(unsigned int number)
 
 	SAFE_WRITE(1, fd, "1", 1);
 	SAFE_RENAME(fname1, fname2);
+
 	SAFE_CLOSE(fd);
 
 	/* Generate delete events with fname2 */
@@ -168,6 +171,16 @@ static void do_test(unsigned int number)
 	event_set[tst_count].fid = &dir_fid;
 	strcpy(event_set[tst_count].name, FILE_NAME1);
 	tst_count++;
+	/*
+	 * Event on non-dir child with the same name may be merged with the
+	 * directory entry modification events above, unless FAN_REPORT_FID is
+	 * set and child fid is reported.
+	 */
+	event_set[tst_count].mask = FAN_OPEN;
+	event_set[tst_count].fid = &dir_fid;
+	strcpy(event_set[tst_count].name, FILE_NAME1);
+	tst_count++;
+
 	event_set[tst_count].mask = FAN_DELETE | FAN_MOVED_TO;
 	event_set[tst_count].fid = &dir_fid;
 	strcpy(event_set[tst_count].name, FILE_NAME2);
@@ -178,11 +191,37 @@ static void do_test(unsigned int number)
 	 * is set.
 	 */
 	if (mark->flag == FAN_MARK_FILESYSTEM && (group->flag & FAN_REPORT_FID)) {
-		event_set[tst_count].mask = FAN_DELETE_SELF;
+		event_set[tst_count].mask = FAN_DELETE_SELF | FAN_MOVE_SELF;
 		event_set[tst_count].fid = &file_fid;
 		strcpy(event_set[tst_count].name, "");
 		tst_count++;
 	}
+	event_set[tst_count].mask = FAN_CLOSE_WRITE;
+	event_set[tst_count].fid = &dir_fid;
+	strcpy(event_set[tst_count].name, FILE_NAME2);
+	tst_count++;
+
+	dirfd = SAFE_OPEN(dname1, O_RDONLY | O_DIRECTORY);
+	SAFE_CLOSE(dirfd);
+
+	SAFE_UMOUNT(dname1);
+
+	/*
+	 * Directory watch gets open/close events on itself and on its subdirs.
+	 * Filesystem watch gets open/close event on all directories with name ".".
+	 */
+	event_set[tst_count].mask = FAN_OPEN | FAN_CLOSE_NOWRITE | FAN_ONDIR;
+	event_set[tst_count].fid = &dir_fid;
+	strcpy(event_set[tst_count].name, ".");
+	tst_count++;
+	/*
+	 * Directory watch gets self event on itself and filesystem watch gets
+	 * self event on all directories with name ".".
+	 */
+	event_set[tst_count].mask = FAN_DELETE_SELF | FAN_MOVE_SELF | FAN_ONDIR;
+	event_set[tst_count].fid = &dir_fid;
+	strcpy(event_set[tst_count].name, ".");
+	tst_count++;
 
 	SAFE_RENAME(dname1, dname2);
 	SAFE_RMDIR(dname2);
@@ -198,14 +237,8 @@ static void do_test(unsigned int number)
 	event_set[tst_count].fid = &root_fid;
 	strcpy(event_set[tst_count].name, DIR_NAME2);
 	tst_count++;
-	/*
-	 * Directory watch gets self event on itself and filesystem watch gets
-	 * self event on all directories with name ".".
-	 */
-	event_set[tst_count].mask = FAN_DELETE_SELF | FAN_ONDIR;
-	strcpy(event_set[tst_count].name, ".");
-	event_set[tst_count].fid = &dir_fid;
-	tst_count++;
+	/* Expect no more events */
+	event_set[tst_count].mask = 0;
 
 	/*
 	 * Cleanup the marks
@@ -220,7 +253,7 @@ static void do_test(unsigned int number)
 		struct file_handle *file_handle;
 		unsigned int fhlen;
 		const char *filename;
-		int namelen, info_type;
+		int namelen, info_type, mask_match;
 
 		event = (struct fanotify_event_metadata *)&event_buf[i];
 		event_fid = (struct fanotify_event_info_fid *)(event + 1);
@@ -242,6 +275,16 @@ static void do_test(unsigned int number)
 			info_type = FAN_EVENT_INFO_TYPE_DFID;
 		}
 
+		/*
+		 * Event may contain more than the expected mask, but it must
+		 * have all the bits in expected mask.
+		 * Expected event on dir must not get event on non dir and the
+		 * other way around.
+		 */
+		mask_match = ((event->mask & expected->mask) &&
+			      !(expected->mask & ~event->mask) &&
+			      !((event->mask ^ expected->mask) & FAN_ONDIR));
+
 		if (test_num >= tst_count) {
 			tst_res(TFAIL,
 				"got unnecessary event: mask=%llx "
@@ -259,7 +302,7 @@ static void do_test(unsigned int number)
 				(unsigned)event->pid, event->fd,
 				event->event_len, event_fid->hdr.info_type,
 				event_fid->hdr.len, fhlen);
-		} else if (event->mask != expected->mask) {
+		} else if (!mask_match) {
 			tst_res(TFAIL,
 				"got event: mask=%llx (expected %llx) "
 				"pid=%u fd=%d name='%s' "
@@ -356,10 +399,19 @@ static void do_test(unsigned int number)
 				event_fid->hdr.len, fhlen);
 		}
 
+		if (test_num < tst_count)
+			test_num++;
+
+		if (mask_match) {
+			/* In case of merged event match next expected mask */
+			event->mask &= ~expected->mask | FAN_ONDIR;
+			if (event->mask & ~FAN_ONDIR)
+				continue;
+		}
+
 		i += event->event_len;
 		if (event->fd > 0)
 			SAFE_CLOSE(event->fd);
-		test_num++;
 	}
 
 	for (; test_num < tst_count; test_num++) {
-- 
2.17.1

