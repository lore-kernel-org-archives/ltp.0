Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA92C61DD6
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 11:07:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E85013E5893
	for <ltp@archiver.kernel.org>; Wed,  2 Sep 2026 13:07:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55BD63E93AE
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B31751400E00
 for <ltp@lists.linux.it>; Wed,  2 Sep 2026 13:04:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15FA321E2D;
 Wed,  2 Sep 2026 11:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DSGEF6RHOTw0G9ukSVTk03U8atyoQ/Zui8hcUSFfT0=;
 b=g737Jq19isCP0u91pEcqRzwFvxF2oc0i0ACzVpg+x8FCzCFblvSpI2sb2bTrDDjlLxNq6F
 4KQL3GMKzTKFCKZNF6Funk0J5u8YJNy8gz5TK8D8zdIWkkDXiBcwzta/HQD1w/X23VqVn9
 ydrnxRoAhPMpKdkQ6y0yQd80c7dANrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DSGEF6RHOTw0G9ukSVTk03U8atyoQ/Zui8hcUSFfT0=;
 b=5lsQALTl/nYAN1432+UjTL0BsYrYCr29vO7IuU8KWCzTAOrkb6G86erypyuuQDVtUGarvf
 irFVZN5SHP0qbZAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=U939+QO6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Gn5y1PDx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788347071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DSGEF6RHOTw0G9ukSVTk03U8atyoQ/Zui8hcUSFfT0=;
 b=U939+QO6VsUSAOxOgEdqPgCgZduaBvULbCWwtHFFJkF0c7sNUzBndRRkb4vUUxdCKSEyQ/
 y5M0zTf/MnUEStBbWoNp7EZhPwAewy4Ahp/BhT7HOaY0G8wPUMku8ERT0DuhU0gFp9Iq4X
 WpVZJG968in5e6OfjOKYrkpmkObAPtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788347071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DSGEF6RHOTw0G9ukSVTk03U8atyoQ/Zui8hcUSFfT0=;
 b=Gn5y1PDxgEwDi0QYFjq+Nhj7UVi2pOzOLvu5W/YgWIcHQaZr4roQTZ31mj8xM0w6hET9ig
 6DBWWI/G+IaHn4Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E90D13918;
 Wed,  2 Sep 2026 11:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wGuYCbcCmGpzQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 02 Sep 2026 11:04:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 02 Sep 2026 13:04:21 +0200
MIME-Version: 1.0
Message-Id: <20260902-keyctl_coverage-v1-6-d29dfa2ebcef@suse.com>
References: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
In-Reply-To: <20260902-keyctl_coverage-v1-0-d29dfa2ebcef@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788347062; l=2691;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=M7oUhw3YsVdSpqEULspBvfRARCsNZleqDVxVnNCZSv4=;
 b=NIIW66PpQcJfyL1fDb5+dCN2Vp/ginGvRdrAckjJt9bGqG+r1nZhnaLM/4gr2XRdlcc/dFiBD
 sE9XzrLB/SNALAq/evt3Ip9EHSPNC1biHQC+97C97sLbiqT6GnkTFCM
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 15FA321E2D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 06/33] keyctl14: Negative tests for KEYCTL_DESCRIBE
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
