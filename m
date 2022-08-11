Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF42C19F2A
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 13:58:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 863873C9605
	for <ltp@archiver.kernel.org>; Thu, 11 Aug 2022 15:57:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B25B13C9503
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 15:57:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 78DC2600127
 for <ltp@lists.linux.it>; Thu, 11 Aug 2022 15:57:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E7D55C8D4;
 Thu, 11 Aug 2022 13:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660226256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZizIxlrFiilgTWYd/KFSoMJuwwVFEExkYNY7SB/4xGM=;
 b=qk93a/yjAAOFJyAJR8QETECfmwnTDJyiw6NCOMxtlrvmxopqWyXyfxJnYmsV9Z/EWPoNaH
 eLnSN6ZPNOhN+X/W86sgnh0msL36JjqlLa9lzL45mHSrJDF9v7BVMXTp/1onlPSfjHvIrT
 hd7P7S3imz4gO2vpDmL84KdK4GZbaaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660226256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZizIxlrFiilgTWYd/KFSoMJuwwVFEExkYNY7SB/4xGM=;
 b=VnY4N6CADzvPxcZ2DEXanlGFWNNfn1Texo7Oj6ja/Yx7qEelGxb0YtI+hZk2PjIqhY+7VN
 QdpLUU4FNeGQAlAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CBFB1342A;
 Thu, 11 Aug 2022 13:57:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id j/9qCNAK9WKmcwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 11 Aug 2022 13:57:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Aug 2022 15:57:29 +0200
Message-Id: <20220811135731.2228-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] mount03: Convert to new API
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

Hi,

I wanted to speedup mount03 rewrite [1], thus I finished the work.

