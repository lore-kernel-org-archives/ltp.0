Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC4AC4332F
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 13:41:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4EFD3C932D
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 14:41:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9637B3C91EA
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 14:41:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E71426008F7
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 14:41:26 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4F9BE1F391;
 Tue, 15 Mar 2022 13:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1647351686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1npqPjOgutcCuRw1Ty3JbFMJGBXbsAIARV8NWqAF1/o=;
 b=qS4sG9m9MUWQRis1Td3YS2XoCSszc9J4wfwgzWS4YUB8Tr6Efe6o2kJcD+kw79NsLlRNu4
 j4N8hhwG0ovj/fWfFv+H8RwGALLH2+3jsZCdpv7J207EPow5tO8TNb9lTkkjq02dvI3nw2
 1KclhtiogIAY4bGNaiLtC2EThWEl/rI=
Received: from g78.suse.de (unknown [10.163.24.182])
 by relay2.suse.de (Postfix) with ESMTP id 1E5C1A3B96;
 Tue, 15 Mar 2022 13:41:26 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 15 Mar 2022 13:41:22 +0000
Message-Id: <20220315134122.22912-2-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315134122.22912-1-rpalethorpe@suse.com>
References: <20220315134122.22912-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] cgroups: Add first IO controller test
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In V1 there is the blkio controller. This was renamed to just io on
V2. The interface and functionality is significantly
different. Presently there do not appear to be any tests for the V2
controller.

Note that one can not simply stat a file on BTRFS to find the actual
block device the filesystem is using. Nor can you read
/proc/self/mountinfo. BTRFS seems to generate "anonymous"
devices (e.g. 0:27) and this is what is reported by stat. These
however are invisible to the IO controller.

So instead we have to look in /proc/mounts for the device path then
stat the special (/dev/<device>) file to get the actual major and
minor device number.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/controllers                           |   3 +
 testcases/kernel/controllers/io/.gitignore    |   1 +
 testcases/kernel/controllers/io/Makefile      |   6 +
 .../kernel/controllers/io/io_control01.c      | 162 ++++++++++++++++++
 4 files changed, 172 insertions(+)
 create mode 100644 testcases/kernel/controllers/io/.gitignore
 create mode 100644 testcases/kernel/controllers/io/Makefile
 create mode 100644 testcases/kernel/controllers/io/io_control01.c

diff --git a/runtest/controllers b/runtest/controllers
index 3108a2561..22d482050 100644
--- a/runtest/controllers
+++ b/runtest/controllers
@@ -360,6 +360,9 @@ cpuset_regression_test cpuset_regression_test.sh
 
 cgroup_xattr	cgroup_xattr
 
+# V2 IO controller (was blkio)
+io_control01 io_control01
+
 pids_1_1 pids.sh 1 1 0
 pids_1_2 pids.sh 1 2 0
 pids_1_10 pids.sh 1 10 0
