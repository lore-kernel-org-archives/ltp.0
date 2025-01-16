Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD40DC02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 08:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737016893; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=UuhQg3oYt3fdky+cNJeTP9adedimdUf+uxoojtm81e8=;
 b=nHU+EoJafp5S6bqq2P9mm+303F/EhYHnzFxupfXKBmscQ5voqE2Evvv0A3BzyEqDolybA
 x62o2I8w4XmzKyt+wOqXC1hQPUG3Z99Et1aYPYl39lM6osIof+eLh/vAxoTJCCAxJibDSri
 +J9ELYTY1L8V2N4OH1OPtqr8pBZX75s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D0DF3C7BA2
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 09:41:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4BF43C7B90
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 09:40:22 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.137;
 helo=esa11.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com
 [207.54.90.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 186A0217039
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 09:40:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1737016822; x=1768552822;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q2Vp0W74HShbzv0gE5/9cZxbSboK2hzTgDyfhRe2vdU=;
 b=DAZKs6EYDKklZs/M0BZm4aJxOsawafbdF3+Sx31mO/SiIcPGAvTWNC7H
 6dpFm0POnv7/XoaMOY7MirJ8HRK/Of99VLquXQJb8JKxBQXCr+M59zQhm
 I3F3Jxf3H15rvIbshHgj+/6RW9VP52JS8F21zx8B3OMY4oyop1mgxsVOV
 DADVBfQNacEL4e4CIkF+c6lJRiVflxOyDgymMnIQIfUC6gHWOfqriSLxQ
 Tdjj4DCsDVR5RRhDmDpHdddQqYTJCISwyh07NozxQImztKvLneLX+lGnO
 vwViqn8DALX+2J/GkhNxY4cE1O/40DXULNJxZSTSVza8d4ONfjDwYk2ag g==;
X-CSE-ConnectionGUID: EDZ++CrjTR2ifi88Ogk5mw==
X-CSE-MsgGUID: gJ5gTk6tQgSXkzfH1WxBLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="166219835"
X-IronPort-AV: E=Sophos;i="6.13,208,1732546800"; d="scan'208";a="166219835"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 17:40:17 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id C9E12DBB81
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:40:15 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id A2239D8B31
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:40:15 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 422DF6B9B0
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:40:15 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.81])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id C8F9C1A0073;
 Thu, 16 Jan 2025 16:40:14 +0800 (CST)
To: ltp@lists.linux.it,
	andrea.cervesato@suse.com,
	pvorel@suse.cz
Date: Thu, 16 Jan 2025 16:40:13 +0800
Message-ID: <20250116084013.503341-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250116084013.503341-1-ruansy.fnst@fujitsu.com>
References: <20250116084013.503341-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28926.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28926.006
X-TMASE-Result: 10--16.199500-10.000000
X-TMASE-MatchedRID: huMMtcahIlDFkNQYjukgj5dVcy7Vo9q8yeUl7aCTy8jozDhGeQC9EtNY
 YRfr5x1AmzzMF21UDfkSuJRtSU84o1o8LOaXS5gWTuctSpiuWyU2ZWOmuJUS2VgLks93sG9t09D
 6Rw2zIrO+c1YW/zYo9uWAL3Qlk9WwNtwF1IC9LrXTfU1/F+PbMxeN9Hd3TB5GLX3qyf3ewG/fBp
 UK8sRWMVnt5WLcKQcPnMh62rDc2LujbvGIi5SCUEmSRRbSc9s3jkDrBOJwwnQGUwx5dhPPaRFEt
 97pQ+C8QjjMqdTySgNvdZwBfXZFGGwYJ6a6zhum30kDaWZBE1R9LQinZ4QefPcjNeVeWlqY+gtH
 j7OwNO2FR9Hau8GO7gP90fJP9eHt
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] fchownat03: Add error tests for fchownat()
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
From: Shiyang Ruan via ltp <ltp@lists.linux.it>
Reply-To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Move the 3 error tests form fchownat01 to here, and add tests for rest
possible errnos per the man page.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 testcases/kernel/syscalls/fchownat/.gitignore |   1 +
 .../kernel/syscalls/fchownat/fchownat03.c     | 148 ++++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fchownat/fchownat03.c

diff --git a/testcases/kernel/syscalls/fchownat/.gitignore b/testcases/kernel/syscalls/fchownat/.gitignore
index 35c00345b..60fac7e69 100644
--- a/testcases/kernel/syscalls/fchownat/.gitignore
+++ b/testcases/kernel/syscalls/fchownat/.gitignore
@@ -1,2 +1,3 @@
 /fchownat01
 /fchownat02
