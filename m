Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17F0C54FB3
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 16:43:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 387A83C9E3B
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 18:43:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79ED33C9DE7
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:42:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C80962005F7
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:42:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 17E441F7BB;
 Mon,  2 Jun 2025 16:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748882530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDMusfxCojnGZUMf+dEUVlg8n3XGsnFUQxPzx8Ua7fU=;
 b=sEOi5CCjVexyujMf03mShUiHTWSvxYTQro8WFoLkw3ukc0veXUJsQ0/T+06jPEjVLS3gQf
 oRFUIs18RzC+OhmG1NFUlBGm6a641ysV7u+3xwPz3SDGQ7LacShGFFuCidnLGSXbep0W6A
 J6zRBJKaiBKd1SFOSC6jwXBlFpZMpiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748882530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDMusfxCojnGZUMf+dEUVlg8n3XGsnFUQxPzx8Ua7fU=;
 b=XWOgvZWdtDJjsHO0Ha6GRzixOa3Cs1MFq7YeOf7yAbfSwgBlmY4AOBDyo8K/sEUyv7lTz0
 pgeMfkwoNEv2mpAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sEOi5CCj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XWOgvZWd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748882530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDMusfxCojnGZUMf+dEUVlg8n3XGsnFUQxPzx8Ua7fU=;
 b=sEOi5CCjVexyujMf03mShUiHTWSvxYTQro8WFoLkw3ukc0veXUJsQ0/T+06jPEjVLS3gQf
 oRFUIs18RzC+OhmG1NFUlBGm6a641ysV7u+3xwPz3SDGQ7LacShGFFuCidnLGSXbep0W6A
 J6zRBJKaiBKd1SFOSC6jwXBlFpZMpiU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748882530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pDMusfxCojnGZUMf+dEUVlg8n3XGsnFUQxPzx8Ua7fU=;
 b=XWOgvZWdtDJjsHO0Ha6GRzixOa3Cs1MFq7YeOf7yAbfSwgBlmY4AOBDyo8K/sEUyv7lTz0
 pgeMfkwoNEv2mpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E396613AE7;
 Mon,  2 Jun 2025 16:42:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uOXlNWHUPWgGFwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 02 Jun 2025 16:42:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 02 Jun 2025 18:41:28 +0200
MIME-Version: 1.0
Message-Id: <20250602-lsm-v5-5-5c0dd01df3c4@suse.com>
References: <20250602-lsm-v5-0-5c0dd01df3c4@suse.com>
In-Reply-To: <20250602-lsm-v5-0-5c0dd01df3c4@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748882528; l=3097;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=2TP9X2Ieo1Sj4NEAYlMzMFC3krlkdHsYvtSRUp61DCg=;
 b=+4mgFQJokwZDA1esJeX/g/SOte3zX+t22sgoe0Lh3Jv1t19gZImNNS8UBSgdQIds422x6dyuE
 ZVKGFHj9UeXCb1As4au+A997AmPoiWvD3oBWAWERphGi0U8GyBmY/4m
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 17E441F7BB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 ASN(0.00)[asn:9498, ipnet:::/1, country:IN];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 5/7] Add lsm_list_modules01 test
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
index ac3c46ee9f8ae84cbbef18ef0c18bf224dd46964..01129a0bfb0f56098a83176caeb3098e7ddc810d 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -761,6 +761,7 @@ lseek11 lseek11
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
