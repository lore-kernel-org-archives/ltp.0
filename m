Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4E4C71153
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 09:45:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E22E3CB8EC
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 11:45:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BBC03CB6F8
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 11:45:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D0E7A600ACD
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 11:45:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C7D6D212AE;
 Mon,  4 Sep 2023 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1693820706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9tPluzmj+CgTgQ+SNnKGFLZi3Jb3PAVJLbtOcHtvUhI=;
 b=mEAL15cJceytCNruwbzur036hpKwudh5IUPwIunxKCYJ6h6MChEoHD80yI4oQwlgXaxZjf
 D2++R71sgwf8IT0BsxM9eskCbdINbxMDuMs/cGStCV2JBxGl+LPv/Mqgdc9/gODFI2aYiX
 l0Hf4sPynsmTGyeP//LwpdTvWqfth/8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2359313425;
 Mon,  4 Sep 2023 09:45:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +PuOOiGn9WRXCAAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 04 Sep 2023 09:45:05 +0000
To: ltp@lists.linux.it
Date: Mon,  4 Sep 2023 05:45:01 -0400
Message-Id: <20230904094501.17371-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230902030354.14107-1-wegao@suse.com>
References: <20230902030354.14107-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] splices06.c: Add splice check on proc files
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
 testcases/kernel/syscalls/splice/splice06.c | 227 ++++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100644 testcases/kernel/syscalls/splice/splice06.c

