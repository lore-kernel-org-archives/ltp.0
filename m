Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D84E95A8E
	for <ltp@archiver.kernel.org>; Mon,  9 Oct 2023 11:21:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08AAB3CB928
	for <ltp@archiver.kernel.org>; Mon,  9 Oct 2023 13:21:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5AAA93C8AC0
 for <ltp@lists.linux.it>; Mon,  9 Oct 2023 13:21:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9E054140026F
 for <ltp@lists.linux.it>; Mon,  9 Oct 2023 13:21:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E7B4921879;
 Mon,  9 Oct 2023 11:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1696850496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iQ4APC5U1Vhw+l5PjntunGqYhOVvDgSaM2ffexdztso=;
 b=bJXVWrboSPv1ZC8+WQt3sG6CG+3Ro4g2EbaCUYfRqeIo37nn1/7axEjSVI8MXrxFWzAI38
 vUWfauGXkPm9ku6t2VVTnxkLSW8e/xKp+ZR10kaKwg7Ac/gocGiionmRH9iMqUps/pqJba
 HVcCrR4KSCRq/YGnBF0z7djGSvfX4H8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 741E713586;
 Mon,  9 Oct 2023 11:21:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OVtbBj/iI2WBHgAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 09 Oct 2023 11:21:35 +0000
To: ltp@lists.linux.it
Date: Mon,  9 Oct 2023 07:20:47 -0400
Message-Id: <20231009112047.2359-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] open15: allow restricted O_CREAT of FIFOs and
 regular files
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

Fix: #574

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open15.c   | 188 ++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100644 testcases/kernel/syscalls/open/open15.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 4f1ee1f34..4152e1e5f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -935,6 +935,7 @@ open11 open11
 open12 open12
 open13 open13
 open14 open14
+open15 open15
 
 openat01 openat01
 openat02 openat02
diff --git a/testcases/kernel/syscalls/open/.gitignore b/testcases/kernel/syscalls/open/.gitignore
index 001d874d6..af5997572 100644
--- a/testcases/kernel/syscalls/open/.gitignore
+++ b/testcases/kernel/syscalls/open/.gitignore
@@ -12,3 +12,4 @@
 /open12_child
 /open13
 /open14
