Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B857C4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 13:56:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C92093CBE51
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 14:56:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E2AAC3CBE3E
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 14:55:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 501751400432
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 14:55:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6F9661FEA4;
 Mon, 12 Dec 2022 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1670853341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c0ibjmzRSTH+myH5486RV4lXxyu1vYUDDSj4+2UDYMY=;
 b=Fpkni+wuvC3LcQyY6G+Cm8pDRi13hLv/v++3BXzuJLzJxx5umLSzU5GDx8MHHNFQgB/7I+
 CIdgQT6BXD0XgBW9uUFo9A5+qI45hBNnf7UyMERYQeHqvWOvr9V4sy762LwHRoJK0wh08e
 9/ze7HGxpjDxIjyjUkmZGVxDsJkHKK0=
Received: from g78.cable.virginm.net (unknown [10.163.28.198])
 by relay2.suse.de (Postfix) with ESMTP id 459E12C142;
 Mon, 12 Dec 2022 13:55:41 +0000 (UTC)
To: ltp@lists.linux.it
Date: Mon, 12 Dec 2022 13:55:24 +0000
Message-Id: <20221212135524.1333-3-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212135524.1333-1-rpalethorpe@suse.com>
References: <20221212135524.1333-1-rpalethorpe@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] tst_fill_fs: Add alternate access pattern
 "flat"
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

Depending on the workload, the way in which a file system is filled
will be different. The system calls will also be different.

This adds a fill mode which uses writev with uniform batches of
data. This simulates when the FS is filled by a program which batches
writes.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_fs.h                              |  7 ++-
 lib/tst_fill_fs.c                             | 59 ++++++++++++++++++-
 testcases/kernel/fs/fs_fill/fs_fill.c         | 18 ++++--
 .../kernel/syscalls/fallocate/fallocate05.c   |  2 +-
 .../kernel/syscalls/fallocate/fallocate06.c   |  2 +-
 5 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index cc6d9b547..43ead32a2 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -34,6 +34,11 @@
 #define TST_VFAT_MAGIC     0x4d44 /* AKA MSDOS */
 #define TST_EXFAT_MAGIC    0x2011BAB0UL
 
+enum tst_fill_access_pattern {
+	TST_FILL_FLAT_VEC,
+	TST_FILL_RANDOM
+};
+
 enum {
 	TST_BYTES = 1,
 	TST_KB = 1024,
@@ -201,7 +206,7 @@ int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist);
 /*
  * Creates and writes to files on given path until write fails with ENOSPC
  */
