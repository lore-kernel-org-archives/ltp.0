Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 175DDC3065C
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 14:14:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 961D43D3EE9
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 16:14:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA3413D3ED5
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 16:13:19 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2B37D14052CB
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 16:13:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D17F121B2E;
 Tue,  2 Jul 2024 14:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719929596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vMDzcoYDaZeU5RZ4E0ow0csLAaSB7Ye0+E90p+9uqE=;
 b=xhFEJ2PB55SwnMRtNnfA5KWHDlBLkZuJ7UHaABeQ1lnO3TCyru7VYMD5pOpFCxUkT78w7G
 Iq0C4RlNIDtBJi+TrUGSasvAWoglK/wTWFimRrdSctMBRjwfhFGWrV2/7nWTl0Q1GFGGNP
 /2hy+jEylxFoMSKG7ymsS1gIUS17/l0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719929596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vMDzcoYDaZeU5RZ4E0ow0csLAaSB7Ye0+E90p+9uqE=;
 b=x5eV/pqtg1DvurT4HWxuxvxp4kqMDzn7aJlMJVx8UODUpRbuZiYwgVvty172HVcFRYehxy
 qqm+edNEHLN8QmAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xhFEJ2PB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="x5eV/pqt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719929596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vMDzcoYDaZeU5RZ4E0ow0csLAaSB7Ye0+E90p+9uqE=;
 b=xhFEJ2PB55SwnMRtNnfA5KWHDlBLkZuJ7UHaABeQ1lnO3TCyru7VYMD5pOpFCxUkT78w7G
 Iq0C4RlNIDtBJi+TrUGSasvAWoglK/wTWFimRrdSctMBRjwfhFGWrV2/7nWTl0Q1GFGGNP
 /2hy+jEylxFoMSKG7ymsS1gIUS17/l0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719929596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2vMDzcoYDaZeU5RZ4E0ow0csLAaSB7Ye0+E90p+9uqE=;
 b=x5eV/pqtg1DvurT4HWxuxvxp4kqMDzn7aJlMJVx8UODUpRbuZiYwgVvty172HVcFRYehxy
 qqm+edNEHLN8QmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80F4313A9A;
 Tue,  2 Jul 2024 14:13:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OKNqGfwKhGbpDgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 02 Jul 2024 14:13:16 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 02 Jul 2024 16:12:51 +0200
MIME-Version: 1.0
Message-Id: <20240702-stat04-v1-5-e27d9953210d@suse.com>
References: <20240702-stat04-v1-0-e27d9953210d@suse.com>
In-Reply-To: <20240702-stat04-v1-0-e27d9953210d@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3489;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=Arb6LDcOBG1QCRVzf8bKRlgS4kRTDfYhS6Knm48QJ20=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmhArvBFsuFqjfasHuEWLi6vbX0nNVJJGDgoHvg
 13tbX0Pg1GJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZoQK7wAKCRDLzBqyILPm
 RkyXC/9r/zyHqqYzkB87WwEJ2CHG8AsT4fCbgZ+XoBODKuQE/ZFDxrYBZ8QC5FZ0elppjo/gANS
 TrsOwF476g37hPSH2sGeeICVFvHyCnKhBmBF+PFSqL6oLXphepz1NYY1zG5gu9RaB+QeEvlUFSJ
 kS5qM3UTLm05HycEJe2niC1DsHqPH1ejZD1ZrKXQ1a/3JER5vwRHkFTy7vRHByI8OYHHpRlu8al
 KHWj9enMiPgoGKLq360Pc0qZu6rXftglT58vwhCfRxalxTGHk0PqgpFxZTMEqHMd0HEtDrCAKXs
 vOBzQYTZaXUWPv+mQYc+urAv0okcetKmv+TZI8XaWLoOLw6e4ezWbLbq8GkecjTWbJvBkbFN+cD
 4A3x/E2mMSoX7mVOQ5f49VU+/au7SBYscfE1CTg89ZfNM0gCk2g88dn18X0kZpaBWdbS0aucsiV
 xs2inBFyOLFm4GstEGAcOQb0lsHudYb1v7+1YMYKq6klR0FvjbIQVm1NUKbjyUpTLcU/U=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D17F121B2E
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] Add open15 test
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
 runtest/syscalls                          |  2 +-
 testcases/kernel/syscalls/open/.gitignore |  1 +
 testcases/kernel/syscalls/open/open15.c   | 86 +++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index 928e75f9b..47efac158 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -923,7 +923,6 @@ nice04 nice04
 nice05 nice05
 
 open01 open01
-open01A symlink01 -T open01
 open02 open02
 open03 open03
 open04 open04
@@ -936,6 +935,7 @@ open11 open11
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
index 000000000..cbe2d62a4
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open15.c
@@ -0,0 +1,86 @@
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
+#define FILENAME "myfile.txt"
+#define BIG_STRING "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
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
+	SAFE_SYMLINK(FILENAME, symname);
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
+	SAFE_UNLINK(FILENAME);
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
+	fd_file = SAFE_OPEN(FILENAME, O_CREAT | O_RDWR, 0777);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_file, BIG_STRING, str_size);
+
+	SAFE_SYMLINK(FILENAME, symname);
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
+	SAFE_UNLINK(FILENAME);
+}
+
+static void run(void)
+{
+	test_open_symlink();
+	test_open_compare();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
