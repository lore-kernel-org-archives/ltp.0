From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Tue, 2 Apr 2019 21:02:15 +1100
Subject: [LTP] [PATCH 2/4] syscalls/fanotify13: new test to verify
 FAN_REPORT_FID functionality
In-Reply-To: <cover.1554197461.git.mbobrowski@mbobrowski.org>
References: <cover.1554197461.git.mbobrowski@mbobrowski.org>
Message-ID: <da7bbaf1f0661dec476e636ed250ab640f5d2c31.1554197461.git.mbobrowski@mbobrowski.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Newly defined test file to validate the fanotify FAN_REPORT_FID
functionality.

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/.gitignore   |   1 +
 testcases/kernel/syscalls/fanotify/fanotify.h   |  19 +-
 testcases/kernel/syscalls/fanotify/fanotify13.c | 329 ++++++++++++++++++++++++
 3 files changed, 346 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify13.c

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
index 14654b7c7..450f3829d 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -57,9 +57,6 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
 #ifndef FAN_REPORT_TID
 #define FAN_REPORT_TID		0x00000100
 #endif
-#ifndef FAN_REPORT_FID
-#define FAN_REPORT_FID		0x00000200
-#endif
 
 #ifndef FAN_MARK_INODE
 #define FAN_MARK_INODE		0
@@ -89,6 +86,22 @@ struct fanotify_mark_type {
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
+#endif
+
 #define INIT_FANOTIFY_MARK_TYPE(t) \
 	{ FAN_MARK_ ## t, "FAN_MARK_" #t }
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
new file mode 100644
index 000000000..fb49df5f9
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -0,0 +1,329 @@
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
+static void do_setup(void)
+{
+	int fd;
+
+	/* Check for kernel fanotify support */
+	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF, O_RDONLY);
+	SAFE_CLOSE(fd);
+
+	/* Create file and directories for testing */
+	create_objects();
+}
+
+static void get_object_stats(struct test_case_t *tc)
+{
+	int mount_id;
+	unsigned int i;
+	struct statfs stats;
+
+	for (i = 0; i < ARRAY_SIZE(objects); i++) {
+		if (statfs(objects[i].path, &stats) == -1)
+			tst_brk(TBROK | TERRNO,
+				"statfs(%s, ...) failed", objects[i].path);
+		memcpy(&event_set[i].fsid, &stats.f_fsid,
+			sizeof(stats.f_fsid));
+
+		event_set[i].handle.handle_bytes = MAX_HANDLE_SZ;
+		if (name_to_handle_at(AT_FDCWD, objects[i].path,
+					&event_set[i].handle,
+					&mount_id, 0) == -1) {
+			if (errno == EOPNOTSUPP) {
+				tst_res(TCONF,
+					"filesystem %s does not support file "
+					"handles",
+					tst_device->fs_type);
+			}
+			tst_brk(TBROK | TERRNO,
+				"name_to_handle_at(AT_FDCWD, %s, ...) failed",
+				objects[i].path);
+		}
+
+		event_set[i].expected_mask = tc->mask;
+		if (!objects[i].is_dir)
+			event_set[i].expected_mask &= ~FAN_ONDIR;
+	}
+}
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
+	/* Gets the filesystem fsid and file handle for each object */
+	get_object_stats(tc);
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
+	/* Place marks on a set of objects */
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
2.16.4


-- 
Matthew Bobrowski
