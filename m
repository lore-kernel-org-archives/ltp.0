Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0609C2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 10:47:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 72E723D3960
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 12:47:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41DFF3D0CD5
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:45:58 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9EFAA200345
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:45:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 218B821BAD;
 Tue,  9 Jul 2024 10:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720521957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvdwezHHI8oGFCS9iqYbQc4mtSoi54JTgoZBOm8S68I=;
 b=Y74anJWlLrWmc/OJehevBHd8Il37HYa3p+BthhvBWrQzjBMOKrJ3s8wjWYdApkJKaE/Mp9
 pn7nPWt3SzlG3eLdXRVr2sciMZ7KmM1FnZ9zNem0yD4ja2hXcPgC6LQ/s6kVpJj3YJc0g5
 kBrEmhBtD3FE1lzR2igNXyNxTQdi1Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720521957;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvdwezHHI8oGFCS9iqYbQc4mtSoi54JTgoZBOm8S68I=;
 b=3e6NdGsNevimFwYZGa/WOpC1otDfQZlIkbm6KYs67aXggE3J5jh+Xfai+FHuKHz8RwzSAx
 Zr7QTokZCtH4XUDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720521957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvdwezHHI8oGFCS9iqYbQc4mtSoi54JTgoZBOm8S68I=;
 b=Y74anJWlLrWmc/OJehevBHd8Il37HYa3p+BthhvBWrQzjBMOKrJ3s8wjWYdApkJKaE/Mp9
 pn7nPWt3SzlG3eLdXRVr2sciMZ7KmM1FnZ9zNem0yD4ja2hXcPgC6LQ/s6kVpJj3YJc0g5
 kBrEmhBtD3FE1lzR2igNXyNxTQdi1Uk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720521957;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvdwezHHI8oGFCS9iqYbQc4mtSoi54JTgoZBOm8S68I=;
 b=3e6NdGsNevimFwYZGa/WOpC1otDfQZlIkbm6KYs67aXggE3J5jh+Xfai+FHuKHz8RwzSAx
 Zr7QTokZCtH4XUDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02D3A13A7B;
 Tue,  9 Jul 2024 10:45:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uBYuOuQUjWaBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 09 Jul 2024 10:45:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 09 Jul 2024 12:45:35 +0200
MIME-Version: 1.0
Message-Id: <20240709-stat04-v2-5-2693a473a2ab@suse.com>
References: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
In-Reply-To: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2999;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=2Nf0RyMqleC4S5IlDwzmoHbA19+QuywOVkg32r65iTI=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjRTX5PgygIYM4Aq8pQP7ouYsFmAUt8Ltilfoy
 sBqauccQnGJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo0U1wAKCRDLzBqyILPm
 RueXC/95cqCjZcLGF3/taCd7d5+G304zyyUPD752lWWMBU892TY7Y3H81XwXBtG0mLzgWKpwvAh
 Oy1D8IzKb3Ulqx15cx4VpXun6QZeqdsBn+E/+CIrPTyLztJ5tWVyhvlcCWHwCOq+PkNdQ40j1PB
 HNgYdXfE66sj5mFob8303dx6r7sr8Ue9/mqC6Zq6LvI0hSj0TH03Aq+0L137SOZQ02CDFh596AF
 +9WoPHYFxUZlidKwgDnpKbqblvZV/wG5tErTxfhguU6IoMfl/NtmS4suaSYaBxTfV4ZTXf/70nE
 VOlesb/MKCCO9JFLdNa0QD0a66oi73ba2kgu+ulTl5Je/sJ1Jm6X9DWa4AMXSUVLs0grYyBqOwL
 bymx2vNfjxk+eRuNF1v4jUm8tKVIzA7oFtIGhVttyf/7usZcvJIB+oaUhkekTez9NboHpGJhktn
 D0C0iqj3Q4R7HixvCi2hQ1bpxLcTJ8sRDQGPJ3z98C9Ld5ssuztbnDtX6z9mGyvmWlG6E=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 5/5] Add open15 test
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
 testcases/kernel/syscalls/open/open15.c   | 64 +++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/runtest/syscalls b/runtest/syscalls
index 40c0dd070..4dfdf3782 100644
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
index 000000000..4ad7292ae
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open15.c
@@ -0,0 +1,64 @@
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
+#define SYMBNAME "myfile_symlink"
+#define BIG_STRING "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
+
+static char buff_file[128];
+static char buff_symlink[128];
+static int str_size;
+
+static void run(void)
+{
+	int fd_file, fd_symlink;
+
+	memset(buff_file, 0, sizeof(buff_file));
+	memset(buff_symlink, 0, sizeof(buff_symlink));
+
+	fd_file = SAFE_OPEN(FILENAME, O_CREAT | O_RDWR, 0777);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_file, BIG_STRING, str_size);
+
+	SAFE_SYMLINK(FILENAME, SYMBNAME);
+
+	SAFE_LSEEK(fd_file, 0, 0);
+	SAFE_READ(1, fd_file, buff_file, str_size);
+
+	fd_symlink = SAFE_OPEN(SYMBNAME, O_RDWR, 0777);
+	SAFE_LSEEK(fd_symlink, 0, 0);
+	SAFE_READ(1, fd_symlink, buff_symlink, str_size);
+
+	TST_EXP_EXPR(!strncmp(buff_file, buff_symlink, str_size),
+		"file data is the equivalent to symlink generated file data");
+
+	SAFE_CLOSE(fd_file);
+	SAFE_CLOSE(fd_symlink);
+
+	SAFE_UNLINK(SYMBNAME);
+	SAFE_UNLINK(FILENAME);
+}
+
+static void setup(void)
+{
+	str_size = strlen(BIG_STRING);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.needs_tmpdir = 1,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
