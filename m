Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD84E77188
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 10:32:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28A803C3088
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 11:32:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C506F3C2F3F
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 11:31:27 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 379D6100B8C8
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 11:31:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC3911F449
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 10:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736159486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwSaVukRfvETPVOQFfVQXZuu6JlMRKr0A3xfDFyifYw=;
 b=PyIJKR/Mm2/jawn0jRyJzQfM+jNhSglntt63H2WBQ53mAHUlebyB9cmu+XrYrqkgnFTECD
 nZjtFaTxjG5cXHz3KvzbzhpvJYbIrfw5IcrmKrQVeMIswCJAteeoLwiESuzFujXCZmNtP5
 YNt8sNzxuTjFXeUzJUsCvRqa9V4bhqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736159486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwSaVukRfvETPVOQFfVQXZuu6JlMRKr0A3xfDFyifYw=;
 b=2UTXyUaa4DuUTn8W3MB3wu7mZWQ7SO+JVPAwppE+2R6US7V/5iDh6SFMn0QB9C/+GJRi0r
 yAWKPjIRmtwqA9BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="PyIJKR/M";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2UTXyUaa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736159486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwSaVukRfvETPVOQFfVQXZuu6JlMRKr0A3xfDFyifYw=;
 b=PyIJKR/Mm2/jawn0jRyJzQfM+jNhSglntt63H2WBQ53mAHUlebyB9cmu+XrYrqkgnFTECD
 nZjtFaTxjG5cXHz3KvzbzhpvJYbIrfw5IcrmKrQVeMIswCJAteeoLwiESuzFujXCZmNtP5
 YNt8sNzxuTjFXeUzJUsCvRqa9V4bhqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736159486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwSaVukRfvETPVOQFfVQXZuu6JlMRKr0A3xfDFyifYw=;
 b=2UTXyUaa4DuUTn8W3MB3wu7mZWQ7SO+JVPAwppE+2R6US7V/5iDh6SFMn0QB9C/+GJRi0r
 yAWKPjIRmtwqA9BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C92F4137DA
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 10:31:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KNtoL/6we2fGfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 06 Jan 2025 10:31:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 06 Jan 2025 11:31:32 +0100
MIME-Version: 1.0
Message-Id: <20250106-fix_setsid_tests-v2-10-c43f57a2bab6@suse.com>
References: <20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com>
In-Reply-To: <20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736159485; l=2535;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=ng5Mb+kwDXiBwHf4D3c2dKygXKYLsS9wfJDJcEH5f5E=;
 b=HO/9ULlmTCPRlYwpbAh2wb5nnld/h6dy7fOuUpH0Lz0BGfZ6XLfzfYFIz9BSC/p/5DfaRjOZp
 Fj1YWiW2ed/A3heACHyTUN/ajpLbLPNnMGPablGKZ3s3BqP22bMbbkf
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: DC3911F449
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 10/11] Add pty08 test
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
 testcases/kernel/pty/pty08.c    | 57 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

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
index 0000000000000000000000000000000000000000..c4fdc937d21031845e9d429ab1e345a92fb97240
--- /dev/null
+++ b/testcases/kernel/pty/pty08.c
@@ -0,0 +1,57 @@
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
+#include "tst_test.h"
+
+#define MASTERCLONE "/dev/ptmx"
+
+static void run(void)
+{
+	int masterfd, slavefd;
+	char *slavename;
+	char buf;
+
+	masterfd = SAFE_OPEN(MASTERCLONE, O_RDWR);
+	slavename = SAFE_PTSNAME(masterfd);
+
+	tst_res(TINFO, "pts device location is %s", slavename);
+
+	if (grantpt(masterfd) == -1)
+		tst_brk(TBROK | TERRNO, "grantpt() error");
+
+	if (unlockpt(masterfd) == -1)
+		tst_brk(TBROK | TERRNO, "unlockpt() error");
+
+	slavefd = SAFE_OPEN(slavename, O_RDWR);
+
+	tst_res(TINFO, "Closing master communication");
+	SAFE_CLOSE(masterfd);
+
+	TST_EXP_FAIL(read(slavefd, &buf, 1), EIO);
+	TST_EXP_FAIL(write(slavefd, &buf, 1), EIO);
+
+	SAFE_CLOSE(slavefd);
+}
+
+static void setup(void)
+{
+	if (access(MASTERCLONE, F_OK))
+		tst_brk(TBROK, "%s device doesn't exist", MASTERCLONE);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