diff --git a/testcases/kernel/syscalls/splice/splice06.c b/testcases/kernel/syscalls/splice/splice06.c
new file mode 100644
index 000000000..3139d16db
--- /dev/null
+++ b/testcases/kernel/syscalls/splice/splice06.c
@@ -0,0 +1,227 @@
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
+#include <ctype.h>
+
+#include "tst_test.h"
+#include "lapi/splice.h"
+
+#define BUF_SIZE 100
+#define PIPE_MAX_INIT_SIZE 65536
+#define PIPE_MAX_TEST_SIZE 4096
+#define DOMAIN_INIT_NAME "LTP_INIT"
+#define DOMAIN_TEST_NAME "LTP_TEST"
+#define INTEGER_PROCFILE "/proc/sys/fs/pipe-max-size"
+#define STRING_PROCFILE "/proc/sys/kernel/domainname"
+
+static void format_str(char *str)
+{
+	int i;
+
+	for (i = 0; i < BUF_SIZE ; i++) {
+		if (!isdigit(str[i])) {
+			str[i] = '\0';
+			break;
+		}
+	}
+	if (i == BUF_SIZE)
+		tst_brk(TBROK, "can not find nonnumeric character from input string");
+}
+
+static int splice_read_num(const char *file)
+{
+	int pipes[2];
+	int fd_in;
+	int ret;
+	int num;
+	char buf[BUF_SIZE];
+
+	memset(buf, '\0', sizeof(buf));
+	fd_in = SAFE_OPEN(file, O_RDONLY);
+	SAFE_PIPE(pipes);
+
+	ret = splice(fd_in, NULL, pipes[1], NULL, BUF_SIZE - 1, 0);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "splice(fd_in, pipe) failed");
+
+	SAFE_READ(0, pipes[0], buf, BUF_SIZE);
+
+	/* Search for the first nonnumeric character and replace it with \0 */
+	format_str(buf);
+
+	if (tst_parse_int(buf, &num, 0, INT_MAX))
+		tst_brk(TBROK, "Invalid buffer num %s", buf);
+
+	SAFE_CLOSE(fd_in);
+	SAFE_CLOSE(pipes[0]);
+	SAFE_CLOSE(pipes[1]);
+
+	return num;
+}
+
+static char *splice_read_str(const char *file, char *dest)
+{
+	int pipes[2];
+	int fd_in;
+	int ret;
+
+	fd_in = SAFE_OPEN(file, O_RDONLY);
+	SAFE_PIPE(pipes);
+
+	ret = splice(fd_in, NULL, pipes[1], NULL, BUF_SIZE, 0);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "splice(fd_in, pipe) failed");
+
+	SAFE_READ(0, pipes[0], dest, BUF_SIZE);
+
+	SAFE_CLOSE(fd_in);
+	SAFE_CLOSE(pipes[0]);
+	SAFE_CLOSE(pipes[1]);
+
+	return dest;
+}
+
+
+static void splice_write_num(const char *file, int num)
+{
+	int pipes[2];
+	int fd_out;
+	int ret;
+	char buf[BUF_SIZE];
+
+	memset(buf, '\0', sizeof(buf));
+
+	fd_out = SAFE_OPEN(file, O_WRONLY, 0777);
+	SAFE_PIPE(pipes);
+	sprintf(buf, "%d", num);
+
+	SAFE_WRITE(SAFE_WRITE_ALL, pipes[1], buf, strlen(buf));
+
+	ret = splice(pipes[0], NULL, fd_out, NULL, BUF_SIZE, 0);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "splice write failed");
+
+	SAFE_CLOSE(fd_out);
+	SAFE_CLOSE(pipes[0]);
+	SAFE_CLOSE(pipes[1]);
+}
+
+static void splice_write_str(const char *file, char *dest)
+{
+	int pipes[2];
+	int fd_out;
+	int ret;
+
+	fd_out = SAFE_OPEN(file, O_WRONLY, 0777);
+	SAFE_PIPE(pipes);
+
+	SAFE_WRITE(SAFE_WRITE_ALL, pipes[1], dest, strlen(dest));
+
+	ret = splice(pipes[0], NULL, fd_out, NULL, BUF_SIZE, 0);
+	if (ret < 0)
+		tst_brk(TBROK | TERRNO, "splice write failed");
+
+	SAFE_CLOSE(fd_out);
+	SAFE_CLOSE(pipes[0]);
+	SAFE_CLOSE(pipes[1]);
+}
+
+static void file_write_num(const char *file, int num)
+{
+	SAFE_FILE_PRINTF(file, "%d", num);
+}
+
+static void file_write_str(const char *file, char *dest)
+{
+	SAFE_FILE_PRINTF(file, "%s", dest);
+}
+
+static int file_read_num(const char *file)
+{
+	int num;
+
+	SAFE_FILE_SCANF(file, "%d", &num);
+
+	return num;
+}
+
+static char *file_read_str(const char *file, char *dest)
+{
+	SAFE_FILE_SCANF(file, "%s", dest);
+	return dest;
+}
+
+static void splice_test(void)
+{
+
+	char buf_file[BUF_SIZE];
+	char buf_splice[BUF_SIZE];
+
+	if (file_read_num(INTEGER_PROCFILE) == splice_read_num(INTEGER_PROCFILE))
+		tst_res(TPASS, "Read num through splice correctly");
+	else
+		tst_brk(TBROK | TERRNO, "Read num through splice failed");
+
+	splice_write_num(INTEGER_PROCFILE, PIPE_MAX_TEST_SIZE);
+
+	if (file_read_num(INTEGER_PROCFILE) == PIPE_MAX_TEST_SIZE)
+		tst_res(TPASS, "Write num through splice correctly");
+	else
+		tst_brk(TBROK | TERRNO, "Write num through splice failed");
+
+	memset(buf_file, '\0', sizeof(buf_file));
+	memset(buf_splice, '\0', sizeof(buf_splice));
+
+	file_read_str(STRING_PROCFILE, buf_file);
+	splice_read_str(STRING_PROCFILE, buf_splice);
+
+	if (!strncmp(buf_file, buf_splice, strlen(buf_file)))
+		tst_res(TPASS, "Read string through splice correctly");
+	else
+		tst_brk(TBROK | TERRNO, "Read string through splice failed");
+
+	memset(buf_file, '\0', sizeof(buf_file));
+
+	splice_write_str(STRING_PROCFILE, DOMAIN_TEST_NAME);
+	file_read_str(STRING_PROCFILE, buf_file);
+
+	if (!strncmp(buf_file, DOMAIN_TEST_NAME, strlen(buf_file)))
+		tst_res(TPASS, "Write string through splice correctly");
+	else
+		tst_brk(TBROK | TERRNO, "Write string through splice failed");
+}
+
+static void setup(void)
+{
+	file_write_str(STRING_PROCFILE, DOMAIN_INIT_NAME);
+	file_write_num(STRING_PROCFILE, PIPE_MAX_INIT_SIZE);
+}
+
+static struct tst_test test = {
+	.min_kver = "5.11",
+	.setup = setup,
+	.test_all = splice_test,
+	.needs_tmpdir = 1,
+	.save_restore = (const struct tst_path_val[]) {
+		{INTEGER_PROCFILE, NULL, TST_SR_TCONF},
+		{STRING_PROCFILE, NULL, TST_SR_TCONF},
+		{}
+	},
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
