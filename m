From: Amir Goldstein <amir73il@gmail.com>
Date: Wed,  9 Sep 2020 20:57:06 +0300
Subject: [LTP] [PATCH 09/10] syscalls/fanotify10: Test with group flag
 FAN_REPORT_NAME
In-Reply-To: <20200909175707.10670-1-amir73il@gmail.com>
References: <20200909175707.10670-1-amir73il@gmail.com>
Message-ID: <20200909175707.10670-10-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The group flag FAN_REPORT_NAME could change the behavior of merging
inode mark mask with sb/mount marks.

Add another group class with flag FAN_REPORT_NAME to see how it affects
merging of events on kernels that support FAN_REPORT_NAME.

On old kernels without FAN_REPORT_NAME support, the new group class is
not tested.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify10.c     | 72 +++++++++++--------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 3cdb25a73..9ebb6d68f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -45,16 +45,18 @@
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN        (EVENT_MAX * EVENT_SIZE)
 
-static unsigned int fanotify_prio[] = {
+static unsigned int fanotify_class[] = {
 	FAN_CLASS_PRE_CONTENT,
 	FAN_CLASS_CONTENT,
-	FAN_CLASS_NOTIF
+	FAN_CLASS_NOTIF,
+	/* Reporting dfid+name+fid merges events similar to reporting fd */
+	FAN_REPORT_DFID_NAME_FID,
 };
-#define FANOTIFY_PRIORITIES ARRAY_SIZE(fanotify_prio)
+#define NUM_CLASSES ARRAY_SIZE(fanotify_class)
 
 #define GROUPS_PER_PRIO 3
 
-static int fd_notify[FANOTIFY_PRIORITIES][GROUPS_PER_PRIO];
+static int fd_notify[NUM_CLASSES][GROUPS_PER_PRIO];
 
 static char event_buf[EVENT_BUF_LEN];
 
@@ -75,6 +77,7 @@ static char event_buf[EVENT_BUF_LEN];
 
 static pid_t child_pid;
 static int bind_mount_created;
+static unsigned int num_classes = NUM_CLASSES;
 
 enum {
 	FANOTIFY_INODE,
@@ -216,11 +219,23 @@ static int create_fanotify_groups(unsigned int n)
 	mark = &fanotify_mark_types[tc->mark_type];
 	ignore_mark = &fanotify_mark_types[tc->ignore_mark_type];
 
-	for (p = 0; p < FANOTIFY_PRIORITIES; p++) {
+	for (p = 0; p < num_classes; p++) {
 		for (i = 0; i < GROUPS_PER_PRIO; i++) {
-			fd_notify[p][i] = SAFE_FANOTIFY_INIT(fanotify_prio[p] |
-							     FAN_NONBLOCK,
-							     O_RDONLY);
+			fd_notify[p][i] = fanotify_init(fanotify_class[p] |
+							FAN_NONBLOCK, O_RDONLY);
+			if (fd_notify[p][i] == -1) {
+				if (errno == EINVAL &&
+				    fanotify_class[p] & FAN_REPORT_NAME) {
+					tst_res(TCONF,
+						"FAN_REPORT_NAME not supported by kernel?");
+					/* Do not try creating this group again */
+					num_classes--;
+					return -1;
+				}
+
+				tst_brk(TBROK | TERRNO,
+					"fanotify_init(%x, 0) failed", fanotify_class[p]);
+			}
 
 			/*
 			 * Add mark for each group.
@@ -281,7 +296,7 @@ static void cleanup_fanotify_groups(void)
 {
 	unsigned int i, p;
 
-	for (p = 0; p < FANOTIFY_PRIORITIES; p++) {
+	for (p = 0; p < num_classes; p++) {
 		for (i = 0; i < GROUPS_PER_PRIO; i++) {
 			if (fd_notify[p][i] > 0)
 				SAFE_CLOSE(fd_notify[p][i]);
@@ -289,22 +304,23 @@ static void cleanup_fanotify_groups(void)
 	}
 }
 
-static void verify_event(int group, struct fanotify_event_metadata *event,
+static void verify_event(int p, int group, struct fanotify_event_metadata *event,
 			 unsigned long long expected_mask)
 {
 	if (event->mask != expected_mask) {
-		tst_res(TFAIL, "group %d got event: mask %llx (expected %llx) "
-			"pid=%u fd=%u", group, (unsigned long long)event->mask,
+		tst_res(TFAIL, "group %d (%x) got event: mask %llx (expected %llx) "
+			"pid=%u fd=%u", group, fanotify_class[p],
+			(unsigned long long) event->mask,
 			(unsigned long long) expected_mask,
 			(unsigned)event->pid, event->fd);
 	} else if (event->pid != child_pid) {
-		tst_res(TFAIL, "group %d got event: mask %llx pid=%u "
-			"(expected %u) fd=%u", group,
+		tst_res(TFAIL, "group %d (%x) got event: mask %llx pid=%u "
+			"(expected %u) fd=%u", group, fanotify_class[p],
 			(unsigned long long)event->mask, (unsigned)event->pid,
 			(unsigned)getpid(), event->fd);
 	} else {
-		tst_res(TPASS, "group %d got event: mask %llx pid=%u fd=%u",
-			group, (unsigned long long)event->mask,
+		tst_res(TPASS, "group %d (%x) got event: mask %llx pid=%u fd=%u",
+			group, fanotify_class[p], (unsigned long long)event->mask,
 			(unsigned)event->pid, event->fd);
 	}
 }
@@ -357,7 +373,7 @@ static void test_fanotify(unsigned int n)
 		tst_brk(TBROK, "Child process terminated incorrectly");
 
 	/* First verify all groups without matching ignore mask got the event */
-	for (p = 0; p < FANOTIFY_PRIORITIES; p++) {
+	for (p = 0; p < num_classes; p++) {
 		if (p > 0 && !tc->expected_mask_with_ignore)
 			break;
 
@@ -365,9 +381,10 @@ static void test_fanotify(unsigned int n)
 			ret = read(fd_notify[p][i], event_buf, EVENT_BUF_LEN);
 			if (ret < 0) {
 				if (errno == EAGAIN) {
-					tst_res(TFAIL, "group %d (prio %d) "
+					tst_res(TFAIL, "group %d (%x) "
 						"with %s did not get event",
-						i, p, mark->name);
+						i, fanotify_class[p], mark->name);
+					continue;
 				}
 				tst_brk(TBROK | TERRNO,
 					"reading fanotify events failed");
@@ -380,12 +397,12 @@ static void test_fanotify(unsigned int n)
 			}
 			event = (struct fanotify_event_metadata *)event_buf;
 			if (ret > (int)event->event_len) {
-				tst_res(TFAIL, "group %d (prio %d) with %s "
+				tst_res(TFAIL, "group %d (%x) with %s "
 					"got more than one event (%d > %d)",
-					i, p, mark->name, ret,
+					i, fanotify_class[p], mark->name, ret,
 					event->event_len);
 			} else {
-				verify_event(i, event, p == 0 ?
+				verify_event(p, i, event, p == 0 ?
 						tc->expected_mask_without_ignore :
 						tc->expected_mask_with_ignore);
 			}
@@ -394,8 +411,7 @@ static void test_fanotify(unsigned int n)
 		}
 	}
 	/* Then verify all groups with matching ignore mask did got the event */
-	for (p = 1; p < FANOTIFY_PRIORITIES &&
-			!tc->expected_mask_with_ignore; p++) {
+	for (p = 1; p < num_classes && !tc->expected_mask_with_ignore; p++) {
 		for (i = 0; i < GROUPS_PER_PRIO; i++) {
 			ret = read(fd_notify[p][i], event_buf, EVENT_BUF_LEN);
 			if (ret == 0) {
@@ -403,15 +419,15 @@ static void test_fanotify(unsigned int n)
 					"zero length read from fanotify fd");
 			}
 			if (ret > 0) {
-				tst_res(TFAIL, "group %d (prio %d) with %s and "
+				tst_res(TFAIL, "group %d (%x) with %s and "
 					"%s ignore mask got event",
-					i, p, mark->name, ignore_mark->name);
+					i, fanotify_class[p], mark->name, ignore_mark->name);
 				if (event->fd != FAN_NOFD)
 					SAFE_CLOSE(event->fd);
 			} else if (errno == EAGAIN) {
-				tst_res(TPASS, "group %d (prio %d) with %s and "
+				tst_res(TPASS, "group %d (%x) with %s and "
 					"%s ignore mask got no event",
-					i, p, mark->name, ignore_mark->name);
+					i, fanotify_class[p], mark->name, ignore_mark->name);
 			} else {
 				tst_brk(TBROK | TERRNO,
 					"reading fanotify events failed");
-- 
2.17.1

