Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C895C624D0
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:06:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A91E33E5857
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:06:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2260D3E93B9
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B59A0200BCF
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 18BDB1F834;
 Wed,  2 Sep 2026 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrcGBUOZlISGz8k63v3RAmZasIssKWheL1zmOC/uqgo=;
 b=nHjG3qvHQK1GVzRL6tJMJaU8faDmfaQTTHMYstZwMNb3kg4pI5Kq6tdJsOBe4ylcGo9Z0l
 M2K/1k7YDznuxTSSL9c12DJksc21zhFCCKHDDAMkeotJdXageIdd1ztHJVV8zwx0ttR9Gh
 6YhBAdHadnHM88rK3srvdg/LwTKEJ9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrcGBUOZlISGz8k63v3RAmZasIssKWheL1zmOC/uqgo=;
 b=26a0jtUBYvrA/FGKIa5vMIYvsowdkZB6nj5POiOKcgsuIApUYhjFqUScZGzadxM/i9Tl23
 ig8u+3douvjOEICg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EwmWJsd8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lx3hgi1Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrcGBUOZlISGz8k63v3RAmZasIssKWheL1zmOC/uqgo=;
 b=EwmWJsd8XSCksFEZnjU16kCqkVdIAjt2LZVWF5wwArXYAhg3DPqjlM8L5AOt7n3dbX92OC
 cOKkd2UWH096FaN4sKuKHtCyOrGQEyMSEAzhrPDCSNHHj3t6MyKE7NdxO7tRv60j/Np/85
 vTKbAbfacmgjpXaA6nea+vW1r9oU4I4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KrcGBUOZlISGz8k63v3RAmZasIssKWheL1zmOC/uqgo=;
 b=lx3hgi1QKE/jkm1G4Dwz+6VwNntLxJccWEiF270GJ6NXaNfPulRbMsH0ZLXIAIDU6z9Iav
 hApaZTHVdiGcreAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53E5F1393C;
 Wed,  2 Sep 2026 11:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MIlhErcCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:22 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-7-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=3051;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=u9XnpyAZTgPa/iHHByu8D/VDUQDv02tFrxxhDUwNGqA=;
 b=PKd7q+hYHb8sve85w9rP1f7o6slQQ3UJU0IvQmdWNj0MK6gZ8b2M1Nh/ntlzwC4SMaO2RjA/S
 duKRlbB4uMCDOS/WtB8GUfz6a+kFL/6Mnh/HKszOyROmKbR+GIowSQX
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 18BDB1F834
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 07/33] keyctl15: Test KEYCTL_GET_SECURITY label
 retrieval
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

Test KEYCTL_GET_SECURITY label retrieval: verify reading the security
label of a valid key into a large buffer returns a positive length
and an empty string when no LSM label is set.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl15.c | 66 +++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 160d2f798..da901baae 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -732,6 +732,7 @@ keyctl11 keyctl11
 keyctl12 keyctl12
 keyctl13 keyctl13
 keyctl14 keyctl14
+keyctl15 keyctl15
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 8120454d8..852fee4ea 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -12,3 +12,4 @@
 /keyctl12
 /keyctl13
 /keyctl14
+/keyctl15
diff --git a/testcases/kernel/syscalls/keyctl/keyctl15.c b/testcases/kernel/syscalls/keyctl/keyctl15.c
new file mode 100644
index 000000000..c281e9c69
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl15.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_GET_SECURITY`` label retrieval of :manpage:`keyctl(2)`.
+ *
+ * ``KEYCTL_GET_SECURITY`` reads the LSM security label of a key.
+ * When no label is set (no LSM enabled or the LSM does not label keys)
+ * the operation returns 1 and an empty string.
+ *
+ * [Algorithm]
+ *
+ * - read the label of a valid key into a large buffer, verify the return
+ *   value is at least 1 and an empty string is returned when no label is set
+ */
+
+#include "keyctl_common.h"
+
+#define KEY_DESC	"ltpkeyctl15"
+#define PAYLOAD		"payload"
+#define BUF_SIZE	128
+
+static key_serial_t key;
+static char buf[BUF_SIZE];
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD),
+			   KEY_SPEC_PROCESS_KEYRING);
+	SAFE_KEYCTL(KEYCTL_SETPERM, key, KEY_PERM_SET, 0, 0);
+}
+
+static void run(void)
+{
+	memset(buf, 0, sizeof(buf));
+
+	TEST(keyctl(KEYCTL_GET_SECURITY, key, (unsigned long)buf, sizeof(buf), 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_GET_SECURITY failed");
+
+	if (TST_RET < 1) {
+		tst_res(TFAIL, "returned %ld, expected at least 1", TST_RET);
+		return;
+	}
+
+	if (TST_RET == 1) {
+		if (buf[0] != '\0') {
+			tst_res(TFAIL, "empty label is not NUL terminated");
+			return;
+		}
+
+		tst_res(TPASS, "no label set, empty string returned");
+		return;
+	}
+
+	tst_res(TPASS, "security label returned, full length %ld", TST_RET);
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
