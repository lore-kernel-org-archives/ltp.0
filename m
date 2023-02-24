Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC86C61DA4
	for <ltp@archiver.kernel.org>; Fri, 24 Feb 2023 02:38:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E3DE3CBB91
	for <ltp@archiver.kernel.org>; Fri, 24 Feb 2023 03:38:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B08963CB05A
 for <ltp@lists.linux.it>; Fri, 24 Feb 2023 03:38:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6C204600CC7
 for <ltp@lists.linux.it>; Fri, 24 Feb 2023 03:38:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 24C815FCC4;
 Fri, 24 Feb 2023 02:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1677206305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O3alG+SmK1btiJTE4sp6Ig1fFO6y/mnQ9g2SSFInXqQ=;
 b=Qa7GR271FY0qz/lZ+j+fi0SvJJhvr65iD5gi7e+qv6XjsGW7VaFawxYGs9UueL5gOebCc9
 GzDgCI7jxuY6VjWRzrlDdpThn/R4D+wmgWmgsVDjf17gvzYyV5fYhVdoy+jVSWB7uR7jwU
 C2v+byZuBwXGFjL+3pGSERDBbsPp85M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55D4F1342C;
 Fri, 24 Feb 2023 02:38:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TESrCyAj+GOEAQAAMHmgww
 (envelope-from <wegao@suse.com>); Fri, 24 Feb 2023 02:38:24 +0000
To: ltp@lists.linux.it
Date: Thu, 23 Feb 2023 21:38:15 -0500
Message-Id: <20230224023815.28273-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] kill01: New case cgroup kill
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Move basic test from kernel for cgroup kill button.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/controllers                           |   1 +
 testcases/kernel/controllers/kill/.gitignore  |   3 +
 testcases/kernel/controllers/kill/Makefile    |  13 +
 .../kernel/controllers/kill/cgroup_util.c     | 668 ++++++++++++++++++
 .../kernel/controllers/kill/cgroup_util.h     |  59 ++
 testcases/kernel/controllers/kill/kill01.c    | 336 +++++++++
 6 files changed, 1080 insertions(+)
 create mode 100644 testcases/kernel/controllers/kill/.gitignore
 create mode 100644 testcases/kernel/controllers/kill/Makefile
 create mode 100644 testcases/kernel/controllers/kill/cgroup_util.c
 create mode 100644 testcases/kernel/controllers/kill/cgroup_util.h
 create mode 100644 testcases/kernel/controllers/kill/kill01.c

diff --git a/runtest/controllers b/runtest/controllers
index 8d1b936bf..2f69a8ec2 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -23,6 +23,7 @@ memcontrol01 memcontrol01
 memcontrol02 memcontrol02
 memcontrol03 memcontrol03
 memcontrol04 memcontrol04
+kill01 kill01
 
 cgroup_fj_function_debug cgroup_fj_function.sh debug
 cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