Changes include:
* simplify code by using:
  - SAFE macros
  - TST_EXP_FAIL() instead of TST_EXP_FAIL2()
  - remove if () check from SAFE macros (that's the point of safe macros
	to not having to use if () check

* fix mount03_setuid_test call, so it can expect 0 exit code
I wonder myself why this fixes it:
-		SAFE_SETREUID(nobody_uid, nobody_gid);
+		SAFE_SETGID(nobody_gid);
+		SAFE_SETREUID(-1, nobody_uid);

* add missing TST_RESOURCE_COPY()
@Cyril: is it really needed?

* do not run test function if initial mount() fails

* cleanup useless comments
* style changes (simplify function and variable names, simplify docparse)

Full diff is below.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20220726070206.266-1-chenhx.fnst@fujitsu.com/

Petr Vorel (1):
  tst_test_macros.h: Add TST_EXP_EQ_STR

chenhx.fnst@fujitsu.com (1):
  mount03: Convert to new API

 include/tst_test_macros.h                 |  10 +
 testcases/kernel/syscalls/mount/mount03.c | 495 +++++++---------------
 2 files changed, 164 insertions(+), 341 deletions(-)

diff --git include/tst_test_macros.h include/tst_test_macros.h
index c8f7825c4..8cc959243 100644
--- include/tst_test_macros.h
+++ include/tst_test_macros.h
@@ -242,4 +242,14 @@ extern void *TST_RET_PTR;
 #define TST_EXP_EQ_SSZ(VAL_A, VAL_B) \
 		TST_EXP_EQ_(VAL_A, #VAL_A, VAL_B, #VAL_B, ssize_t, "%zi")
 
+#define TST_EXP_EQ_STR(STR_A, STR_B) do {\
+	if (strcmp(STR_A, STR_B)) { \
+		tst_res_(__FILE__, __LINE__, TFAIL, \
+			"'%s' != '%s'", STR_A, STR_B); \
+	} else { \
+		tst_res_(__FILE__, __LINE__, TPASS, \
+			"'%s' == '%s'", STR_A, STR_B); \
+	} \
+} while (0)
+
 #endif	/* TST_TEST_MACROS_H__ */
diff --git testcases/kernel/syscalls/mount/mount03.c testcases/kernel/syscalls/mount/mount03.c
index e6395c592..74b018d78 100644
--- testcases/kernel/syscalls/mount/mount03.c
+++ testcases/kernel/syscalls/mount/mount03.c
@@ -7,265 +7,176 @@
 /*\
  * [Description]
  *
- * Check for basic mount(2) system call flags.
- *
- * Verify that mount(2) syscall passes for each flag setting and validate
- * the flags
- *
- * - MS_RDONLY - mount read-only.
- * - MS_NODEV - disallow access to device special files.
- * - MS_NOEXEC - disallow program execution.
- * - MS_SYNCHRONOUS - writes are synced at once.
- * - MS_REMOUNT - alter flags of a mounted FS.
- * - MS_NOSUID - ignore suid and sgid bits.
- * - MS_NOATIME - do not update access times.
+ * Verify mount(2) for various flags.
  */
 
-#ifndef _GNU_SOURCE
-#define _GNU_SOURCE
-#endif
-
-#define TEMP_FILE	"temp_file"
-#define FILE_MODE	0644
-#define SUID_MODE	0511
-
 #include <stdio.h>
+#include <stdlib.h>
 #include <sys/types.h>
 #include <sys/wait.h>
-#include <linux/limits.h>
-#include <stdlib.h>
 #include <pwd.h>
+#include "old_resource.h"
 #include "tst_test.h"
-#include "tst_safe_file_ops.h"
 #include "lapi/mount.h"
 
 #define MNTPOINT        "mntpoint"
 #define TESTBIN	"mount03_setuid_test"
-#define TCASE_ENTRY(_flags, _do_test)    \
-	{                                \
-		.name = "Flag " #_flags, \
-		.flags = _flags,         \
-		.do_test = _do_test      \
-	}
+#define TEST_STR "abcdefghijklmnopqrstuvwxyz"
+#define FILE_MODE	0644
+#define SUID_MODE	0511
 
 static int otfd;
-static char write_buffer[BUFSIZ];
-static char read_buffer[BUFSIZ];
+static char wbuf[BUFSIZ];
+static char rbuf[BUFSIZ];
 static char file[PATH_MAX];
 static uid_t nobody_uid;
 static gid_t nobody_gid;
 
-static void test_ms_nosuid(void);
-static void test_ms_rdonly(void);
-static void test_ms_nodev(void);
-static void test_noexec(void);
-static void test_ms_synchronous(void);
-static void test_ms_remount(void);
-static void test_ms_noatime(void);
-
-static struct tcase {
-	char *name;
-	unsigned int flags;
-	void (*do_test)(void);
-} tcases[] = {
-	TCASE_ENTRY(MS_RDONLY, test_ms_rdonly),
-	TCASE_ENTRY(MS_NODEV, test_ms_nodev),
-	TCASE_ENTRY(MS_NOEXEC, test_noexec),
-	TCASE_ENTRY(MS_SYNCHRONOUS, test_ms_synchronous),
-	TCASE_ENTRY(MS_RDONLY, test_ms_remount),
-	TCASE_ENTRY(MS_NOSUID, test_ms_nosuid),
-	TCASE_ENTRY(MS_NOATIME, test_ms_noatime),
-};
+static void test_rdonly(void)
+{
+	snprintf(file, PATH_MAX, "%s/rdonly", MNTPOINT);
+	TST_EXP_FAIL(otfd = open(file, O_CREAT | O_RDWR, 0700), EROFS);
+}
 
-static void test_ms_rdonly(void)
+static void test_nodev(void)
 {
-	/* Validate MS_RDONLY flag of mount call */
+	snprintf(file, PATH_MAX, "%s/nodev", MNTPOINT);
+	SAFE_MKNOD(file, S_IFBLK | 0777, 0);
+	TST_EXP_FAIL(otfd = open(file, O_RDWR, 0700), EACCES);
+	SAFE_UNLINK(file);
+}
 
-	snprintf(file, PATH_MAX, "%s/tmp", MNTPOINT);
-	TST_EXP_FAIL2(open(file,  O_CREAT | O_RDWR, 0700),
-		      EROFS, "mount(2) passed with flag MS_RDONLY: "
-		      "open fail with EROFS as expected");
+static void test_noexec(void)
+{
+	snprintf(file, PATH_MAX, "%s/noexec", MNTPOINT);
+	otfd = SAFE_OPEN(file, O_CREAT | O_RDWR, 0700);
+	TST_EXP_FAIL(execlp(file, basename(file), NULL), EACCES);
+}
 
-	otfd = TST_RET;
+static void test_synchronous(void)
+{
+	strcpy(wbuf, TEST_STR);
+	snprintf(file, PATH_MAX, "%s/synchronous", MNTPOINT);
+	otfd = SAFE_OPEN(file, O_RDWR | O_CREAT, FILE_MODE);
+	SAFE_WRITE(1, otfd, wbuf, strlen(wbuf));
+	SAFE_LSEEK(otfd, 0, SEEK_SET);
+	SAFE_READ(0, otfd, rbuf, sizeof(rbuf));
+	TST_EXP_EQ_STR(rbuf, wbuf);
 }
 
-static void test_ms_nosuid(void)
+static void test_remount(void)
 {
-	/* Validate MS_NOSUID flag of mount call */
+	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, MS_REMOUNT, NULL);
+	snprintf(file, PATH_MAX, "%s/remount", MNTPOINT);
+	TST_EXP_FD(otfd = open(file, O_CREAT | O_RDWR, 0700));
+}
 
