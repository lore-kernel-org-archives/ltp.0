From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Nov 2020 16:51:20 +0100
Subject: [LTP] [PATCH v2 2/5] fanotify: Handle supported features checks in
 setup()
In-Reply-To: <20201113155123.5959-1-pvorel@suse.cz>
References: <20201113155123.5959-1-pvorel@suse.cz>
Message-ID: <20201113155123.5959-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Create 2 helpers which are used in various tests in setup() to check for
FAN_ACCESS_PERM enablement (caused by disabled CONFIG_FANOTIFY_ACCESS_PERMISSIONS)
or FAN_OPEN_EXEC and FAN_OPEN_EXEC_PERM support in kernel.

That helps to further code simplification in next commit.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Amir,

New in v2.

Is that how you meant the check?
Not sure about function names, feel free to suggest better ones.
Also it's not good that it's not clear from function name whether it
uses tst_brk() on EINVAL or it returns value.

Kind regards,
Petr

 testcases/kernel/syscalls/fanotify/fanotify.h | 47 +++++++++++++++
 .../kernel/syscalls/fanotify/fanotify03.c     | 30 ++++------
 .../kernel/syscalls/fanotify/fanotify07.c     |  2 +
 .../kernel/syscalls/fanotify/fanotify10.c     |  8 +++
 .../kernel/syscalls/fanotify/fanotify12.c     | 57 ++++++++-----------
 5 files changed, 91 insertions(+), 53 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 0afbc02aa..0c61f8ab7 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -242,4 +242,51 @@ static inline void fanotify_save_fid(const char *path,
 #define INIT_FANOTIFY_MARK_TYPE(t) \
 	{ FAN_MARK_ ## t, "FAN_MARK_" #t }
 
+
+static inline void fanotify_access_permissions_supported_by_kernel(void)
+{
+	int fd;
+
+	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
+
+	if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, ".") < 0) {
+		if (errno == EINVAL) {
+			tst_brk(TCONF | TERRNO,
+				"CONFIG_FANOTIFY_ACCESS_PERMISSIONS not configured in kernel?");
+		} else {
+			tst_brk(TBROK | TERRNO,
+				"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD,"
+				" \".\") failed", fd);
+		}
+	}
+
+	SAFE_CLOSE(fd);
+}
+
+static inline int fanotify_exec_events_supported_by_kernel(uint64_t mask,
+							   const char* smask)
+{
+	int fd;
+	int rval = 0;
+
+	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
+
+	if (fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, ".") < 0) {
+		if (errno == EINVAL) {
+			rval = -1;
+		} else {
+			tst_brk(TBROK | TERRNO,
+				"fanotify_mark (%d, FAN_MARK_ADD, %s, AT_FDCWD, \".\") failed",
+				fd, smask);
+		}
+	}
+
+	SAFE_CLOSE(fd);
+
+	return rval;
+}
+
+#define FANOTIFY_EXEC_EVENTS_SUPPORTED_BY_KERNEL(mask) \
+	fanotify_exec_events_supported_by_kernel(mask, #mask)
+
 #endif /* __FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 1ef1c206b..fbec652f6 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -212,28 +212,23 @@ static int setup_mark(unsigned int n)
 	char *const files[] = {fname, FILE_EXEC_PATH};
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+
+	if (support_exec_events != 0 && tc->mask & FAN_OPEN_EXEC_PERM) {
+		tst_res(TCONF | TERRNO, "FAN_OPEN_EXEC_PERM not supported in kernel?");
+		return -1;
+	}
+
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
 
 	for (; i < ARRAY_SIZE(files); i++) {
 		if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
 				  tc->mask, AT_FDCWD, files[i]) < 0) {
 			if (errno == EINVAL &&
-				(tc->mask & FAN_OPEN_EXEC_PERM &&
-				 !support_exec_events)) {
-				tst_res(TCONF,
-					"FAN_OPEN_EXEC_PERM not supported in "
-					"kernel?");
-				return -1;
-			} else if (errno == EINVAL &&
 					mark->flag == FAN_MARK_FILESYSTEM) {
 				tst_res(TCONF,
 					"FAN_MARK_FILESYSTEM not supported in "
 					"kernel?");
 				return -1;
-			} else if (errno == EINVAL) {
-				tst_brk(TCONF | TERRNO,
-					"CONFIG_FANOTIFY_ACCESS_PERMISSIONS "
-					"not configured in kernel?");
 			} else {
 				tst_brk(TBROK | TERRNO,
 					"fanotify_mark(%d, FAN_MARK_ADD | %s, "
@@ -241,14 +236,6 @@ static int setup_mark(unsigned int n)
 					"AT_FDCWD, %s) failed.",
 					fd_notify, mark->name, fname);
 			}
-		} else {
-			/*
-			 * To distinguish between perm not supported, exec
-			 * events not supported and filesystem mark not
-			 * supported.
-			 */
-			if (tc->mask & FAN_OPEN_EXEC_PERM)
-				support_exec_events = 1;
 		}
 	}
 
