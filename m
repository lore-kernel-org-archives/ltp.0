Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592FFCD54A4
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 08:30:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C086C3CE482
	for <ltp@archiver.kernel.org>; Tue, 19 Sep 2023 10:30:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BCCD03CA70E
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 10:29:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 77E2310009F7
 for <ltp@lists.linux.it>; Tue, 19 Sep 2023 10:29:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B37801FE09;
 Tue, 19 Sep 2023 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1695112194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sk+jW0rbVZbENPFOOr63vAVDOQzc70cdzeCN43iLaHA=;
 b=Bd3cWf2lySY28M8tOeolzkBozLh20C5K8LgV1yLRlChq23n4q15dVTfmkAtOEIwQUYvv/S
 CoLhdjzR/xZQyG80OwP+ZVORyNp4Wwum0idvJt+4K1GAErrhpWcNGMG7VckGhOLpdqJQW4
 +oG5ETcZ/trBWtD8lsz82K6pHKuqFfI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F056B13458;
 Tue, 19 Sep 2023 08:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QobLLwFcCWWNDgAAMHmgww
 (envelope-from <wegao@suse.com>); Tue, 19 Sep 2023 08:29:53 +0000
To: ltp@lists.linux.it
Date: Tue, 19 Sep 2023 04:29:49 -0400
Message-Id: <20230919082949.21027-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230908072925.15102-1-wegao@suse.com>
References: <20230908072925.15102-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cachestat01.c: Add cachestat() testcheck
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 configure.ac                                  |   1 +
 include/lapi/cachestat.h                      |  36 +++
 include/lapi/syscalls/aarch64.in              |   1 +
 include/lapi/syscalls/arc.in                  |   1 +
 include/lapi/syscalls/arm.in                  |   1 +
 include/lapi/syscalls/hppa.in                 |   1 +
 include/lapi/syscalls/i386.in                 |   1 +
 include/lapi/syscalls/ia64.in                 |   1 +
 include/lapi/syscalls/powerpc.in              |   1 +
 include/lapi/syscalls/powerpc64.in            |   1 +
 include/lapi/syscalls/s390.in                 |   1 +
 include/lapi/syscalls/s390x.in                |   1 +
 include/lapi/syscalls/sh.in                   |   1 +
 include/lapi/syscalls/sparc.in                |   1 +
 include/lapi/syscalls/sparc64.in              |   1 +
 include/lapi/syscalls/x86_64.in               |   1 +
 runtest/syscalls                              |   2 +
 .../kernel/syscalls/cachestat/.gitignore      |   1 +
 testcases/kernel/syscalls/cachestat/Makefile  |   8 +
 .../kernel/syscalls/cachestat/cachestat01.c   | 260 ++++++++++++++++++
 20 files changed, 322 insertions(+)
 create mode 100644 include/lapi/cachestat.h
 create mode 100644 testcases/kernel/syscalls/cachestat/.gitignore
 create mode 100644 testcases/kernel/syscalls/cachestat/Makefile
 create mode 100644 testcases/kernel/syscalls/cachestat/cachestat01.c

