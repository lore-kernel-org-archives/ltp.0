Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41C7C369D5
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 14:45:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59D7C3CBB9D
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 16:45:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C87533CBBC5
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 16:44:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CE5DB6008FF
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 16:44:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4DDDE1F391;
 Mon, 28 Apr 2025 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745851444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hg4kXGvQ5FTPrBuGt0y2fX+3X0hdlH6iIQxBrkdUXWY=;
 b=iqt4zKgwzckgGgnY6MPvzfVHmA1rX7KOqKKHyCTpvC+nbml1oMeyKlwzzKZc+zNo/UuxbC
 ZsWlRhG8SdqM+CSc4b0/2qAaqjOH4cg7Rtcxozn1ySewD0dzHx9zet9KPkGljmWqOaxwh0
 boVZrVif9RUwJ4gGXuiYGeVb38dN4yI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745851444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hg4kXGvQ5FTPrBuGt0y2fX+3X0hdlH6iIQxBrkdUXWY=;
 b=qO1Us2vrR/zGbO5H15Q+DVGOwHRaSZj+nK6JD9aiLChRTbQvM5qxubim7cXLbP+0tVZHFY
 Qz4MadO9TUkhIhDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745851444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hg4kXGvQ5FTPrBuGt0y2fX+3X0hdlH6iIQxBrkdUXWY=;
 b=iqt4zKgwzckgGgnY6MPvzfVHmA1rX7KOqKKHyCTpvC+nbml1oMeyKlwzzKZc+zNo/UuxbC
 ZsWlRhG8SdqM+CSc4b0/2qAaqjOH4cg7Rtcxozn1ySewD0dzHx9zet9KPkGljmWqOaxwh0
 boVZrVif9RUwJ4gGXuiYGeVb38dN4yI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745851444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hg4kXGvQ5FTPrBuGt0y2fX+3X0hdlH6iIQxBrkdUXWY=;
 b=qO1Us2vrR/zGbO5H15Q+DVGOwHRaSZj+nK6JD9aiLChRTbQvM5qxubim7cXLbP+0tVZHFY
 Qz4MadO9TUkhIhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 177B613A25;
 Mon, 28 Apr 2025 14:44:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aLcTBDSUD2ioegAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 28 Apr 2025 14:44:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 28 Apr 2025 16:44:00 +0200
MIME-Version: 1.0
Message-Id: <20250428-lsm-v3-5-33a4caa9aaf2@suse.com>
References: <20250428-lsm-v3-0-33a4caa9aaf2@suse.com>
In-Reply-To: <20250428-lsm-v3-0-33a4caa9aaf2@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745851441; l=3097;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=4UHgKnxWhbTqy2Bk+7MqdzrFgTA+QRRywVAzAHXylsg=;
 b=QpE7Glyd2hS1/fU0OtRSHcCpExWn6o3xoKysAhcen8eT9sbWZvAGO0OlgEuPTm7uK2BbfjQlm
 nMaZ6z+qZX8Ctd47nTK05vaL0wnvOUS935lf+hUjcQwS/PcSfudROeK
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:mid, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 5/7] Add lsm_list_modules01 test
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