diff --git a/testcases/kernel/controllers/kill/.gitignore b/testcases/kernel/controllers/kill/.gitignore
new file mode 100644
index 000000000..a79fc6c6b
--- /dev/null
+++ b/testcases/kernel/controllers/kill/.gitignore
@@ -0,0 +1,3 @@
+/kill01
+/kill01.o
+/cgroup_util.o
diff --git a/testcases/kernel/controllers/kill/Makefile b/testcases/kernel/controllers/kill/Makefile
new file mode 100644
index 000000000..89f70903e
--- /dev/null
+++ b/testcases/kernel/controllers/kill/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+MAKE_TARGETS            := kill01
+kill01: cgroup_util.o kill01.o
+	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION)
+
+kill01.o cgroup_util.o : %.o: %.c
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/kill/cgroup_util.c b/testcases/kernel/controllers/kill/cgroup_util.c
new file mode 100644
index 000000000..662395146
--- /dev/null
+++ b/testcases/kernel/controllers/kill/cgroup_util.c
@@ -0,0 +1,668 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2012 Christian Brauner <brauner-AT-kernel.org>
+ */
+
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <linux/limits.h>
+#include <linux/sched.h>
+#include <poll.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/inotify.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "lapi/syscalls.h"
+#include "cgroup_util.h"
+
+struct __clone_args {
+	__aligned_u64 flags;
+	__aligned_u64 pidfd;
+	__aligned_u64 child_tid;
+	__aligned_u64 parent_tid;
+	__aligned_u64 exit_signal;
+	__aligned_u64 stack;
+	__aligned_u64 stack_size;
+	__aligned_u64 tls;
+#ifndef CLONE_ARGS_SIZE_VER0
+#define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
+#endif
+	__aligned_u64 set_tid;
+	__aligned_u64 set_tid_size;
+#ifndef CLONE_ARGS_SIZE_VER1
+#define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
+#endif
+	__aligned_u64 cgroup;
+#ifndef CLONE_ARGS_SIZE_VER2
+#define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
+#endif
+};
+
+static pid_t sys_clone3(struct __clone_args *args, size_t size)
+{
+	fflush(stdout);
+	fflush(stderr);
+	return syscall(__NR_clone3, args, size);
+}
+
+/* Returns read len on success, or -errno on failure. */
+static ssize_t read_text(const char *path, char *buf, size_t max_len)
+{
+	ssize_t len;
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	len = read(fd, buf, max_len - 1);
+
+	if (len >= 0)
+		buf[len] = 0;
+
+	close(fd);
+	return len < 0 ? -errno : len;
+}
+
+/* Returns written len on success, or -errno on failure. */
+static ssize_t write_text(const char *path, char *buf, ssize_t len)
+{
+	int fd;
+
+	fd = open(path, O_WRONLY | O_APPEND);
+	if (fd < 0)
+		return -errno;
+
+	len = write(fd, buf, len);
+	close(fd);
+	return len < 0 ? -errno : len;
+}
+
+char *cg_name(const char *root, const char *name)
+{
+	size_t len = strlen(root) + strlen(name) + 2;
+	char *ret = malloc(len);
+
+	snprintf(ret, len, "%s/%s", root, name);
+
+	return ret;
+}
+
+char *cg_name_indexed(const char *root, const char *name, int index)
+{
+	size_t len = strlen(root) + strlen(name) + 10;
+	char *ret = malloc(len);
+
+	snprintf(ret, len, "%s/%s_%d", root, name, index);
+
+	return ret;
+}
+
+char *cg_control(const char *cgroup, const char *control)
+{
+	size_t len = strlen(cgroup) + strlen(control) + 2;
+	char *ret = malloc(len);
+
+	snprintf(ret, len, "%s/%s", cgroup, control);
+
+	return ret;
+}
+
+/* Returns 0 on success, or -errno on failure. */
+int cg_read(const char *cgroup, const char *control, char *buf, size_t len)
+{
+	char path[PATH_MAX];
+	ssize_t ret;
+
+	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
+
+	ret = read_text(path, buf, len);
+	return ret >= 0 ? 0 : ret;
+}
+
+int cg_read_strcmp(const char *cgroup, const char *control,
+		   const char *expected)
+{
+	size_t size;
+	char *buf;
+	int ret;
+
+	/* Handle the case of comparing against empty string */
+	if (!expected)
+		return -1;
+
+	size = strlen(expected) + 1;
+
+	buf = malloc(size);
+	if (!buf)
+		return -1;
+
+	if (cg_read(cgroup, control, buf, size)) {
+		free(buf);
+		return -1;
+	}
+
+	ret = strcmp(expected, buf);
+	free(buf);
+	return ret;
+}
+
+int cg_read_strstr(const char *cgroup, const char *control, const char *needle)
+{
+	char buf[PAGE_SIZE];
+
+	if (cg_read(cgroup, control, buf, sizeof(buf)))
+		return -1;
+
+	return strstr(buf, needle) ? 0 : -1;
+}
+
+long cg_read_long(const char *cgroup, const char *control)
+{
+	char buf[128];
+
+	if (cg_read(cgroup, control, buf, sizeof(buf)))
+		return -1;
+
+	return atol(buf);
+}
+
+long cg_read_key_long(const char *cgroup, const char *control, const char *key)
+{
+	char buf[PAGE_SIZE];
+	char *ptr;
+
+	if (cg_read(cgroup, control, buf, sizeof(buf)))
+		return -1;
+
+	ptr = strstr(buf, key);
+	if (!ptr)
+		return -1;
+
+	return atol(ptr + strlen(key));
+}
+
+long cg_read_lc(const char *cgroup, const char *control)
+{
+	char buf[PAGE_SIZE];
+	static const char delim[] = "\n";
+	char *line;
+	long cnt = 0;
+
+	if (cg_read(cgroup, control, buf, sizeof(buf)))
+		return -1;
+
+	for (line = strtok(buf, delim); line; line = strtok(NULL, delim))
+		cnt++;
+
+	return cnt;
+}
+
+/* Returns 0 on success, or -errno on failure. */
+int cg_write(const char *cgroup, const char *control, char *buf)
+{
+	char path[PATH_MAX];
+	ssize_t len = strlen(buf), ret;
+
+	snprintf(path, sizeof(path), "%s/%s", cgroup, control);
+	ret = write_text(path, buf, len);
+	return ret == len ? 0 : ret;
+}
+
+int cg_write_numeric(const char *cgroup, const char *control, long value)
+{
+	char buf[64];
+	int ret;
+
+	ret = sprintf(buf, "%lu", value);
+	if (ret < 0)
+		return ret;
+
+	return cg_write(cgroup, control, buf);
+}
+
+int cg_find_unified_root(char *root, size_t len)
+{
+	char buf[10 * PAGE_SIZE];
+	char *fs, *mount, *type;
+	static const char delim[] = "\n\t ";
+
+	if (read_text("/proc/self/mounts", buf, sizeof(buf)) <= 0)
+		return -1;
+
+	/*
+	 * Example:
+	 * cgroup /sys/fs/cgroup cgroup2 rw,seclabel,noexec,relatime 0 0
+	 */
+	for (fs = strtok(buf, delim); fs; fs = strtok(NULL, delim)) {
+		mount = strtok(NULL, delim);
+		type = strtok(NULL, delim);
+		strtok(NULL, delim);
+		strtok(NULL, delim);
+		strtok(NULL, delim);
+
+		if (strcmp(type, "cgroup2") == 0) {
+			strncpy(root, mount, len);
+			return 0;
+		}
+	}
+
+	return -1;
+}
+
+int cg_create(const char *cgroup)
+{
+	return mkdir(cgroup, 0755);
+}
+
+int cg_wait_for_proc_count(const char *cgroup, int count)
+{
+	char buf[10 * PAGE_SIZE] = {0};
+	int attempts;
+	char *ptr;
+
+	for (attempts = 10; attempts >= 0; attempts--) {
+		int nr = 0;
+
+		if (cg_read(cgroup, "cgroup.procs", buf, sizeof(buf)))
+			break;
+
+		for (ptr = buf; *ptr; ptr++)
+			if (*ptr == '\n')
+				nr++;
+
+		if (nr >= count)
+			return 0;
+
+		usleep(100000);
+	}
+
+	return -1;
+}
+
+int cg_killall(const char *cgroup)
+{
+	char buf[PAGE_SIZE];
+	char *ptr = buf;
+
+	/* If cgroup.kill exists use it. */
+	if (!cg_write(cgroup, "cgroup.kill", "1"))
+		return 0;
+
+	if (cg_read(cgroup, "cgroup.procs", buf, sizeof(buf)))
+		return -1;
+
+	while (ptr < buf + sizeof(buf)) {
+		int pid = strtol(ptr, &ptr, 10);
+
+		if (pid == 0)
+			break;
+		if (*ptr)
+			ptr++;
+		else
+			break;
+		if (kill(pid, SIGKILL))
+			return -1;
+	}
+
+	return 0;
+}
+
+int cg_destroy(const char *cgroup)
+{
+	int ret;
+
+retry:
+	ret = rmdir(cgroup);
+	if (ret && errno == EBUSY) {
+		cg_killall(cgroup);
+		usleep(100);
+		goto retry;
+	}
+
+	if (ret && errno == ENOENT)
+		ret = 0;
+
+	return ret;
+}
+
+int cg_enter(const char *cgroup, int pid)
+{
+	char pidbuf[64];
+
+	snprintf(pidbuf, sizeof(pidbuf), "%d", pid);
+	return cg_write(cgroup, "cgroup.procs", pidbuf);
+}
+
+int cg_enter_current(const char *cgroup)
+{
+	return cg_write(cgroup, "cgroup.procs", "0");
+}
+
+int cg_enter_current_thread(const char *cgroup)
+{
+	return cg_write(cgroup, "cgroup.threads", "0");
+}
+
+int cg_run(const char *cgroup,
+	   int (*fn)(const char *cgroup, void *arg),
+	   void *arg)
+{
+	int pid, retcode;
+
+	pid = fork();
+	if (pid < 0) {
+		return pid;
+	} else if (pid == 0) {
+		char buf[64];
+
+		snprintf(buf, sizeof(buf), "%d", getpid());
+		if (cg_write(cgroup, "cgroup.procs", buf))
+			exit(EXIT_FAILURE);
+		exit(fn(cgroup, arg));
+	} else {
+		waitpid(pid, &retcode, 0);
+		if (WIFEXITED(retcode))
+			return WEXITSTATUS(retcode);
+		else
+			return -1;
+	}
+}
+
+pid_t clone_into_cgroup(int cgroup_fd)
+{
+#ifdef CLONE_ARGS_SIZE_VER2
+	pid_t pid;
+
+	struct __clone_args args = {
+		.flags = CLONE_INTO_CGROUP,
+		.exit_signal = SIGCHLD,
+		.cgroup = cgroup_fd,
+	};
+
+	pid = sys_clone3(&args, sizeof(struct __clone_args));
+	/*
+	 * Verify that this is a genuine test failure:
+	 * ENOSYS -> clone3() not available
+	 * E2BIG  -> CLONE_INTO_CGROUP not available
+	 */
+	if (pid < 0 && (errno == ENOSYS || errno == E2BIG))
+		goto pretend_enosys;
+
+	return pid;
+
+pretend_enosys:
+#endif
+	errno = ENOSYS;
+	return -ENOSYS;
+}
+
+int clone_reap(pid_t pid, int options)
+{
+	int ret;
+	siginfo_t info = {
+		.si_signo = 0,
+	};
+
+again:
+	ret = waitid(P_PID, pid, &info, options | __WALL | __WNOTHREAD);
+	if (ret < 0) {
+		if (errno == EINTR)
+			goto again;
+		return -1;
+	}
+
+	if (options & WEXITED) {
+		if (WIFEXITED(info.si_status))
+			return WEXITSTATUS(info.si_status);
+	}
+
+	if (options & WSTOPPED) {
+		if (WIFSTOPPED(info.si_status))
+			return WSTOPSIG(info.si_status);
+	}
+
+	if (options & WCONTINUED) {
+		if (WIFCONTINUED(info.si_status))
+			return 0;
+	}
+
+	return -1;
+}
+
+int dirfd_open_opath(const char *dir)
+{
+	return open(dir, O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW | O_PATH);
+}
+
+#define close_prot_errno(fd)                                                           \
+	do {                                                                           \
+		if (fd >= 0) {                                                         \
+			int _e_ = errno;                                               \
+			close(fd);                                                     \
+			errno = _e_;                                                   \
+		} \
+	} while (0)
+static int clone_into_cgroup_run_nowait(const char *cgroup,
+					int (*fn)(void))
+{
+	int cgroup_fd;
+	pid_t pid;
+
+	cgroup_fd =  dirfd_open_opath(cgroup);
+	if (cgroup_fd < 0)
+		return -1;
+
+	pid = clone_into_cgroup(cgroup_fd);
+	close_prot_errno(cgroup_fd);
+	if (pid == 0)
+		exit(fn());
+
+	return pid;
+}
+
+int cg_run_nowait(const char *cgroup,
+		  int (*fn)(void))
+{
+	int pid;
+
+	pid = clone_into_cgroup_run_nowait(cgroup, fn);
+	if (pid > 0)
+		return pid;
+
+	/* Genuine test failure. */
+	if (pid < 0 && errno != ENOSYS)
+		return -1;
+
+	pid = fork();
+	if (pid == 0) {
+		char buf[64];
+
+		snprintf(buf, sizeof(buf), "%d", getpid());
+		if (cg_write(cgroup, "cgroup.procs", buf))
+			exit(EXIT_FAILURE);
+		exit(fn());
+	}
+
+	return pid;
+}
+
+int get_temp_fd(void)
+{
+	return open(".", O_TMPFILE | O_RDWR | O_EXCL, 0600);
+}
+
+int alloc_anon(void *arg)
+{
+	size_t size = (unsigned long)arg;
+	char *buf, *ptr;
+
+	buf = malloc(size);
+	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
+		*ptr = 0;
+
+	free(buf);
+	return 0;
+}
+
+int is_swap_enabled(void)
+{
+	char buf[PAGE_SIZE];
+	static const char delim[] = "\n";
+	int cnt = 0;
+	char *line;
+
+	if (read_text("/proc/swaps", buf, sizeof(buf)) <= 0)
+		return -1;
+
+	for (line = strtok(buf, delim); line; line = strtok(NULL, delim))
+		cnt++;
+
+	return cnt > 1;
+}
+
+int set_oom_adj_score(int pid, int score)
+{
+	char path[PATH_MAX];
+	int fd, len;
+
+	sprintf(path, "/proc/%d/oom_score_adj", pid);
+
+	fd = open(path, O_WRONLY | O_APPEND);
+	if (fd < 0)
+		return fd;
+
+	len = dprintf(fd, "%d", score);
+	if (len < 0) {
+		close(fd);
+		return len;
+	}
+
+	close(fd);
+	return 0;
+}
+
+int proc_mount_contains(const char *option)
+{
+	char buf[4 * PAGE_SIZE];
+	ssize_t read;
+
+	read = read_text("/proc/mounts", buf, sizeof(buf));
+	if (read < 0)
+		return read;
+
+	return strstr(buf, option) != NULL;
+}
+
+ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size)
+{
+	char path[PATH_MAX];
+	ssize_t ret;
+
+	if (!pid)
+		snprintf(path, sizeof(path), "/proc/%s/%s",
+			 thread ? "thread-self" : "self", item);
+	else
+		snprintf(path, sizeof(path), "/proc/%d/%s", pid, item);
+
+	ret = read_text(path, buf, size);
+	return ret < 0 ? -1 : ret;
+}
+
+int proc_read_strstr(int pid, bool thread, const char *item, const char *needle)
+{
+	char buf[PAGE_SIZE];
+
+	if (proc_read_text(pid, thread, item, buf, sizeof(buf)) < 0)
+		return -1;
+
+	return strstr(buf, needle) ? 0 : -1;
+}
+
+int clone_into_cgroup_run_wait(const char *cgroup)
+{
+	int cgroup_fd;
+	pid_t pid;
+
+	cgroup_fd =  dirfd_open_opath(cgroup);
+	if (cgroup_fd < 0)
+		return -1;
+
+	pid = clone_into_cgroup(cgroup_fd);
+	close_prot_errno(cgroup_fd);
+	if (pid < 0)
+		return -1;
+
+	if (pid == 0)
+		exit(EXIT_SUCCESS);
+
+	/*
+	 * We don't care whether this fails. We only care whether the initial
+	 * clone succeeded.
+	 */
+	(void)clone_reap(pid, WEXITED);
+	return 0;
+}
+
+static int __prepare_for_wait(const char *cgroup, const char *filename)
+{
+	int fd, ret = -1;
+
+	fd = inotify_init1(0);
+	if (fd == -1)
+		return fd;
+
+	ret = inotify_add_watch(fd, cg_control(cgroup, filename), IN_MODIFY);
+	if (ret == -1) {
+		close(fd);
+		fd = -1;
+	}
+
+	return fd;
+}
+
+int cg_prepare_for_wait(const char *cgroup)
+{
+	return __prepare_for_wait(cgroup, "cgroup.events");
+}
+
+int memcg_prepare_for_wait(const char *cgroup)
+{
+	return __prepare_for_wait(cgroup, "memory.events");
+}
+
+int cg_wait_for(int fd)
+{
+	int ret = -1;
+	struct pollfd fds = {
+		.fd = fd,
+		.events = POLLIN,
+	};
+
+	while (true) {
+		ret = poll(&fds, 1, 10000);
+
+		if (ret == -1) {
+			if (errno == EINTR)
+				continue;
+
+			break;
+		}
+
+		if (ret > 0 && fds.revents & POLLIN) {
+			ret = 0;
+			break;
+		}
+	}
+
+	return ret;
+}
diff --git a/testcases/kernel/controllers/kill/cgroup_util.h b/testcases/kernel/controllers/kill/cgroup_util.h
new file mode 100644
index 000000000..bc068eead
--- /dev/null
+++ b/testcases/kernel/controllers/kill/cgroup_util.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdbool.h>
+#include <stdlib.h>
+
+#define PAGE_SIZE 4096
+#define MB(x) (x << 20)
+#define USEC_PER_SEC	1000000L
+#define NSEC_PER_SEC	1000000000L
+
+/*
+ * Checks if two given values differ by less than err% of their sum.
+ */
+static inline int values_close(long a, long b, int err)
+{
+	return abs(a - b) <= (a + b) / 100 * err;
+}
+
+extern int cg_find_unified_root(char *root, size_t len);
+extern char *cg_name(const char *root, const char *name);
+extern char *cg_name_indexed(const char *root, const char *name, int index);
+extern char *cg_control(const char *cgroup, const char *control);
+extern int cg_create(const char *cgroup);
+extern int cg_destroy(const char *cgroup);
+extern int cg_read(const char *cgroup, const char *control,
+		   char *buf, size_t len);
+extern int cg_read_strcmp(const char *cgroup, const char *control,
+			  const char *expected);
+extern int cg_read_strstr(const char *cgroup, const char *control,
+			  const char *needle);
+extern long cg_read_long(const char *cgroup, const char *control);
+long cg_read_key_long(const char *cgroup, const char *control, const char *key);
+extern long cg_read_lc(const char *cgroup, const char *control);
+extern int cg_write(const char *cgroup, const char *control, char *buf);
+int cg_write_numeric(const char *cgroup, const char *control, long value);
+extern int cg_run(const char *cgroup,
+		  int (*fn)(const char *cgroup, void *arg),
+		  void *arg);
+extern int cg_enter(const char *cgroup, int pid);
+extern int cg_enter_current(const char *cgroup);
+extern int cg_enter_current_thread(const char *cgroup);
+extern int cg_run_nowait(const char *cgroup,
+			 int (*fn)(void));
+extern int get_temp_fd(void);
+extern int alloc_pagecache(int fd, size_t size);
+extern int alloc_anon(void *arg);
+extern int is_swap_enabled(void);
+extern int set_oom_adj_score(int pid, int score);
+extern int cg_wait_for_proc_count(const char *cgroup, int count);
+extern int cg_killall(const char *cgroup);
+int proc_mount_contains(const char *option);
+extern ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size);
+extern int proc_read_strstr(int pid, bool thread, const char *item, const char *needle);
+extern pid_t clone_into_cgroup(int cgroup_fd);
+extern int clone_reap(pid_t pid, int options);
+extern int clone_into_cgroup_run_wait(const char *cgroup);
+extern int dirfd_open_opath(const char *dir);
+extern int cg_prepare_for_wait(const char *cgroup);
+extern int memcg_prepare_for_wait(const char *cgroup);
+extern int cg_wait_for(int fd);
diff --git a/testcases/kernel/controllers/kill/kill01.c b/testcases/kernel/controllers/kill/kill01.c
new file mode 100644
index 000000000..e589b6c16
--- /dev/null
+++ b/testcases/kernel/controllers/kill/kill01.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2012 Christian Brauner <brauner-AT-kernel.org>
+ */
+
+/*\
+ * [Description]
+ *
+ * Basic cgroup kill test.
+ *
+ */
+
+#include <errno.h>
+#include <linux/limits.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/wait.h>
+
+#include "lapi/syscalls.h"
+#include "cgroup_util.h"
+#include "tst_test.h"
+
+/* define kselftest exit codes */
+#define KSFT_PASS  0
+#define KSFT_FAIL  1
+#define KSFT_XFAIL 2
+#define KSFT_XPASS 3
+#define KSFT_SKIP  4
+
+static int wait_for_pid(pid_t pid)
+{
+	int status, ret;
+
+again:
+	ret = waitpid(pid, &status, 0);
+	if (ret == -1) {
+		if (errno == EINTR)
+			goto again;
+
+		return -1;
+	}
+
+	if (!WIFEXITED(status))
+		return -1;
+
+	return WEXITSTATUS(status);
+}
+
+
+/*
+ * Kill the given cgroup and wait for the inotify signal.
+ * If there are no events in 10 seconds, treat this as an error.
+ * Then check that the cgroup is in the desired state.
+ */
+static int cg_kill_wait(const char *cgroup)
+{
+	int fd, ret = -1;
+
+	fd = cg_prepare_for_wait(cgroup);
+	if (fd < 0)
+		return fd;
+
+	ret = cg_write(cgroup, "cgroup.kill", "1");
+	if (ret)
+		goto out;
+
+	ret = cg_wait_for(fd);
+	if (ret)
+		goto out;
+
+out:
+	close(fd);
+	return ret;
+}
+
+/*
+ * A simple process running in a sleep loop until being
+ * re-parented.
+ */
+static int child_fn(void)
+{
+	int ppid = getppid();
+
+	while (getppid() == ppid)
+		usleep(1000);
+
+	return getppid() == ppid;
+}
+
+static int test_cgkill_simple(const char *root)
+{
+	pid_t pids[100];
+	int ret = KSFT_FAIL;
+	char *cgroup = NULL;
+	int i;
+
+	cgroup = cg_name(root, "cg_test_simple");
+	if (!cgroup)
+		goto cleanup;
+
+	if (cg_create(cgroup))
+		goto cleanup;
+
+	for (i = 0; i < 100; i++)
+		pids[i] = cg_run_nowait(cgroup, child_fn);
+
+	if (cg_wait_for_proc_count(cgroup, 100))
+		goto cleanup;
+
+	if (cg_read_strcmp(cgroup, "cgroup.events", "populated 1\n"))
+		goto cleanup;
+
+	if (cg_kill_wait(cgroup))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	for (i = 0; i < 100; i++)
+		wait_for_pid(pids[i]);
+
+	if (ret == KSFT_PASS &&
+	    cg_read_strcmp(cgroup, "cgroup.events", "populated 0\n"))
+		ret = KSFT_FAIL;
+
+	if (cgroup)
+		cg_destroy(cgroup);
+	free(cgroup);
+	return ret;
+}
+
+/*
+ * The test creates the following hierarchy:
+ *       A
+ *    / / \ \
+ *   B  E  I K
+ *  /\  |
+ * C  D F
+ *      |
+ *      G
+ *      |
+ *      H
+ *
+ * with a process in C, H and 3 processes in K.
+ * Then it tries to kill the whole tree.
+ */
+static int test_cgkill_tree(const char *root)
+{
+	pid_t pids[5];
+	char *cgroup[10] = {0};
+	int ret = KSFT_FAIL;
+	int i;
+
+	cgroup[0] = cg_name(root, "cg_test_tree_A");
+	if (!cgroup[0])
+		goto cleanup;
+
+	cgroup[1] = cg_name(cgroup[0], "B");
+	if (!cgroup[1])
+		goto cleanup;
+
+	cgroup[2] = cg_name(cgroup[1], "C");
+	if (!cgroup[2])
+		goto cleanup;
+
+	cgroup[3] = cg_name(cgroup[1], "D");
+	if (!cgroup[3])
+		goto cleanup;
+
+	cgroup[4] = cg_name(cgroup[0], "E");
+	if (!cgroup[4])
+		goto cleanup;
+
+	cgroup[5] = cg_name(cgroup[4], "F");
+	if (!cgroup[5])
+		goto cleanup;
+
+	cgroup[6] = cg_name(cgroup[5], "G");
+	if (!cgroup[6])
+		goto cleanup;
+
+	cgroup[7] = cg_name(cgroup[6], "H");
+	if (!cgroup[7])
+		goto cleanup;
+
+	cgroup[8] = cg_name(cgroup[0], "I");
+	if (!cgroup[8])
+		goto cleanup;
+
+	cgroup[9] = cg_name(cgroup[0], "K");
+	if (!cgroup[9])
+		goto cleanup;
+
+	for (i = 0; i < 10; i++)
+		if (cg_create(cgroup[i]))
+			goto cleanup;
+
+	pids[0] = cg_run_nowait(cgroup[2], child_fn);
+	pids[1] = cg_run_nowait(cgroup[7], child_fn);
+	pids[2] = cg_run_nowait(cgroup[9], child_fn);
+	pids[3] = cg_run_nowait(cgroup[9], child_fn);
+	pids[4] = cg_run_nowait(cgroup[9], child_fn);
+
+	/*
+	 * Wait until all child processes will enter
+	 * corresponding cgroups.
+	 */
+
+	if (cg_wait_for_proc_count(cgroup[2], 1) ||
+	    cg_wait_for_proc_count(cgroup[7], 1) ||
+	    cg_wait_for_proc_count(cgroup[9], 3))
+		goto cleanup;
+
+	/*
+	 * Kill A and check that we get an empty notification.
+	 */
+	if (cg_kill_wait(cgroup[0]))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	for (i = 0; i < 5; i++)
+		wait_for_pid(pids[i]);
+
+	if (ret == KSFT_PASS &&
+	    cg_read_strcmp(cgroup[0], "cgroup.events", "populated 0\n"))
+		ret = KSFT_FAIL;
+
+	for (i = 9; i >= 0 && cgroup[i]; i--) {
+		cg_destroy(cgroup[i]);
+		free(cgroup[i]);
+	}
+
+	return ret;
+}
+
+static int forkbomb_fn(void)
+{
+	int ppid;
+
+	fork();
+	fork();
+
+	ppid = getppid();
+
+	while (getppid() == ppid)
+		usleep(1000);
+
+	return getppid() == ppid;
+}
+
+/*
+ * The test runs a fork bomb in a cgroup and tries to kill it.
+ */
+static int test_cgkill_forkbomb(const char *root)
+{
+	int ret = KSFT_FAIL;
+	char *cgroup = NULL;
+	pid_t pid = -ESRCH;
+
+	cgroup = cg_name(root, "cg_forkbomb_test");
+	if (!cgroup)
+		goto cleanup;
+
+	if (cg_create(cgroup))
+		goto cleanup;
+
+	pid = cg_run_nowait(cgroup, forkbomb_fn);
+	if (pid < 0)
+		goto cleanup;
+
+	usleep(100000);
+
+	if (cg_kill_wait(cgroup))
+		goto cleanup;
+
+	if (cg_wait_for_proc_count(cgroup, 0))
+		goto cleanup;
+
+	ret = KSFT_PASS;
+
+cleanup:
+	if (pid > 0)
+		wait_for_pid(pid);
+
+	if (ret == KSFT_PASS &&
+	    cg_read_strcmp(cgroup, "cgroup.events", "populated 0\n"))
+		ret = KSFT_FAIL;
+
+	if (cgroup)
+		cg_destroy(cgroup);
+	free(cgroup);
+	return ret;
+}
+
+#define T(x) { x, #x }
+static struct tcase {
+	int (*fn)(const char *root);
+	const char *tname;
+} tcases[] = {
+	T(test_cgkill_simple),
+	T(test_cgkill_tree),
+	T(test_cgkill_forkbomb),
+};
+#undef T
+
+static void run_test(unsigned int n)
+{
+	char root[PATH_MAX];
+	struct tcase *tc = &tcases[n];
+
+	if (cg_find_unified_root(root, sizeof(root)))
+		tst_brk(TBROK, "cgroup v2 isn't mounted");
+	switch (tc->fn(root)) {
+	case KSFT_PASS:
+		tst_res(TPASS, "Successfully tested %s", tc->tname);
+		break;
+	case KSFT_SKIP:
+		tst_res(TCONF, "Skip %s since not support", tc->tname);
+		break;
+	default:
+		tst_res(TFAIL, "%s failed", tc->tname);
+		break;
+	}
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = run_test,
+	.forks_child = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
