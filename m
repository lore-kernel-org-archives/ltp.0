Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE98AC3DA64
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:30:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EC643D1F39
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 16:30:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E5C63D1EF0
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 16:30:04 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ACA881402FB5
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 16:30:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3DD27219D1;
 Thu,  1 Aug 2024 14:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722522603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y50r1xycIKX+iQ3cP5T4HQ0TxEUEobLIKDGFGw1tdS4=;
 b=eGmE9HciVLNo/zMG0u1oafHJePfYxa19vMtp1CAdBqAOT8iCicd2LAgm/wHfEUcwiu0gmG
 /rU3JD+a4sZif1Da1HvCQWRnovJffL47fNTqFQ2SmydbT0JUvQ/fYH1XH4+CLrnOZGKibB
 xmzE5gngEhnK8dfV87htkTuWGQ1XNGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722522603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y50r1xycIKX+iQ3cP5T4HQ0TxEUEobLIKDGFGw1tdS4=;
 b=HuDnumIm1N8kt7E1kJMmbT2JdZlvOpfnhCGWK2MrhDbRean/2MNw0gIyqG1v3zjq4/y+1X
 s19AAWftBTEUedDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722522603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y50r1xycIKX+iQ3cP5T4HQ0TxEUEobLIKDGFGw1tdS4=;
 b=eGmE9HciVLNo/zMG0u1oafHJePfYxa19vMtp1CAdBqAOT8iCicd2LAgm/wHfEUcwiu0gmG
 /rU3JD+a4sZif1Da1HvCQWRnovJffL47fNTqFQ2SmydbT0JUvQ/fYH1XH4+CLrnOZGKibB
 xmzE5gngEhnK8dfV87htkTuWGQ1XNGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722522603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y50r1xycIKX+iQ3cP5T4HQ0TxEUEobLIKDGFGw1tdS4=;
 b=HuDnumIm1N8kt7E1kJMmbT2JdZlvOpfnhCGWK2MrhDbRean/2MNw0gIyqG1v3zjq4/y+1X
 s19AAWftBTEUedDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D586B13946;
 Thu,  1 Aug 2024 14:30:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8I8GLuqbq2Z2AwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 14:30:02 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Aug 2024 16:29:43 +0200
MIME-Version: 1.0
Message-Id: <20240801-fchmodat2-v4-4-7f2f11a53a09@suse.com>
References: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
In-Reply-To: <20240801-fchmodat2-v4-0-7f2f11a53a09@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4479;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=FiidbMb0Ic7siV5MpFgVUWJisBk/zfCS3GmqPwnUdmI=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmq5vnP3rFVXrW+MekG366Q3ytBVOpgIXPmOTcX
 CuvMviM4GaJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqub5wAKCRDLzBqyILPm
 RrI5C/9vgJJPgN51n4/4q8ILBGjk1ru2A8TLJsLmgQI7zIp3ENIHxAkpQ5ZODHubNf0R2ox0bU0
 M7Pj3+5KKO/a9SCYTCiX2T6qMH2TjGQvPpPgQHwq3D8IQkYjfUYQVrVYF+jnOgs8Sq+d1xCSPOt
 ROuBCNK/dYGkGShGrAti7M5SkxPF+7QRuPKJQNLd3oMwYAVxuQ5wDqeTQyqaSRv3m4Jedr3y5za
 zBHGZR6XxSYYbdHrXAzv6hbopfZUm6QMKDFM+uqSyg2okmk35wtjDrVX+F1X4GHqo2vNgjjwElk
 sx/rYcFSKICgiXWjiGfzBjqys3F7oUWAyf40Ox4j0GohoJDroJ0dvg9OvylmXT+bG13UgPTGDkR
 nvqDe5gSoBATZn+ygfd67w1h7BAgDt2kFl4u3MwgfhnDoWoSIr1Z32yt2V5kBoLHwAQjntHN3E7
 /4EZ6jfRJX1vRk3YHxR/8F0yMNiS0+pkxPktjyPiJZY9ypZaT0VB4EIbb1akvFEfixkpI=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-1.10 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 4/5] Add fchmodat2_01 test
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