diff --git a/testcases/kernel/controllers/io/.gitignore b/testcases/kernel/controllers/io/.gitignore
new file mode 100644
index 000000000..d626fa80d
--- /dev/null
+++ b/testcases/kernel/controllers/io/.gitignore
@@ -0,0 +1 @@
+io_control01
diff --git a/testcases/kernel/controllers/io/Makefile b/testcases/kernel/controllers/io/Makefile
new file mode 100644
index 000000000..5ea7d67db
--- /dev/null
+++ b/testcases/kernel/controllers/io/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/controllers/io/io_control01.c b/testcases/kernel/controllers/io/io_control01.c
new file mode 100644
index 000000000..706e67c89
--- /dev/null
+++ b/testcases/kernel/controllers/io/io_control01.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0
+/* [Description]
+ *
+ * Perform some I/O on a file and check if at least some of it is
+ * recorded by the I/O controller.
+ *
+ * The exact amount of I/O performed is dependent on the file system,
+ * page cache, scheduler and block driver. We call sync and drop the
+ * file's page cache to force reading and writing. We also write
+ * random data to try to prevent compression.
+ *
+ * The pagecache is a particular issue for reading. If the call to
+ * fadvise is ignored then the data may only be read from the
+ * cache. So that no I/O requests are made.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/sysmacros.h>
+#include <mntent.h>
+
+#include "tst_test.h"
+
+static unsigned int dev_major, dev_minor;
+
+static void run(void)
+{
+	int i, fd;
+	char *line, *buf_ptr;
+	const size_t pgsz = SAFE_SYSCONF(_SC_PAGESIZE);
+	char *buf = SAFE_MALLOC(MAX((size_t)BUFSIZ, pgsz));
+	unsigned long st_rbytes = 0, st_wbytes = 0, st_rios = 0, st_wios = 0;
+
+	SAFE_CG_READ(tst_cg, "io.stat", buf, BUFSIZ - 1);
+	line = strtok_r(buf, "\n", &buf_ptr);
+	while (line) {
+		unsigned int mjr, mnr;
+		unsigned long dbytes, dios;
+
+		const int convs =
+			sscanf(line,
+			       "%u:%u rbytes=%lu wbytes=%lu rios=%lu wios=%lu dbytes=%lu dios=%lu",
+			       &mjr, &mnr, &st_rbytes, &st_wbytes, &st_rios, &st_wios,
+			       &dbytes, &dios);
+
+		if (convs < 2)
+			continue;
+
+		tst_res(TINFO, "Found %u:%u in io.stat", dev_major, dev_minor);
+
+		if (mjr == dev_major || mnr == dev_minor)
+			break;
+
+		line = strtok_r(NULL, "\n", &buf_ptr);
+	}
+
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
+
+	fd = SAFE_OPEN("/dev/urandom", O_RDONLY, 0600);
+	SAFE_READ(1, fd, buf, pgsz);
+	SAFE_CLOSE(fd);
+
+	fd = SAFE_OPEN("mnt/dat", O_WRONLY | O_CREAT, 0600);
+
+	for (i = 0; i < 4; i++) {
+		SAFE_WRITE(1, fd, buf, pgsz);
+		SAFE_FSYNC(fd);
+		TST_EXP_PASS_SILENT(posix_fadvise(fd, pgsz * i, pgsz, POSIX_FADV_DONTNEED));
+	}
+
+	SAFE_CLOSE(fd);
+	fd = SAFE_OPEN("mnt/dat", O_RDONLY, 0600);
+
+	for (i = 0; i < 4; i++)
+		SAFE_READ(1, fd, buf, pgsz);
+
+	tst_res(TPASS, "Did some IO in the IO controller");
+
+	SAFE_CG_READ(tst_cg, "io.stat", buf, BUFSIZ - 1);
+	line = strtok_r(buf, "\n", &buf_ptr);
+	while (line) {
+		unsigned int mjr, mnr;
+		unsigned long rbytes, wbytes, rios, wios, dbytes, dios;
+
+		const int convs =
+			sscanf(line,
+			       "%u:%u rbytes=%lu wbytes=%lu rios=%lu wios=%lu dbytes=%lu dios=%lu",
+			       &mjr, &mnr, &rbytes, &wbytes, &rios, &wios,
+			       &dbytes, &dios);
+
+		if (convs < 8)
+			break;
+
+		if (mjr != dev_major || mnr != dev_minor) {
+			line = strtok_r(NULL, "\n", &buf_ptr);
+			continue;
+		}
+
+		tst_res(TPASS, "Found %u:%u in io.stat", dev_major, dev_minor);
+		TST_EXP_EXPR(rbytes > st_rbytes, "(rbytes=%lu) > (st_rbytes=%lu)", rbytes, st_rbytes);
+		TST_EXP_EXPR(wbytes > st_wbytes, "(wbytes=%lu) > (st_wbytes=%lu)", wbytes, st_wbytes);
+		TST_EXP_EXPR(rios > st_rios, "(rios=%lu) > (st_rios=%lu)", rios, st_rios);
+		TST_EXP_EXPR(wios > st_wios, "(wios=%lu) > (st_wios=%lu)", wios, st_wios);
+
+		goto out;
+	}
+
+	tst_res(TINFO, "io.stat:\n%s", buf);
+	tst_res(TFAIL, "Did not find %u:%u in io.stat", dev_major, dev_minor);
+out:
+	free(buf);
+	SAFE_CLOSE(fd);
+	SAFE_UNLINK("mnt/dat");
+}
+
+static void setup(void)
+{
+	char buf[PATH_MAX] = { 0 };
+	char *path = SAFE_GETCWD(buf, PATH_MAX - sizeof("mnt") - 1);
+	struct mntent *mnt;
+	FILE *mntf = setmntent("/proc/self/mounts", "r");
+	struct stat st;
+
+	strcpy(path + strlen(path), "/mnt");
+
+	if (!mntf) {
+		tst_brk(TBROK | TERRNO, "Can't open /proc/self/mounts");
+		return;
+	}
+
+	mnt = getmntent(mntf);
+	if (!mnt) {
+		tst_brk(TBROK | TERRNO, "Can't read mounts or no mounts?");
+		return;
+	}
+
+	do {
+		if (strcmp(mnt->mnt_dir, path))
+			continue;
+
+		SAFE_STAT(mnt->mnt_fsname, &st);
+		dev_major = major(st.st_rdev);
+		dev_minor = minor(st.st_rdev);
+
+		return;
+
+	} while ((mnt = getmntent(mntf)));
+
+	tst_brk(TBROK, "Could not find mount device");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_device = 1,
+	.mntpoint = "mnt",
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const[]){ "ntfs", "tmpfs", NULL },
+	.needs_cgroup_ver = TST_CG_V2,
+	.needs_cgroup_ctrls = (const char *const[]){ "io", NULL },
+};
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
