Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDE2C2BD09
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 13:41:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0025E3D19A7
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 15:41:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E70173CBA12
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 15:41:37 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5B9D5100112D
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 15:41:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A80A1FB8B
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 13:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720791695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Us3tHO18VK4mF8foUsrb77s2wSR5VdSs9JaBt68uD6k=;
 b=F8eqMw5jCvIe0nEf6+hpq171rM4ySLQpGlehJ96EOt03FESbgfOo0+r3XGODa21q0WdSdS
 93oxRwa26GKTtpEWb9hgUuHn+Wb8lb401+UsOAs2V+TXXVLKqF6sbXM5KQmAQX4tRAfchA
 eno/RsF2CBNYsPoV8Q/b0J0jImlOFs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720791695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Us3tHO18VK4mF8foUsrb77s2wSR5VdSs9JaBt68uD6k=;
 b=XT366k4/x45/E5N2fXcq0B8IQbvv0u+fGmcSDfmFJZVXcurT24NHyBhCUgkzu1hMkTDvNp
 9lfDXa9fxSVGvVDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=F8eqMw5j;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="XT366k4/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720791695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Us3tHO18VK4mF8foUsrb77s2wSR5VdSs9JaBt68uD6k=;
 b=F8eqMw5jCvIe0nEf6+hpq171rM4ySLQpGlehJ96EOt03FESbgfOo0+r3XGODa21q0WdSdS
 93oxRwa26GKTtpEWb9hgUuHn+Wb8lb401+UsOAs2V+TXXVLKqF6sbXM5KQmAQX4tRAfchA
 eno/RsF2CBNYsPoV8Q/b0J0jImlOFs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720791695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Us3tHO18VK4mF8foUsrb77s2wSR5VdSs9JaBt68uD6k=;
 b=XT366k4/x45/E5N2fXcq0B8IQbvv0u+fGmcSDfmFJZVXcurT24NHyBhCUgkzu1hMkTDvNp
 9lfDXa9fxSVGvVDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA5F213686
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 13:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +gS9K44ykWajagAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 13:41:34 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 12 Jul 2024 15:44:11 +0200
Message-ID: <20240712134412.30853-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5A80A1FB8B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_NONE(0.00)[]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add tst_tmpdir_path() and tst_tmpdir_mkpath()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

- tst_tmpdir_path() creates a singleton string copy of the library
  internal path and returns pointer to it on all subsequent calls.

- tst_tmpdir_mkpath() constructs a path from the temporary directory
  path and printf-like format paramters.

- both functions use guarded buffers to allocate the memory, which
  especially means that there is no reason to free these strings at
  the program end.

- all new library tests are converted to the new API

+ macro is added for new library that fails compilation if old API
  function is used

This should solve the absolute temporary directory path handling once
for all.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h                            |  5 ---
 include/tst_tmpdir.h                          | 37 ++++++++++++++++++-
 lib/newlib_tests/tst_device.c                 |  5 +--
 lib/tst_tmpdir.c                              | 37 +++++++++++++++++++
 .../kernel/mem/hugetlb/hugemmap/hugemmap01.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap02.c  |  2 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap04.c  |  2 +-
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |  1 -
 testcases/kernel/syscalls/chroot/chroot01.c   |  8 +---
 testcases/kernel/syscalls/chroot/chroot02.c   |  8 +---
 testcases/kernel/syscalls/creat/creat08.c     |  6 +--
 .../kernel/syscalls/faccessat/faccessat01.c   |  5 +--
 .../kernel/syscalls/faccessat2/faccessat201.c |  5 +--
 .../kernel/syscalls/fchmodat/fchmodat01.c     |  5 +--
 .../kernel/syscalls/io_uring/io_uring02.c     |  3 +-
 .../kernel/syscalls/ioctl/ioctl_loop01.c      |  5 ++-
 .../kernel/syscalls/ioctl/ioctl_loop02.c      | 11 +++---
 .../kernel/syscalls/ioctl/ioctl_loop05.c      |  5 ++-
 testcases/kernel/syscalls/mkdir/mkdir03.c     |  4 +-
 testcases/kernel/syscalls/mount/mount06.c     | 19 +++++-----
 testcases/kernel/syscalls/mount/mount07.c     | 18 +++------
 testcases/kernel/syscalls/open/open10.c       |  6 +--
 .../kernel/syscalls/pathconf/pathconf01.c     |  8 +---
 .../kernel/syscalls/pathconf/pathconf02.c     |  7 +---
 .../kernel/syscalls/readlinkat/readlinkat01.c |  5 +--
 testcases/kernel/syscalls/rename/rename09.c   | 10 +----
 testcases/kernel/syscalls/stat/stat04.c       | 13 +------
 testcases/kernel/syscalls/statx/statx07.c     |  7 +---
 testcases/kernel/syscalls/utime/utime07.c     |  2 +-
 29 files changed, 122 insertions(+), 129 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index a5fd9a00e..517c8d032 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -629,11 +629,6 @@ void tst_set_max_runtime(int max_runtime);
  */
 int tst_creat_unlinked(const char *path, int flags);
 
