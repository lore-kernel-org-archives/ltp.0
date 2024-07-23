Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2282C3DA63
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 17:59:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01CE83D1C3C
	for <ltp@archiver.kernel.org>; Tue, 23 Jul 2024 19:59:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0693B3D1BF9
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 19:59:10 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 21E20600BFA
 for <ltp@lists.linux.it>; Tue, 23 Jul 2024 19:59:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44E4B1FD63;
 Tue, 23 Jul 2024 17:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721757549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/IbR9OpXip+DMu+2u/7+OxDQE+nl0RcXpEkNaCX/js=;
 b=QWS8ngZ0jM5pVsuwLM9BKMhOdlAdm6kudmj1tNrW4lzc4kxGFg9LfkKXP8QxMg8k6Wbyfo
 Ahe4LYsceQYFM0NGIMpcR0HxIdGz9InyKEoGDY9aRCv26Ntr/yZE8QlK8X+EmajlaFF4E8
 6YOoAr1vVjnBTWbxHeGb8A8wTje3BLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721757549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/IbR9OpXip+DMu+2u/7+OxDQE+nl0RcXpEkNaCX/js=;
 b=/pHivNlw3I7rt1bINxPTrL2LN04PdVUinb1HenOs4TWtmNbFrBu5Ila/jMUJy65S+3HYi+
 HLiQcOL7VW2/2KCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QWS8ngZ0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/pHivNlw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721757549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/IbR9OpXip+DMu+2u/7+OxDQE+nl0RcXpEkNaCX/js=;
 b=QWS8ngZ0jM5pVsuwLM9BKMhOdlAdm6kudmj1tNrW4lzc4kxGFg9LfkKXP8QxMg8k6Wbyfo
 Ahe4LYsceQYFM0NGIMpcR0HxIdGz9InyKEoGDY9aRCv26Ntr/yZE8QlK8X+EmajlaFF4E8
 6YOoAr1vVjnBTWbxHeGb8A8wTje3BLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721757549;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j/IbR9OpXip+DMu+2u/7+OxDQE+nl0RcXpEkNaCX/js=;
 b=/pHivNlw3I7rt1bINxPTrL2LN04PdVUinb1HenOs4TWtmNbFrBu5Ila/jMUJy65S+3HYi+
 HLiQcOL7VW2/2KCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17BB813888;
 Tue, 23 Jul 2024 17:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6CFgBFXvn2aMEgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 23 Jul 2024 17:58:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 23 Jul 2024 17:41:06 +0200
MIME-Version: 1.0
Message-Id: <20240723-fchmodat2-v2-4-e658a98b113e@suse.com>
References: <20240723-fchmodat2-v2-0-e658a98b113e@suse.com>
In-Reply-To: <20240723-fchmodat2-v2-0-e658a98b113e@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5071;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=qdiS5pIFKtEltmgTjeflFKG5qzvWeljNB2US4AGfD/4=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmn+9XNY3rfYC6zdSAsik5SwHqrcDPr8nqyUjBw
 zjQ0By4A4OJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZp/vVwAKCRDLzBqyILPm
 RmBADACrWuHLNT1+SPKI6Zm6rEuSAHymXuBmPwD8kFHhRMIgDvBCThmqrzrnyhoSm9r6im4ag/w
 E5Fg20+ZT9QZx9Jm3Lw7utqv5nHAMKaJVVW6/3W9PLl9qbO5VIt7Ph+e03e8newRO3ECut6s2Sc
 sc188fcaGUA39jExcP/OLmRSrwG/rkzERHb2HVmjTgt6hdE+439HhtZjaGT2ai3JL7TLecaqLNA
 74Q9cawysvUlzk8i4fNNZi6+c81nxxgjSX88vDFll+2ZKp47ccn7BRZH920V+abNwMSWgTXMSrV
 jOxyzmiNyI+E4wHVj2Ws8NNHJ1z1S5cBpkDCnNcUMWZtENjkaeD3RdeaN8LKrxwYyFtMYmS84H+
 YyXPCxgT64x+xXZrxd6qhIj6j/pFfbt/5UMTNj++sfQMr8+DqOQq0NMfy7RBulktwqY68dKUros
 jT+XG0rjGAPZKX75NIYXSV2tIJT7RpT/4GROJUoO0KmXHZRROZSx2Q0XDQ6u8euNRxiNY=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 44E4B1FD63
X-Spamd-Result: default: False [-4.31 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/5] Add fchmodat2_01 test
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
 testcases/kernel/syscalls/fchmodat2/fchmodat2.h    |  20 ++++
 testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c | 105 +++++++++++++++++++++
 5 files changed, 135 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 27eb9a86b..b4bb4f391 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -265,6 +265,8 @@ fchmod06 fchmod06
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
diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2.h b/testcases/kernel/syscalls/fchmodat2/fchmodat2.h
new file mode 100644
index 000000000..4d8449fe9
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef FCHMODAT2_H
+#define FCHMODAT2_H
+
+#include "tst_test.h"
+#include "tst_safe_file_at.h"
+
+static inline void verify_mode(int dirfd, const char *path, mode_t mode)
+{
+	struct stat st;
+
+	SAFE_FSTATAT(dirfd, path, &st, AT_SYMLINK_NOFOLLOW);
+	TST_EXP_EQ_LI(st.st_mode, mode);
+}
+
+#endif
diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
new file mode 100644
index 000000000..38d5d1bee
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
@@ -0,0 +1,105 @@
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
+#include "fchmodat2.h"
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
+static void test_regular_file(void)
+{
+	tst_res(TINFO, "Using regular files");
+
+	SAFE_CHMOD(MNTPOINT"/"FNAME, 0640);
+
+	TST_EXP_PASS(fchmodat2(fd_dir, FNAME, 0700, 0));
+	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
+
+	TST_EXP_PASS(fchmodat2(fd_dir, FNAME, 0700, AT_SYMLINK_NOFOLLOW));
+	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
+}
+
+static void test_symbolic_link(void)
+{
+	tst_res(TINFO, "Using symbolic link");
+
+	TST_EXP_PASS(fchmodat2(fd_dir, SNAME, 0700, 0));
+	verify_mode(fd_dir, FNAME, S_IFREG | 0700);
+	verify_mode(fd_dir, SNAME, S_IFLNK | 0777);
+
+	TST_EXP_PASS(fchmodat2(fd_dir, SNAME, 0640, AT_SYMLINK_NOFOLLOW));
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
+	TST_EXP_PASS(fchmodat2(fd, "", 0777, AT_EMPTY_PATH));
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