-void tst_fill_fs(const char *path, int verbose);
+void tst_fill_fs(const char *path, int verbose, enum tst_fill_access_pattern pattern);
 
 /*
  * test if FIBMAP ioctl is supported
diff --git a/lib/tst_fill_fs.c b/lib/tst_fill_fs.c
index 1d6d76abd..e7d5d73b7 100644
--- a/lib/tst_fill_fs.c
+++ b/lib/tst_fill_fs.c
@@ -7,13 +7,16 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/statvfs.h>
+#include <sys/uio.h>
 
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
+#include "lapi/fcntl.h"
 #include "tst_fs.h"
 #include "tst_rand_data.h"
+#include "tst_safe_file_at.h"
 
-void tst_fill_fs(const char *path, int verbose)
+void fill_random(const char *path, int verbose)
 {
 	int i = 0;
 	char file[PATH_MAX];
@@ -67,3 +70,57 @@ void tst_fill_fs(const char *path, int verbose)
 		SAFE_CLOSE(fd);
 	}
 }
+
+void fill_flat_vec(const char *path, int verbose)
+{
+	int dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY | O_FSYNC);
+	int fd = SAFE_OPENAT(dir, "AOF", O_WRONLY | O_CREAT, 0600);
+	struct iovec iov[512];
+	int iovcnt = ARRAY_SIZE(iov);
+	int retries = 3;
+
+	SAFE_CLOSE(dir);
+
+	for (int i = 0; i < iovcnt; i++) {
+		iov[i] = (struct iovec) {
+			(void *)tst_rand_data,
+			tst_rand_data_len
+		};
+	}
+
+	while (retries) {
+		const int ret = writev(fd, iov, iovcnt);
+
+		if (!ret)
+			tst_res(TWARN | TERRNO, "writev returned 0; not sure what this means");
+
+		if (ret > -1) {
+			if (verbose && retries < 3)
+				tst_res(TINFO, "writev(\"%s/AOF\", iov, %d) = %d", path, iovcnt, ret);
+
+			retries = 3;
+			continue;
+		}
+
+		if (errno != ENOSPC)
+			tst_brk(TBROK | TERRNO, "writev(\"%s/AOF\", iov, %d)", path, iovcnt);
+
+		if (verbose)
+			tst_res(TINFO, "writev(\"%s/AOF\", iov, %d): ENOSPC", path, iovcnt);
+
+		retries--;
+	}
+
+	SAFE_CLOSE(fd);
+}
+
+void tst_fill_fs(const char *path, int verbose, enum tst_fill_access_pattern pattern)
+{
+
+	switch (pattern) {
+	case TST_FILL_FLAT_VEC:
+		return fill_flat_vec(path, verbose);
+	case TST_FILL_RANDOM:
+		return fill_random(path, verbose);
+	}
+}
diff --git a/testcases/kernel/fs/fs_fill/fs_fill.c b/testcases/kernel/fs/fs_fill/fs_fill.c
index 95dfc2cb6..2027b6df1 100644
--- a/testcases/kernel/fs/fs_fill/fs_fill.c
+++ b/testcases/kernel/fs/fs_fill/fs_fill.c
@@ -25,6 +25,7 @@ static int enospc_cnt;
 static struct worker *workers;
 
 struct worker {
+	enum tst_fill_access_pattern pattern;
 	char dir[PATH_MAX];
 };
 
@@ -36,7 +37,7 @@ static void *worker(void *p)
 	char file[PATH_MAX];
 
 	while (run) {
-		tst_fill_fs(w->dir, 0);
+		tst_fill_fs(w->dir, 1, w->pattern);
 
 		tst_atomic_inc(&enospc_cnt);
 
@@ -61,22 +62,26 @@ static void *worker(void *p)
 	return NULL;
 }
 
-static void testrun(void)
+static void testrun(unsigned int n)
 {
 	pthread_t threads[nthreads];
 	unsigned int i, ms;
 
+	tst_atomic_store(0, &enospc_cnt);
+
 	run = 1;
-	for (i = 0; i < nthreads; i++)
+	for (i = 0; i < nthreads; i++) {
+		workers[i].pattern = n;
 		SAFE_PTHREAD_CREATE(&threads[i], NULL, worker, &workers[i]);
+	}
 
 	for (ms = 0; ; ms++) {
 		usleep(1000);
 
-		if (ms >= 1000 && enospc_cnt)
+		if (ms >= 1000 && tst_atomic_load(&enospc_cnt))
 			break;
 
-		if (enospc_cnt > 100)
+		if (tst_atomic_load(&enospc_cnt) > 100)
 			break;
 	}
 
@@ -116,5 +121,6 @@ static struct tst_test test = {
 	.all_filesystems = 1,
 	.setup = setup,
 	.cleanup = cleanup,
-	.test_all = testrun,
+	.test = testrun,
+	.tcnt = 2
 };
diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index d67c6cf5b..af6bf9e8c 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -68,7 +68,7 @@ static void run(void)
 		tst_brk(TBROK | TTERRNO, "fallocate(fd, 0, 0, %ld)", bufsize);
 	}
 
-	tst_fill_fs(MNTPOINT, 1);
+	tst_fill_fs(MNTPOINT, 1, TST_FILL_RANDOM);
 
 	TEST(write(fd, buf, bufsize));
 
diff --git a/testcases/kernel/syscalls/fallocate/fallocate06.c b/testcases/kernel/syscalls/fallocate/fallocate06.c
index 16f9db066..124fb7eae 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate06.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate06.c
@@ -202,7 +202,7 @@ static void run(unsigned int n)
 	}
 
 	if (tc->fill_fs)
-		tst_fill_fs(MNTPOINT, 1);
+		tst_fill_fs(MNTPOINT, 1, TST_FILL_RANDOM);
 
 	SAFE_LSEEK(fd, offset, SEEK_SET);
 	TEST(write(fd, wbuf, size));
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
