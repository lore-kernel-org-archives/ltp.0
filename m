Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B78AC624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:11:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A639F3E5A9A
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:11:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AD023E9796
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C22062000CE
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:09:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 35D8822B29;
 Fri,  4 Sep 2026 12:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJS9P/h9xh2elksAlKP0Y3B6wWeiRLMmSAR55qjiwms=;
 b=lRM6VDodGwyWOX1xXXdxpw4ZW0g+l1m/isFmrRdBeMrJMkYWomfn1g7Ru2a4ZXX5zRSQar
 ccrTH/ecrwnHEapwLljue+9m32uqJBVmqixVwrCZfk+GN60zX4m+DRgSMntUSOtlXDOPuL
 3ru4TdS+DibBV03GnhAUzXzQvy4p9kU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJS9P/h9xh2elksAlKP0Y3B6wWeiRLMmSAR55qjiwms=;
 b=mTQs1CpVDgm5JPZwezMhsoK65JtbelqMTKrbrhr8xX1OpXeNV9RUjS8Oz+lnkVv9hG6zB8
 qJMjpaFGDWW62cAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qV+yiQyq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5SCVUfXm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788523741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJS9P/h9xh2elksAlKP0Y3B6wWeiRLMmSAR55qjiwms=;
 b=qV+yiQyqc6cu9b+p85GFrebBpd0ayfRrX4maTvauaQwd9KTXWpA3HAg+Vxou6CXOWzQh0W
 rs1G5YhzatPsXt3amV043/CXOlW1gykmKOM02/U0hXPET+m8LrDehhCjPZML+E0c7bjBp+
 +34NESbYLhMQoU+MmpvBacEb38V6OXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788523741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJS9P/h9xh2elksAlKP0Y3B6wWeiRLMmSAR55qjiwms=;
 b=5SCVUfXmk7BEjudDcq5LtFfw8yI10vLJJnyvptWUQTzAzNvJDWTr/hk2XQlyW34vprAkGB
 il+Q+zs2DUNlHwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 514E513994;
 Fri,  4 Sep 2026 12:08:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gIQ1Eda0mmpENgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 04 Sep 2026 12:08:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 04 Sep 2026 14:09:00 +0200
MIME-Version: 1.0
Message-Id: <20260904-keyctl_coverage-v2-11-43b78b15ef9f@suse.com>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
In-Reply-To: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788523731; l=2299;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=FXUJ4fL0RSqLZSy0bfMx65qehuajc481hZyXGruJ/AA=;
 b=nddhuBPo/VbXtGEM2LDmKmSHBccNVc5EveollC5k1SQozEoQeMF0cbnrQSSr8cE2DMMKp2ePr
 THBxOydDWWbDwsuhLGO1ixyudPgmBYNUxANH58n97j2cLEaqBrdL01c
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: 35D8822B29
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 11/33] keyctl19: Test KEYCTL_MOVE with same source
 and destination
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

Test KEYCTL_MOVE when the source keyring equals the destination
keyring: verify the operation succeeds as a no-op and the key
remains linked in the keyring.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/keyctl/.gitignore |  1 +
 testcases/kernel/syscalls/keyctl/keyctl19.c | 43 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 895dd0fc4..1935bee31 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -736,6 +736,7 @@ keyctl15 keyctl15
 keyctl16 keyctl16
 keyctl17 keyctl17
 keyctl18 keyctl18
+keyctl19 keyctl19
 
 kcmp01 kcmp01
 kcmp02 kcmp02
diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
index 808cd2d23..f32107923 100644
--- a/testcases/kernel/syscalls/keyctl/.gitignore
+++ b/testcases/kernel/syscalls/keyctl/.gitignore
@@ -16,3 +16,4 @@
 /keyctl16
 /keyctl17
 /keyctl18
+/keyctl19
diff --git a/testcases/kernel/syscalls/keyctl/keyctl19.c b/testcases/kernel/syscalls/keyctl/keyctl19.c
new file mode 100644
index 000000000..389ad7603
--- /dev/null
+++ b/testcases/kernel/syscalls/keyctl/keyctl19.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test ``KEYCTL_MOVE`` of :manpage:`keyctl(2)` with same source and destination.
+ *
+ * [Algorithm]
+ *
+ * - move a key where the source keyring equals the destination keyring,
+ *   verify it is a successful no-op
+ */
+
+#include "keyctl_common.h"
+
+#define RING_DESC	"ltpkeyctl19"
+#define KEY_DESC	"k"
+#define PAYLOAD		"payload"
+
+static key_serial_t ring;
+static key_serial_t key;
+
+static void setup(void)
+{
+	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
+
+	ring = new_ring(RING_DESC);
+	key = new_user_key(KEY_DESC, PAYLOAD, sizeof(PAYLOAD), ring);
+}
+
+static void run(void)
+{
+	TST_EXP_PASS(keyctl(KEYCTL_MOVE, key, ring, ring, 0));
+
+	TST_EXP_EQ_LI(search_ring(ring, "user", KEY_DESC), key);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.min_kver = "5.3",
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
