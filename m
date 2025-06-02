Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDA3C54FB3
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 16:43:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 778D83C9DED
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 18:43:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6EF043C9E17
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:42:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9CEEC1A00F03
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:42:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B7800219CA;
 Mon,  2 Jun 2025 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748882529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEqYzFbVuoV9MSL8OiFL2QPMUlzStV9yewEZIkdVHa8=;
 b=qEcXt4HeAnMl6lHoeFILncz60syFGefx2gVRyPAeoZSAdGimkDlEG0h0GMgd3wBFNPRKdD
 FLTsZWjEawilYm7IP5Xl4vIk6V875FFShn7R/sgBRkg76djxDVzfp9mbl8gBmwargcAz5a
 E0sLWwMehz6mfn7ASpqXNw7JsI/fyA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748882529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEqYzFbVuoV9MSL8OiFL2QPMUlzStV9yewEZIkdVHa8=;
 b=M3n5e5iFDMKKAUMcimJeNMcmCUwUrFC71DiL+BonO+FbPGsIYbcAfFdroGZRRJODY6liYt
 5h9ZLtL+RaE9l8Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748882529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEqYzFbVuoV9MSL8OiFL2QPMUlzStV9yewEZIkdVHa8=;
 b=qEcXt4HeAnMl6lHoeFILncz60syFGefx2gVRyPAeoZSAdGimkDlEG0h0GMgd3wBFNPRKdD
 FLTsZWjEawilYm7IP5Xl4vIk6V875FFShn7R/sgBRkg76djxDVzfp9mbl8gBmwargcAz5a
 E0sLWwMehz6mfn7ASpqXNw7JsI/fyA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748882529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mEqYzFbVuoV9MSL8OiFL2QPMUlzStV9yewEZIkdVHa8=;
 b=M3n5e5iFDMKKAUMcimJeNMcmCUwUrFC71DiL+BonO+FbPGsIYbcAfFdroGZRRJODY6liYt
 5h9ZLtL+RaE9l8Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90D7E13AE7;
 Mon,  2 Jun 2025 16:42:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WGOlIWHUPWgGFwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 02 Jun 2025 16:42:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 02 Jun 2025 18:41:26 +0200
MIME-Version: 1.0
Message-Id: <20250602-lsm-v5-3-5c0dd01df3c4@suse.com>
References: <20250602-lsm-v5-0-5c0dd01df3c4@suse.com>
In-Reply-To: <20250602-lsm-v5-0-5c0dd01df3c4@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748882528; l=3010;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=mx1VVydSmiLqwerV5U/GjXojQKsNrOpjDEw5WlYNjh8=;
 b=lIfWmmj8eTzg2qpBLRp9BgFBwdfoW5ko3AfFrRyd2oFjNY5BZxaoOWgE3GzmD76GelXy1PISK
 bPQgLxyTTRqBHfY5fcBP3muGdAM9tOZtWqQtKqrLm3cezG09/ca9Scm
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/7] Add lsm_get_self_attr02 test
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

Verify that lsm_get_self_attr syscall is acting correctly when ctx
is NULL. The syscall can behave in different ways according to the
current system status:

- if any LSM is running inside the system, the syscall will pass
  and it will provide a size as big as the attribute
- if no LSM(s) are running inside the system, the syscall will fail
  with -1 return code and it will provide EOPNOTSUPP errno

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/lsm/.gitignore           |  1 +
 .../kernel/syscalls/lsm/lsm_get_self_attr02.c      | 45 ++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index f141baa8110aa4e701a808f72a19f2bad46da2d6..2c69e2cc93d2bea73a4849cbb406d3f87ba41d15 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -759,6 +759,7 @@ lseek07 lseek07
 lseek11 lseek11
 
 lsm_get_self_attr01 lsm_get_self_attr01
+lsm_get_self_attr02 lsm_get_self_attr02
 
 lstat01 lstat01
 lstat01_64 lstat01_64
diff --git a/testcases/kernel/syscalls/lsm/.gitignore b/testcases/kernel/syscalls/lsm/.gitignore
index 49f4a9263349ce633b8decb8fff1dd1d2111cf49..9f7c9b00b026a377f1b36f483ac2c1a0adba6249 100644
--- a/testcases/kernel/syscalls/lsm/.gitignore
+++ b/testcases/kernel/syscalls/lsm/.gitignore
@@ -1 +1,2 @@
 lsm_get_self_attr01
+lsm_get_self_attr02
diff --git a/testcases/kernel/syscalls/lsm/lsm_get_self_attr02.c b/testcases/kernel/syscalls/lsm/lsm_get_self_attr02.c
new file mode 100644
index 0000000000000000000000000000000000000000..889f3830fde8a5817936e67d9ee191a7513ff454
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_get_self_attr02.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that lsm_get_self_attr syscall is acting correctly when ctx is NULL.
+ * The syscall can behave in different ways according to the current system
+ * status:
+ *
+ * - if any LSM is running inside the system, the syscall will pass and it will
+ *   provide a size as big as the attribute
+ * - if no LSM(s) are running inside the system, the syscall will fail with -1
+ *   return code
+ */
+#include "lsm_common.h"
+
+static uint32_t page_size;
+static uint32_t lsm_count;
+
+static void run(void)
+{
+	uint32_t size = page_size;
+
+	if (lsm_count) {
+		TST_EXP_POSITIVE(lsm_get_self_attr(
+			LSM_ATTR_CURRENT, NULL, &size, 0));
+		TST_EXP_EXPR(size > 1);
+	} else {
+		TST_EXP_FAIL(lsm_get_self_attr(
+			LSM_ATTR_CURRENT, NULL, &size, 0), EOPNOTSUPP);
+	}
+}
+
+static void setup(void)
+{
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+	lsm_count = count_supported_attr_current();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "6.8",
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
