Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE929C5B56C
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 16:02:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58FDA3D073F
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 18:02:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7643E3D0659
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:01:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 127981000361
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:01:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5AB1E3E09;
 Mon, 10 Aug 2026 16:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786377663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZiyMPPI2g/TYBjCtXpiWL46ELqQVDp5978LCKQGQce0=;
 b=rfLKyszm7yxNgJGdnk0xaKqvhd9+5mIaB89q8Qg829OvZqr3RsxobS7+U5nI/dm8hZKDmC
 +YyKbsDVrdiXhGr0+MQ5cqvzd6BqUe/kmvtSlY8vwUyAbFcs+MLX4f3wt6XuRoiUffoyd3
 BsodlCztGgY0lXZrKx64lJsaOwZSUSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786377663;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZiyMPPI2g/TYBjCtXpiWL46ELqQVDp5978LCKQGQce0=;
 b=iFJ6+9GrLJlGqtnUv44MP3HANMJh8EfoPbJDoj+3BL3vdwVVjWJjNDOx25ibhlTtaJoPme
 ks1r7U3JQTkJq6Cg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lcTNigv3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/C9O244D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786377659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZiyMPPI2g/TYBjCtXpiWL46ELqQVDp5978LCKQGQce0=;
 b=lcTNigv3PK67/Ur3NABAbIYaRbDNF6Iti1mU5xlHprbOIU1NdbIfLgh6TJZyajJnYzOUH9
 QT3QQm9xn6NmfFk6G04wSsWqvkgUhA/mQCTxwdE+p3X+m6zoqRICtLBFlUm93YM+AiQVse
 sg0O9Ez73Go/nTTwCqoWhRK+D9LDYu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786377659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZiyMPPI2g/TYBjCtXpiWL46ELqQVDp5978LCKQGQce0=;
 b=/C9O244DxN6sVdUhCG2ps60/NuSIEcy8CdEEeUYnZ+3qESlqh/qJhD7+8jLN8Hzne+VH8x
 9CFYSQwmM+yeoNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F31A7779C6;
 Mon, 10 Aug 2026 16:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SIvtObP1eWquLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 16:00:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Aug 2026 18:00:48 +0200
Message-ID: <20260810160048.1040517-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810160048.1040517-1-pvorel@suse.cz>
References: <20260810160048.1040517-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,suse.cz:dkim];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 5AB1E3E09
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 7/7] lib: Add 2 basic tests for .min_kver &&
 .max_kver
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

* tst_max_kver_old.c
Basic test to test .max_kver detection works. Test should TCONF due
running on newer kernel.

* tst_min_kver_max_kver.c
Basic test to test that .min_kver and .max_kver can be used together.
Test should TCONF or TPASS.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v4->v5:
* Add one more test, increase max_kver in the test added previous
  version.

 lib/newlib_tests/.gitignore              |  2 ++
 lib/newlib_tests/runtest.sh              |  2 ++
 lib/newlib_tests/tst_max_kver_old.c      | 21 +++++++++++++++++++++
 lib/newlib_tests/tst_min_kver_max_kver.c | 22 ++++++++++++++++++++++
 4 files changed, 47 insertions(+)
 create mode 100644 lib/newlib_tests/tst_max_kver_old.c
 create mode 100644 lib/newlib_tests/tst_min_kver_max_kver.c

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index b851638246..d55e38bb29 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -72,3 +72,5 @@ test_brk_pass
 test_brk_variant
 test_fail_variant
 test_cpu_vendor
+tst_max_kver_old
+tst_min_kver_max_kver
diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index 71808ef8b8..ad38d845a3 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -26,6 +26,8 @@ tst_device
 tst_expiration_timer
 tst_filesystems01
 tst_fuzzy_sync0[1-3]
+tst_max_kver_old
+tst_min_kver_max_kver
 tst_needs_cmds0[1-36-8]
 tst_res_hexd
 tst_safe_sscanf
diff --git a/lib/newlib_tests/tst_max_kver_old.c b/lib/newlib_tests/tst_max_kver_old.c
new file mode 100644
index 0000000000..3b03f555b6
--- /dev/null
+++ b/lib/newlib_tests/tst_max_kver_old.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Petr Vorel <pvorel@suse.cz>
+ */
+
+/*
+ * Basic test to test .max_kver detection works.
+ * Test should TCONF due running on newer kernel.
+ */
+
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_res(TFAIL, "Really running on kernel 1.0?");
+}
+
+static struct tst_test test = {
+	.max_kver = "1.0",
+	.test_all = do_test,
+};
diff --git a/lib/newlib_tests/tst_min_kver_max_kver.c b/lib/newlib_tests/tst_min_kver_max_kver.c
new file mode 100644
index 0000000000..5c1b0b3a29
--- /dev/null
+++ b/lib/newlib_tests/tst_min_kver_max_kver.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Petr Vorel <pvorel@suse.cz>
+ */
+
+/*
+ * Basic test to test that .min_kver and .max_kver can be used together.
+ * Test should TCONF or TPASS.
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
+	.max_kver = "7.2",
+	.test_all = do_test,
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
