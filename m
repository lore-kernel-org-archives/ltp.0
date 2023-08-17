Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D79EC2FC04
	for <ltp@archiver.kernel.org>; Thu, 17 Aug 2023 00:40:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A4E33CCF9C
	for <ltp@archiver.kernel.org>; Thu, 17 Aug 2023 02:40:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A0D23CCD4C
 for <ltp@lists.linux.it>; Thu, 17 Aug 2023 02:39:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 63EBC10004A2
 for <ltp@lists.linux.it>; Thu, 17 Aug 2023 02:39:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2D64A2186B;
 Thu, 17 Aug 2023 00:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1692232794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CCOCivgOA95hIMLy7kXW3wmt66ughJdgemLGpSTQdho=;
 b=mEvT6rUcNwlDn861PW1kVNjUg5HSpCsE1aby+55Wwja+kmDfHwTOd25bNLi8KcuiW55jzd
 S7V0WNj3ZQ5SCGHJ5jMKiIjyHmENw6s3iLKbo1Ve7akb8V4zeDpp1auyuWWrot+Rt7OFJZ
 nH3eU2rshfAzToPTooXZtFYT33pKFSU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7748213441;
 Thu, 17 Aug 2023 00:39:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GtgrE1ls3WQvDgAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 17 Aug 2023 00:39:53 +0000
To: ltp@lists.linux.it
Date: Wed, 16 Aug 2023 20:39:47 -0400
Message-Id: <20230817003947.16029-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] splices06.c: Add splice check on proc files
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

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/splice/splice06.c | 134 ++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 testcases/kernel/syscalls/splice/splice06.c

diff --git a/testcases/kernel/syscalls/splice/splice06.c b/testcases/kernel/syscalls/splice/splice06.c
new file mode 100644
index 000000000..f14fd84c5
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice06.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test is cover splice() on proc files.
+ *
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <signal.h>
+#include <sys/types.h>
+#include <fcntl.h>
+
+#include "tst_test.h"
+#include "lapi/splice.h"
+
+#define TEST_BLOCK_SIZE 100
+#define NAME_SPACES_NUM 1024
+#define PROCFILE "/proc/sys/user/max_user_namespaces"
+#define TESTFILE1 "splice_testfile_1"
+#define TESTFILE2 "splice_testfile_2"
+
+static int fd_in, fd_out;
+static int origin_name_spaces_num;
+static char line[TEST_BLOCK_SIZE];
+
+static void splice_file(void)
+{
+	int pipes[2];
+	int ret;
+
+	SAFE_PIPE(pipes);
+
+	ret = splice(fd_in, NULL, pipes[1], NULL, TEST_BLOCK_SIZE, 0);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "splice(fd_in, pipe) failed");
+
+	ret = splice(pipes[0], NULL, fd_out, NULL, TEST_BLOCK_SIZE, 0);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "splice(pipe, fd_out) failed");
+
+	SAFE_CLOSE(fd_in);
+	SAFE_CLOSE(fd_out);
+	SAFE_CLOSE(pipes[0]);
+	SAFE_CLOSE(pipes[1]);
+}
+
+static void set_value(char file[], int num)
+{
+	int fd;
+	int len = snprintf(NULL, 0, "%d", num);
+
+	memset(line, '\0', sizeof(line));
+	sprintf(line, "%d", num);
+
+	fd = SAFE_OPEN(file, O_RDWR | O_CREAT | O_TRUNC, 0777);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, line, len);
+	SAFE_CLOSE(fd);
+}
+
+static int get_value(char file[])
+{
+	int fd, num, ret;
+
+	memset(line, '\0', sizeof(line));
+
+	fd = SAFE_OPEN(file, O_RDONLY);
+	SAFE_READ(0, fd, line, TEST_BLOCK_SIZE);
+	SAFE_CLOSE(fd);
+
+	ret = sscanf(line, "%d", &num);
+	if (ret == EOF)
+		tst_brk(TBROK | TERRNO, "sscanf error");
+
+	return num;
+}
+
+static void splice_test(void)
+{
+
+	int name_spaces_num_setting = get_value(PROCFILE);
+
+	fd_in = SAFE_OPEN(PROCFILE, O_RDONLY);
+	fd_out = SAFE_OPEN(TESTFILE2, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	splice_file();
+
+	if (name_spaces_num_setting == get_value(TESTFILE2))
+		tst_res(TPASS, "Written data has been read back correctly");
+	else
+		tst_brk(TBROK | TERRNO, "Written data has been read back failed");
+
+	if (get_value(PROCFILE) != NAME_SPACES_NUM)
+		name_spaces_num_setting = NAME_SPACES_NUM;
+	else
+		name_spaces_num_setting = NAME_SPACES_NUM + 1;
+
+	set_value(TESTFILE1, name_spaces_num_setting);
+
+	fd_in = SAFE_OPEN(TESTFILE1, O_RDONLY, 0777);
+	fd_out = SAFE_OPEN(PROCFILE, O_WRONLY, 0777);
+
+	splice_file();
+
+	if (name_spaces_num_setting == get_value(PROCFILE))
+		tst_res(TPASS, "Written data has been written correctly");
+	else
+		tst_brk(TBROK | TERRNO, "Written data has been written failed");
+}
+
+static void setup(void)
+{
+	origin_name_spaces_num = get_value(PROCFILE);
+}
+
+static void cleanup(void)
+{
+	set_value(PROCFILE, origin_name_spaces_num);
+}
+
+static struct tst_test test = {
+	.min_kver = "5.11",
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = splice_test,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
