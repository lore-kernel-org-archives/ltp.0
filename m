Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E76CD128A
	for <ltp@archiver.kernel.org>; Mon,  1 Apr 2024 03:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711942048; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=+G6+D+BBmJSpCkaRiJdIyaXpCKm56pOZI91nqxdfkkk=;
 b=BJ95NKfcW0jIuGkdjTh1BZ2TokRtoKX8f4IesYdDP5lzkaCjXPMEyAEOpO8FC4j/2TyqS
 4C+1/2X7hJEiJK0y+sI9CpXmdqNYTXDQ0r9b6XbN/ukhrbRWGRHCzPE5CKmW9VGchUyHxQl
 EWBVtLoBp/tJlKpKZQehWSKHuxf2lP0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19BAF3CB75C
	for <ltp@archiver.kernel.org>; Mon,  1 Apr 2024 05:27:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 572893CAECE
 for <ltp@lists.linux.it>; Mon,  1 Apr 2024 05:27:07 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=139.138.61.252;
 helo=esa7.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com
 [139.138.61.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 902011A00606
 for <ltp@lists.linux.it>; Mon,  1 Apr 2024 05:27:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1711942026; x=1743478026;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FWPIGjQAKxO7cMDW+CUuldFNOYPye+LBGoaRX/MXxS4=;
 b=SW4Ed1D3M5oSIXUHWonWTHHEmxUwnY7JHqT7wUVpyl+I9xiLNa1ntJW1
 YG2xSbjbwGCELH3pHTXpGJcoprkOfCEEYPt8oHKSGB+oHb15BEMJkkNF5
 Gk1q8a0Q0eaoYj4d4FBkaUTG8lyEpUmqiHMnwK6XI+H5+2RtnHTjX8Y7S
 v+3ERjEh7SW9GpbAOZQMFU0M8uT7IuKDVLKA76nLYmdY+mjDU+l6U6yWE
 TdXyaJA7oJ+CzLt+xiuiGPUjcTlhFE4+TB5uSJNwy25MXqb1RruI9to0+
 dwr4LfENRefAkmVjc+Pa0FZN/gWwtqiL05jcQVHXZTqJrec3YZQ1qvUjz A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="132987553"
X-IronPort-AV: E=Sophos;i="6.07,171,1708354800"; d="scan'208";a="132987553"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2024 12:27:02 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8BAF3E95D6
 for <ltp@lists.linux.it>; Mon,  1 Apr 2024 12:27:00 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id CD1E3CFA5E
 for <ltp@lists.linux.it>; Mon,  1 Apr 2024 12:26:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 543F11E9543
 for <ltp@lists.linux.it>; Mon,  1 Apr 2024 12:26:59 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id E7CE61A0002;
 Mon,  1 Apr 2024 11:26:58 +0800 (CST)
To: ltp@lists.linux.it
Date: Sun, 31 Mar 2024 22:52:49 -0400
Message-Id: <20240401025249.8715-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28290.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28290.004
X-TMASE-Result: 10--21.599100-10.000000
X-TMASE-MatchedRID: ViBM8e+kg1tSuJfEWZSQfKzGfgakLdjaTJDl9FKHbrk6FHRWx2FGsI3c
 eRXYSJoDIvrftAIhWmJ8eC2pVr1wb6/Elphzpf1LGYJhRh6ssesfimmlcABuNyfJTn+dmnFQGmV
 udEhnpoTXFQkvS/0vibjp8M1JUHNNXhvAA0pOb6LkKCFOKwAEzF7OZ6hrwwnzRaSpfGgYItc7ET
 vuQ225CeK7iWl7pVxurWabj9w4QrbOLLwxlMO5Pb9A3Bl1/DcV+VJ6lZyB0s/PhbT/QiIN5YY+d
 4I4WCpEGPUqcyv3m0IhRIvYJaL9ihccs8336rx5hdD+G7U5X/SOVGny5q72hrq7tRXXP55Go8WM
 kQWv6iXBcIE78YqRWo6HM5rqDwqtlExlQIQeRG0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] unlinkat: Add negative tests for unlinkat
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add negative cases for unlink(), including following errnos:
EACCES, EFAULT, EISDIR, ENAMETOOLONG ENOENT, ENOTDIR, EPERM, EROFS, EBADF,
EINVAL

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/unlinkat/.gitignore |   1 +
 .../kernel/syscalls/unlinkat/unlinkat02.c     | 202 ++++++++++++++++++
 3 files changed, 204 insertions(+)
 create mode 100644 testcases/kernel/syscalls/unlinkat/unlinkat02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b99ce7170..ed5eab1a9 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1655,6 +1655,7 @@ unlink09 unlink09
 
 #unlinkat test cases
 unlinkat01 unlinkat01
+unlinkat02 unlinkat02
 
 unshare01 unshare01
 unshare02 unshare02
