Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53955C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:10:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C373E3E974C
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:10:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32D9F3E935B
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AD7F5140120F
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1551E1FE74;
 Fri,  4 Sep 2026 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxvuydLkYALXXMq5V+uyWW/OwfQn1zOyySqf8umsPqs=;
 b=L7ZCLN9RMNvrrUjkVmJpcSyDtSyYPDA/eEAkho6UjUxE64Ef/CS8MdsrofN26ZeWPRfa4P
 KIITpxnOoNrU6rZQda1x2MiWpeBeNcBEuAwa7H1h1w2qtFd9XWVdKglIGnn7u7t4JfC/Mm
 5bfwZasc5ph2Juvy+9VDPbaOgZ6IBAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxvuydLkYALXXMq5V+uyWW/OwfQn1zOyySqf8umsPqs=;
 b=gJpA3GylQkPcZnGWZSmF5c/Nook8cj5NXEI/703Uq+/O/laJFcB4DRtcIgX+hxZBMazzHj
 S/kBmEcEtlcwAGCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxvuydLkYALXXMq5V+uyWW/OwfQn1zOyySqf8umsPqs=;
 b=rGLcjL3sgazmCWiqxqYimCDWUMybaZBGXRJwi6cbKRFFhRl9r8Vo0JprktI8wD9n9mOWxM
 HVBb/G/zQv4OuDOnXXDLn1y0tkNQghrNl5CqKI4PMbXDfdeQcOWZqtD21PxT6M6BrwPcsD
 e8q9BBJVCiOGt3yTSFWVZueiJwFpEsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523733;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MxvuydLkYALXXMq5V+uyWW/OwfQn1zOyySqf8umsPqs=;
 b=DxC2IKhGLtj9brTwke7zMKYwNcy7r6yO+AuqqorkBI7vb21IpGsvE5UIa9tSI1NySbFaNR
 guyqS1yWoi7+GSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA33113889;
 Fri,  4 Sep 2026 12:08:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4NHgJtS0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:52 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:08:53 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-4-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=2788;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=EvWeHOdCxUWRaqbWuZ8BFuK/axzFOZUDg5tOZfuIG8g=;
 b=ZblOhbFFU2fYIriPAC4zehwtithN++Fk7d3/Zzi/UbI+xZogAajgj0PFdtJNAvuNgFWOWKUAK
 7xBwh3XzZdSDJoPm9QXVeDqT7OYELWQtrcZg8cbmQMaFuWihaZTmqRP
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 04/33] keyctl12: Test KEYCTL_DESCRIBE with too
 small buffer
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

Test KEYCTL_DESCRIBE when called with a buffer smaller than the
full description length: verify the buffer is left untouched and the
return value still reports the full length.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl12.c | 62 +++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 7c9042471..d8e846e65 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -729,6 +729,7 @@ keyctl08 keyctl08
 keyctl09 keyctl09
 keyctl10 keyctl10
 keyctl11 keyctl11
+keyctl12 keyctl12
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 4974fe48d..9ce6e2250 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -9,3 +9,4 @@
 /keyctl09
 /keyctl10
 /keyctl11
+/keyctl12
diff --git a/testcases/kernel/syscalls/keyctl/keyctl12.c b/testcases/kernel/syscalls/keyctl/keyctl12.c
new file mode 100644
index 000000000..b135fbe49
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl12.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_DESCRIBE`` of :manpage:`keyctl(2)` with too small buffer.
+ *
+ * [Algorithm]
+ *
+ * - describe a key with buffer smaller than full length, verify the buffer
+ *   remains untouched and the return value is unchanged
+ */
+
+#include "keyctl_common.h"
+
+#define BUF_SIZE	64
+
+static key_serial_t key;
+static long desc_len;
+static char buf[BUF_SIZE];
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	key = new_user_key("k", "payload", 7, KEY_SPEC_PROCESS_KEYRING);
+	SAFE_KEYCTL(KEYCTL_SETPERM, key, KEY_PERM_SET, 0, 0);
+
+	TEST(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)NULL, 0, 0));
+	if (TST_RET < 0)
+		tst_brk(TBROK | TTERRNO, "KEYCTL_DESCRIBE failed");
+
+	desc_len = TST_RET;
+}
+
+static void run(void)
+{
+	size_t i;
+
+	memset(buf, 0xAA, sizeof(buf));
+	TST_EXP_EQ_LI_SILENT(keyctl(KEYCTL_DESCRIBE, key, (unsigned long)buf,
+				    desc_len - 1, 0), desc_len);
+	if (!TST_PASS)
+		return;
+
+	for (i = 0; i < sizeof(buf); i++) {
+		if (buf[i] != (char)0xAA) {
+			tst_res(TFAIL,
+				"too small buffer was written to at offset %zu",
+				i);
+			return;
+		}
+	}
+
+	tst_res(TPASS, "too small buffer was left untouched");
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
