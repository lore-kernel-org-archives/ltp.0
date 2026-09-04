Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CE1C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:11:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1BE63E976E
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:11:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A9EF3E978A
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 950311A010E2
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 95ECA1FB57;
 Fri,  4 Sep 2026 12:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DSGEF6RHOTw0G9ukSVTk03U8atyoQ/Zui8hcUSFfT0=;
 b=QIxXq/gs+RGmbNyEKRDg5z6QQZU8uaX6QKoSIyHtzVCVtbnYMHMJXbkovChCohvFJErr8l
 kzYqawLh9vSW3rPQcL5r5J5TNMDFVfn4us3Ued9/kpwpjotHxHV8OONy3Djw0z3aYcqb/r
 iHhsjCLquYfnQINkUP+JH5LULt66XDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DSGEF6RHOTw0G9ukSVTk03U8atyoQ/Zui8hcUSFfT0=;
 b=MCrsOnG7s1rEhez6ocWK36gHIy0vsCz01vQiBHAtwueuaimcryilDZiVWyuU3+w2/PqzwA
 65J0rkilo7ytz0Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="x3Cr/NkF";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hNR7x0Bb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DSGEF6RHOTw0G9ukSVTk03U8atyoQ/Zui8hcUSFfT0=;
 b=x3Cr/NkFBAu+CaGzhnKqP+LvNSrqZSZPbSf3d8Zl2D5rE2PSEhAycLOr2jdA6sFRfh7sEw
 KqID6k4CY1w2zarZ0h91/Xu1Al+yjr+ETNpI+qjtEuu8JQFNQWoCW2/ZrEFO5k9M9ltjRF
 uroitRMODI6BPIxEkj82h26TW04A1xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DSGEF6RHOTw0G9ukSVTk03U8atyoQ/Zui8hcUSFfT0=;
 b=hNR7x0BbawetLoEBRvMi8Rk5ohUDfXro+dXH3gPLg6ZbNVhwTbF3cdZHqxL2AJiGN6RETA
 0zHon5fL7YHiM+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C0231397D;
 Fri,  4 Sep 2026 12:08:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CLmqB9W0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:53 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:08:55 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-6-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=2691;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=M7oUhw3YsVdSpqEULspBvfRARCsNZleqDVxVnNCZSv4=;
 b=jlRlX/xRQatEIkyFE5WPVWNL6T1cV3ih8wykU5VsVFhDINR/U7BdDyqgn+STQvB59yMl1xodl
 9Yz3yVAKdi+Dyb8ExXDsDaQPmOEckKVS0M/AVjvf42q85pubbrRLMAd
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 95ECA1FB57
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.de:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 06/33] keyctl14: Negative tests for KEYCTL_DESCRIBE
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

Test error conditions of KEYCTL_DESCRIBE using a parameterized
tcase table: verify ENOKEY on a bogus key id and EACCES when View
permission is missing.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl14.c | 54 +++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 25367084d..160d2f798 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -731,6 +731,7 @@ keyctl10 keyctl10
 keyctl11 keyctl11
 keyctl12 keyctl12
 keyctl13 keyctl13
+keyctl14 keyctl14
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index d4ce61a6e..8120454d8 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -11,3 +11,4 @@
 /keyctl11
 /keyctl12
 /keyctl13
+/keyctl14
diff --git a/testcases/kernel/syscalls/keyctl/keyctl14.c b/testcases/kernel/syscalls/keyctl/keyctl14.c
new file mode 100644
index 000000000..e98dde40f
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl14.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Negative test cases for ``KEYCTL_DESCRIBE`` of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - describe with bogus key id fails with ``ENOKEY``
+ * - describe without View permission fails with ``EACCES``
+ */
+
+#include "keyctl_common.h"
+
+#define BUF_SIZE	64
+
+static key_serial_t key_no_view;
+static key_serial_t bogus_id = INT32_MAX;
+static char buf[BUF_SIZE];
+
+static struct tcase {
+	key_serial_t *keyid;
+	int exp_errno;
+	const char *desc;
+} tcases[] = {
+	{ &bogus_id, ENOKEY, "bogus key id" },
+	{ &key_no_view, EACCES, "key without View permission" },
+};
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key_no_view = new_user_key("k_no_view", "payload", 7, KEY_SPEC_PROCESS_KEYRING);
+	SAFE_KEYCTL(KEYCTL_SETPERM, key_no_view, KEY_PERM_NO_VIEW, 0, 0);
+}
+
+static void verify_negative(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL2(keyctl(KEYCTL_DESCRIBE, (unsigned long)*tc->keyid,
+			     (unsigned long)buf, sizeof(buf), 0),
+		      tc->exp_errno,
+		      "KEYCTL_DESCRIBE with %s", tc->desc);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = verify_negative,
+	.tcnt = ARRAY_SIZE(tcases),
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