+/open15
diff --git a/testcases/kernel/syscalls/open/open15.c b/testcases/kernel/syscalls/open/open15.c
new file mode 100644
index 000000000..f0eec08e7
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open15.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify disallows open of FIFOs or regular files not owned by the user in world
+ * writable sticky directories
+ *
+ * Linux commit 30aba6656f61ed44cba445a3c0d38b296fa9e8f5
+ */
+
+#include <pwd.h>
+#include <stdlib.h>
+#include "tst_test.h"
+#include "tst_safe_file_at.h"
+
+#define  FILENAME  "setuid04_testfile"
+#define  DIR "ltp_tmp_check1"
+#define  TEST_FILE "test_file_1"
+#define  TEST_FIFO "test_fifo_1"
+#define  LTP_USER1 "ltp_user1"
+#define  LTP_USER2 "ltp_user2"
+#define  CONCAT(dir, filename) dir "/" filename
+#define  PROTECTED_REGULAR "/proc/sys/fs/protected_regular"
+#define  PROTECTED_FIFOS "/proc/sys/fs/protected_fifos"
+
+static int LTP_USER1_UID;
+static int LTP_USER2_UID;
+static int dir_fd;
+
+static void run(void)
+{
+	int pid;
+
+	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 0);
+	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 0);
+
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		SAFE_SETUID(LTP_USER1_UID);
+
+		int fd = SAFE_OPENAT(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777);
+
+		SAFE_CLOSE(fd);
+		fd = SAFE_MKFIFO(CONCAT(DIR, TEST_FIFO), 0777);
+		SAFE_CLOSE(fd);
+
+		TST_CHECKPOINT_WAKE(0);
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(0);
+
+	pid = SAFE_FORK();
+
+	if (pid == 0) {
+		SAFE_SETUID(LTP_USER2_UID);
+
+		int fd = SAFE_OPENAT(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777);
+
+		tst_res(TPASS, "check protect_regural == 0 pass");
+		SAFE_CLOSE(fd);
+
+		fd = SAFE_OPEN(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT);
+		tst_res(TPASS, "check protect_fifos == 0 pass");
+		SAFE_CLOSE(fd);
+
+		TST_CHECKPOINT_WAKE(1);
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(1);
+
+	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 1);
+	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 1);
+
+	pid = SAFE_FORK();
+
+	if (pid == 0) {
+		SAFE_SETUID(LTP_USER2_UID);
+
+		TEST(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777));
+		if (TST_RET == -1 && TST_ERR == EACCES)
+			tst_res(TPASS, "check protect_regural == 1 pass");
+		else
+			tst_res(TFAIL | TERRNO, "check protect_regural == 1 failed");
+
+		TEST(open(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT, 0777));
+		if (TST_RET == -1 && TST_ERR == EACCES)
+			tst_res(TPASS, "check protect_fifos == 1 pass");
+		else
+			tst_res(TFAIL | TERRNO, "check protect_fifos == 1 failed");
+
+		TST_CHECKPOINT_WAKE(2);
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(2);
+
+	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%d", 2);
+	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%d", 2);
+	SAFE_CHMOD(DIR, 0020 | S_ISVTX);
+
+	pid = SAFE_FORK();
+
+	if (pid == 0) {
+		SAFE_SETUID(LTP_USER2_UID);
+
+		TEST(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777));
+		if (TST_RET == -1 && TST_ERR == EACCES)
+			tst_res(TPASS, "check protect_regural == 2 pass");
+		else
+			tst_res(TFAIL | TERRNO, "check protect_regural == 2 failed");
+
+		TEST(open(CONCAT(DIR, TEST_FIFO), O_RDWR | O_CREAT, 0777));
+		if (TST_RET == -1 && TST_ERR == EACCES)
+			tst_res(TPASS, "check protect_fifos == 2 pass");
+		else
+			tst_res(TFAIL | TERRNO, "check protect_fifos == 2 failed");
+
+		TST_CHECKPOINT_WAKE(3);
+		exit(0);
+	}
+
+	TST_CHECKPOINT_WAIT(3);
+}
+
+static int add_user(char *username)
+{
+	const char *const cmd_useradd[] = {"useradd", username, NULL};
+	struct passwd *ltpuser;
+	int rc, uid = -1;
+
+	switch ((rc = tst_cmd(cmd_useradd, NULL, NULL, TST_CMD_PASS_RETVAL))) {
+	case 0:
+	case 9:
+		ltpuser = SAFE_GETPWNAM(username);
+		uid = ltpuser->pw_uid;
+		break;
+	default:
+		tst_brk(TBROK, "Useradd failed (%d)", rc);
+	}
+
+	return uid;
+}
+
+static void del_user(char *username)
+{
+	const char *const cmd_userdel[] = {"userdel", "-r", username, NULL};
+
+	tst_cmd(cmd_userdel, NULL, NULL, TST_CMD_PASS_RETVAL);
+
+}
+
+static void setup(void)
+{
+	umask(0);
+	SAFE_MKDIR(DIR, 0777 | S_ISVTX);
+
+	dir_fd = SAFE_OPEN(DIR, O_DIRECTORY);
+
+	LTP_USER1_UID = add_user(LTP_USER1);
+	LTP_USER2_UID = add_user(LTP_USER2);
+}
+
+static void cleanup(void)
+{
+	del_user(LTP_USER1);
+	del_user(LTP_USER2);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.test_all = run,
+	.needs_tmpdir = 1,
+	.forks_child = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{PROTECTED_REGULAR, NULL, TST_SR_SKIP},
+		{PROTECTED_FIFOS, NULL, TST_SR_SKIP},
+		{}
+	},
+	.needs_checkpoints = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
