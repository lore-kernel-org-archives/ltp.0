Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE43606A328
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=iS8Efj/B
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 255C43CFDC4
	for <ltp@archiver.kernel.org>; Fri,  6 Nov 2026 04:30:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15A0F3CEF42
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 04:30:23 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 92F67200245
 for <ltp@lists.linux.it>; Fri,  6 Nov 2026 04:30:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Hl
 a0k2N+Th9YljmoIVRpCM8qVKTMuO5ap1qmfxrNnng=; b=iS8Efj/B2ugHxDifVY
 6G+kg2kenQVzbd0Tr7YDMzZ80D8Md+HPxnp1D7L4hpWe0LUR1MbGUab2EGfH1S/p
 u1+b+5LzF10Wfbh01jbR5aATsjFJKElax+/4UxGg0R61IkjCvtmgsJZcQT2k6UQo
 Y4SAzcvEVZQnBIblX8twDy40o=
Received: from localhost.localdomain (unknown [])
 by gzsmtp2 (Coremail) with SMTP id PSgvCgC3AAimSe1q+NUKEA--.40898S2;
 Fri, 06 Nov 2026 11:29:50 +0800 (CST)
From: Xuewen Wang <wangxuewen_ky@163.com>
To: ltp@lists.linux.it
Date: Fri,  6 Nov 2026 11:29:29 +0800
Message-Id: <20261106032929.63222-1-wangxuewen_ky@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: PSgvCgC3AAimSe1q+NUKEA--.40898S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFyxZr1xAry8CrWUtry3XFb_yoWxArW8pF
 Z3C3WUtr4kXF1xCan7JFy8Ar1rCrn7GF18Jw10gw1Yv3Z8Ar10qr4IgFyruryUJrW8tay2
 ka1fJr9xJrWDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jZhLnUUUUU=
X-CM-SenderInfo: pzdqw5pxhzv0xbn1qiywtou0bp/xtbC7w+TfGrtSa+qaQAA3t
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/cachestat05: Add test for permission
 checks
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Xuewen Wang <wangxuewen@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Xuewen Wang <wangxuewen@kylinos.cn>

