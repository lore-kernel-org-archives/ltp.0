Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E37C3DA49
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 08:56:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C1923D3843
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 10:56:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1FF93D0B06
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 10:54:46 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B496B6011DF
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 10:54:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A96161FE4D;
 Wed, 10 Jul 2024 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720601684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYbVQnZi13K/LbddZtIfT3lBlH5wNqcjmafdC96Z/bg=;
 b=gJGoUXknHwua1keqlw1dTGbg06m0hp/KGXVJ3dykg/yPgFMoHZQawCW1lI7UX2cQN0Qrdv
 j/wFLE3xDzPXJ8JO8sx4lYlGipxJ4xUASRG7S3eLKtnHvFPzn8bMFmqf0dfVQtQsA+o7c7
 gjPyQYo76rCwsP8t+FydjZ28B9G91Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720601684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYbVQnZi13K/LbddZtIfT3lBlH5wNqcjmafdC96Z/bg=;
 b=m/BuRbJzUZ3Bu4nJP5sMoDGRQ5qQkleYalW2fh0P2An4zeDlp9xqt6QbYRfxwXY+4x03bR
 YoIkbGb6nIkXKzDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gJGoUXkn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="m/BuRbJz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720601684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYbVQnZi13K/LbddZtIfT3lBlH5wNqcjmafdC96Z/bg=;
 b=gJGoUXknHwua1keqlw1dTGbg06m0hp/KGXVJ3dykg/yPgFMoHZQawCW1lI7UX2cQN0Qrdv
 j/wFLE3xDzPXJ8JO8sx4lYlGipxJ4xUASRG7S3eLKtnHvFPzn8bMFmqf0dfVQtQsA+o7c7
 gjPyQYo76rCwsP8t+FydjZ28B9G91Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720601684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYbVQnZi13K/LbddZtIfT3lBlH5wNqcjmafdC96Z/bg=;
 b=m/BuRbJzUZ3Bu4nJP5sMoDGRQ5qQkleYalW2fh0P2An4zeDlp9xqt6QbYRfxwXY+4x03bR
 YoIkbGb6nIkXKzDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8545B1369A;
 Wed, 10 Jul 2024 08:54:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8KhHH1RMjmbFTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 08:54:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 10:54:24 +0200
MIME-Version: 1.0
Message-Id: <20240710-stat04-v3-4-c68a2324ad94@suse.com>
References: <20240710-stat04-v3-0-c68a2324ad94@suse.com>
In-Reply-To: <20240710-stat04-v3-0-c68a2324ad94@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3431;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=P5RLLxA0jMof5HlQCNs8IhSfWxblq/Ki/8YR/W+J80Q=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjkxIO6QvRV6G7PwSM5i3gJqLCpMeaR9knQhnb
 to/mUDcMcuJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo5MSAAKCRDLzBqyILPm
 Rm0LC/9TvMdj7aHxnTABENwn2ZNgbypqkElWHtcH1AegJsSpGG0NMSokpBnzFpkRH6jKWeaX/Gc
 fomOa6YANUySW+BOO3x9yq3jqzUHnryQmLjBE2E8oNucyPeOEx5/cHXdcdppMQgsiutggrKp40D
 CcJ4cAuvMI3jDN1ucloExp0Qt++lVS2dbXxL6sMbRCbZP3ofvUwIUXtPhDZvDTqi6YYP/XisS5Y
 sLj11ykxPuT+sciI4eBupxBwZm2zPdHcXV8sPmJBA2F8OKoiOmxbma8A2gOeV06iCLdbyH+uIN5
 G5C3MX1OpZkeolwxRsBM7usv1mI0jGhE5+1orZKBTeTR8+Zzk8s04+Mk00wQFiUrKehqRUR1qxZ
 ru0T5uulhkkfzt5OCHUP6NfAaWlv9BbV+FHioDeBHsc0JUqT7R9dcn4mkjwqWYoLzNRYpE7Hs66
 HWYjP0F8/8Y9+UOZSTk1cGwzRwmWEOU0WP6l+eXvuMkw5A+47o/i+LPJgUOQCjh/Ej2h4=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Queue-Id: A96161FE4D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/4] Add open15 test
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
 testcases/kernel/syscalls/open/open15.c   | 75 +++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 1 deletion(-)

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
index 000000000..09d7a1f3b
--- /dev/null
+++ b/testcases/kernel/syscalls/open/open15.c
@@ -0,0 +1,75 @@
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
+ * generated files. We generate a file via symlink, then we read both from file
+ * and symlink, comparing that data has been correctly written.
+ */
+
+#include "tst_test.h"
+
+#define FILENAME "myfile.txt"
+#define SYMBNAME "myfile_symlink"
+#define BIG_STRING "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz"
+
+static char buff_file[128];
+static char buff_symb[128];
+static int str_size;
+
+static void run(void)
+{
+	int fd_file, fd_symb;
+
+	memset(buff_file, 0, sizeof(buff_file));
+	memset(buff_symb, 0, sizeof(buff_symb));
+
+	tst_res(TINFO, "Create symlink");
+	SAFE_TOUCH(FILENAME, 0777, NULL);
+	SAFE_SYMLINK(FILENAME, SYMBNAME);
+
+	fd_file = SAFE_OPEN(FILENAME, O_RDONLY, 0777);
+	fd_symb = SAFE_OPEN(SYMBNAME, O_RDWR, 0777);
+
+	tst_res(TINFO, "Write data via symlink");
+	SAFE_WRITE(SAFE_WRITE_ALL, fd_symb, BIG_STRING, str_size);
+	SAFE_LSEEK(fd_symb, 0, 0);
+
+	tst_res(TINFO, "Read data via file");
+	SAFE_READ(1, fd_file, buff_file, str_size);
+	SAFE_LSEEK(fd_file, 0, 0);
+
+	tst_res(TINFO, "Read data via symlink");
+	SAFE_READ(1, fd_symb, buff_symb, str_size);
+	SAFE_LSEEK(fd_symb, 0, 0);
+
+	TST_EXP_EXPR(!strncmp(buff_file, BIG_STRING, str_size),
+		"file data has been correctly written");
+
+	TST_EXP_EXPR(!strncmp(buff_file, buff_symb, str_size),
+		"file data is the equivalent to symlink generated file data");
+
+	SAFE_CLOSE(fd_file);
+	SAFE_CLOSE(fd_symb);
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