-/*
- * Returns path to the test temporary directory in a newly allocated buffer.
- */
-char *tst_get_tmpdir(void);
-
 /*
  * Returns path to the test temporary directory root (TMPDIR).
  */
diff --git a/include/tst_tmpdir.h b/include/tst_tmpdir.h
index e6c5d962c..c0a0ad31f 100644
--- a/include/tst_tmpdir.h
+++ b/include/tst_tmpdir.h
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2017-2024 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2020 Martin Doucha <mdoucha@suse.cz>
  */
 
@@ -16,4 +16,39 @@
  */
 void tst_purge_dir(const char *path);
 
+/**
+ * tst_tmpdir_path - Returns a pointer to a tmpdir path.
+ *
+ * The returned path is allocated and initialized the first time this function is
+ * called, each subsequent call will return the same pointer.
+ *
+ * @return A newly allocated path. The memory is freed automatically at the end
+ *         of the test. If allocation fails the function calls tst_brk() and
+ *         exits the test.
+ */
+char *tst_tmpdir_path(void);
+
+/**
+ * tst_tmpdir_mkpath - Construct an absolute path pointing to a file inside tmpdir.
+ *
+ * Constructs a path inside tmpdir i.e. adds a prefix pointing to the current
+ * test tmpdir to the string build by the printf-like format.
+ *
+ * @fmt A printf-like format string.
+ * @... A printf-like parameter list.
+ *
+ * @return A newly allocated path. The memory is freed automatically at the end
+ *         of the test. If allocation fails the function calls tst_brk() and
+ *         exits the test.
+ */
+char *tst_tmpdir_mkpath(const char *fmt, ...)
+	__attribute__((format(printf, 1, 2)));
+
+/*
+ * Make sure nobody uses old API functions in new code.
+ */
+#ifndef LTPLIB
+# define tst_get_tmpdir #error Use tst_tmpdir_path()!
+#endif
+
 #endif /* TST_TMPDIR_H__ */
diff --git a/lib/newlib_tests/tst_device.c b/lib/newlib_tests/tst_device.c
index 53099f9bc..ef69728f4 100644
--- a/lib/newlib_tests/tst_device.c
+++ b/lib/newlib_tests/tst_device.c
@@ -28,11 +28,8 @@ static int set_block_size(int fd)
 static void setup(void)
 {
 	int fd;
-	int ret;
 
-	ret = asprintf(&mntpoint, "%s/mnt", tst_get_tmpdir());
-	if (ret < 0)
-		tst_brk(TBROK, "asprintf failure");
+	mntpoint = tst_tmpdir_mkpath("mnt");
 
 	fd = SAFE_OPEN(tst_device->dev, O_RDONLY);
 
diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 0f1b15ca4..1fb1bd698 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -71,6 +71,7 @@
 #include <fcntl.h>
 
 #include "test.h"
+#include "tst_buffers.h"
 #include "safe_macros.h"
 #include "tst_tmpdir.h"
 #include "ltp_priv.h"
@@ -352,3 +353,39 @@ void tst_purge_dir(const char *path)
 	if (purge_dir(path, &err))
 		tst_brkm(TBROK, NULL, "%s: %s", __func__, err);
 }