diff --git a/configure.ac b/configure.ac
index 662c4c058..4b5547b5b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -93,6 +93,7 @@ AC_CHECK_FUNCS_ONCE([ \
     epoll_pwait2 \
     execveat \
     faccessat2 \
+    cachestat \
     fallocate \
     fchownat \
     fsconfig \
diff --git a/include/lapi/cachestat.h b/include/lapi/cachestat.h
new file mode 100644
index 000000000..fea390849
--- /dev/null
+++ b/include/lapi/cachestat.h
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2003-2023
+ * Author: Wei Gao <wegao@suse.com>
+ */
+
+#ifndef CACHESTAT_H
+#define CACHESTAT_H
+
+#include "tst_test.h"
+#include "config.h"
+#include "lapi/syscalls.h"
+
+#ifndef HAVE_CACHESTAT
+struct cachestat_range {
+	__u64 off;
+	__u64 len;
+};
+
+struct cachestat {
+	__u64 nr_cache;
+	__u64 nr_dirty;
+	__u64 nr_writeback;
+	__u64 nr_evicted;
+	__u64 nr_recently_evicted;
+};
+
+int cachestat(unsigned int fd,
+                struct cachestat_range *cstat_range,
+                struct cachestat *cstat, unsigned int flags)
+{
+	return tst_syscall(__NR_cachestat, fd, cstat_range, cstat, flags);
+}
+#endif
+
+#endif /* CACHESTAT_H */
diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 2cb6c2d87..1c0218eae 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -297,4 +297,5 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 3e2ee9061..5d7cd6ca4 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -317,3 +317,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 7bdbca533..e41a7e576 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -395,3 +395,4 @@ faccessat2 (__NR_SYSCALL_BASE+439)
 epoll_pwait2 (__NR_SYSCALL_BASE+441)
 quotactl_fd (__NR_SYSCALL_BASE+443)
 futex_waitv (__NR_SYSCALL_BASE+449)
+cachestat (__NR_SYSCALL_BASE+451)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 8ebdafafb..2772e7334 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -44,3 +44,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index 1472631c4..2d341182e 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -431,3 +431,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 0ea6e9722..141c6be51 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -344,3 +344,4 @@ faccessat2 1463
 epoll_pwait2 1465
 quotactl_fd 1467
 futex_waitv 1473
+cachestat 1475
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index 545d9d3d6..67e928951 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -424,3 +424,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index 545d9d3d6..67e928951 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -424,3 +424,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index 7213ac5f8..b456ea408 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -411,3 +411,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 879012e2b..2c57eacdf 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -359,3 +359,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 7d5192a27..25eb9bb26 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -405,3 +405,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 91d2fb1c2..e934591dd 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -410,3 +410,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 1f2fc59b7..4c489e38d 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -375,3 +375,4 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index dc61aa56e..4afea6019 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -352,6 +352,7 @@ faccessat2 439
 epoll_pwait2 441
 quotactl_fd 443
 futex_waitv 449
+cachestat 451
 rt_sigaction 512
 rt_sigreturn 513
 ioctl 514
diff --git a/runtest/syscalls b/runtest/syscalls
index 4fb76584f..b84b2d2ce 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -59,6 +59,8 @@ capset04 capset04
 
 cacheflush01 cacheflush01
 
+cachestat01 cachestat01
+
 chdir01 chdir01
 chdir01A symlink01 -T chdir01
 chdir04 chdir04
diff --git a/testcases/kernel/syscalls/cachestat/.gitignore b/testcases/kernel/syscalls/cachestat/.gitignore
new file mode 100644
index 000000000..870bceae4
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/.gitignore
@@ -0,0 +1 @@
+/cachestat01
diff --git a/testcases/kernel/syscalls/cachestat/Makefile b/testcases/kernel/syscalls/cachestat/Makefile
new file mode 100644
index 000000000..49238eee0
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (c) 2023 Wei Gao <wegao@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
new file mode 100644
index 000000000..9ad432b59
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
@@ -0,0 +1,260 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Andre Przywara <andre.przywara@arm.com>
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ *
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that cachestat() executes successfully
+ *
+ */
+
+#include <stdio.h>
+#include <math.h>
+#include <unistd.h> /* _SC_PAGESIZE */
+#include <stdbool.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/cachestat.h"
+
+#define SAFE_FREE(p) { if (p) { free(p); (p) = NULL; } }
+#define TMPFS_MAGIC 0x01021994
+#define TEST_NORMAL_FILE "tmpfilecachestat"
+#define SHM_FILE "tmpshmcstat"
+#define NUM_PAGES 4
+
+static int fd;
+static int fd_shm;
+static size_t PS;
+static size_t filesize;
+static char *data;
+static int random_fd;
+
+/*
+ * fsync() is implemented via noop_fsync() on tmpfs. This makes the fsync()
+ * test fail below, so we need to check for test file living on a tmpfs.
+ */
+static bool is_on_tmpfs(int fd)
+{
+	struct statfs statfs_buf;
+
+	if (fstatfs(fd, &statfs_buf))
+		return false;
+
+	return statfs_buf.f_type == TMPFS_MAGIC;
+}
+
+static void print_cachestat(struct cachestat *cs)
+{
+	tst_res(TINFO,
+			"Using cachestat: Cached: %llu, Dirty: %llu, Writeback: %llu, Evicted: %llu, Recently Evicted: %llu",
+			cs->nr_cache, cs->nr_dirty, cs->nr_writeback,
+			cs->nr_evicted, cs->nr_recently_evicted);
+}
+
+static const char * const dev_files[] = {
+	"/dev/zero", "/dev/null", "/dev/urandom",
+	"/proc/version", "/proc"
+};
+
+static bool write_exactly(int write_fd)
+{
+	char *cursor;
+	int remained;
+
+	remained = filesize;
+	cursor = data;
+	while (remained) {
+		ssize_t read_len = SAFE_READ(1, random_fd, cursor, remained);
+
+		if (read_len <= 0)
+			tst_brk(TBROK | TERRNO, "Unable to read from urandom.");
+
+		remained -= read_len;
+		cursor += read_len;
+	}
+
+	remained = filesize;
+	cursor = data;
+	while (remained) {
+		ssize_t write_len = SAFE_WRITE(1, write_fd, cursor, remained);
+
+		if (write_len <= 0)
+			tst_brk(TBROK | TERRNO, "Unable write random data to file.");
+
+		remained -= write_len;
+		cursor += write_len;
+	}
+
+	return true;
+}
+
+/*
+ * Open/create the file at filename, (optionally) write random data to it
+ * (exactly num_pages), then test the cachestat syscall on this file.
+ *
+ * If test_fsync == true, fsync the file, then check the number of dirty
+ * pages.
+ */
+static void test_cachestat(const char *filename, bool write_random, bool create,
+		bool test_fsync, int open_flags, mode_t open_mode)
+{
+	struct cachestat cs;
+	struct cachestat_range cs_range = { 0, filesize };
+
+	if (!fcntl(fd, F_GETFD))
+		SAFE_CLOSE(fd);
+	fd = SAFE_OPEN(filename, open_flags, open_mode);
+
+	if (write_random) {
+		if (!write_exactly(fd))
+			tst_brk(TBROK | TERRNO, "Unable to access urandom.");
+	}
+
+	TST_EXP_PASS(cachestat(fd, &cs_range, &cs, 0));
+
+	print_cachestat(&cs);
+
+	if (write_random) {
+		if (cs.nr_cache + cs.nr_evicted != NUM_PAGES) {
+			tst_brk(TBROK | TERRNO,
+					"Total number of cached and evicted pages is off.");
+		}
+	}
+
+	if (test_fsync) {
+		if (is_on_tmpfs(fd)) {
+			tst_res(TCONF, "skip fsync check on tmpfs");
+		} else if (fsync(fd)) {
+			tst_brk(TBROK | TERRNO, "fsync fails.");
+		} else {
+			TST_EXP_PASS(cachestat(fd, &cs_range, &cs, 0));
+			print_cachestat(&cs);
+			if (cs.nr_dirty) {
+				tst_brk(TBROK | TERRNO,
+						"Number of dirty should be zero after fsync.");
+			} else {
+				tst_res(TPASS, "Cachestat (after fsync) pass.");
+			}
+		}
+	}
+
+	close(fd);
+
+	if (create)
+		remove(filename);
+
+	tst_res(TPASS, "cachestat works with file %s", filename);
+}
+
+static void test_incorrect_file(void)
+{
+	TST_EXP_FAIL(cachestat(-1, NULL, NULL, 0), EBADF);
+}
+
+static void test_virtual_file(void)
+{
+	for (unsigned long i = 0; i < sizeof(dev_files) / sizeof(*dev_files); i++) {
+		const char *dev_filename = dev_files[i];
+
+		test_cachestat(dev_filename, false, false, false, O_RDONLY, 0400);
+	}
+}
+
+static void test_normal_file(void)
+{
+	test_cachestat(TEST_NORMAL_FILE, true, true, false, O_CREAT | O_RDWR, 0600);
+	test_cachestat(TEST_NORMAL_FILE, true, true, true, O_CREAT | O_RDWR, 0600);
+}
+
+static void check_cachestat_range(struct cachestat_range *ptr_cs_range, __u64 expect_num_pages)
+{
+	struct cachestat cs;
+
+	TST_EXP_PASS(cachestat(fd_shm, ptr_cs_range, &cs, 0));
+	print_cachestat(&cs);
+	if (cs.nr_cache + cs.nr_evicted != expect_num_pages) {
+		tst_brk(TFAIL | TERRNO,
+				"Total number of cached and evicted pages is off.");
+	} else {
+		tst_res(TPASS,
+				"Cachestat range check pass.");
+	}
+}
+
+static void test_share_memory(void)
+{
+
+	struct cachestat_range cs_range = { 0, filesize};
+
+	if (ftruncate(fd_shm, filesize))
+		tst_brk(TFAIL | TERRNO, "Unable to truncate shmem file.");
+
+	if (!write_exactly(fd_shm))
+		tst_brk(TFAIL | TERRNO, "Unable to write to shmem file.");
+
+	check_cachestat_range(&cs_range, NUM_PAGES);
+
+	size_t compute_len = PS * NUM_PAGES / 2;
+	unsigned long num_pages = ceil((double)NUM_PAGES / 2);
+
+	cs_range.off = PS;
+	cs_range.len = compute_len;
+	check_cachestat_range(&cs_range, num_pages);
+}
+
+static struct tcase {
+	void (*tfunc)(void);
+} tcases[] = {
+	{&test_incorrect_file},
+	{&test_virtual_file},
+	{&test_normal_file},
+	{&test_share_memory}
+};
+
+static void run(unsigned int i)
+{
+	tcases[i].tfunc();
+}
+
+
+static void setup(void)
+{
+
+	PS = sysconf(_SC_PAGESIZE);
+	filesize = NUM_PAGES * PS;
+	data = tst_alloc(filesize);
+	random_fd = SAFE_OPEN("/dev/urandom", O_RDONLY);
+
+	/* setup for test_share_memory case */
+	fd_shm = shm_open(SHM_FILE, O_CREAT | O_RDWR, 0700);
+	if (fd_shm < 0)
+		tst_brk(TFAIL | TERRNO, "Unable to create shmem file.");
+}
+
+static void cleanup(void)
+{
+	SAFE_CLOSE(random_fd);
+
+	/* cleanup for test_normal_file case*/
+	if (!fcntl(fd, F_GETFD))
+		SAFE_CLOSE(fd);
+	remove(TEST_NORMAL_FILE);
+
+	/* cleanup for test_share_memory case */
+	SAFE_CLOSE(fd_shm);
+	shm_unlink(SHM_FILE);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_tmpdir = 1,
+	.min_kver = "6.5.0"
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
