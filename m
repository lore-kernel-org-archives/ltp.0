Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE457C02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 11:39:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BFBA3C7D0F
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 12:39:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 391AC3C7BCD
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:36:07 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A556A14004E1
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:36:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A6D80211D7
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737027365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmwl90JXEwtz2yiGF5TFkL4BWQlqpkxaT6K6hXa8nHo=;
 b=b7m6nxbVmzx1s+1v3a9hpGGtSbMEjAUt1KKoOjEz0TQobRfEbgAeNbLvvFDPQOA1iq1Zfm
 e/pecCOgoT21tpiNyTrFojQ7OnJYMQiB5TCbInFarpnhTgi/JdTU7TVclr8Wr+NtmZYsFd
 IioFgJAmevKrW6gCroy5Ype6c8VAxC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737027365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmwl90JXEwtz2yiGF5TFkL4BWQlqpkxaT6K6hXa8nHo=;
 b=mo1ThskXs3ZANmbP4QlynP/iVeThPyvQVjDTWwdOf3sAz5LzpIhVPQp0jRGWGtzhINGtqQ
 qY6a7g2p4PYg7pBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=b7m6nxbV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mo1ThskX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737027365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmwl90JXEwtz2yiGF5TFkL4BWQlqpkxaT6K6hXa8nHo=;
 b=b7m6nxbVmzx1s+1v3a9hpGGtSbMEjAUt1KKoOjEz0TQobRfEbgAeNbLvvFDPQOA1iq1Zfm
 e/pecCOgoT21tpiNyTrFojQ7OnJYMQiB5TCbInFarpnhTgi/JdTU7TVclr8Wr+NtmZYsFd
 IioFgJAmevKrW6gCroy5Ype6c8VAxC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737027365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmwl90JXEwtz2yiGF5TFkL4BWQlqpkxaT6K6hXa8nHo=;
 b=mo1ThskXs3ZANmbP4QlynP/iVeThPyvQVjDTWwdOf3sAz5LzpIhVPQp0jRGWGtzhINGtqQ
 qY6a7g2p4PYg7pBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 886B413AEC
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8MxNHSXviGdrOgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 11:36:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Jan 2025 12:36:10 +0100
MIME-Version: 1.0
Message-Id: <20250116-fix_setsid_tests-v4-11-910f062a7235@suse.com>
References: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
In-Reply-To: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737027362; l=2032;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=f63bHiLC+vCxuadyyymZ9i2MRg38+NWrKz6EZZMmmuI=;
 b=a0k9jBT+AA33URaUm5D68ngI4dBEmP+KeBiczXxYQ6YdHoTFXU2DgSui4xswnqM9DSvHuNzlz
 37tr9iA+KSNCseElUu97OUb+V1ZgAzne4yM7juo1CL+axkTW6DC66ay
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: A6D80211D7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 11/12] Add pty08 test
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

Verify that slave pseudo-terminal fails reading/writing if master has
been closed.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/pty                     |  1 +
 testcases/kernel/pty/.gitignore |  1 +
 testcases/kernel/pty/pty08.c    | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/runtest/pty b/runtest/pty
index 6343da391ba17627abaf09aa5a23509e4f745556..365a46ee9730aa36b22dbbdbfba82ac0d491ac94 100644
--- a/runtest/pty
+++ b/runtest/pty
@@ -6,6 +6,7 @@ pty04 pty04
 pty05 pty05
 pty06 pty06
 pty07 pty07
+pty08 pty08
 ptem01 ptem01
 ptem02 ptem02
 ptem03 ptem03
diff --git a/testcases/kernel/pty/.gitignore b/testcases/kernel/pty/.gitignore
index 630d7fcf7b0e0adfbc21b793fa456d6c5f5e4ad9..7d8d4dceda84f2e2695a8bee39abfe894288b8b6 100644
--- a/testcases/kernel/pty/.gitignore
+++ b/testcases/kernel/pty/.gitignore
@@ -12,3 +12,4 @@
 /pty05
 /pty06
 /pty07
+/pty08
diff --git a/testcases/kernel/pty/pty08.c b/testcases/kernel/pty/pty08.c
new file mode 100644
index 0000000000000000000000000000000000000000..45e99d18ba898ce24b4151f79554b5f49a9b7586
--- /dev/null
+++ b/testcases/kernel/pty/pty08.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines  Corp., 2002
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that slave pseudo-terminal fails reading/writing if master has been
+ * closed.
+ */
+
+#define _GNU_SOURCE
+
+#include "common.h"
+
+static void run(void)
+{
+	int slavefd;
+	int masterfd;
+	char buf;
+
+	masterfd = open_master();
+	slavefd = open_slave(masterfd);
+
+	tst_res(TINFO, "Closing master communication");
+	SAFE_CLOSE(masterfd);
+
+	TST_EXP_EQ_LI(read(slavefd, &buf, 1), 0);
+	TST_EXP_FAIL(write(slavefd, &buf, 1), EIO);
+
+	SAFE_CLOSE(slavefd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