diff --git a/testcases/kernel/syscalls/unlinkat/.gitignore b/testcases/kernel/syscalls/unlinkat/.gitignore
index 76ed551f2..450063051 100644
--- a/testcases/kernel/syscalls/unlinkat/.gitignore
+++ b/testcases/kernel/syscalls/unlinkat/.gitignore
@@ -1 +1,2 @@
 /unlinkat01
+/unlinkat02
diff --git a/testcases/kernel/syscalls/unlinkat/unlinkat02.c b/testcases/kernel/syscalls/unlinkat/unlinkat02.c
new file mode 100644
index 000000000..87e6dc704
--- /dev/null
+++ b/testcases/kernel/syscalls/unlinkat/unlinkat02.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that unlinkat(2) fails with
+ *
+ * - EACCES when write access to the directory containing pathname not allowed
+ * - EACCES when one of directories in pathname did not allow search permission
+ * - EFAULT when pathname points outside acessible address space
+ * - EISDIR when pathname refers to a directory
+ * - ENAMETOOLONG when pathname is too long
+ * - ENOENT when a component of the pathname does not exist
+ * - ENOENT when pathname is empty
+ * - ENOTDIR when a component of pathname used as dicrectory is not a directory
+ * - EPERM when file to be unlinked is marked immutable
+ * - EPERM when file to be unlinked is marked append-only
+ * - EROFS when pathname refers to a file on a read-only filesystem
+ * - EBADF when pathname is relative but dirfd is neither AT_FDCWD nor valid
+ * - EINVAL when an invalid flag is specified
+ * - ENOTDIR when pathname is relative and dirfd refers to a file
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <pwd.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "lapi/fs.h"
+
+#define DIR_EACCES_NOWRITE "nowrite"
+#define DIR_EACCES_NOSEARCH "nosearch"
+#define TEST_EACCES "test_eacces"
+#define DIR_NORMAL "normal"
+#define TEST_NORMAL "test_normal"
+#define TEST_EFAULT "test_efault"
+#define DIR_EISDIR "isdir"
+#define TEST_ENOENT_NOTEXIST "test_enoent_notexist"
+#define TEST_ENOENT_FILE "test_enoent_file"
+#define TEST_ENOTDIR "enotdir/file"
+#define DIR_ENOTDIR "enotdir"
+#define TEST_EPERM_IMMUTABLE "test_eperm_immutable"
+#define TEST_EPERM_APPEND_ONLY "test_eperm_append_only"
+#define DIR_EROFS "erofs"
+#define TEST_EROFS "test_erofs"
+#define DIR_EBADF "ebadf"
+#define TEST_EBADF "test_ebadf"
+#define DIR_ENOTDIR2 "enotdir2"
+#define TEST_ENOTDIR2 "test_enotdir2"
+
+static struct passwd *pw;
+static char longfilename[PATH_MAX + 1];
+static int fd_immutable;
+static int fd_append_only;
+
+static struct test_case_t {
+	char *dirname;
+	char *filename;
+	int flags;
+	int user;
+	int expected_errno;
+	char *desc;
+} tcases[] = {
+	{DIR_EACCES_NOWRITE, TEST_EACCES, 0, 1, EACCES,
+		"unlinkat() in directory with no write access"},
+	{DIR_EACCES_NOSEARCH, TEST_EACCES, 0, 1, EACCES,
+		"unlinkat() in directory with no search access"},
+	{DIR_NORMAL, NULL, 0, 0, EFAULT,
+		"unlinkat() access pathname outside address space"},
+	{DIR_NORMAL, DIR_EISDIR, 0, 0, EISDIR,
+		"unlinkat() pathname is a directory"},
+	{DIR_NORMAL, longfilename, 0, 0, ENAMETOOLONG,
+		"unlinkat() pathname is too long"},
+	{DIR_NORMAL, TEST_ENOENT_NOTEXIST, 0, 0, ENOENT,
+		"unlinkat() pathname does not exist"},
+	{DIR_NORMAL, "", 0, 0, ENOENT,
+		"unlinkat() pathname is a empty"},
+	{DIR_NORMAL, TEST_ENOTDIR, 0, 0, ENOTDIR,
+		"unlinkat() component of pathname used as directory "
+		"is not directory"},
+	{DIR_NORMAL, TEST_EPERM_IMMUTABLE, 0, 0, EPERM,
+		"unlinkat() pathname is immutable"},
+	{DIR_NORMAL, TEST_EPERM_APPEND_ONLY, 0, 0, EPERM,
+		"unlinkat() pathname is append-only"},
+	{DIR_EROFS, TEST_EROFS, 0, 0, EROFS,
+		"unlinkat() pathname in read-only filesystem"},
+	{DIR_EBADF, TEST_EBADF, 0, 0, EBADF,
+		"unlinkat() dirfd is not valid"},
+	{DIR_NORMAL, TEST_NORMAL, -1, 0, EINVAL,
+		"unlinkat() flag is not valid"},
+	{DIR_ENOTDIR2, TEST_ENOTDIR2, 0, 0, ENOTDIR,
+		"unlinkat() dirfd is not a directory"},
+};
+
+static void setup(void)
+{
+	int attr;
+
+	pw = SAFE_GETPWNAM("nobody");
+
+	SAFE_MKDIR(DIR_EACCES_NOWRITE, 0777);
+	SAFE_TOUCH(DIR_EACCES_NOWRITE "/" TEST_EACCES, 0777, NULL);
+	SAFE_CHMOD(DIR_EACCES_NOWRITE, 0555);
+
+	SAFE_MKDIR(DIR_EACCES_NOSEARCH, 0777);
+	SAFE_TOUCH(DIR_EACCES_NOSEARCH "/" TEST_EACCES, 0777, NULL);
+	SAFE_CHMOD(DIR_EACCES_NOSEARCH, 0666);
+
+	SAFE_MKDIR(DIR_NORMAL, 0777);
+	SAFE_TOUCH(DIR_NORMAL "/" TEST_NORMAL, 0777, NULL);
+	SAFE_TOUCH(DIR_NORMAL "/" TEST_EFAULT, 0777, NULL);
+
+	SAFE_MKDIR(DIR_NORMAL "/" DIR_EISDIR, 0777);
+
+	memset(longfilename, '1', PATH_MAX + 1);
+
+	SAFE_TOUCH(DIR_NORMAL "/" DIR_ENOTDIR, 0777, NULL);
+
+	fd_immutable = SAFE_OPEN(DIR_NORMAL "/" TEST_EPERM_IMMUTABLE,
+			O_CREAT, 0777);
+	ioctl(fd_immutable, FS_IOC_GETFLAGS, &attr);
+	attr |= FS_IMMUTABLE_FL;
+	ioctl(fd_immutable, FS_IOC_SETFLAGS, &attr);
+	SAFE_CLOSE(fd_immutable);
+
+	fd_append_only = SAFE_OPEN(DIR_NORMAL "/" TEST_EPERM_APPEND_ONLY,
+			O_CREAT, 0777);
+	ioctl(fd_append_only, FS_IOC_GETFLAGS, &attr);
+	attr |= FS_IMMUTABLE_FL;
+	ioctl(fd_append_only, FS_IOC_SETFLAGS, &attr);
+	SAFE_CLOSE(fd_append_only);
+
+	SAFE_TOUCH(DIR_ENOTDIR2, 0777, NULL);
+}
+
+static void cleanup(void)
+{
+	int attr;
+
+	fd_immutable = SAFE_OPEN(DIR_NORMAL "/" TEST_EPERM_IMMUTABLE,
+			O_RDONLY, 0777);
+	ioctl(fd_immutable, FS_IOC_GETFLAGS, &attr);
+	attr &= ~FS_IMMUTABLE_FL;
+	ioctl(fd_immutable, FS_IOC_SETFLAGS, &attr);
+	SAFE_CLOSE(fd_immutable);
+
+	fd_append_only = SAFE_OPEN(DIR_NORMAL "/" TEST_EPERM_APPEND_ONLY,
+			O_RDONLY, 0777);
+	ioctl(fd_append_only, FS_IOC_GETFLAGS, &attr);
+	attr &= ~FS_IMMUTABLE_FL;
+	ioctl(fd_append_only, FS_IOC_SETFLAGS, &attr);
+	SAFE_CLOSE(fd_append_only);
+}
+
+static void do_unlinkat(struct test_case_t *tc)
+{
+	int dirfd = open(tc->dirname, O_DIRECTORY);
+	/* Special situation when dirfd refers to a file */
+	if (dirfd < 0)
+		dirfd = open(tc->dirname, O_APPEND);
+
+	TST_EXP_FAIL(unlinkat(dirfd, tc->filename, tc->flags),
+		tc->expected_errno,
+		"%s", tc->desc);
+}
+
+static void verify_unlinkat(unsigned int i)
+{
+	struct test_case_t *tc = &tcases[i];
+	pid_t pid;
+
+	if (tc->user) {
+		pid = SAFE_FORK();
+		if (!pid) {
+			SAFE_SETUID(pw->pw_uid);
+			do_unlinkat(tc);
+			exit(0);
+		}
+		SAFE_WAITPID(pid, NULL, 0);
+	} else {
+		do_unlinkat(tc);
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.cleanup = cleanup,
+	.test = verify_unlinkat,
+	.needs_rofs = 1,
+	.mntpoint = DIR_EROFS,
+	.needs_root = 1,
+	.forks_child = 1,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
