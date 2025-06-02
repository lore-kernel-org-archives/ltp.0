Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE5CC54FB3
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 16:42:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6808F3C9DB9
	for <ltp@archiver.kernel.org>; Mon,  2 Jun 2025 18:42:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12CD83C9879
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:42:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CA39B1A00CA0
 for <ltp@lists.linux.it>; Mon,  2 Jun 2025 18:42:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DB3911F7A1;
 Mon,  2 Jun 2025 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748882530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iimfW5Wc751VeAkeZX4v57A+vWHL25w1O1yaAQLDr6A=;
 b=kLofwInzA0lROE+ksnn37pnO46wB4S2QFdoDivA/gGIGFd8zdffj9lEaHf+wUXi+LLBR3O
 0zWKDVp7OvgztQ9rDPMe9XI0UYuM1Eu5v6KKCB10S1HF2tEC6Ua3WbXcWXEtji1retj+op
 9LaoPGjoPOi0o+BUBMSheYU2gKP3PZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748882530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iimfW5Wc751VeAkeZX4v57A+vWHL25w1O1yaAQLDr6A=;
 b=Fh7DPBmqG4pJ6AfAPyd1/cLe5Jc4S33f9S7aWubCY/pmRK94KRISQbpE3gfDccZRyrC7kW
 fyE679ECRhoNpIBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s0h2Lpd8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gAY5BXsS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748882529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iimfW5Wc751VeAkeZX4v57A+vWHL25w1O1yaAQLDr6A=;
 b=s0h2Lpd84MuAlROvZBltAUeIqXUCp+QeSZPGcSrolv/MHiDUvEikJgw22IPcmggxUpLw3E
 bzFIPn9Pg+9Fv1/R8xvbObECFfzBV5XYflxm0x/JvZ69+KdzMdPe+A4FHQnsl9u5aQvQ+H
 4zchJ3KhWkD0fMCdeke1XX1bFlG9FCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748882529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iimfW5Wc751VeAkeZX4v57A+vWHL25w1O1yaAQLDr6A=;
 b=gAY5BXsS/CHYO9QYQwGADHZDNf2pcxLwS0IAaFtWHwtaa9G9WtbPJFH1RF3/MuTfcFs5CG
 s/G50Q6Uy8uyyuCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFC3E13AE1;
 Mon,  2 Jun 2025 16:42:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sGoNLWHUPWgGFwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 02 Jun 2025 16:42:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 02 Jun 2025 18:41:27 +0200
MIME-Version: 1.0
Message-Id: <20250602-lsm-v5-4-5c0dd01df3c4@suse.com>
References: <20250602-lsm-v5-0-5c0dd01df3c4@suse.com>
In-Reply-To: <20250602-lsm-v5-0-5c0dd01df3c4@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748882528; l=3189;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=X23Jz2DmVEjxU3lgorM+woTcexL2woxncOTbo2m8Afg=;
 b=icK7iXfkGHoUE3SuRSwytpZm2Xn+eq63f4fs54Di5evEt1O7bzoy1/CBwlR5kfYG6RDCj2Ibz
 nw0Y7ivR6EUCcs9LHtCsqbIRt39GoZLfg15pg14QvKhkfKKBMFuNNos
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 ASN(0.00)[asn:9498, ipnet:::/1, country:IN]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: DB3911F7A1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 4/7] Add lsm_get_self_attr03 test
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

Verify that LSM_ATTR_CURRENT attribute is correctly recognizing
the current, active security context of the process. This is done by
checking that /proc/self/attr/current matches with the obtained value.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/lsm/.gitignore           |  1 +
 .../kernel/syscalls/lsm/lsm_get_self_attr03.c      | 68 ++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 2c69e2cc93d2bea73a4849cbb406d3f87ba41d15..ac3c46ee9f8ae84cbbef18ef0c18bf224dd46964 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -760,6 +760,7 @@ lseek11 lseek11
 
 lsm_get_self_attr01 lsm_get_self_attr01
 lsm_get_self_attr02 lsm_get_self_attr02
+lsm_get_self_attr03 lsm_get_self_attr03
 
 lstat01 lstat01
 lstat01_64 lstat01_64
diff --git a/testcases/kernel/syscalls/lsm/.gitignore b/testcases/kernel/syscalls/lsm/.gitignore
index 9f7c9b00b026a377f1b36f483ac2c1a0adba6249..19956fdf8b9952b4850c3a20826e29ec67ea3560 100644
--- a/testcases/kernel/syscalls/lsm/.gitignore
+++ b/testcases/kernel/syscalls/lsm/.gitignore
@@ -1,2 +1,3 @@
 lsm_get_self_attr01
 lsm_get_self_attr02
+lsm_get_self_attr03
diff --git a/testcases/kernel/syscalls/lsm/lsm_get_self_attr03.c b/testcases/kernel/syscalls/lsm/lsm_get_self_attr03.c
new file mode 100644
index 0000000000000000000000000000000000000000..68d348de0fe99dd9fada4230f1f3cc0c0401ea8e
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_get_self_attr03.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that LSM_ATTR_CURRENT attribute is correctly recognizing
+ * the current, active security context of the process. This is done by
+ * checking that /proc/self/attr/current matches with the obtained value.
+ */
+
+#include "lsm_common.h"
+
+static struct lsm_ctx *ctx;
+static uint32_t page_size;
+
+static void run(void)
+{
+	tst_res(TINFO, "Verifying 'LSM_ATTR_CURRENT' attribute");
+
+	uint32_t count;
+	uint32_t size = page_size;
+	char attr[size];
+
+	memset(attr, 0, size);
+	memset(ctx, 0, LSM_CTX_SIZE_DEFAULT);
+
+	count = TST_EXP_POSITIVE(
+		lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size, 0));
+
+	if (TST_RET == -1)
+		return;
+
+	if (!count) {
+		tst_res(TFAIL, "Can't read any attribute");
+		return;
+	}
+
+	read_proc_attr("current", attr, page_size);
+
+	TST_EXP_EQ_STR(attr, (char *)ctx->ctx);
+
+	struct lsm_ctx *next = next_ctx(ctx);
+
+	for (uint32_t i = 1; i < count; i++) {
+		TST_EXP_EXPR(strcmp(attr, (char *)next->ctx) != 0,
+			"Attribute and next LSM context must be different");
+
+		next = next_ctx(next);
+	}
+}
+
+static void setup(void)
+{
+	verify_supported_attr_current();
+
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "6.8",
+	.bufs = (struct tst_buffers[]) {
+		{&ctx, .size = LSM_CTX_SIZE_DEFAULT},
+		{}
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