+
+char *tst_tmpdir_path(void)
+{
+	static char *tmpdir;
+
+	if (tmpdir)
+		return tmpdir;
+
+	tmpdir = tst_strdup(TESTDIR);
+
+	return tmpdir;
+}
+
+char *tst_tmpdir_mkpath(const char *fmt, ...)
+{
+	size_t testdir_len = strlen(TESTDIR);
+	size_t path_len = testdir_len;
+	va_list va, vac;
+	char *ret;
+
+	va_start(va, fmt);
+	va_copy(vac, va);
+	path_len += vsnprintf(NULL, 0, fmt, va) + 2;
+	va_end(va);
+
+	ret = tst_alloc(path_len);
+
+	strcpy(ret, TESTDIR);
+
+	ret[testdir_len] = '/';
+
+	vsprintf(ret + testdir_len + 1, fmt, vac);
+	va_end(vac);
+
+	return ret;
+}
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
index 3fc730002..de5133381 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap01.c
@@ -75,7 +75,7 @@ void setup(void)
 		tst_brk(TCONF, "Not enough hugepages for testing.");
 
 	if (!Hopt)
-		Hopt = tst_get_tmpdir();
+		Hopt = tst_tmpdir_path();
 	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
index e818cd5a3..b788aeafb 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap02.c
@@ -122,7 +122,7 @@ static void setup(void)
 		tst_brk(TCONF, "Not enough hugepages for testing.");
 
 	if (!Hopt)
-		Hopt = tst_get_tmpdir();
+		Hopt = tst_tmpdir_path();
 	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 6af032aa5..f52747e68 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -93,7 +93,7 @@ void setup(void)
 		tst_brk(TCONF, "Not enough hugepages for testing!");
 
 	if (!Hopt)
-		Hopt = tst_get_tmpdir();
+		Hopt = tst_tmpdir_path();
 	SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
 
 	snprintf(TEMPFILE, sizeof(TEMPFILE), "%s/mmapfile%d", Hopt, getpid());
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index 34fe08c24..a694514d2 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -17,7 +17,6 @@
 #include <errno.h>
 #include <sys/wait.h>
 #include "tst_test.h"
-#include "old_tmpdir.h"
 #include "mem.h"
 
 #define PALIGN(p, a) ((void *)LTP_ALIGN((unsigned long)(p), (a)))
diff --git a/testcases/kernel/syscalls/chroot/chroot01.c b/testcases/kernel/syscalls/chroot/chroot01.c
index febf064db..60f3f609c 100644
--- a/testcases/kernel/syscalls/chroot/chroot01.c
+++ b/testcases/kernel/syscalls/chroot/chroot01.c
@@ -27,18 +27,12 @@ static void setup(void)
 {
 	struct passwd *ltpuser;
 
-	path = tst_get_tmpdir();
+	path = tst_tmpdir_path();
 	ltpuser = SAFE_GETPWNAM("nobody");
 	SAFE_SETEUID(ltpuser->pw_uid);
 }
 
-static void cleanup(void)
-{
-	free(path);
-}
-
 static struct tst_test test = {
-	.cleanup = cleanup,
 	.setup = setup,
 	.test_all = verify_chroot,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/chroot/chroot02.c b/testcases/kernel/syscalls/chroot/chroot02.c
index ad33abdcc..b01a87660 100644
--- a/testcases/kernel/syscalls/chroot/chroot02.c
+++ b/testcases/kernel/syscalls/chroot/chroot02.c
@@ -37,17 +37,11 @@ static void verify_chroot(void)
 
 static void setup(void)
 {
-	path = tst_get_tmpdir();
+	path = tst_tmpdir_path();
 	SAFE_TOUCH(TMP_FILENAME, 0666, NULL);
 }
 
-static void cleanup(void)
-{
-	free(path);
-}
-
 static struct tst_test test = {
-	.cleanup = cleanup,
 	.setup = setup,
 	.test_all = verify_chroot,
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/creat/creat08.c b/testcases/kernel/syscalls/creat/creat08.c
index 91581dbf8..011753ac5 100644
--- a/testcases/kernel/syscalls/creat/creat08.c
+++ b/testcases/kernel/syscalls/creat/creat08.c
@@ -29,7 +29,6 @@
 #define NOSETGID_B	DIR_B "/nosetgid"
 #define ROOT_SETGID	DIR_B "/root_setgid"
 
-static char *tmpdir;
 static uid_t orig_uid, nobody_uid;
 static gid_t nobody_gid, free_gid;
 static int fd = -1;
@@ -44,7 +43,6 @@ static void setup(void)
 	tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)nobody_uid,
 		(int)nobody_gid);
 	free_gid = tst_get_free_gid(nobody_gid);