+/fchownat03
diff --git a/testcases/kernel/syscalls/fchownat/fchownat03.c b/testcases/kernel/syscalls/fchownat/fchownat03.c
new file mode 100644
index 000000000..06928490b
--- /dev/null
+++ b/testcases/kernel/syscalls/fchownat/fchownat03.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2006
+ * Copyright (c) Linux Test Project, 2007-2024
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that,
+ * - fchownat() returns -1 and sets errno to EACCES if there is no permission
+     to access to the file.
+ * - fchownat() returns -1 and sets errno to EBADF if the file descriptor
+ *   of the specified file is not valid.
+ * - fchownat() returns -1 and sets errno to EFAULT if the filename points
+     outside of accessable address space.
+ * - fchownat() returns -1 and sets errno to EINVAL if the flag is invalid.
+ * - fchownat() returns -1 and sets errno to ELOOP if too many symbolic links
+ *   were encountered in resolving filename.
+ * - fchownat() returns -1 and sets errno to ENAMETOOLONG if the filename is
+     too long.
+ * - fchownat() returns -1 and sets errno to ENOENT if the specified file does
+ *   not exist.
+ * - fchownat() returns -1 and sets errno to ENOTDIR if the file descriptor is
+ *   a file.
+ * - fchownat() returns -1 and sets errno to EPERM if the effective user id
+ *   of process does not match the owner of the file and the process is not
+ *   super user.
+ * - fchownat() returns -1 and sets errno to EROFS if the file is readonly.
+ */
+
+#define _GNU_SOURCE
+#include <pwd.h>
+#include "tst_test.h"
+
+#define TESTFILE		"testfile"
+#define TESTFILE_EACCESS_DIR	"eaccess"
+#define TESTFILE_EACCESS	TESTFILE_EACCESS_DIR"/eaccess"
+#define TESTFILE_ELOOP		"testfile_eloop"
+#define TESTFILE_ENOENT		"/tmp/does/not/exist"
+#define TESTFILE_EPERM		"/dev/null"
+#define TESTFILE_EROFS_MNT	"ro_mntpoint"
+#define TESTFILE_EROFS		TESTFILE_EROFS_MNT"/file"
+
+static int file_fd = -1;
+static int no_fd = -1;
+static int dir_fd = -1;
+
+static char *file_eaccess;
+static char *file_ebadf;
+static char *file_efault;
+static char *file_einval;
+static char *file_eloop;
+static char *file_enametoolong;
+static char *file_enoent;
+static char *file_enotdir;
+static char *file_eperm;
+static char *file_erofs;
+
+static struct tcase {
+	char **filename;
+	char *desc;
+	int *fd;
+	int flag;
+	int exp_errno;
+} tcases[] = {
+	{&file_eaccess,      TESTFILE_EACCESS,  &dir_fd,  0,    EACCES},
+	{&file_ebadf,        TESTFILE,          &no_fd,   0,    EBADF},
+	{&file_efault,       "Invalid address", &dir_fd,  0,    EFAULT},
+	{&file_einval,       TESTFILE,          &dir_fd,  9999, EINVAL},
+	{&file_eloop,        TESTFILE_ELOOP,    &dir_fd,  0,    ELOOP},
+	{&file_enametoolong, "aaaa...",         &dir_fd,  0,    ENAMETOOLONG},
+	{&file_enoent,       TESTFILE_ENOENT,   &dir_fd,  0,    ENOENT},
+	{&file_enotdir,      TESTFILE,          &file_fd, 0,    ENOTDIR},
+	{&file_eperm,        TESTFILE_EPERM,    &dir_fd,  0,    EPERM},
+	{&file_erofs,        TESTFILE_EROFS,    &dir_fd,  0,    EROFS},
+};
+
+static void fchownat_verify(unsigned int n)
+{
+	uid_t euid = geteuid();
+	gid_t egid = getegid();
+
+	TST_EXP_FAIL(fchownat(*tcases[n].fd, *tcases[n].filename, euid, egid, tcases[n].flag),
+		     tcases[n].exp_errno,
+		     "fchownat(%d, %s, %d, %d, %d)",
+		     *tcases[n].fd, tcases[n].desc, euid, egid, tcases[n].flag);
+}
+
+static void setup(void)
+{
+	struct passwd *ltpuser;
+
+	SAFE_TOUCH(TESTFILE, 0600, NULL);
+	dir_fd = SAFE_OPEN("./", O_DIRECTORY);
+
+	/* EACCES setting */
+	SAFE_SETEUID(0);
+	SAFE_MKDIR(TESTFILE_EACCESS_DIR, S_IRWXU);
+	SAFE_TOUCH(TESTFILE_EACCESS, 0666, NULL);
+	ltpuser = SAFE_GETPWNAM("nobody");
+	SAFE_SETEUID(ltpuser->pw_uid);
+
+	/* EFAULT setting */
+	file_efault = tst_get_bad_addr(NULL);
+
+	/* ENOTDIR setting */
+	file_fd = SAFE_OPEN("file_fd", O_CREAT | O_RDWR, 0600);
+
+	/* ELOOP setting */
+	SAFE_SYMLINK(TESTFILE_ELOOP, "test_file_eloop2");
+	SAFE_SYMLINK("test_file_eloop2", TESTFILE_ELOOP);
+
+	/* ENAMETOOLONG setting */
+	memset(file_enametoolong, 'a', PATH_MAX+1);
+	file_enametoolong[PATH_MAX+1] = 0;
+}
+
+static void cleanup(void)
+{
+	if (dir_fd != -1)
+		SAFE_CLOSE(dir_fd);
+	if (file_fd != -1)
+		SAFE_CLOSE(file_fd);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.needs_rofs = 1,
+	.mntpoint = TESTFILE_EROFS_MNT,
+	.test = fchownat_verify,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.bufs = (struct tst_buffers []) {
+		{&file_eaccess,      .str = TESTFILE_EACCESS},
+		{&file_ebadf,        .str = TESTFILE},
+		{&file_einval,       .str = TESTFILE},
+		{&file_eloop,        .str = TESTFILE_ELOOP},
+		{&file_enametoolong, .size = PATH_MAX+2},
+		{&file_enoent,       .str = TESTFILE_ENOENT},
+		{&file_enotdir,      .str = TESTFILE},
+		{&file_eperm,        .str = TESTFILE_EPERM},
+		{&file_erofs,        .str = TESTFILE_EROFS},
+		{}
+	},
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
