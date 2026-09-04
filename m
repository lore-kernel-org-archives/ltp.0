Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A95C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:12:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EB2D3E30CD
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:12:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C13FC3E976B
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 76C29600F3F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E47061FE8B;
 Fri,  4 Sep 2026 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJZfplWPyyVc+1uM2pLScCalESSECkb/q8mtnRWJKYc=;
 b=LGO4H6/EPsKNdOLfq+xzLlbJ7qnimZUb4TmYVrzD33Eb/aDNowxdBXUSxfd+HTbbrKt8Yi
 rA0XiT2DB3pqWGjvYM148MYjzla2JR5tZbyWEm5jT758H6yzKjGBRc6I6DjQeZtLh8BB+R
 J4F/Pe5X+EIZBJmC9Z3H7MeBLDWZ9lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJZfplWPyyVc+1uM2pLScCalESSECkb/q8mtnRWJKYc=;
 b=Z6o9tG6eFHsguCwfVUx1wdpW7O0DJiSeaTEiNo7knLDwxUhYw/UHXoQ9ZV6fqyKW8Gl/Y+
 VbTPCJS+z+jy0xDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MkwkUcoF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VyKq8JPf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJZfplWPyyVc+1uM2pLScCalESSECkb/q8mtnRWJKYc=;
 b=MkwkUcoF2NXOwneeNwQr8H4FQpOh4Q1IDc2VywOTFNsTpJUHEDzzM1Fi4TGwBFALlF4PUQ
 9TGcp+IwtHscpRlPZWS/VD7UjAG+AubQcPQL4yvRGYFPLr/suhpJfozSXjS9t55rMNTaS5
 rSps18njJ4WxIELq3gxo02vPl5av2P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJZfplWPyyVc+1uM2pLScCalESSECkb/q8mtnRWJKYc=;
 b=VyKq8JPfctI1yvd1/n51PdbvycXHY369rGKyrFQ906MQ8qhSASa8Kh2GZSvVsk7S1URQ/5
 k8ETNmmESB4P90Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D5111398A;
 Fri,  4 Sep 2026 12:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yELMI9W0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:08:57 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-8-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=3148;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=QPZPaU/pNiZP89O1mDougadtkoSNRrsEfz+V7ZCczjQ=;
 b=721R/BOZGmUyX9zidE23svuIR8TwHVHt3SF6VQYtmnd/LOBK9nhVB0Jd0ELKHZwdQzxXN5+LU
 U4eORgzpNF5DvAl1SA2BDUKeUWqy8UpmfChTxKTINNUsYkn3nglSKMC
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E47061FE8B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 08/33] keyctl16: Test KEYCTL_GET_SECURITY truncated
 copy
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

Test KEYCTL_GET_SECURITY truncated copy behavior: verify that calling
with a 1-byte buffer receives exactly one byte while the return value
still reports the full label length.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl16.c | 74 +++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index da901baae..89c8a95af 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -733,6 +733,7 @@ keyctl12 keyctl12
 keyctl13 keyctl13
 keyctl14 keyctl14
 keyctl15 keyctl15
+keyctl16 keyctl16
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 852fee4ea..c351716d0 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -13,3 +13,4 @@
 /keyctl13
 /keyctl14
 /keyctl15
+/keyctl16
diff --git a/testcases/kernel/syscalls/keyctl/keyctl16.c b/testcases/kernel/syscalls/keyctl/keyctl16.c
new file mode 100644
index 000000000..f5662e326
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl16.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_GET_SECURITY`` truncated copy of :manpage:`keyctl(2)`.
+ *
+ * ``KEYCTL_GET_SECURITY`` returns the full length of the label, but unlike
+ * ``KEYCTL_DESCRIBE`` the kernel performs a truncated copy when the user
+ * buffer is too small.
+ *
+ * [Algorithm]
+ *
+ * - verify a one byte buffer receives exactly one byte while the full
+ *   length is still returned
+ */
+
+#include "keyctl_common.h"
+
+#define KEY_DESC	"ltpkeyctl16"
+#define PAYLOAD		"payload"
+#define BUF_SIZE	128
+
+static key_serial_t key;
+static long sec_len;
+static char buf[BUF_SIZE];
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD),
+			   KEY_SPEC_PROCESS_KEYRING);
+	SAFE_KEYCTL(KEYCTL_SETPERM, key, KEY_PERM_SET, 0, 0);
+
+	TEST(keyctl(KEYCTL_GET_SECURITY, key, (unsigned long)NULL, 0, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_GET_SECURITY failed");
+
+	sec_len = TST_RET;
+}
+
+static void run(void)
+{
+	size_t i;
+
+	memset(buf, 0xAA, sizeof(buf));
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_GET_SECURITY, key,
+				    (unsigned long)buf, 1, 0), sec_len);
+	if (!TST_PASS)
+		return;
+
+	if (buf[0] == (char)0xAA) {
+		tst_res(TFAIL, "nothing was copied into the buffer");
+		return;
+	}
+
+	for (i = 1; i < sizeof(buf); i++) {
+		if (buf[i] != (char)0xAA) {
+			tst_res(TFAIL, "copy overran the buffer at offset %zu",
+				i);
+			return;
+		}
+	}
+
+	tst_res(TPASS, "exactly one byte copied, full length %ld returned",
+		sec_len);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