+static void test_nosuid(void)
+{
 	pid_t pid;
 	int status;
 
 	pid = SAFE_FORK();
-
 	if (!pid) {
-		SAFE_SETREUID(nobody_uid, nobody_gid);
+		SAFE_SETGID(nobody_gid);
+		SAFE_SETREUID(-1, nobody_uid);
 		SAFE_EXECLP(TESTBIN, TESTBIN, NULL);
 	}
 
-	waitpid(pid, &status, 0);
-	if (WIFEXITED(status)) {
-		/* reset the setup_uid */
-		if (status)
-			tst_res(TPASS, "mount(2) passed with flag MS_NOSUID");
-	} else {
-		tst_res(TFAIL, "mount(2) failed with flag MS_NOSUID");
-	}
-}
-
-static void test_ms_nodev(void)
-{
-	/* Validate MS_NODEV flag of mount call */
-
-	snprintf(file, PATH_MAX, "%s/mynod_%d", MNTPOINT, getpid());
-	if (SAFE_MKNOD(file, S_IFBLK | 0777, 0) == 0) {
-		TST_EXP_FAIL2(open(file, O_RDWR, 0700),
-			      EACCES, "mount(2) passed with flag MS_NODEV: "
-			      "open fail with EACCES as expected");
-		otfd = TST_RET;
-	}
-	SAFE_UNLINK(file);
-}
+	SAFE_WAITPID(pid, &status, 0);
 
-static void test_noexec(void)
-{
-	/* Validate MS_NOEXEC flag of mount call */
-	int ret;
-
-	snprintf(file, PATH_MAX, "%s/tmp1", MNTPOINT);
-	TST_EXP_FD_SILENT(open(file, O_CREAT | O_RDWR, 0700),
-			  "opening %s failed", file);
-	otfd = TST_RET;
-	if (otfd >= 0) {
-		SAFE_CLOSE(otfd);
-		ret = execlp(file, basename(file), NULL);
-		if ((ret == -1) && (errno == EACCES)) {
-			tst_res(TPASS, "mount(2) passed with flag MS_NOEXEC");
+	if (WIFEXITED(status)) {
+		switch (WEXITSTATUS(status)) {
+		case EXIT_FAILURE:
+			tst_res(TFAIL, "%s failed", TESTBIN);
 			return;
-		}
-	}
-	tst_brk(TFAIL | TERRNO, "mount(2) failed with flag MS_NOEXEC");
-}
-
-static void test_ms_synchronous(void)
-{
-	/*
-	 * Validate MS_SYNCHRONOUS flag of mount call.
-	 * Copy some data into data buffer.
-	 */
-
-	strcpy(write_buffer, "abcdefghijklmnopqrstuvwxyz");
-
-	/* Creat a temporary file under above directory */
-	snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TEMP_FILE);
-	TST_EXP_FD_SILENT(open(file, O_RDWR | O_CREAT, FILE_MODE),
-			  "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			  file, FILE_MODE);
-	otfd = TST_RET;
-
-	/* Write the buffer data into file */
-	SAFE_WRITE(1, otfd, write_buffer, strlen(write_buffer));
-
-	/* Set the file ptr to b'nning of file */
-	SAFE_LSEEK(otfd, 0, SEEK_SET);
-
-	/* Read the contents of file */
-	if (SAFE_READ(0, otfd, read_buffer, sizeof(read_buffer)) > 0) {
-		if (strcmp(read_buffer, write_buffer)) {
-			tst_brk(TFAIL, "Data read from %s and written "
-				"mismatch", file);
-		} else {
-			SAFE_CLOSE(otfd);
-			tst_res(TPASS, "mount(2) passed with flag MS_SYNCHRONOUS");
+		case EXIT_SUCCESS:
+			tst_res(TPASS, "%s passed", TESTBIN);
 			return;
+		default:
+		case TBROK:
+			break;
 		}
-	} else {
-		tst_brk(TFAIL | TERRNO, "read() Fails on %s", file);
 	}
-}
 
-static void test_ms_remount(void)
-{
-	/* Validate MS_REMOUNT flag of mount call */
-
-	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, MS_REMOUNT, NULL));
-	if (TST_RET != 0) {
-		tst_brk(TFAIL | TTERRNO, "mount(2) failed to remount");
-	} else {
-		snprintf(file, PATH_MAX, "%s/tmp2", MNTPOINT);
-		TEST(open(file, O_CREAT | O_RDWR, 0700));
-		otfd = TST_RET;
-		if (otfd == -1) {
-			tst_res(TFAIL, "open(%s) on readonly "
-				"filesystem passed", file);
-		} else
-			tst_res(TPASS, "mount(2) passed with flag MS_REMOUNT");
-	}
+	tst_brk(TBROK, "Child %s", tst_strstatus(status));
 }
 