-	tmpdir = tst_get_tmpdir();
 }
 
 static void file_test(const char *name, mode_t mode, int sgid, gid_t gid)
@@ -125,15 +123,13 @@ static void run(void)
 	file_test(ROOT_SETGID, MODE_SGID, 1, free_gid);
 
 	/* Cleanup between loops */
-	tst_purge_dir(tmpdir);
+	tst_purge_dir(tst_tmpdir_path());
 }
 
 static void cleanup(void)
 {
 	if (fd >= 0)
 		SAFE_CLOSE(fd);
-
-	free(tmpdir);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/faccessat/faccessat01.c b/testcases/kernel/syscalls/faccessat/faccessat01.c
index 557d7eb4c..d429cdd14 100644
--- a/testcases/kernel/syscalls/faccessat/faccessat01.c
+++ b/testcases/kernel/syscalls/faccessat/faccessat01.c
@@ -55,10 +55,7 @@ static void verify_faccessat(unsigned int i)
 
 static void setup(void)
 {
-	char *tmpdir_path = tst_get_tmpdir();
-
-	abs_path = tst_aprintf("%s/%s", tmpdir_path, FILEPATH);
-	free(tmpdir_path);
+	abs_path = tst_tmpdir_mkpath(FILEPATH);
 
 	SAFE_MKDIR(TESTDIR, 0700);
 	dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
diff --git a/testcases/kernel/syscalls/faccessat2/faccessat201.c b/testcases/kernel/syscalls/faccessat2/faccessat201.c
index 012091752..bbe441b51 100644
--- a/testcases/kernel/syscalls/faccessat2/faccessat201.c
+++ b/testcases/kernel/syscalls/faccessat2/faccessat201.c
@@ -56,10 +56,7 @@ static void verify_faccessat2(unsigned int i)
 
 static void setup(void)
 {
-	char *tmpdir_path = tst_get_tmpdir();
-
-	abs_path = tst_aprintf("%s/%s", tmpdir_path, RELPATH);
-	free(tmpdir_path);
+	abs_path = tst_tmpdir_mkpath(RELPATH);
 
 	SAFE_MKDIR(TESTDIR, 0777);
 	dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index bf3812738..97ba31763 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -60,10 +60,7 @@ static void verify_fchmodat(unsigned int i)
 
 static void setup(void)
 {
-	char *tmpdir_path = tst_get_tmpdir();
-
-	abs_path = tst_aprintf("%s/%s", tmpdir_path, FILEPATH);
-	free(tmpdir_path);
+	abs_path = tst_tmpdir_mkpath(FILEPATH);
 
 	SAFE_MKDIR(TESTDIR, 0700);
 	dir_fd = SAFE_OPEN(TESTDIR, O_DIRECTORY);
diff --git a/testcases/kernel/syscalls/io_uring/io_uring02.c b/testcases/kernel/syscalls/io_uring/io_uring02.c
index c9d4bbcb1..50206cf1f 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring02.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring02.c
@@ -64,13 +64,12 @@ static struct msghdr beef_header = {
 
 static void setup(void)
 {
-	char *tmpdir = tst_get_tmpdir();
+	char *tmpdir = tst_tmpdir_path();
 	int ret;
 
 	addr.sun_family = AF_UNIX;
 	ret = snprintf(addr.sun_path, sizeof(addr.sun_path), "%s/%s", tmpdir,
 		SOCK_NAME);
-	free(tmpdir);
 
 	if (ret >= (int)sizeof(addr.sun_path))
 		tst_brk(TBROK, "Tempdir path is too long");
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index 734d803d5..a4d191a2e 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -27,7 +27,8 @@
 #include "lapi/loop.h"
 #include "tst_test.h"
 
-static char dev_path[1024], backing_path[1024], backing_file_path[1024];
+static char dev_path[1024], backing_path[1024];
+static char *backing_file_path;
 static int dev_num, attach_flag, dev_fd, parted_sup;
 
 /*
@@ -124,7 +125,7 @@ static void setup(void)
 	sprintf(autoclear_path, "/sys/block/loop%d/loop/autoclear", dev_num);
 	sprintf(backing_path, "/sys/block/loop%d/loop/backing_file", dev_num);
 	sprintf(sys_loop_partpath, "/sys/block/loop%d/loop%dp1", dev_num, dev_num);
-	sprintf(backing_file_path, "%s/test.img", tst_get_tmpdir());
+	backing_file_path = tst_tmpdir_mkpath("test.img");
 	sprintf(loop_partpath, "%sp1", dev_path);
 	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
 }
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
index 12d4e8230..380fd1006 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
@@ -27,7 +27,9 @@
 #include "tst_test.h"
 
 static int file_fd, file_change_fd, file_fd_invalid;
-static char backing_path[1024], backing_file_path[1024], backing_file_change_path[1024];
+static char backing_path[1024];
+static char *backing_file_path;
+static char *backing_file_change_path;
 static int attach_flag, dev_fd, loop_configure_sup = 1;
 static char loop_ro_path[1024], dev_path[1024];
 static struct loop_config loopconfig;
@@ -109,7 +111,6 @@ static void setup(void)
 	int dev_num;
 	int ret;
 
-	char *tmpdir = tst_get_tmpdir();
 	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
 	if (dev_num < 0)
 		tst_brk(TBROK, "Failed to find free loop device");
@@ -119,12 +120,10 @@ static void setup(void)
 	tst_fill_file("test2.img", 0, 2048, 20);
 
 	sprintf(backing_path, "/sys/block/loop%d/loop/backing_file", dev_num);
-	sprintf(backing_file_path, "%s/test.img", tmpdir);
-	sprintf(backing_file_change_path, "%s/test1.img", tmpdir);
+	backing_file_path = tst_tmpdir_mkpath("test.img");
+	backing_file_change_path = tst_tmpdir_mkpath("test1.img");
 	sprintf(loop_ro_path, "/sys/block/loop%d/ro", dev_num);
 
-	free(tmpdir);
-
 	file_change_fd = SAFE_OPEN("test1.img", O_RDWR);
 	file_fd_invalid = SAFE_OPEN("test2.img", O_RDWR);
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index 3a5d5afef..6f19280cc 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -37,7 +37,8 @@
 #define DIO_MESSAGE "In dio mode"
 #define NON_DIO_MESSAGE "In non dio mode"
 
-static char dev_path[1024], sys_loop_diopath[1024], backing_file_path[1024];
+static char dev_path[1024], sys_loop_diopath[1024];
+static char *backing_file_path;
 static int dev_num, dev_fd, block_devfd, attach_flag, logical_block_size;
 
 static void check_dio_value(int flag)
@@ -124,7 +125,7 @@ static void setup(void)
 	 *   size of loop is bigger than the backing device's and the loop
 	 *   needn't transform transfer.
 	 */
-	sprintf(backing_file_path, "%s/test.img", tst_get_tmpdir());
+	backing_file_path = tst_tmpdir_mkpath("test.img");
 	tst_find_backing_dev(backing_file_path, bd_path, sizeof(bd_path));
 	block_devfd = SAFE_OPEN(bd_path, O_RDWR);
 	SAFE_IOCTL(block_devfd, BLKSSZGET, &logical_block_size);
diff --git a/testcases/kernel/syscalls/mkdir/mkdir03.c b/testcases/kernel/syscalls/mkdir/mkdir03.c
index 20089c9c9..85d46801e 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir03.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir03.c
@@ -85,10 +85,8 @@ static void verify_mkdir(unsigned int n)
 static void setup(void)
 {
 	unsigned int i;
-	char *tmpdir = tst_get_tmpdir();
 
-	SAFE_SYMLINK(tmpdir, TST_SYMLINK);
-	free(tmpdir);
+	SAFE_SYMLINK(tst_tmpdir_path(), TST_SYMLINK);
 
 	SAFE_MKFIFO(TST_PIPE, 0777);
 	SAFE_MKDIR(TST_FOLDER, 0777);
diff --git a/testcases/kernel/syscalls/mount/mount06.c b/testcases/kernel/syscalls/mount/mount06.c
index 2376deab3..8028dc5ec 100644
--- a/testcases/kernel/syscalls/mount/mount06.c
+++ b/testcases/kernel/syscalls/mount/mount06.c
@@ -27,14 +27,14 @@
 #define MNTPOINT_DST "mntpoint2"
 
 static char *tmppath;
-static char mntpoint_src[PATH_MAX];
-static char mntpoint_dst[PATH_MAX];
-static char tstfiles_src[PATH_MAX];
-static char tstfiles_dst[PATH_MAX];
+static char *mntpoint_src;
+static char *mntpoint_dst;
+static char *tstfiles_src;
+static char *tstfiles_dst;
 
 static void setup(void)
 {
-	tmppath = tst_get_tmpdir();
+	tmppath = tst_tmpdir_path();
 
 	/*
 	 * Turn current dir into a private mount point being a parent
@@ -43,11 +43,10 @@ static void setup(void)
 	SAFE_MOUNT(tmppath, tmppath, "none", MS_BIND, NULL);
 	SAFE_MOUNT("none", tmppath, "none", MS_PRIVATE, NULL);
 
-	snprintf(mntpoint_src, PATH_MAX, "%s/%s", tmppath, MNTPOINT_SRC);
-	snprintf(mntpoint_dst, PATH_MAX, "%s/%s", tmppath, MNTPOINT_DST);
-
-	snprintf(tstfiles_src, PATH_MAX, "%s/%s/testfile", tmppath, MNTPOINT_SRC);
-	snprintf(tstfiles_dst, PATH_MAX, "%s/%s/testfile", tmppath, MNTPOINT_DST);
+	mntpoint_src = tst_tmpdir_mkpath(MNTPOINT_SRC);
+	mntpoint_dst = tst_tmpdir_mkpath(MNTPOINT_DST);
+	tstfiles_src = tst_tmpdir_mkpath("%s/testfile", MNTPOINT_SRC);
+	tstfiles_dst = tst_tmpdir_mkpath("%s/testfile", MNTPOINT_DST);
 
 	SAFE_MKDIR(mntpoint_dst, 0750);
 }
diff --git a/testcases/kernel/syscalls/mount/mount07.c b/testcases/kernel/syscalls/mount/mount07.c
index eb3fb55a0..495777067 100644
--- a/testcases/kernel/syscalls/mount/mount07.c
+++ b/testcases/kernel/syscalls/mount/mount07.c
@@ -31,9 +31,9 @@
 
 #define MNTPOINT "mntpoint"
 
-static char test_file[PATH_MAX];
-static char link_file[PATH_MAX];
-static char temp_link_file[PATH_MAX];
+static char *test_file;
+static char *link_file;
+static char *temp_link_file;
 static int flag;
 
 static void setup_symlink(void)
@@ -114,15 +114,9 @@ static void test_statfs(bool nosymfollow)
 
 static void setup(void)
 {
-	char *tmpdir = tst_get_tmpdir();
-
-	snprintf(test_file, PATH_MAX, "%s/%s/test_file", tst_get_tmpdir(),
-			MNTPOINT);
-	snprintf(link_file, PATH_MAX, "%s/%s/link_file", tst_get_tmpdir(),
-			MNTPOINT);
-	snprintf(temp_link_file, PATH_MAX, "%s/%s/temp_link_file",
-			tst_get_tmpdir(), MNTPOINT);
-	free(tmpdir);
+	test_file = tst_tmpdir_mkpath("%s/test_file", MNTPOINT);
+	link_file = tst_tmpdir_mkpath("%s/link_file", MNTPOINT);
+	temp_link_file = tst_tmpdir_mkpath("%s/temp_link_file", MNTPOINT);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/open/open10.c b/testcases/kernel/syscalls/open/open10.c
index d2d3729d2..916357158 100644
--- a/testcases/kernel/syscalls/open/open10.c
+++ b/testcases/kernel/syscalls/open/open10.c
@@ -27,7 +27,6 @@
 #define NOSETGID_B	DIR_B "/nosetgid"
 #define ROOT_SETGID	DIR_B "/root_setgid"
 
-static char *tmpdir;
 static uid_t orig_uid, nobody_uid;
 static gid_t nobody_gid, free_gid;
 static int fd = -1;
@@ -42,7 +41,6 @@ static void setup(void)
 	tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)nobody_uid,
 		(int)nobody_gid);
 	free_gid = tst_get_free_gid(nobody_gid);
-	tmpdir = tst_get_tmpdir();
 }
 
 static void file_test(const char *name, mode_t mode, int sgid, gid_t gid)
@@ -123,15 +121,13 @@ static void run(void)
 	file_test(ROOT_SETGID, MODE_SGID, 1, free_gid);
 
 	/* Cleanup between loops */
-	tst_purge_dir(tmpdir);
+	tst_purge_dir(tst_tmpdir_path());
 }
 
 static void cleanup(void)
 {
 	if (fd >= 0)
 		SAFE_CLOSE(fd);
-
-	free(tmpdir);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/pathconf/pathconf01.c b/testcases/kernel/syscalls/pathconf/pathconf01.c
index 66b8d1fc1..280709a91 100644
--- a/testcases/kernel/syscalls/pathconf/pathconf01.c
+++ b/testcases/kernel/syscalls/pathconf/pathconf01.c
@@ -45,7 +45,7 @@ static void verify_pathconf(unsigned int i)
 {
 	struct tcase *tc = &tcases[i];
 
-	path = tst_get_tmpdir();
+	path = tst_tmpdir_path();
 
 	TEST(pathconf(path, tc->value));
 
@@ -55,14 +55,8 @@ static void verify_pathconf(unsigned int i)
 		tst_res(TPASS, "pathconf(%s, %s)", path, tc->name);
 }
 
-static void cleanup(void)
-{
-	free(path);
-}
-
 static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.test = verify_pathconf,
 	.tcnt = ARRAY_SIZE(tcases),
-	.cleanup = cleanup,
 };
diff --git a/testcases/kernel/syscalls/pathconf/pathconf02.c b/testcases/kernel/syscalls/pathconf/pathconf02.c
index 3fb2cdbe8..42b97dc93 100644
--- a/testcases/kernel/syscalls/pathconf/pathconf02.c
+++ b/testcases/kernel/syscalls/pathconf/pathconf02.c
@@ -70,12 +70,9 @@ static void setup(void)
 
 	SAFE_TOUCH("testfile", 0777, NULL);
 
-	char *tmpdir =  tst_get_tmpdir();
+	abs_path = tst_tmpdir_mkpath(FILEPATH);
 
-	abs_path = tst_aprintf("%s/%s", tmpdir, FILEPATH);
-
-	SAFE_CHMOD(tmpdir, 0);
-	free(tmpdir);
+	SAFE_CHMOD(tst_tmpdir_path(), 0);
 
 	memset(path, 'a', PATH_LEN);
 
diff --git a/testcases/kernel/syscalls/readlinkat/readlinkat01.c b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
index b1214c3ae..cd78ba134 100644
--- a/testcases/kernel/syscalls/readlinkat/readlinkat01.c
+++ b/testcases/kernel/syscalls/readlinkat/readlinkat01.c
@@ -66,10 +66,7 @@ static void verify_readlinkat(unsigned int i)
 
 static void setup(void)
 {
-	char *tmpdir = tst_get_tmpdir();
-
-	abspath = tst_aprintf("%s/" TEST_SYMLINK, tmpdir);
-	free(tmpdir);
+	abspath = tst_tmpdir_mkpath(TEST_SYMLINK);
 
 	file_fd = SAFE_OPEN(TEST_FILE, O_CREAT, 0600);
 	SAFE_SYMLINK(TEST_FILE, TEST_SYMLINK);
diff --git a/testcases/kernel/syscalls/rename/rename09.c b/testcases/kernel/syscalls/rename/rename09.c
index 368a436c2..927b36f27 100644
--- a/testcases/kernel/syscalls/rename/rename09.c
+++ b/testcases/kernel/syscalls/rename/rename09.c
@@ -27,14 +27,12 @@
 #define PERMS    0700
 
 static uid_t orig_uid, test_users[2];
-static char *tmpdir;
 
 static void setup(void)
 {
 	umask(0);
 	orig_uid = getuid();
 	tst_get_uids(test_users, 0, 2);
-	tmpdir = tst_get_tmpdir();
 }
 
 static void run(void)
@@ -54,18 +52,12 @@ static void run(void)
 
 	/* Cleanup between loops */
 	SAFE_SETEUID(orig_uid);
-	tst_purge_dir(tmpdir);
-}
-
-static void cleanup(void)
-{
-	free(tmpdir);
+	tst_purge_dir(tst_tmpdir_path());
 }
 
 static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
-	.cleanup = cleanup,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 };
diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
index a9c86ba89..04ddcd2d1 100644
--- a/testcases/kernel/syscalls/stat/stat04.c
+++ b/testcases/kernel/syscalls/stat/stat04.c
@@ -44,16 +44,13 @@ static void run(void)
 static void setup(void)
 {
 	char opt_bsize[32];
-	char *tmpdir;
 	const char *const fs_opts[] = {opt_bsize, NULL};
 	struct stat sb;
 	int pagesize;
 	int fd;
 
-	tmpdir = tst_get_tmpdir();
-	SAFE_ASPRINTF(&file_path, "%s/%s", tmpdir, FILENAME);
-	SAFE_ASPRINTF(&symb_path, "%s/%s", tmpdir, SYMBNAME);
-	free(tmpdir);
+	file_path = tst_tmpdir_mkpath(FILENAME);
+	symb_path = tst_tmpdir_mkpath(SYMBNAME);
 
 	/* change st_blksize / st_dev */
 	SAFE_STAT(".", &sb);
@@ -84,12 +81,6 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	if (file_path)
-		free(file_path);
-
-	if (symb_path)
-		free(symb_path);
-
 	if (tst_is_mounted(MNTPOINT))
 		SAFE_UMOUNT(MNTPOINT);
 }
diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
index 7b02cfae7..968174330 100644
--- a/testcases/kernel/syscalls/statx/statx07.c
+++ b/testcases/kernel/syscalls/statx/statx07.c
@@ -54,7 +54,6 @@
 #define SERV_FORCE_SYNC "server/force_sync_file"
 #define SERV_DONT_SYNC "server/dont_sync_file"
 
-static char *cwd;
 static char cmd[BUFF_SIZE];
 static int mounted;
 static int exported;
@@ -116,8 +115,6 @@ static void setup(void)
 	int ret;
 	char server_path[BUFF_SIZE];
 
-	cwd = tst_get_tmpdir();
-
 	mode_t old_umask = umask(0);
 
 	SAFE_MKDIR(SERV_PATH, DEFAULT_MODE);
@@ -127,7 +124,7 @@ static void setup(void)
 
 	umask(old_umask);
 
-	snprintf(server_path, sizeof(server_path), ":%s/%s", cwd, SERV_PATH);
+	snprintf(server_path, sizeof(server_path), ":%s/%s", tst_tmpdir_path(), SERV_PATH);
 
 	snprintf(cmd, sizeof(cmd),
 		 "exportfs -i -o no_root_squash,rw,sync,no_subtree_check,fsid=%d *%.1024s",
@@ -155,7 +152,7 @@ static void cleanup(void)
 	if (!exported)
 		return;
 	snprintf(cmd, sizeof(cmd),
-		 "exportfs -u *:%s/%s", cwd, SERV_PATH);
+		 "exportfs -u *:%s/%s", tst_tmpdir_path(), SERV_PATH);
 
 	if (tst_system(cmd) == -1)
 		tst_res(TWARN | TST_ERR, "failed to clear exportfs");
diff --git a/testcases/kernel/syscalls/utime/utime07.c b/testcases/kernel/syscalls/utime/utime07.c
index 3aff2c8ef..8889b3a6d 100644
--- a/testcases/kernel/syscalls/utime/utime07.c
+++ b/testcases/kernel/syscalls/utime/utime07.c
@@ -43,7 +43,7 @@ static void test_utime(void)
 
 	tst_res(TINFO, "Test if utime() changes access time");
 
-	create_symlink(tst_get_tmpdir(), symname);
+	create_symlink(tst_tmpdir_path(), symname);
 	SAFE_STAT(symname, &oldsym_stat);
 
 	struct utimbuf utimes = {
-- 
2.44.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
