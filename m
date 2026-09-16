Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A62EC88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 14:06:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05B133E806D
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 16:06:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F9D53E803E
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D93811A00A48
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 16:04:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 52FDC1F896;
 Wed, 16 Sep 2026 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+97nnUOzouASlTJ2V65XOwEGuj/YmcA2ggk5WrOark=;
 b=Yw/p/UuTpMviIn1n9/gbkZmU57336Bu6FRcYUr1Pewr4S5rowxS9HQ+dTWhcyQrSwMoMQz
 dUd0d/nzWNVzT86x3evn3VnMkazOiPHPsu/PDVZeUDtmBZbHc4GWvOAkxhrXqn3JTIWeQ8
 MO8tcfVCXFaDrGk1B48lHe/0lsJ9Muo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+97nnUOzouASlTJ2V65XOwEGuj/YmcA2ggk5WrOark=;
 b=VhLc1s2YRu3GooYUfhU78cUNl9L65qX8WrsZRb7xdTM9liErVaoi0gDJB+PN1NUFjuBmRI
 QDGkkcn6B2/rtVAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789567460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+97nnUOzouASlTJ2V65XOwEGuj/YmcA2ggk5WrOark=;
 b=ZNWNLmOqNm4wZaalxeETxG7Rc3meOGILHxFZdcrCHIQqaVvWaFYgwQCp6aWRJ6H1VANydf
 Ba7bqJSEvd3wCD8/mHSAyMn1Sx1KMHq+Pi0YtXcVJ4ORhtf1b9mkQyDtOztHDt/o8jwtyj
 wikKKNpUQAOAKZg0zqPawLhIV1Im+qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789567460;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+97nnUOzouASlTJ2V65XOwEGuj/YmcA2ggk5WrOark=;
 b=aBzJIezVGGD9Q6Q4XnnItPIIep6noXW/fwAcfFlGX3OSmSDQZ7ALxW8ckhAoNtqDZ8LsWQ
 2CKvNeMndbMwDbCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABDA3139A9;
 Wed, 16 Sep 2026 14:04:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1xhOO9ihqmqNRQAAD6G6ig:T15
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 14:04:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Sep 2026 16:03:40 +0200
Message-ID: <20260916140402.1797325-15-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916140402.1797325-1-pvorel@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.997];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:mid,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 14/36] keyctl20: Test KEYCTL_MOVE displacement
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

Test KEYCTL_MOVE displacement behavior: verify moving a key without
KEYCTL_MOVE_EXCL into a destination holding a matching key displaces
the existing key.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel:
* Use SAFE_NEW_RING(), SAFE_NEW_USER_KEY(), keyctl() instead of
  search_ring()
* Remove keyctl(KEYCTL_UNLINK, ...) check (Cyril) ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl20.c | 51 +++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 testcases/kernel/syscalls/keyctl/keyctl20.c

diff --git a/runtest/syscalls b/runtest/syscalls
index affa47e957..63a16dd5a3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -737,6 +737,7 @@ keyctl16 keyctl16
 keyctl17 keyctl17
 keyctl18 keyctl18
 keyctl19 keyctl19
+keyctl20 keyctl20
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index f321079233..acddfa79ec 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -17,3 +17,4 @@
 /keyctl17
 /keyctl18
 /keyctl19
+/keyctl20
diff --git a/testcases/kernel/syscalls/keyctl/keyctl20.c b/testcases/kernel/syscalls/keyctl/keyctl20.c
new file mode 100644
index 0000000000..31f1c25ae0
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl20.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_MOVE`` displacement of :manpage:`keyctl(2)`.
+ *
+ * [Algorithm]
+ *
+ * - move a key without ``KEYCTL_MOVE_EXCL`` into a destination keyring that
+ *   already contains a matching key, verify it displaces the existing key
+ */
+
+#include "keyctl_common.h"
+
+#define RING_A_DESC	"ltpkeyctl20_a"
+#define RING_B_DESC	"ltpkeyctl20_b"
+#define KEY_DESC	"k"
+#define PAYLOAD		"payload"
+
+static key_serial_t ring_a, ring_b;
+static key_serial_t key_a, key_excl;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	ring_a = SAFE_NEW_RING(RING_A_DESC);
+	ring_b = SAFE_NEW_RING(RING_B_DESC);
+
+	key_a = SAFE_NEW_USER_KEY(KEY_DESC, PAYLOAD, sizeof(PAYLOAD), ring_a);
+	key_excl = SAFE_NEW_USER_KEY(KEY_DESC, PAYLOAD, sizeof(PAYLOAD), ring_b);
+
+	/* Keep key_excl in session keyring so displacement does not destroy it */
+	SAFE_KEYCTL(KEYCTL_LINK, key_excl, KEY_SPEC_SESSION_KEYRING, 0, 0);
+}
+
+static void run(void)
+{
+	SAFE_KEYCTL(KEYCTL_LINK, key_a, ring_a, 0, 0);
+	TST_EXP_PASS(keyctl(KEYCTL_MOVE, key_a, ring_a, ring_b, 0));
+
+	TST_EXP_EQ_LI(keyctl(KEYCTL_SEARCH, ring_b, "user", KEY_DESC), key_a);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "5.3",
+};
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
