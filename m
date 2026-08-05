Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F282C55ABA
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 15:17:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19EA63E2EEA
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 17:17:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEAA43E90B5
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1EC76200AE4
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 17:15:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16EF37F218;
 Wed,  5 Aug 2026 15:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785942909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FppLxQBPFo9qWkXpnNfc9HFhauekre71rCvvLyidNac=;
 b=E8QVrBJWXzzUnDX3Sikm3xwgze7W0a28lv4r+uoC7gGR4rAeUAIHAI9IHjcL3Pt/6vZR12
 qIvoA5axK/Tn0q87UozLmobvlF5ItszYxn/RRUw+90bI50RRIfLyyqg0DCfBW3oVmSzXOZ
 gELRNmp1OcUZAscbgIVhLFGUAoguWac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785942909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FppLxQBPFo9qWkXpnNfc9HFhauekre71rCvvLyidNac=;
 b=9hW/9n+pj6PTdEFvk78fKSSq021ikhuU/lPngplevjyhh04woeNBHaNCrOySpiE2zquQwM
 TV8mPrLgCF/MU3Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785942905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FppLxQBPFo9qWkXpnNfc9HFhauekre71rCvvLyidNac=;
 b=sVi6OtbcphZeIE2F/lHgHrvJmweZe9hlCsIL/QwH/vn82KDRDLlKvL/uc+p57KOUqyo4ZI
 GNY1qhGdPO8VtNmRAG+4tzhvOerXWG5s5AVt5N7JESvp0GTmL2Kek0F/OvT8L7jnpWyrqM
 N7XiA/PFKqSreHIxcdlgBUgrNaN1prs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785942905;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FppLxQBPFo9qWkXpnNfc9HFhauekre71rCvvLyidNac=;
 b=wwLDfMyTTf2PBxsw5uuisLClcTwsN4XQrmn2nlXhNAXudhYU7ni8pl2RVV6mL+d41J2i2f
 n4MptQ4osnwbPeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4AF1779F0;
 Wed,  5 Aug 2026 15:15:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GEMZJ3ZTc2qsGgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Aug 2026 15:15:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  5 Aug 2026 17:14:48 +0200
Message-ID: <20260805151451.648990-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805151451.648990-1-pvorel@suse.cz>
References: <20260805151451.648990-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 6/9] lib: Add basic test for .min_kver && .max_kver
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

Basic test to CI to test that test with .min_kver < .max_kver will be run.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v4.

 lib/newlib_tests/.gitignore              |  1 +
 lib/newlib_tests/runtest.sh              |  1 +
 lib/newlib_tests/tst_min_kver_max_kver.c | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 lib/newlib_tests/tst_min_kver_max_kver.c

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index b851638246..5f16a7e5bd 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -72,3 +72,4 @@ test_brk_pass
 test_brk_variant
 test_fail_variant
 test_cpu_vendor
+tst_min_kver_max_kver
diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 71808ef8b8..4e8da861fc 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -26,6 +26,7 @@ tst_device
 tst_expiration_timer
 tst_filesystems01
 tst_fuzzy_sync0[1-3]
+tst_min_kver_max_kver
 tst_needs_cmds0[1-36-8]
 tst_res_hexd
 tst_safe_sscanf
diff --git a/lib/newlib_tests/tst_min_kver_max_kver.c b/lib/newlib_tests/tst_min_kver_max_kver.c
new file mode 100644
index 0000000000..a488d0ed47
--- /dev/null
+++ b/lib/newlib_tests/tst_min_kver_max_kver.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Petr Vorel <pvorel@suse.cz>
+ */
+
+/*
+ * Basic test to test that test with .min_kver < .max_kver will be run.
+ */
+
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_res(TPASS, "Test has sufficient kernel version");
+}
+
+static struct tst_test test = {
+	.min_kver = "4.4",
+	.max_kver = "5.0",
+	.test_all = do_test,
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
