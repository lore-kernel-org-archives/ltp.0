Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFDFC624D0
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:06:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E9F83E5821
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:06:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F9343E588C
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E09F21000A2D
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4142421E38;
 Wed,  2 Sep 2026 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=beoYaZUsHFQExTCOeG1qWIsPhookPZ8bH3l+1tciFWQ=;
 b=KhzFIOF1mJBsQTYqDopttQoMaZRWJ5oUVycPe/PwPkawHBWzZTxJuGzAtzsk22886CQQfr
 4YeA2FqzbwvltIZRVY2IG34HsuCnHyrLfTBVFgvVCii/Nc62aavXaazBAa+CrHiccPFBxy
 FBB4/XhXyvxvZRjlIiZnDASgs+qgebE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=beoYaZUsHFQExTCOeG1qWIsPhookPZ8bH3l+1tciFWQ=;
 b=0zL3Rtzv8lMX0gwKJs2nwIPjzaAQA5cZpRZpMffQe5QmYV3Puy7Zz8EDNZSzcD+3CNet0J
 u6+Zex7UqDalMZDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Mn/CPSyI";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=U3n91yCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=beoYaZUsHFQExTCOeG1qWIsPhookPZ8bH3l+1tciFWQ=;
 b=Mn/CPSyIkhqeazEdKWUAnVXaK+KomdB02czpSqLjufKXfWoQ1r/pOBOvmNS1ZTd8Pva3XR
 Z1dm6pvB8BGRW+4EXnc0rVmk7ycN9tuxLeO52F1tzJXnFOGLWw2JJGd7MFt2B9Bg0Kd8hu
 0ek/YrQySGmulkdBqnYNlqKGSfd1w30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=beoYaZUsHFQExTCOeG1qWIsPhookPZ8bH3l+1tciFWQ=;
 b=U3n91yCBslqCjpf6oITX0pfs/uLudIrExbBrAEUVa/A9kDc0VkONWE9LIJYdHEJ7af8DB6
 KjcfukFWx3HAnpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D84413978;
 Wed,  2 Sep 2026 11:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OHjBJLcCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:24 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-9-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=2861;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=05fD71NTEJcluZrPisofr9AFADpoIhe3LICmG9ZX0sc=;
 b=DptrdpCuu4Yz5CSpDFpp2Gafwa/TLNFrDdFsLdwexVMn/EQGw9bTr9rpNp4rLnlFUu+VMN0Uw
 0FkYqKhJqs4C3PgQkit3RN05IL7bDd1HCWtlC8kUSTjV1SadWqGSXsM
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4142421E38
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 09/33] keyctl17: Negative tests for KEYCTL_GET_SECURITY
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

Test error conditions of KEYCTL_GET_SECURITY using a parameterized
tcase table: verify ENOKEY on a bogus key id and ENOKEY when View
permission is missing (due to the kernel request-key auth token
fallback path).

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl17.c | 55 +++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 89c8a95af..fcc1d58a8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -734,6 +734,7 @@ keyctl13 keyctl13
 keyctl14 keyctl14
 keyctl15 keyctl15
 keyctl16 keyctl16
+keyctl17 keyctl17
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index c351716d0..dddb45f85 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -14,3 +14,4 @@
 /keyctl14
 /keyctl15
 /keyctl16
+/keyctl17
diff --git a/testcases/kernel/syscalls/keyctl/keyctl17.c b/testcases/kernel/syscalls/keyctl/keyctl17.c
new file mode 100644
index 000000000..216152f1d
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl17.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Negative test cases for ``KEYCTL_GET_SECURITY`` of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - get_security with bogus key id fails with ``ENOKEY``
+ * - get_security without View permission fails with ``ENOKEY`` (the kernel
+ *   falls back to looking for an auth token and returns its ``ENOKEY``)
+ */
+
+#include "keyctl_common.h"
+
+#define BUF_SIZE	128
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
+	{ &key_no_view, ENOKEY, "key without View permission" },
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
+	TST_EXP_FAIL2(keyctl(KEYCTL_GET_SECURITY, (unsigned long)*tc->keyid,
+			     (unsigned long)buf, sizeof(buf), 0),
+		      tc->exp_errno,
+		      "KEYCTL_GET_SECURITY with %s", tc->desc);
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
