From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Sun, 19 May 2019 15:25:35 +1000
Subject: [LTP] [PATCH v3 1/3] syscalls/fanotify13: new test to verify
 FAN_REPORT_FID functionality
In-Reply-To: <cover.1558242368.git.mbobrowski@mbobrowski.org>
References: <cover.1558242368.git.mbobrowski@mbobrowski.org>
Message-ID: <5a1302c56c25f53395757727ec509169bdd6bc03.1558242368.git.mbobrowski@mbobrowski.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A newly defined test file to validate the fanotify FAN_REPORT_FID
functionality. A new line entry for this test file has been added within
runtest/syscalls.

Additionally, defined a helper function that can be used to obtain
__kernel_fsid_t and file_handle objects. This helper will be used by
test files related to verifying FAN_REPORT_FID. The name_to_handle_at()
function is conditionally added to accommodate for builds on older
distributions.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 configure.ac                                  |   1 +
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h |  56 +++-
 .../kernel/syscalls/fanotify/fanotify13.c     | 313 ++++++++++++++++++
 5 files changed, 369 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify13.c

diff --git a/configure.ac b/configure.ac
index 53ad784d7..ac4d85b0e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -68,6 +68,7 @@ AC_CHECK_FUNCS([ \
     kcmp \
     mkdirat \
     mknodat \
+    name_to_handle_at \
     openat \
     preadv \
     preadv2 \
diff --git a/runtest/syscalls b/runtest/syscalls
index 2b8ca719b..dfdc6cbf9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -537,6 +537,7 @@ fanotify09 fanotify09
 fanotify10 fanotify10
 fanotify11 fanotify11
 fanotify12 fanotify12
+fanotify13 fanotify13
 
 ioperm01 ioperm01
 ioperm02 ioperm02
diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
index 4256b8cd3..16bdd99e5 100644
--- a/testcases/kernel/syscalls/fanotify/.gitignore
+++ b/testcases/kernel/syscalls/fanotify/.gitignore
@@ -10,4 +10,5 @@
 /fanotify10
 /fanotify11
 /fanotify12
+/fanotify13
 /fanotify_child
diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 14654b7c7..d6e259002 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -29,6 +29,11 @@
 #define	__FANOTIFY_H__
 
 #include "config.h"
+#include <sys/statfs.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
 
 #if defined(HAVE_SYS_FANOTIFY_H)
 
@@ -57,9 +62,6 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
 #ifndef FAN_REPORT_TID
 #define FAN_REPORT_TID		0x00000100
 #endif
-#ifndef FAN_REPORT_FID
-#define FAN_REPORT_FID		0x00000200
-#endif
 
 #ifndef FAN_MARK_INODE
 #define FAN_MARK_INODE		0
@@ -89,6 +91,54 @@ struct fanotify_mark_type {
 	const char * name;
 };
 
+#ifndef FAN_REPORT_FID
+#define FAN_REPORT_FID		0x00000200
+
+struct fanotify_event_info_header {
+	uint8_t info_type;
+	uint8_t pad;
+	uint16_t len;
+};
+
+struct fanotify_event_info_fid {
+	struct fanotify_event_info_header hdr;
+	__kernel_fsid_t fsid;
+	unsigned char handle[0];
+};
+
+/*
+ * Helper function used to obtain __kernel_fsid_t and file_handle objects
+ * for a given path. Used by test files correlated to FAN_REPORT_FID
+ * functionality.
+ */
+static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
+			struct file_handle *handle)
+{
+	int mount_id;
+	struct statfs stats;
+
+	if (statfs(path, &stats) == -1)
+		tst_brk(TBROK | TERRNO,
+			"statfs(%s, ...) failed", path);
+	memcpy(fsid, &stats.f_fsid, sizeof(stats.f_fsid));
+
+#ifdef HAVE_NAME_TO_HANDLE_AT
+	if (name_to_handle_at(AT_FDCWD, path, handle, &mount_id, 0) == -1) {
+		if (errno == EOPNOTSUPP) {
+			tst_brk(TCONF,
+				"filesystem %s does not support file handles",
+				tst_device->fs_type);
+		}
+		tst_brk(TBROK | TERRNO,
+			"name_to_handle_at(AT_FDCWD, %s, ...) failed", path);
+	}
+#else
+	tst_brk(TCONF, "name_to_handle_at() is not implmented");
+#endif /* HAVE_NAME_TO_HANDLE_AT */
+}
+
+#endif
+
 #define INIT_FANOTIFY_MARK_TYPE(t) \
 	{ FAN_MARK_ ## t, "FAN_MARK_" #t }
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
new file mode 100644
index 000000000..820f1390c
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 Matthew Bobrowski. All Rights Reserved.
+ *
+ * Started by Matthew Bobrowski <mbobrowski@mbobrowski.org>
+ *
+ * DESCRIPTION
+ *	Validate that the values returned within an event when
+ *	FAN_REPORT_FID is specified matches those that are obtained via
+ *	explicit invocation to system calls statfs(2) and
+ *	name_to_handle_at(2).
+ */
+#define _GNU_SOURCE
+#include "config.h"
+
+#include <stdio.h>
+#include <string.h>
+#include <sys/statfs.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "fanotify.h"
+
+#if defined(HAVE_SYS_FANOTIFY_H)
+#include <sys/fanotify.h>
+
+#define PATH_LEN 128
+#define BUF_SIZE 256
+#define DIR_ONE "dir_one"
+#define FILE_ONE "file_one"
+#define FILE_TWO "file_two"
+#define MOUNT_PATH "mntpoint"
+#define EVENT_MAX ARRAY_SIZE(objects)
+#define DIR_PATH_ONE MOUNT_PATH"/"DIR_ONE
+#define FILE_PATH_ONE MOUNT_PATH"/"FILE_ONE
+#define FILE_PATH_TWO MOUNT_PATH"/"FILE_TWO
+
+struct event_t {
+	unsigned long long expected_mask;
+	__kernel_fsid_t fsid;
+	struct file_handle handle;
+	char buf[MAX_HANDLE_SZ];
+};
+
+static struct object_t {
+	const char *path;
+	int is_dir;
+} objects[] = {
+	{FILE_PATH_ONE, 0},
+	{FILE_PATH_TWO, 0},
+	{DIR_PATH_ONE, 1}
+};
+
+static struct test_case_t {
+	struct fanotify_mark_type mark;
+	unsigned long long mask;
+} test_cases[] = {
+	{
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_OPEN | FAN_CLOSE_NOWRITE
+	},
+	{
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_OPEN | FAN_CLOSE_NOWRITE | FAN_ONDIR
+	},
+	{
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_OPEN | FAN_CLOSE_NOWRITE
+	},
+	{
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_OPEN | FAN_CLOSE_NOWRITE | FAN_ONDIR
+	},
+	{
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+		FAN_OPEN | FAN_CLOSE_NOWRITE
+	},
+	{
+		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
+		FAN_OPEN | FAN_CLOSE_NOWRITE | FAN_ONDIR
+	}
+};
+
+static int fanotify_fd;
+static char events_buf[BUF_SIZE];
+static struct event_t event_set[EVENT_MAX];
+
+static void create_objects(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(objects); i++) {
+		if (objects[i].is_dir)
+			SAFE_MKDIR(objects[i].path, 0755);
+		else
+			SAFE_FILE_PRINTF(objects[i].path, "0");
+	}
+}
+
+static void get_object_stats(void)
+{
+	unsigned int i;
+	for (i = 0; i < ARRAY_SIZE(objects); i++) {
+		event_set[i].handle.handle_bytes = MAX_HANDLE_SZ;
+		fanotify_get_fid(objects[i].path, &event_set[i].fsid,
+				&event_set[i].handle);
+	}
+}
+
+static void do_setup(void)
+{
+	int fd;
+
+	/* Check for kernel fanotify support */
+	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
+	SAFE_CLOSE(fd);
+
+	/* Create file and directory objects for testing */
+	create_objects();
+
+	/* Get the filesystem fsid and file handle for each created object */
+	get_object_stats();
+}
+
+
+static int setup_marks(unsigned int fd, struct test_case_t *tc)
+{
+	unsigned int i;
+	struct fanotify_mark_type *mark = &tc->mark;
+
+	for (i = 0; i < ARRAY_SIZE(objects); i++) {
+		if (fanotify_mark(fd, FAN_MARK_ADD | mark->flag, tc->mask,
+					AT_FDCWD, objects[i].path) == -1) {
+			if (errno == EINVAL &&
+				mark->flag & FAN_MARK_FILESYSTEM) {
+				tst_res(TCONF,
+					"FAN_MARK_FILESYSTEM not supported by "
+					"kernel");
+				return 1;
+			} else if (errno == ENODEV &&
+					!event_set[i].fsid.val[0] &&
+					!event_set[i].fsid.val[1]) {
+				tst_res(TCONF,
+					"FAN_REPORT_FID not supported on "
+					"filesystem type %s",
+					tst_device->fs_type);
+				return 1;
+			}
+			tst_brk(TBROK | TERRNO,
+				"fanotify_mark(%d, FAN_MARK_ADD, FAN_OPEN, "
+				"AT_FDCWD, %s) failed",
+				fanotify_fd, objects[i].path);
+		}
+
+		/* Setup the expected mask for each generated event */
+		event_set[i].expected_mask = tc->mask;
+		if (!objects[i].is_dir)
+			event_set[i].expected_mask &= ~FAN_ONDIR;
+	}
+	return 0;
+}
+
+static void do_test(unsigned int number)
+{
+	unsigned int i;
+	int len, fds[ARRAY_SIZE(objects)];
+
+	struct file_handle *event_file_handle;
+	struct fanotify_event_metadata *metadata;
+	struct fanotify_event_info_fid *event_fid;
+	struct test_case_t *tc = &test_cases[number];
+	struct fanotify_mark_type *mark = &tc->mark;
+
+	tst_res(TINFO,
+		"Test #%d: FAN_REPORT_FID with mark flag: %s",
+		number, mark->name);
+
+	fanotify_fd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, O_RDONLY);
+	if (fanotify_fd == -1) {
+		if (errno == EINVAL) {
+			tst_res(TCONF,
+				"FAN_REPORT_FID not supported by kernel");
+			return;
+		}
+		tst_brk(TBROK | TERRNO,
+			"fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_FID, "
+			"O_RDONLY) failed");
+	}
+
+	/* Place marks on a set of objects and setup the expected masks
+	 * for each event that is expected to be generated
+	 */
+	if (setup_marks(fanotify_fd, tc) != 0)
+		return;
+
+	/* Generate sequence of FAN_OPEN events on objects */
+	for (i = 0; i < ARRAY_SIZE(objects); i++)
+		fds[i] = SAFE_OPEN(objects[i].path, O_RDONLY);
+
+	/* Generate sequence of FAN_CLOSE_NOWRITE events on objects. Each
+	 * FAN_CLOSE_NOWRITE event is expected to be merged with its
+	 * respective FAN_OPEN event that was performed on the same object
+	 */
+	for (i = 0; i < ARRAY_SIZE(objects); i++) {
+		if (fds[i] > 0)
+			SAFE_CLOSE(fds[i]);
+	}
+
+	/* Read events from event queue */
+	len = SAFE_READ(0, fanotify_fd, events_buf, BUF_SIZE);
+
+	/* Iterate over event queue */
+	for (i = 0, metadata = (struct fanotify_event_metadata *) events_buf;
+		FAN_EVENT_OK(metadata, len);
+		metadata = FAN_EVENT_NEXT(metadata, len), i++) {
+		event_fid = (struct fanotify_event_info_fid *) (metadata + 1);
+		event_file_handle = (struct file_handle *) event_fid->handle;
+
+		/* File descriptor is redundant with FAN_REPORT_FID */
+		if (metadata->fd != FAN_NOFD)
+			tst_res(TFAIL,
+				"Unexpectedly received file descriptor %d in "
+				"event. Expected to get FAN_NOFD(%d)",
+				metadata->fd, FAN_NOFD);
+
+		/* Ensure that the correct mask has been reported in event */
+		if (metadata->mask != event_set[i].expected_mask)
+			tst_res(TFAIL,
+				"Unexpected mask received: %llx (expected: "
+				"%llx) in event",
+				metadata->mask,
+				event_set[i].expected_mask);
+
+		/* Verify handle_bytes returned in event */
+		if (event_file_handle->handle_bytes
+				!= event_set[i].handle.handle_bytes) {
+			tst_res(TFAIL,
+				"handle_bytes (%x) returned in event does not "
+				"equal to handle_bytes (%x) returned in "
+				"name_to_handle_at(2)",
+				event_file_handle->handle_bytes,
+				event_set[i].handle.handle_bytes);
+			continue;
+		}
+
+		/* Verify handle_type returned in event */
+		if (event_file_handle->handle_type !=
+				event_set[i].handle.handle_type) {
+			tst_res(TFAIL,
+				"handle_type (%x) returned in event does not "
+				"equal to handle_type (%x) returned in "
+				"name_to_handle_at(2)",
+				event_file_handle->handle_type,
+				event_set[i].handle.handle_type);
+			continue;
+		}
+
+		/* Verify file identifier f_handle returned in event */
+		if (memcmp(event_file_handle->f_handle,
+				event_set[i].handle.f_handle,
+				event_set[i].handle.handle_bytes) != 0) {
+			tst_res(TFAIL,
+				"event_file_handle->f_handle does not match "
+				"event_set[i].handle.f_handle returned in "
+				"name_to_handle_at(2)");
+			continue;
+		}
+
+		/* Verify filesystem ID fsid  returned in event */
+		if (memcmp(&event_fid->fsid, &event_set[i].fsid,
+				sizeof(event_set[i].fsid)) != 0) {
+			tst_res(TFAIL,
+				"event_fid.fsid != stat.f_fsid that was "
+				"obtained via statfs(2)");
+			continue;
+		}
+
+		tst_res(TPASS,
+			"got event: mask=%llx, pid=%d, fid=%x.%x.%lx values "
+			"returned in event match those returned in statfs(2) "
+			"and name_to_handle_at(2)",
+			metadata->mask,
+			getpid(),
+			event_fid->fsid.val[0],
+			event_fid->fsid.val[1],
+			*(unsigned long *) event_file_handle->f_handle);
+	}
+}
+
+static void do_cleanup(void)
+{
+	if (fanotify_fd > 0)
+		SAFE_CLOSE(fanotify_fd);
+}
+
+static struct tst_test test = {
+	.setup = do_setup,
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(test_cases),
+	.cleanup = do_cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.mount_device = 1,
+	.mntpoint = MOUNT_PATH,
+	.all_filesystems = 1
+};
+
+#else
+	TST_TEST_CONF("System does not have required fanotify support");
+#endif
-- 
2.21.0


-- 
Matthew Bobrowski
