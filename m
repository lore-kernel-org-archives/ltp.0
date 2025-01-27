Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBF3C02188
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 14:10:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20A383C2C4A
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 15:10:22 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3D003C2C45
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:29 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 672191BD3404
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 15:08:29 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5BA0A2115D
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0OBcNUEnTdNbd9TmwlUODkNr1mZie81BsQy7hW600w=;
 b=B/cyafWka1Og3PO2mUIersL9NsLXRVQRyld5dGpTQOsk0tmJkqZ2+D6Y9bTn90DegKayHT
 iTf39s0DRDKzBzp4UQU1YN0YjNgzCIkLNjHRT31TY5OuT4U6bh2wVtWpOsKlzO98i0ID4N
 jqTFtZ+1B2auI1UfqqRDWipNjv73B5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0OBcNUEnTdNbd9TmwlUODkNr1mZie81BsQy7hW600w=;
 b=jp15vniDQdALmeuOAujGoaJfTx5JZeLEI2hVcfoFcAhzbElULidiR0uGLP7xdfnBQIwFjJ
 SBVXrbPZjY43WtBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="B/cyafWk";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jp15vniD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737986908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0OBcNUEnTdNbd9TmwlUODkNr1mZie81BsQy7hW600w=;
 b=B/cyafWka1Og3PO2mUIersL9NsLXRVQRyld5dGpTQOsk0tmJkqZ2+D6Y9bTn90DegKayHT
 iTf39s0DRDKzBzp4UQU1YN0YjNgzCIkLNjHRT31TY5OuT4U6bh2wVtWpOsKlzO98i0ID4N
 jqTFtZ+1B2auI1UfqqRDWipNjv73B5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737986908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0OBcNUEnTdNbd9TmwlUODkNr1mZie81BsQy7hW600w=;
 b=jp15vniDQdALmeuOAujGoaJfTx5JZeLEI2hVcfoFcAhzbElULidiR0uGLP7xdfnBQIwFjJ
 SBVXrbPZjY43WtBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4634F13AAD
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8I5YD1yTl2dfZQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 14:08:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 27 Jan 2025 15:08:26 +0100
MIME-Version: 1.0
Message-Id: <20250127-xattrat-v1-8-c3ee31e2543b@suse.com>
References: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
In-Reply-To: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737986906; l=3805;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=OZ+sOLT1mc0kB8dtPDlb27y0JnzJ5sNTZ5FEm7GFiZ8=;
 b=IF89MwUslZAumKE0evV9V7eiogZsApASUPo3Jd9TU0RcBE5OcNSaaJsHY6jZlT+KvIXZrSQVM
 HL0AHoNHqrTDrzMAIQUBCTtwZEjh2USPv/Bt+yVV/r+i57vjLbu/hR1
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 5BA0A2115D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 8/8] Add setxattrat02 test
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

Test if setxattrat() syscall is correctly raising errors when giving
invalid inputs.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/setxattrat/.gitignore    |   1 +
 .../kernel/syscalls/setxattrat/setxattrat02.c      | 126 +++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/testcases/kernel/syscalls/setxattrat/.gitignore b/testcases/kernel/syscalls/setxattrat/.gitignore
index e636401d7ac3ed58c5f9a24ad31291f0dc1c9ae7..9d007a44dfca6e06cdb5b368201921461c68684d 100644
--- a/testcases/kernel/syscalls/setxattrat/.gitignore
+++ b/testcases/kernel/syscalls/setxattrat/.gitignore
@@ -1 +1,2 @@
 setxattrat01
+setxattrat02
diff --git a/testcases/kernel/syscalls/setxattrat/setxattrat02.c b/testcases/kernel/syscalls/setxattrat/setxattrat02.c
new file mode 100644
index 0000000000000000000000000000000000000000..7891dc9e5f7c051c8413cfea677417d7edd8bef5
--- /dev/null
+++ b/testcases/kernel/syscalls/setxattrat/setxattrat02.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test if setxattrat() syscall is correctly raising errors when giving invalid
+ * inputs.
+ */
+
+#include <sys/xattr.h>
+
+#include "tst_test.h"
+#include "lapi/xattr.h"
+#include "lapi/syscalls.h"
+
+#define FNAME "ltp_file"
+#define XATTR_TEST_KEY "trusted.ltptestkey"
+#define XATTR_TEST_VALUE "ltprulez"
+#define XATTR_TEST_VALUE_SIZE 8
+
+static struct xattr_args *args;
+static struct xattr_args *null_args;
+static int invalid_fd = -1;
+static int tmpdir_fd = -1;
+
+static struct tcase {
+	int *dfd;
+	int at_flags;
+	struct xattr_args **args;
+	size_t args_size;
+	int exp_errno;
+	char *reason;
+} tcases[] = {
+	{
+		.dfd = &invalid_fd,
+		.args = &args,
+		.args_size = sizeof(struct xattr_args),
+		.exp_errno = EBADF,
+		.reason = "Invalid directory file descriptor",
+	},
+	{
+		.dfd = &tmpdir_fd,
+		.at_flags = -1,
+		.args = &args,
+		.args_size = sizeof(struct xattr_args),
+		.exp_errno = EINVAL,
+		.reason = "Invalid AT flags",
+	},
+	{
+		.dfd = &tmpdir_fd,
+		.at_flags = AT_SYMLINK_NOFOLLOW + 1,
+		.args = &args,
+		.args_size = sizeof(struct xattr_args),
+		.exp_errno = EINVAL,
+		.reason = "Out of bound AT flags",
+	},
+	{
+		.dfd = &tmpdir_fd,
+		.args = &null_args,
+		.args_size = sizeof(struct xattr_args),
+		.exp_errno = EINVAL,
+		.reason = "Invalid arguments",
+	},
+	{
+		.dfd = &tmpdir_fd,
+		.args = &args,
+		.args_size = SIZE_MAX,
+		.exp_errno = E2BIG,
+		.reason = "Arguments size is too big",
+	},
+	{
+		.dfd = &tmpdir_fd,
+		.args = &args,
+		.args_size = sizeof(struct xattr_args) - 1,
+		.exp_errno = EINVAL,
+		.reason = "Invalid arguments size",
+	},
+};
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	args->flags = XATTR_CREATE;
+	args->value = XATTR_TEST_VALUE;
+	args->size = XATTR_TEST_VALUE_SIZE;
+
+	TST_EXP_FAIL(tst_syscall(__NR_setxattrat,
+		tc->dfd, FNAME, tc->at_flags, XATTR_TEST_KEY,
+		tc->args, tc->args_size),
+		tc->exp_errno, "%s", tc->reason);
+}
+
+static void setup(void)
+{
+	char *tmpdir;
+
+	tmpdir = tst_tmpdir_path();
+	tmpdir_fd = SAFE_OPEN(tmpdir, O_DIRECTORY);
+
+	SAFE_TOUCH(FNAME, 0777, NULL);
+}
+
+static void cleanup(void)
+{
+	if (tmpdir_fd != -1)
+		SAFE_CLOSE(tmpdir_fd);
+
+	SAFE_UNLINK(FNAME);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&args, .size = sizeof(struct xattr_args)},
+		{},
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