Verify that cachestat() only reveals page cache statistics for files the
calling process has write access to, owns, or has open for writing, as
required by the permission check added in 5f537664e705 ("cachestat: fix
page cache statistics permission checking") to prevent page cache
residency information leaks.

A child process opens the test files as write accessor, owner, writer
and reader, drops privileges and calls cachestat(), which either
succeeds or fails with EPERM. The write-accessor descriptor is opened
on a read-only file before the privileges are dropped and the owned
file is read-only for its owner, so that each of the three permission
conditions is tested in isolation. Kernels without the fix fail the
read-only case and the test prints the missing fix hint.

Tested on 6.6.160 (with the fix backported) and 7.3.0-rc5, x86_64:
4/4 TPASS.

Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>
---
Changes in v2 (addressing the AI review):

- Use :manpage:`cachestat(2)` for the syscall references in the doc
  comment
- Remove the kernel version check and tc->needs_fix: kernels without
  the fix fail the read-only case and the .tags linux-git hint points
  to the fix commit
- Open the test file before dropping privileges and use the read-only
  file with O_RDWR for the write-accessor case, so that the
  FMODE_WRITE condition is not confounded with the file write
  permission
- Create the owned file with mode 0400 so that the ownership condition
  is not confounded with the owner write permission
- Reword the summary to cover all three permission conditions: files
  the caller has write access to, owns, or has open for writing

 runtest/syscalls                              |   1 +
 .../kernel/syscalls/cachestat/.gitignore      |   1 +
 .../kernel/syscalls/cachestat/cachestat05.c   | 133 ++++++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 testcases/kernel/syscalls/cachestat/cachestat05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index ff3de1b15..3bd2c98d8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -66,6 +66,7 @@ cachestat01 cachestat01
 cachestat02 cachestat02
 cachestat03 cachestat03
 cachestat04 cachestat04
+cachestat05 cachestat05
 
 chdir01 chdir01
 chdir02 chdir02
diff --git a/testcases/kernel/syscalls/cachestat/.gitignore b/testcases/kernel/syscalls/cachestat/.gitignore
index a3611a533..76e0d90a8 100644
--- a/testcases/kernel/syscalls/cachestat/.gitignore
+++ b/testcases/kernel/syscalls/cachestat/.gitignore
@@ -2,3 +2,4 @@ cachestat01
 cachestat02
 cachestat03
 cachestat04
+/cachestat05
diff --git a/testcases/kernel/syscalls/cachestat/cachestat05.c b/testcases/kernel/syscalls/cachestat/cachestat05.c
new file mode 100644
index 000000000..c3b5ffcc0
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/cachestat05.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Xuewen Wang <wangxuewen@kylinos.cn>
+ */
+
+/*\
+ * Verify that :manpage:`cachestat(2)` only reveals page cache statistics for
+ * files the calling process has write access to, owns, or has open for
+ * writing.
+ *
+ * This is a test for the permission check implemented in
+ * 5f537664e705 ("cachestat: fix page cache statistics permission checking")
+ *
+ * Before the fix, :manpage:`cachestat(2)` could be used to query page cache
+ * statistics of arbitrary readable files, which leaks information about the
+ * file access patterns of other users. Since v6.14 the call fails with EPERM
+ * unless one of these applies:
+ *
+ * - the file descriptor was open for writing
+ * - the caller owns the file
+ * - the caller has write permission to the file
+ *
+ * The descriptor for the write-access case is opened while the child is
+ * still root, so that it refers to a file the unprivileged caller could
+ * not open for writing.
+ *
+ * [Algorithm]
+ *
+ * - fork a child which opens a test file with the open flags of the test
+ *   case, then drops all privileges to an unassigned uid and gid
+ * - the child calls :manpage:`cachestat(2)` on the file descriptor
+ * - the call either succeeds, or fails with EPERM if the descriptor is not
+ *   open for writing and the child neither owns the file nor has write
+ *   permission to it
+ */
+
+#include <stdlib.h>
+#include <fcntl.h>
+#include <sys/stat.h>
+#include "tst_test.h"
+#include "tst_uid.h"
+#include "cachestat.h"
+
+#define FILE_RDWR   "cachestat05_rw"
+#define FILE_OWNED  "cachestat05_owned"
+#define FILE_RDONLY "cachestat05_ro"
+
+static uid_t uid;
+static gid_t gid;
+static struct cachestat *cs;
+static struct cachestat_range *cs_range;
+
+static struct tcase {
+	const char *file;
+	int open_flags;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{FILE_RDONLY, O_RDWR, 0, "descriptor open for writing"},
+	{FILE_OWNED, O_RDONLY, 0, "file owned by the caller"},
+	{FILE_RDWR, O_RDONLY, 0, "file writable by the caller"},
+	{FILE_RDONLY, O_RDONLY, EPERM, "file read-only for the caller"},
+};
+
+static void verify_cachestat(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int fd;
+
+	if (SAFE_FORK())
+		return;
+
+	fd = SAFE_OPEN(tc->file, tc->open_flags);
+
+	SAFE_SETGROUPS(0, NULL);
+	SAFE_SETGID(gid);
+	SAFE_SETUID(uid);
+
+	if (tc->exp_errno) {
+		TST_EXP_FAIL(cachestat(fd, cs_range, cs, 0), tc->exp_errno,
+			     "%s", tc->desc);
+	} else {
+		TST_EXP_PASS(cachestat(fd, cs_range, cs, 0), "%s", tc->desc);
+		print_cachestat(cs);
+	}
+
+	SAFE_CLOSE(fd);
+}
+
+static void setup(void)
+{
+	int fd;
+
+	uid = tst_get_free_uid(0);
+	gid = tst_get_free_gid(0);
+
+	umask(0);
+
+	/* len == 0 queries the whole file */
+	cs_range->off = 0;
+	cs_range->len = 0;
+
+	if (cachestat(-1, cs_range, cs, 0) != -1)
+		tst_brk(TBROK, "cachestat(-1) unexpectedly succeeded");
+
+	fd = SAFE_OPEN(FILE_RDWR, O_CREAT | O_RDWR, 0666);
+	SAFE_CLOSE(fd);
+
+	fd = SAFE_OPEN(FILE_OWNED, O_CREAT | O_RDWR, 0400);
+	SAFE_CLOSE(fd);
+	SAFE_CHOWN(FILE_OWNED, uid, -1);
+
+	fd = SAFE_OPEN(FILE_RDONLY, O_CREAT | O_RDONLY, 0444);
+	SAFE_CLOSE(fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = verify_cachestat,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&cs, .size = sizeof(struct cachestat)},
+		{&cs_range, .size = sizeof(struct cachestat_range)},
+		{}
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "5f537664e705"},
+		{}
+	},
+};
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
