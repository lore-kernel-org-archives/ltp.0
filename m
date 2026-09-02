Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B9BC624D0
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:08:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BFED3C198F
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:08:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06DAA3E93B1
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 93D131400C40
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:48 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 86F1A1FAAA;
 Wed,  2 Sep 2026 11:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1iYGeq60/gAffugILkV8OZBfK4VQlk90otnkNVSAIU=;
 b=dyOFqoWv6As6yFVCmtVp5Kc4A5m+1pILURBOpL5nxZoT6z7i7qaFNhMDBYLOxG9akk60b7
 fYW3+j/IXONnh7EYcQ2ezHSORkqt8x5LCZvgjr1SpdNsXAaZ6Atw0+b1GW0kVMI+eH8nOT
 ZxxgZ3Uo3kF8C/FXSpOV3jcrLTlyIxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347083;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1iYGeq60/gAffugILkV8OZBfK4VQlk90otnkNVSAIU=;
 b=Mu32AHWCFqSBCDJbpySJi9SPr8BCEhN/0J5b+w39dX2+JEwV1gQ4Wd5tTe5HS0cfagqdtv
 XMJNW7XcVZ+v1GCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WbqNYTk2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bNXEtslA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1iYGeq60/gAffugILkV8OZBfK4VQlk90otnkNVSAIU=;
 b=WbqNYTk2tSXn/zDDKtJN1jUGPxBCcykvW63XevMlr9dcUyEemQD7zIJWCAwjPIL66T+OC5
 pXsTk6dIt3F64g/E2I9C4CQMBMfAm8NLAW0fbEUeNJI0Ed7bVhlAE8QgVs73bdR7cseL5/
 uhQ7yOeXgNnS/hJpT2JOI9LaNgmjwJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347079;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i1iYGeq60/gAffugILkV8OZBfK4VQlk90otnkNVSAIU=;
 b=bNXEtslAaJweaueJatWLTNTG38Tdw2DcnQMAFZ2/i4dlZEpRHKidRkYtRBzKMtt0tL3jg4
 4Rt0KKqi1lS6oXAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0803D1398D;
 Wed,  2 Sep 2026 11:04:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4HQeALkCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:25 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:33 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-18-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=2708;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=mbmgvEHofXkaaC/+3qgCXbs0mEohcUJ6S3dFm9DuIkI=;
 b=hAwl5XX7XmUD+/0XaM7pRLOEQSSh6n3OQQyRsP2gL/AqZ2svC1Rc2XB6Pll24BANtgEC1GXW5
 0v6XHNFZwdcA5uu/dTX/AsUCO33vYySxmPu3g5e4mnNjwIULDxmeVpw
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 86F1A1FAAA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 18/33] keyctl26: Test KEYCTL_DH_COMPUTE size query
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

Test KEYCTL_DH_COMPUTE buffer size query: verify that calling
with buflen 0 returns the required output buffer size (256)
without writing to userspace.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl26.c | 53 +++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 1b059f652..108efa4a8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -743,6 +743,7 @@ keyctl22 keyctl22
 keyctl23 keyctl23
 keyctl24 keyctl24
 keyctl25 keyctl25
+keyctl26 keyctl26
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 4cf772558..dd282b7ce 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -23,3 +23,4 @@
 /keyctl23
 /keyctl24
 /keyctl25
+/keyctl26
diff --git a/testcases/kernel/syscalls/keyctl/keyctl26.c b/testcases/kernel/syscalls/keyctl/keyctl26.c
new file mode 100644
index 000000000..32bc5f393
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl26.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_DH_COMPUTE`` size query of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - verify calling ``KEYCTL_DH_COMPUTE`` with ``buflen = 0`` returns required
+ *   buffer size (256) without writing
+ */
+
+#include "keyctl_common.h"
+#include "keyctl_dh_data.h"
+
+static struct keyctl_dh_params *dh_params;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	dh_params->priv = new_user_key("dh_priv", dh_priv, sizeof(dh_priv),
+				       KEY_SPEC_PROCESS_KEYRING);
+	dh_params->prime = new_user_key("dh_prime", dh_prime, sizeof(dh_prime),
+					KEY_SPEC_PROCESS_KEYRING);
+	dh_params->base = new_user_key("dh_base", dh_base, sizeof(dh_base),
+				       KEY_SPEC_PROCESS_KEYRING);
+}
+
+static void run(void)
+{
+	TST_EXP_VAL(keyctl(KEYCTL_DH_COMPUTE, (unsigned long)dh_params,
+			   (unsigned long)NULL, 0, 0),
+		    (long)sizeof(dh_expected_secret));
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "4.7",
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_KEYS=y",
+		"CONFIG_KEY_DH_OPERATIONS=y",
+		"CONFIG_CRYPTO_DH",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&dh_params, .size = sizeof(*dh_params)},
+		{},
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