@@ -347,6 +334,11 @@ static void test_fanotify(unsigned int n)
 
 static void setup(void)
 {
+
+	fanotify_access_permissions_supported_by_kernel();
+
+	support_exec_events = FANOTIFY_EXEC_EVENTS_SUPPORTED_BY_KERNEL(FAN_OPEN_EXEC_PERM);
+
 	sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index c2e185710..f4e8ac9e6 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -195,6 +195,8 @@ static void test_fanotify(void)
 
 static void setup(void)
 {
+	fanotify_access_permissions_supported_by_kernel();
+
 	sprintf(fname, "fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "%s", fname);
 }
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 90cf5cb5f..b95efb998 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -64,6 +64,7 @@ static unsigned int fanotify_class[] = {
 static int fd_notify[NUM_CLASSES][GROUPS_PER_PRIO];
 
 static char event_buf[EVENT_BUF_LEN];
+static int support_exec_events;
 
 #define MOUNT_PATH "fs_mnt"
 #define MNT2_PATH "mntpoint"
@@ -451,6 +452,11 @@ static void test_fanotify(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
+	if (support_exec_events != 0 && tc->expected_mask_with_ignore & FAN_OPEN_EXEC) {
+		tst_res(TCONF | TERRNO, "FAN_OPEN_EXEC not supported in kernel?");
+		return;
+	}
+
 	if (tc->ignored_onchild && tst_kvercmp(5, 9, 0) < 0) {
 		tst_res(TCONF, "ignored mask in combination with flag FAN_EVENT_ON_CHILD"
 				" has undefined behavior on kernel < 5.9");
@@ -535,6 +541,8 @@ cleanup:
 
 static void setup(void)
 {
+	support_exec_events = FANOTIFY_EXEC_EVENTS_SUPPORTED_BY_KERNEL(FAN_OPEN_EXEC);
+
 	/* Create another bind mount@another path for generating events */
 	SAFE_MKDIR(MNT2_PATH, 0755);
 	SAFE_MOUNT(MOUNT_PATH, MNT2_PATH, "none", MS_BIND, NULL);
diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index 7f23fc9dc..bddbdc37c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -39,6 +39,7 @@ static char fname[BUF_SIZE];
 static volatile int fd_notify;
 static volatile int complete;
 static char event_buf[EVENT_BUF_LEN];
+static int support_exec_events;
 
 static struct test_case_t {
 	const char *tname;
@@ -135,26 +136,25 @@ static int setup_mark(unsigned int n)
 	const char *const files[] = {fname, TEST_APP};
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
+
+	if (support_exec_events != 0 && tc->mask & FAN_OPEN_EXEC) {
+		tst_res(TCONF | TERRNO, "FAN_OPEN_EXEC not supported in kernel?");
+		return -1;
+	}
+
 	fd_notify = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
 
 	for (; i < ARRAY_SIZE(files); i++) {
 		/* Setup normal mark on object */
 		if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
 					tc->mask, AT_FDCWD, files[i]) < 0) {
-			if (errno == EINVAL && tc->mask & FAN_OPEN_EXEC) {
-				tst_res(TCONF,
-					"FAN_OPEN_EXEC not supported in "
-					"kernel?");
-				return -1;
-			}else {
-				tst_brk(TBROK | TERRNO,
-					"fanotify_mark(%d, FAN_MARK_ADD | %s, "
-					"%llx, AT_FDCWD, %s) failed",
-					fd_notify,
-					mark->name,
-					tc->mask,
-					files[i]);
-			}
+			tst_brk(TBROK | TERRNO,
+				"fanotify_mark(%d, FAN_MARK_ADD | %s, "
+				"%llx, AT_FDCWD, %s) failed",
+				fd_notify,
+				mark->name,
+				tc->mask,
+				files[i]);
 		}
 
 		/* Setup ignore mark on object */
@@ -163,26 +163,13 @@ static int setup_mark(unsigned int n)
 						| FAN_MARK_IGNORED_MASK,
 						tc->ignore_mask, AT_FDCWD,
 						files[i]) < 0) {
-				if (errno == EINVAL &&
-					tc->ignore_mask & FAN_OPEN_EXEC) {
-					tst_res(TCONF,
-						"FAN_OPEN_EXEC not supported "
-						"in kernel?");
-					return -1;
-				} else if (errno == EINVAL) {
-					tst_brk(TCONF | TERRNO,
-						"CONFIG_FANOTIFY_ACCESS_"
-						"PERMISSIONS not configured in "
-						"kernel?");
-				} else {
-					tst_brk(TBROK | TERRNO,
-						"fanotify_mark (%d, "
-						"FAN_MARK_ADD | %s "
-						"| FAN_MARK_IGNORED_MASK, "
-						"%llx, AT_FDCWD, %s) failed",
-						fd_notify, mark->name,
-						tc->ignore_mask, files[i]);
-				}
+				tst_brk(TBROK | TERRNO,
+					"fanotify_mark (%d, "
+					"FAN_MARK_ADD | %s "
+					"| FAN_MARK_IGNORED_MASK, "
+					"%llx, AT_FDCWD, %s) failed",
+					fd_notify, mark->name,
+					tc->ignore_mask, files[i]);
 			}
 		}
 	}
@@ -249,6 +236,8 @@ cleanup:
 
 static void do_setup(void)
 {
+	support_exec_events = FANOTIFY_EXEC_EVENTS_SUPPORTED_BY_KERNEL(FAN_OPEN_EXEC);
+
 	sprintf(fname, "fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
 }
-- 
2.29.2

