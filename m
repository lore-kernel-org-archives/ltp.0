Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD9FC88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:12:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 188823E8C4D
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:12:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CEF33E806D
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B98DE6008D1
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2042721CB3;
 Wed, 16 Sep 2026 14:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jy8hc+rbuS0pRJrVlXGqVSPs7v2B2EW8U8gHTQUjXaI=;
 b=R0a23eVVS4vrvBHVsj4McPeDkn8/HsgfI97gVWiGt++v0UihmOj7OBmQ/rcZdzllIhvm57
 5m76jk94So26mTv3o6w7+wI8kfZLCcl+4/NU/nTcd9oGM4HmTFdVSk2ERZAxkXk/+I6aIb
 vjga4kA8BAkBy1VNgma1dS+mU1SL9Tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jy8hc+rbuS0pRJrVlXGqVSPs7v2B2EW8U8gHTQUjXaI=;
 b=17c//ZHRDQ1J9hwx/eM2M1G3y5JkV1KRwXkbbDgVEF1c81Ija0PuwkjwBAbcvsTKDbS5aE
 R0QtdydroE2PxjBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jy8hc+rbuS0pRJrVlXGqVSPs7v2B2EW8U8gHTQUjXaI=;
 b=xCBLJxBI3ovMuE4+7Y3eYGJR9qRODtA3VyGuYYMmjdGWQEeG5kHl0h4oTJ/dCzPvh8sgiY
 D5B4cKkbzC5mjV9x8cf+h+ifUAuBiOVmKfMPwXhjmxzLbrgCrulFc1bEhvGB+NLo1vmdyn
 YS4uyMu8X1cs31bQsUMfCgRinr/tOw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jy8hc+rbuS0pRJrVlXGqVSPs7v2B2EW8U8gHTQUjXaI=;
 b=Pao/qYF1Ti7m8rwcet6YAQjoIzzhSks0gTSZCGERTp8KMdji/ClpJTVVcMxwZwK2u1eUmj
 WoOeWwWCsfE2nCAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFF6A139C7;
 Wed, 16 Sep 2026 14:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T33
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:58 +0200
Message-ID: <20260916140402.1797325-33-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLtzdurrd6usbijy4f5nozqpqy)];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 ARC_NA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 32/36] keyctl35: Test KEYCTL_CAPABILITIES size query
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

Test that calling KEYCTL_CAPABILITIES with a NULL buffer and
buflen of 0 returns the total size in bytes of the keyrings
subsystem capability array without faulting.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: use SAFE_KEYCTL() ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl35.c | 46 +++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl35.c

diff --git a/runtest/syscalls b/runtest/syscalls
index e5450ff173..55299bd7c0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -752,6 +752,7 @@ keyctl31 keyctl31
 keyctl32 keyctl32
 keyctl33 keyctl33
 keyctl34 keyctl34
+keyctl35 keyctl35
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index f2ce330d77..58ebb452fa 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -32,3 +32,4 @@
 /keyctl32
 /keyctl33
 /keyctl34
+/keyctl35
diff --git a/testcases/kernel/syscalls/keyctl/keyctl35.c b/testcases/kernel/syscalls/keyctl/keyctl35.c
new file mode 100644
index 0000000000..cc0054813e
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl35.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_CAPABILITIES`` size query of :manpage:`keyctl(2)`, added in Linux 5.3.
+ *
+ * [Algorithm]
+ *
+ * - call ``KEYCTL_CAPABILITIES`` with NULL buffer and ``buflen = 0``
+ * - verify the return value is at least 2 bytes
+ * - verify calling ``KEYCTL_CAPABILITIES`` with a valid buffer returns the
+ *   same size
+ */
+
+#include "keyctl_common.h"
+
+static unsigned char buf[8];
+
+static void run(void)
+{
+	int size;
+
+	size = SAFE_KEYCTL(KEYCTL_CAPABILITIES, (unsigned long)NULL, 0, 0, 0);
+
+	if (size < 2) {
+		tst_res(TFAIL, "KEYCTL_CAPABILITIES size query returned %d, expected >= 2",
+			size);
+		return;
+	}
+
+	tst_res(TPASS, "KEYCTL_CAPABILITIES size query returned %d", size);
+
+	TST_EXP_VAL(keyctl(KEYCTL_CAPABILITIES, (unsigned long)buf, sizeof(buf), 0, 0),
+		    size);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "5.3",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_KEYS=y",
+		NULL
+	},
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
