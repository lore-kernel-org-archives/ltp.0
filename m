Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DED1E77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 14:13:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35B553C2677
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 15:13:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04C1B3C185A
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:20 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 907711B601DB
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 15:11:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3D6AC1F393
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmwl90JXEwtz2yiGF5TFkL4BWQlqpkxaT6K6hXa8nHo=;
 b=klAmYSN5nHNOSElayhmh5I0yBf6ptFErzC5XI37v65OREsDkfOHk9jZjXQTwMT6+8Vm7lL
 iSpPa4t8T2Qc7EgEnyIVaR3i//2YvhLBdHYJnmi77L24WmT1RJn3j9PWUHTJ302sJfDoKT
 nyxoCfB6vZS4iVtS7kFaP8bhlDxJ1/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431879;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmwl90JXEwtz2yiGF5TFkL4BWQlqpkxaT6K6hXa8nHo=;
 b=eFq2HIhkU5zjvNCodPEb+AjxM5KClUEa2+WHrA3nrG/bSKr+R0zUsogqiZWmDFJiCLKI9l
 qCpP7EXtykLPBYCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=klAmYSN5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eFq2HIhk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736431879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmwl90JXEwtz2yiGF5TFkL4BWQlqpkxaT6K6hXa8nHo=;
 b=klAmYSN5nHNOSElayhmh5I0yBf6ptFErzC5XI37v65OREsDkfOHk9jZjXQTwMT6+8Vm7lL
 iSpPa4t8T2Qc7EgEnyIVaR3i//2YvhLBdHYJnmi77L24WmT1RJn3j9PWUHTJ302sJfDoKT
 nyxoCfB6vZS4iVtS7kFaP8bhlDxJ1/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736431879;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmwl90JXEwtz2yiGF5TFkL4BWQlqpkxaT6K6hXa8nHo=;
 b=eFq2HIhkU5zjvNCodPEb+AjxM5KClUEa2+WHrA3nrG/bSKr+R0zUsogqiZWmDFJiCLKI9l
 qCpP7EXtykLPBYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2763213A9E
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yDLQBwfZf2eVWgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 09 Jan 2025 14:11:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 09 Jan 2025 15:11:14 +0100
MIME-Version: 1.0
Message-Id: <20250109-fix_setsid_tests-v3-11-2ce60c904019@suse.com>
References: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
In-Reply-To: <20250109-fix_setsid_tests-v3-0-2ce60c904019@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736431876; l=2032;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=f63bHiLC+vCxuadyyymZ9i2MRg38+NWrKz6EZZMmmuI=;
 b=sQoSvViqLCb85CXJoRT8OyjUPHakf2mGD+847Ipi8DtFjIgJepGx60G6DOFpuy8a7uuRRIm6Q
 qNuyyH8b8QQCm8HrTzhk8EofjuIJ8fWR0H+carwbJGDY8wms3L5GD37
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 3D6AC1F393
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 11/12] Add pty08 test
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