-static void test_ms_noatime(void)
+static void test_noatime(void)
 {
-	/* Validate MS_NOATIME flag of mount call */
 	time_t atime;
-	struct stat file_stat;
+	struct stat st;
 	char readbuf[20];
 
-	snprintf(file, PATH_MAX, "%s/atime", MNTPOINT);
-	TST_EXP_FD_SILENT(open(file, O_CREAT | O_RDWR, 0700));
-	otfd = TST_RET;
+	snprintf(file, PATH_MAX, "%s/noatime", MNTPOINT);
+	TST_EXP_FD_SILENT(otfd = open(file, O_CREAT | O_RDWR, 0700));
 
-	SAFE_WRITE(1, otfd, "TEST_MS_NOATIME", 15);
+	SAFE_WRITE(1, otfd, TEST_STR, strlen(TEST_STR));
+	SAFE_FSTAT(otfd, &st);
+	atime = st.st_atime;
+	sleep(1);
 
-	SAFE_FSTAT(otfd, &file_stat);
+	SAFE_READ(0, otfd, readbuf, sizeof(readbuf));
+	SAFE_FSTAT(otfd, &st);
+	TST_EXP_EQ_LI(st.st_atime, atime);
+}
 
-	atime = file_stat.st_atime;
+#define FLAG_DESC(x) .flag = x, .desc = #x
+static struct tcase {
+	unsigned int flag;
+	char *desc;
+	void (*test)(void);
+} tcases[] = {
+	{FLAG_DESC(MS_RDONLY), test_rdonly},
+	{FLAG_DESC(MS_NODEV), test_nodev},
+	{FLAG_DESC(MS_NOEXEC), test_noexec},
+	{FLAG_DESC(MS_SYNCHRONOUS), test_synchronous},
+	{FLAG_DESC(MS_RDONLY), test_remount},
+	{FLAG_DESC(MS_NOSUID), test_nosuid},
+	{FLAG_DESC(MS_NOATIME), test_noatime},
+};
 
-	sleep(1);
+static void setup(void)
+{
+	struct stat st;
+	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
 
-	SAFE_READ(0, otfd, readbuf, sizeof(readbuf));
+	nobody_uid = ltpuser->pw_uid;
+	nobody_gid = ltpuser->pw_gid;
 
-	SAFE_FSTAT(otfd, &file_stat);
+	snprintf(file, PATH_MAX, "%s/%s", MNTPOINT, TESTBIN);
+	TST_RESOURCE_COPY(NULL, TESTBIN, file);
 
-	if (file_stat.st_atime != atime) {
-		tst_res(TFAIL, "access time is updated");
-		return;
-	}
-	tst_res(TPASS, "mount(2) passed with flag MS_NOATIME");
+	SAFE_STAT(file, &st);
+	if (st.st_mode != SUID_MODE)
+	    SAFE_CHMOD(file, SUID_MODE);
 }
 
-static void run(unsigned int n)
+static void cleanup(void)
 {
-	struct tcase *tc = &tcases[n];
-
-	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type,
-		   tc->flags, NULL));
-	if (tc->do_test)
-		tc->do_test();
-
 	if (otfd >= 0)
 		SAFE_CLOSE(otfd);
+
 	if (tst_is_mounted(MNTPOINT))
 		SAFE_UMOUNT(MNTPOINT);
 }
 
-static void cleanup(void)
-{
-	if (otfd > -1)
-		SAFE_CLOSE(otfd);
-}
 
-static void setup(void)
+static void run(unsigned int n)
 {
-	struct stat file_stat = {0};
-	struct passwd *ltpuser = SAFE_GETPWNAM("nobody");
+	struct tcase *tc = &tcases[n];
 
-	nobody_uid = ltpuser->pw_uid;
-	nobody_gid = ltpuser->pw_gid;
-	snprintf(file, PATH_MAX, "%s/mount03_setuid_test", MNTPOINT);
-	SAFE_STAT(MNTPOINT, &file_stat);
-	if (file_stat.st_mode != SUID_MODE &&
-	    chmod(MNTPOINT, SUID_MODE) < 0)
-		tst_brk(TBROK, "setuid for setuid_test failed");
+	tst_res(TINFO, "Testing flag %s", tc->desc);
+
+	TST_EXP_PASS_SILENT(mount(tst_device->dev, MNTPOINT, tst_device->fs_type,
+		   tc->flag, NULL));
+	if (!TST_PASS)
+		return;
+
+	if (tc->test)
+		tc->test();
+
+	cleanup();
 }
 
 static struct tst_test test = {
@@ -276,7 +187,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.format_device = 1,
 	.resource_files = (const char *const[]) {
-		"mount03_setuid_test",
+		TESTBIN,
 		NULL,
 	},
 	.forks_child = 1,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
