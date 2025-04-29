Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F40D6C369CB
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 07:25:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 893DF3CBBFD
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 09:25:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C17853CBC08
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:23:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5E9CF2000D4
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:23:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 295171F806;
 Tue, 29 Apr 2025 07:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745911411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hg4kXGvQ5FTPrBuGt0y2fX+3X0hdlH6iIQxBrkdUXWY=;
 b=BhsTc3JZjKslwi4xUSGMfYEv9Mr40C5N+/SyFy1XL8rAWcW3Pd+ilg7XU1/SXjaFTtvz0G
 z9zTpzDaEYzTHd2E4cPvJORf6YXqa7LuwRwb2cBG+JeQFLmxLj6h3jBloO4DHOuKM6e76Q
 l1XtFDwOC11R5MtVN+CgU6+Nytd7zd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745911411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hg4kXGvQ5FTPrBuGt0y2fX+3X0hdlH6iIQxBrkdUXWY=;
 b=iitmbQzDAACYPRlNpjK23SFlIxF0nl0uPgY01SL3DU7Y4vRtO4MVU9ov1nrvEYJAJjZ2s3
 9kXbCp9Hm+voIJDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BhsTc3JZ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=iitmbQzD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745911411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hg4kXGvQ5FTPrBuGt0y2fX+3X0hdlH6iIQxBrkdUXWY=;
 b=BhsTc3JZjKslwi4xUSGMfYEv9Mr40C5N+/SyFy1XL8rAWcW3Pd+ilg7XU1/SXjaFTtvz0G
 z9zTpzDaEYzTHd2E4cPvJORf6YXqa7LuwRwb2cBG+JeQFLmxLj6h3jBloO4DHOuKM6e76Q
 l1XtFDwOC11R5MtVN+CgU6+Nytd7zd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745911411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hg4kXGvQ5FTPrBuGt0y2fX+3X0hdlH6iIQxBrkdUXWY=;
 b=iitmbQzDAACYPRlNpjK23SFlIxF0nl0uPgY01SL3DU7Y4vRtO4MVU9ov1nrvEYJAJjZ2s3
 9kXbCp9Hm+voIJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 076531340C;
 Tue, 29 Apr 2025 07:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cPEvAHN+EGgbcAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 29 Apr 2025 07:23:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Apr 2025 09:18:34 +0200
MIME-Version: 1.0
Message-Id: <20250429-lsm-v4-5-602b7097e722@suse.com>
References: <20250429-lsm-v4-0-602b7097e722@suse.com>
In-Reply-To: <20250429-lsm-v4-0-602b7097e722@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745911410; l=3097;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=4UHgKnxWhbTqy2Bk+7MqdzrFgTA+QRRywVAzAHXylsg=;
 b=LL/GTNSx7XGsI0AfNZolzFdlVnulIcUmzHmm4SI6QkwJGxuqDsmtGjuf1oP3WiZDi48Cn4r6Q
 96Cn0F5JnzvBQYx0lledZP/oAAbj90IO0DMydVXQhlpmMEdI12PveRn
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 295171F806
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.de:dkim,suse.com:mid,suse.com:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 5/7] Add lsm_list_modules01 test
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

Verify that lsm_list_modules syscall is raising errors when invalid
data is provided.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/lsm/.gitignore           |  1 +
 testcases/kernel/syscalls/lsm/lsm_list_modules01.c | 75 ++++++++++++++++++++++
 3 files changed, 77 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index d45cda4082ed87bf674ca34d315af9c162a41fe9..c8a9dbeacbae7a6badc705b7e648dbc7a020742f 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -762,6 +762,7 @@ lseek11 lseek11
 lsm_get_self_attr01 lsm_get_self_attr01
 lsm_get_self_attr02 lsm_get_self_attr02
 lsm_get_self_attr03 lsm_get_self_attr03
+lsm_list_modules01 lsm_list_modules01
 
 lstat01 lstat01
 lstat01_64 lstat01_64
diff --git a/testcases/kernel/syscalls/lsm/.gitignore b/testcases/kernel/syscalls/lsm/.gitignore
index 19956fdf8b9952b4850c3a20826e29ec67ea3560..501d332549a84cceb9741346bdb8b83eb02467c5 100644
--- a/testcases/kernel/syscalls/lsm/.gitignore
+++ b/testcases/kernel/syscalls/lsm/.gitignore
@@ -1,3 +1,4 @@
 lsm_get_self_attr01
 lsm_get_self_attr02
 lsm_get_self_attr03
+lsm_list_modules01
diff --git a/testcases/kernel/syscalls/lsm/lsm_list_modules01.c b/testcases/kernel/syscalls/lsm/lsm_list_modules01.c
new file mode 100644
index 0000000000000000000000000000000000000000..51ff5abe151f06d2aa6e3d19c722eb40e77c822c
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_list_modules01.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that lsm_list_modules syscall is raising errors when invalid data is
+ * provided.
+ */
+
+#include "lsm_common.h"
+
+#define MAX_LSM_NUM 32
+
+static uint64_t lsm_ids[MAX_LSM_NUM];
+static uint32_t page_size;
+static uint32_t ids_size;
+static uint32_t ids_size_small;
+
+static struct tcase {
+	uint64_t *ids;
+	uint32_t *size;
+	uint32_t flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{
+		.size = &ids_size,
+		.exp_errno = EFAULT,
+		.msg = "ids is NULL",
+	},
+	{
+		.ids = lsm_ids,
+		.exp_errno = EFAULT,
+		.msg = "size is NULL",
+	},
+	{
+		.ids = lsm_ids,
+		.size = &ids_size_small,
+		.exp_errno = E2BIG,
+		.msg = "size is too small",
+	},
+	{
+		.ids = lsm_ids,
+		.size = &ids_size,
+		.flags = 1,
+		.exp_errno = EINVAL,
+		.msg = "flags must be zero",
+	},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	memset(lsm_ids, 0, sizeof(lsm_ids));
+	ids_size = page_size;
+	ids_size_small = 0;
+
+	TST_EXP_FAIL(lsm_list_modules(tc->ids, tc->size, tc->flags),
+	      tc->exp_errno,
+	      "%s", tc->msg);
+}
+
+static void setup(void)
+{
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.min_kver = "6.8",
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
