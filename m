Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647ED606A31B
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RU311p1B
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91C683CDEBF
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 11:47:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08FBF3CDC7B
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 11:46:54 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7C6111000524
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 11:46:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Qe
 l5v9YY9LEeYDEoTkR97L2SA0YjRUx7IHI7xuRAtjI=; b=RU311p1B6ZKR1S7+5j
 RA1fUrqG84gjBjWOoWlHP0J9LJmzw76A6CcPdA2z1J1VuqwvgS2qVtQlTL377lmb
 DSYXgdrbZkSSGRfv7BK1YvpplO4OVN3t6fMSdv/aMQCbmMgWPAA4DH1pkxNZgiZx
 D3p77BfGg+On+8qr+Hsi11qyA=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wDnT7x8Xuxq+JoGFw--.42697S2; 
 Thu, 05 Nov 2026 18:46:22 +0800 (CST)
From: Xuewen Wang <wangxuewen_ky@163.com>
To: ltp@lists.linux.it
Date: Thu,  5 Nov 2026 18:46:17 +0800
Message-Id: <20261105104617.996224-1-wangxuewen_ky@163.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: _____wDnT7x8Xuxq+JoGFw--.42697S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF4fJr13uFW8ur4ruFW7Jwb_yoW7CrW7pF
 93Cr1Utr4kXF1xCan3JFyDtr4rCryDG3W8Jw409w45Z3Z8AF15tr4SgFyfAr1UJrW0kay7
 Ca1fJr9rJrZrZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jZ0eQUUUUU=
X-CM-SenderInfo: pzdqw5pxhzv0xbn1qiywtou0bp/xtbC8B+MdWrsXn+ooQAA34
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/cachestat05: Add test for permission checks
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

Verify that cachestat() is only allowed on file descriptors with write
access to the underlying file, as required by the permission check added
in 5f537664e705 ("cachestat: fix page cache statistics permission
checking") to prevent page cache residency information leaks.

A child process with dropped privileges opens test files as write
accessor, owner, writer and reader, and the cachestat() call either
succeeds or fails with EPERM. The EPERM case requires v6.14 or newer
and skips gracefully on older kernels.

Tested on 6.6.160 (3 TPASS + 1 TCONF) and 7.3.0-rc5, x86_64: 4/4 TPASS.

Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/cachestat/.gitignore      |   1 +
 .../kernel/syscalls/cachestat/cachestat05.c   | 134 ++++++++++++++++++
 3 files changed, 136 insertions(+)
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
index 000000000..69776991c
--- /dev/null
+++ b/testcases/kernel/syscalls/cachestat/cachestat05.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Xuewen Wang <wangxuewen@kylinos.cn>
+ */
+
+/*\
+ * Verify that cachestat() is only allowed on file descriptors with write
+ * access to the underlying file.
+ *
+ * This is a test for the permission check implemented in
+ * 5f537664e705 ("cachestat: fix page cache statistics permission checking")
+ *
+ * Before the fix, cachestat() could be used to query page cache statistics
+ * of arbitrary readable files, which leaks information about the file access
+ * patterns of other users. Since v6.14 the call fails with EPERM unless the
+ * calling process is allowed to write to the file, that is unless one of
+ * these applies:
+ *
+ * - the file descriptor was open for writing
+ * - the caller owns the file
+ * - the caller has write permission to the file
+ *
+ * [Algorithm]
+ *
+ * - fork a child which drops all privileges to an unassigned uid and gid
+ * - the child opens a test file with the open flags of the test case
+ * - the child calls cachestat() on the file descriptor
+ * - the call either succeeds, or fails with EPERM if the file is neither
+ *   owned nor writable by the child
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
+	int needs_fix;
+	const char *desc;
+} tcases[] = {
+	{FILE_RDWR, O_RDWR, 0, 0, "descriptor open for writing"},
+	{FILE_OWNED, O_RDONLY, 0, 0, "file owned by the caller"},
+	{FILE_RDWR, O_RDONLY, 0, 0, "file writable by the caller"},
+	{FILE_RDONLY, O_RDONLY, EPERM, 1, "file read-only for the caller"},
+};
+
+static void verify_cachestat(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	int fd;
+
+	if (tc->needs_fix && tst_kvercmp(6, 14, 0) < 0) {
+		tst_res(TCONF, "cachestat() permission check added in v6.14");
+		return;
+	}
+
+	if (SAFE_FORK())
+		return;
+
+	SAFE_SETGROUPS(0, NULL);
+	SAFE_SETGID(gid);
+	SAFE_SETUID(uid);
+
+	fd = SAFE_OPEN(tc->file, tc->open_flags);
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
+	fd = SAFE_OPEN(FILE_OWNED, O_CREAT | O_RDWR, 0600);
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
