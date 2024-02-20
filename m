Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBA0C5475B
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 13:33:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B63F3CF1E7
	for <ltp@archiver.kernel.org>; Tue, 20 Feb 2024 14:33:18 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A33C43C601B
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 14:33:03 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7A95460045C
 for <ltp@lists.linux.it>; Tue, 20 Feb 2024 14:33:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9F25621E1D;
 Tue, 20 Feb 2024 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708435979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5JGb/jlxnKeCi57dKWiOjOfid3ThYlcv92KWGSOzWlc=;
 b=ZrtTzac1uIqZnxWb0FU+by6RRn1WP+Zh4dhboqdW70J7ro1dNC0HkGnyx5f7KV9tmLbPQj
 S9dcPIKM7oRCnCclZgjPi5MjGZeHwS9gAAyO0HfPcPgTsYWcYYJVUgHwvapRIlA4tXjghr
 f5BVxqNt+yKF4hrGfpASfohIQG3UKiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708435979;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5JGb/jlxnKeCi57dKWiOjOfid3ThYlcv92KWGSOzWlc=;
 b=HkbU6w/De2senLr1NTmz6Cxxzb+qTZ3iqvbTMHFqGpcjKbb4LtJVaY6mZF0StHQKM04D+1
 IERCR2dPRfvTOBCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708435979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5JGb/jlxnKeCi57dKWiOjOfid3ThYlcv92KWGSOzWlc=;
 b=ZrtTzac1uIqZnxWb0FU+by6RRn1WP+Zh4dhboqdW70J7ro1dNC0HkGnyx5f7KV9tmLbPQj
 S9dcPIKM7oRCnCclZgjPi5MjGZeHwS9gAAyO0HfPcPgTsYWcYYJVUgHwvapRIlA4tXjghr
 f5BVxqNt+yKF4hrGfpASfohIQG3UKiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708435979;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=5JGb/jlxnKeCi57dKWiOjOfid3ThYlcv92KWGSOzWlc=;
 b=HkbU6w/De2senLr1NTmz6Cxxzb+qTZ3iqvbTMHFqGpcjKbb4LtJVaY6mZF0StHQKM04D+1
 IERCR2dPRfvTOBCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67B88134E4;
 Tue, 20 Feb 2024 13:32:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BexHFguq1GXsJwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Feb 2024 13:32:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue, 20 Feb 2024 14:32:54 +0100
Message-Id: <20240220133254.16057-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZrtTzac1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="HkbU6w/D"
X-Spamd-Result: default: False [1.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9F25621E1D
X-Spamd-Bar: +
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add open15 test
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

This test has been extracted from symlink01 and it verifies that
open() is working correctly on symlink() generated files.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                          |   2 +-
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open15.c   | 101 ++++++++++++++++++++++
 3 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/open/open15.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7794f1465..d430446aa 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -922,7 +922,6 @@ nice04 nice04
 nice05 nice05
 
 open01 open01
-open01A symlink01 -T open01
 open02 open02
 open03 open03
 open04 open04
@@ -935,6 +934,7 @@ open11 open11
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
index 000000000..2bd1ab3ce
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open15.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *    Author: David Fenner
+ *    Copilot: Jon Hendrickson
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that open() is working correctly on symlink()
+ * generated files.
+ */
+
+#include "tst_test.h"
+
+#define BIG_STRING "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
+
+static char myfile_path[PATH_MAX];
+
+static void test_open_symlink(void)
+{
+	int fd;
+	int str_size;
+	char buff[128];
+	char *symname = "my_symlink0";
+
+	str_size = strlen(BIG_STRING);
+
+	SAFE_SYMLINK(myfile_path, symname);
+
+	fd = SAFE_OPEN(symname, O_CREAT | O_RDWR, 0777);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, BIG_STRING, str_size);
+	SAFE_LSEEK(fd, 0, 0);
+	SAFE_READ(1, fd, buff, str_size);
+	SAFE_CLOSE(fd);
+
+	TST_EXP_EXPR(!strncmp(buff, BIG_STRING, str_size),
+		"symlink generated file can be opened to write data");
+
+	SAFE_UNLINK(symname);
+	remove(myfile_path);
+}
+
+static void test_open_compare(void)
+{
+	int fd_file, fd_symlink;
+	int str_size;
+	char buff_file[128];
+	char buff_symlink[128];
+	char *symname = "my_symlink1";
+
+	str_size = strlen(BIG_STRING);
+
+	fd_file = SAFE_OPEN(myfile_path, O_CREAT | O_RDWR, 0777);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_file, BIG_STRING, str_size);
+
+	SAFE_SYMLINK(myfile_path, symname);
+
+	SAFE_LSEEK(fd_file, 0, 0);
+	SAFE_READ(1, fd_file, buff_file, str_size);
+
+	fd_symlink = SAFE_OPEN(symname, O_RDWR, 0777);
+	SAFE_LSEEK(fd_symlink, 0, 0);
+	SAFE_READ(1, fd_symlink, buff_symlink, str_size);
+
+	TST_EXP_EXPR(!strncmp(buff_file, buff_symlink, str_size),
+		"file data is the equivalent to symlink generated file data");
+
+	SAFE_CLOSE(fd_file);
+	SAFE_CLOSE(fd_symlink);
+
+	SAFE_UNLINK(symname);
+	remove(myfile_path);
+}
+
+static void setup(void)
+{
+	int size;
+	char *tmpdir;
+
+	tmpdir = tst_get_tmpdir();
+	size = strlen(tmpdir);
+
+	myfile_path[size] = '/';
+	memcpy(myfile_path, tmpdir, size);
+	memcpy(myfile_path + size + 1, "myfile.txt", 6);
+}
+
+static void run(void)
+{
+	test_open_symlink();
+	test_open_compare();
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
