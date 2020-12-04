From: Amir Goldstein <amir73il@gmail.com>
Date: Fri,  4 Dec 2020 11:59:27 +0200
Subject: [LTP] [PATCH 2/5] syscalls/fanotify: Use generic checks for
 fanotify_init flags
In-Reply-To: <20201204095930.866421-1-amir73il@gmail.com>
References: <20201204095930.866421-1-amir73il@gmail.com>
Message-ID: <20201204095930.866421-3-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Convert remaining tests to SAFE_FANOTIFY_INIT and use the generic
helpers to check requires kernel/fs support for fanotify_init flags
in advance.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify10.c     | 26 ++++++++-----------
 .../kernel/syscalls/fanotify/fanotify11.c     | 21 ++++++---------
 .../kernel/syscalls/fanotify/fanotify16.c     | 14 ++--------
 3 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 404e57daa..cc164359f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -57,6 +57,7 @@ static unsigned int fanotify_class[] = {
 	FAN_REPORT_DFID_NAME_FID,
 };
 #define NUM_CLASSES ARRAY_SIZE(fanotify_class)
+#define NUM_PRIORITIES 3
 
 #define GROUPS_PER_PRIO 3
 
@@ -64,6 +65,7 @@ static int fd_notify[NUM_CLASSES][GROUPS_PER_PRIO];
 
 static char event_buf[EVENT_BUF_LEN];
 static int exec_events_unsupported;
+static int fan_report_dfid_unsupported;
 static int filesystem_mark_unsupported;
 
 #define MOUNT_PATH "fs_mnt"
@@ -294,21 +296,8 @@ static int create_fanotify_groups(unsigned int n)
 
 	for (p = 0; p < num_classes; p++) {
 		for (i = 0; i < GROUPS_PER_PRIO; i++) {
-			fd_notify[p][i] = fanotify_init(fanotify_class[p] |
-							FAN_NONBLOCK, O_RDONLY);
-			if (fd_notify[p][i] == -1) {
-				if (errno == EINVAL &&
-				    fanotify_class[p] & FAN_REPORT_NAME) {
-					tst_res(TCONF,
-						"FAN_REPORT_NAME not supported by kernel?");
-					/* Do not try creating this group again */
-					num_classes--;
-					return -1;
-				}
-
-				tst_brk(TBROK | TERRNO,
-					"fanotify_init(%x, 0) failed", fanotify_class[p]);
-			}
+			fd_notify[p][i] = SAFE_FANOTIFY_INIT(fanotify_class[p] |
+							     FAN_NONBLOCK, O_RDONLY);
 
 			/*
 			 * Add mark for each group.
@@ -518,6 +507,13 @@ static void setup(void)
 {
 	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
 	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
+	fan_report_dfid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME,
+									  MOUNT_PATH);
+	if (fan_report_dfid_unsupported) {
+		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_DFID_NAME, fan_report_dfid_unsupported);
+		/* Limit tests to legacy priority classes */
+		num_classes = NUM_PRIORITIES;
+	}
 
 	/* Create another bind mount@another path for generating events */
 	SAFE_MKDIR(MNT2_PATH, 0755);
diff --git a/testcases/kernel/syscalls/fanotify/fanotify11.c b/testcases/kernel/syscalls/fanotify/fanotify11.c
index 785b5c5a5..f3b60cecb 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify11.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify11.c
@@ -36,6 +36,8 @@
 #define gettid() syscall(SYS_gettid)
 static int tid;
 
+static int fan_report_tid_unsupported;
+
 void *thread_create_file(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	char tid_file[64] = {0};
@@ -63,17 +65,13 @@ void test01(unsigned int i)
 			i, (tcases[i] & FAN_REPORT_TID) ? "with" : "without",
 			tgid, tid, event.pid);
 
-	fd_notify = fanotify_init(tcases[i], 0);
-	if (fd_notify < 0) {
-		if (errno == EINVAL && (tcases[i] & FAN_REPORT_TID)) {
-			tst_res(TCONF,
-				"FAN_REPORT_TID not supported in kernel?");
-			return;
-		}
-		tst_brk(TBROK | TERRNO, "fanotify_init(0x%x, 0) failed",
-				tcases[i]);
+	if (fan_report_tid_unsupported && (tcases[i] & FAN_REPORT_TID)) {
+		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_TID, fan_report_tid_unsupported);
+		return;
 	}
 
+	fd_notify = SAFE_FANOTIFY_INIT(tcases[i], 0);
+
 	SAFE_FANOTIFY_MARK(fd_notify, FAN_MARK_ADD,
 			FAN_ALL_EVENTS | FAN_EVENT_ON_CHILD, AT_FDCWD, ".");
 
@@ -96,10 +94,7 @@ void test01(unsigned int i)
 
 static void setup(void)
 {
-	int fd;
-
-	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
-	SAFE_CLOSE(fd);
+	fan_report_tid_unsupported = fanotify_init_flags_supported_by_kernel(FAN_REPORT_TID);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index a4409df14..5ffaec92f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -158,17 +158,7 @@ static void do_test(unsigned int number)
 
 	tst_res(TINFO, "Test #%d: %s", number, tc->tname);
 
-	fd_notify = fanotify_init(group->flag, 0);
-	if (fd_notify == -1) {
-		if (errno == EINVAL) {
-			tst_res(TCONF,
-				"%s not supported by kernel", group->name);
-			return;
-		}
-
-		tst_brk(TBROK | TERRNO,
-			"fanotify_init(%s, 0) failed", group->name);
-	}
+	fd_notify = SAFE_FANOTIFY_INIT(group->flag, 0);
 
 	/*
 	 * Watch dir modify events with name in filesystem/dir
@@ -551,7 +541,7 @@ check_match:
 
 static void setup(void)
 {
-	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_FID, MOUNT_PATH);
+	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_DIR_FID, MOUNT_PATH);
 
 	sprintf(dname1, "%s/%s", MOUNT_PATH, DIR_NAME1);
 	sprintf(dname2, "%s/%s", MOUNT_PATH, DIR_NAME2);
-- 
2.25.1