This test verifies that fchmodat2() syscall is properly working with
AT_SYMLINK_NOFOLLOW on regular files.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |   2 +
 testcases/kernel/syscalls/fchmodat2/.gitignore     |   1 +
 testcases/kernel/syscalls/fchmodat2/Makefile       |   7 ++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c | 114 +++++++++++++++++++++
 4 files changed, 124 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 9b3cba667..50298d01e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -270,6 +270,8 @@ fchmod06 fchmod06
 fchmodat01 fchmodat01
 fchmodat02 fchmodat02
 
+fchmodat2_01 fchmodat2_01
+
 fchown01 fchown01
 fchown01_16 fchown01_16
 fchown02 fchown02
diff --git a/testcases/kernel/syscalls/fchmodat2/.gitignore b/testcases/kernel/syscalls/fchmodat2/.gitignore
new file mode 100644
index 000000000..47d5e2427
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat2/.gitignore
@@ -0,0 +1 @@
+fchmodat2_01
diff --git a/testcases/kernel/syscalls/fchmodat2/Makefile b/testcases/kernel/syscalls/fchmodat2/Makefile
new file mode 100644
index 000000000..8cf1b9024
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat2/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
new file mode 100644
index 000000000..6f77788d2
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that fchmodat2() syscall is properly working with
+ * AT_SYMLINK_NOFOLLOW regular files, symbolic links and directories.
+ */
+
+#include "tst_test.h"
+#include "tst_safe_file_at.h"
+#include "lapi/fcntl.h"
+#include "lapi/stat.h"
+
+#define MNTPOINT "mntpoint"
+#define FNAME "myfile"
+#define SNAME "symlink"
+#define DNAME "mydir"
+#define DNAME_PATH MNTPOINT"/"DNAME
+
+static int fd_dir = -1;
+
+static void verify_mode(int dirfd, const char *path, mode_t mode)
+{
+	struct stat st;
+
+	SAFE_FSTATAT(dirfd, path, &st, AT_SYMLINK_NOFOLLOW);
+	TST_EXP_EQ_LI(st.st_mode, mode);
+}
+
+static void test_regular_file(void)
+{
+	tst_res(TINFO, "Using regular files");
+
+	SAFE_CHMOD(MNTPOINT"/"FNAME, 0640);
+
+	SAFE_FCHMODAT2(fd_dir, FNAME, 0700, 0);
+	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
+
+	SAFE_FCHMODAT2(fd_dir, FNAME, 0700, AT_SYMLINK_NOFOLLOW);
+	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
+}
+
+static void test_symbolic_link(void)
+{
+	tst_res(TINFO, "Using symbolic link");
+
+	SAFE_FCHMODAT2(fd_dir, SNAME, 0700, 0);
+	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
+	verify_mode(fd_dir, SNAME, S_IFLNK | 0777);
+
+	SAFE_FCHMODAT2(fd_dir, SNAME, 0640, AT_SYMLINK_NOFOLLOW);
+	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
+	verify_mode(fd_dir, SNAME, S_IFLNK | 0640);
+}
+
+static void test_empty_folder(void)
+{
+	tst_res(TINFO, "Using empty folder");
+
+	int fd;
+
+	SAFE_CHMOD(DNAME_PATH, 0640);
+	fd = SAFE_OPEN(DNAME_PATH, O_PATH | O_DIRECTORY, 0640);
+
+	SAFE_FCHMODAT2(fd, "", 0777, AT_EMPTY_PATH);
+	verify_mode(fd_dir, DNAME, S_IFDIR | 0777);
+
+	SAFE_CLOSE(fd);
+}
+
+static void run(void)
+{
+	test_regular_file();
+	test_empty_folder();
+	test_symbolic_link();
+}
+
+static void setup(void)
+{
+	fd_dir = SAFE_OPEN(MNTPOINT, O_PATH | O_DIRECTORY, 0640);
+
+	if (access(DNAME_PATH, F_OK) == -1)
+		SAFE_MKDIR(DNAME_PATH, 0640);
+
+	SAFE_TOUCH(MNTPOINT"/"FNAME, 0640, NULL);
+	SAFE_SYMLINKAT(FNAME, fd_dir, SNAME);
+}
+
+static void cleanup(void)
+{
+	SAFE_UNLINKAT(fd_dir, SNAME, 0);
+	SAFE_RMDIR(DNAME_PATH);
+
+	if (fd_dir != -1)
+		SAFE_CLOSE(fd_dir);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "6.6",
+	.mntpoint = MNTPOINT,
+	.format_device = 1,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		NULL
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
