Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E3DC25B75
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 10:55:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5ABE43CFFCD
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 12:55:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2364F3D0064
 for <ltp@lists.linux.it>; Tue, 21 May 2024 12:53:55 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 47C281000A4A
 for <ltp@lists.linux.it>; Tue, 21 May 2024 12:53:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A61E21F00;
 Tue, 21 May 2024 10:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716288832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrwB4rpZgTICb1gaO/t+9BaA8GkYWcYPlqTWAKX3byQ=;
 b=ahyMI9x19bs6F9gOUIh2hQh3aQjJhG4olIHDmXKkSHFDOMGK1+TxhUSmtGiVAWUHht+D37
 PFyzwv4P+IP0gTDEo7u7HTvHSD0mnX4MvTgTzWzOzbhMqZf+jYOhZickAVZqDgXi3QNe2Y
 a5A4cY2wumxavyXaWMq/M8ktKSa8Bvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716288832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrwB4rpZgTICb1gaO/t+9BaA8GkYWcYPlqTWAKX3byQ=;
 b=fNHbCMJnx/uDMdBf8JGnGhJPh0qGG8aMCIYqAxDozeIXrA98YfqRKPqOv+tvch5GJgtIDZ
 737rPCF09tAdydBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Sm4uF3cf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=llDCgUTN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716288831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrwB4rpZgTICb1gaO/t+9BaA8GkYWcYPlqTWAKX3byQ=;
 b=Sm4uF3cf6ilOi4xDHYsbBtrBaehAQQU7jRDtvZYRva03pYV403HnHgn1lErw5GOLImGxw5
 zN9s3lqzFsyqBA7lRfsUHfUb2QLePM2oDvgc37AB8w/1+dutcO41ltWJsCPRaI13usNsla
 K100nU/Bk/9LtTIpYDgIdayIeqpxois=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716288831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LrwB4rpZgTICb1gaO/t+9BaA8GkYWcYPlqTWAKX3byQ=;
 b=llDCgUTNOtMOUdtm//rrbpCmJs4vP1PUhjcXPfvSTdF0fY/7NOg6AnW1jz3nUxGZhcUxiH
 4pWMV8+CatP8cHDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 629D813A79;
 Tue, 21 May 2024 10:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WEIrFz99TGYMPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 May 2024 10:53:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 May 2024 12:53:45 +0200
Message-ID: <20240521105348.126316-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521105348.126316-1-pvorel@suse.cz>
References: <20240521105348.126316-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9A61E21F00
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/5] lib: Add .needs_abi_bits
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

This allows to force kernel ABI.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Change from .skip_in_32bit to .needs_abi_bits

 include/tst_kernel.h | 12 ++++++++++++
 include/tst_test.h   |  7 ++++++-
 lib/tst_kernel.c     | 10 ++++++++++
 lib/tst_test.c       |  5 ++++-
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/tst_kernel.h b/include/tst_kernel.h
index e0ce7ce46..5f49952b7 100644
--- a/include/tst_kernel.h
+++ b/include/tst_kernel.h
@@ -1,10 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2018-2024
  */
 
 #ifndef TST_KERNEL_H__
 #define TST_KERNEL_H__
 
+#include <stdbool.h>
+
 /**
  * tst_kernel_bits() - Detect if running on 32bit or 64bit kernel.
  *
@@ -23,6 +26,15 @@ int tst_kernel_bits(void);
  */
 int tst_is_compat_mode(void);
 
+/**
+ * tst_abi_bits() - Detect if compiled for required kernel ABI.
+ *
+ * @abi: kernel ABI bits (32 or 64).
+ *
+ * Return: true if compiled for required ABI or false otherwise.
+ */
+bool tst_abi_bits(int abi);
+
 /**
  * tst_check_builtin_driver() - Check if the kernel module is built-in.
  *
diff --git a/include/tst_test.h b/include/tst_test.h
index 69587917f..8dc20d110 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
- * Copyright (c) Linux Test Project, 2016-2019
+ * Copyright (c) Linux Test Project, 2016-2024
  */
 
 #ifndef TST_TEST_H__
@@ -328,6 +328,10 @@ struct tst_ulimit_val {
  * @skip_in_compat: Skip the test if we are executing 32bit binary on a 64bit
  *                  kernel, i.e. we are testing the kernel compat layer.
  *
+ * @needs_abi_bits: Skip the test if runs on a different kernel ABI than
+ *                  requested (on 32bit instead of 64bit or vice versa).
+ *                  Possible values: 32, 64.
+ *
  * @needs_hugetlbfs: If set hugetlbfs is mounted at tst_test.mntpoint.
  *
  * @skip_filesystems: A NULL terminated array of unsupported file systems. The
@@ -494,6 +498,7 @@ struct tst_ulimit_val {
 	unsigned int skip_in_lockdown:1;
 	unsigned int skip_in_secureboot:1;
 	unsigned int skip_in_compat:1;
+	int needs_abi_bits;
 
 	unsigned int needs_hugetlbfs:1;
 
diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index 7fd1af871..8dabfeba2 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -1,6 +1,7 @@
 /*
  * Copyright (c) 2017 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2020-2021 Petr Vorel <pvorel@suse.cz>
+ * Copyright (c) Linux Test Project, 2017-2024
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -18,6 +19,7 @@
 
 #include <sys/personality.h>
 #include <sys/utsname.h>
+#include <stdbool.h>
 #include <limits.h>
 
 #include "test.h"
@@ -96,6 +98,14 @@ int tst_is_compat_mode(void)
 	return TST_ABI != tst_kernel_bits();
 }
 
+bool tst_abi_bits(int abi)
+{
+	if (abi != 32 && abi != 64)
+		tst_brkm(TBROK | TERRNO, NULL, "abi parameter can be only 32 or 64");
+
+	return abi == TST_ABI;
+}
+
 static int tst_search_driver_(const char *driver, const char *file)
 {
 	struct stat st;
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 686ee428d..190e8da2a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
- * Copyright (c) Linux Test Project, 2016-2021
+ * Copyright (c) Linux Test Project, 2016-2024
  */
 
 #include <limits.h>
@@ -1209,6 +1209,9 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->skip_in_compat && tst_is_compat_mode())
 		tst_brk(TCONF, "Not supported in 32-bit compat mode");
 
+	if (tst_test->needs_abi_bits && !tst_abi_bits(tst_test->needs_abi_bits))
+		tst_brk(TCONF, "%dbit ABI is not supported", tst_test->needs_abi_bits);
+
 	if (tst_test->needs_cmds) {
 		const char *cmd;
 		int i;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
