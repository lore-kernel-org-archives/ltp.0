Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84E1C4167B
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 21:28:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E3A43CF037
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 22:28:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 108263CBB89
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 22:27:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 339871A00EF2
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 22:27:45 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0491E1FD70;
 Thu,  7 Dec 2023 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701984465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv00gkRo74J9jfzwdYXpEqk1bzjq7h6c2pVFh9dc2EA=;
 b=qfmxlFHIlIYy1FdMOrwfWT4dEZ12RLZMs9tUOu+DunCI4QfUPusQ+m0PAGBboLLqGU/QA4
 SwUrsjXgeFHIV+sqTqQ4ZqP4otNusRujApvbBrhnDX5/dBMeOoYF3K9ZPAx75YTzjTaEnI
 WyIKj8ZBphVYbtvRaNi2p4mQdwsCFL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701984465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv00gkRo74J9jfzwdYXpEqk1bzjq7h6c2pVFh9dc2EA=;
 b=lckTLGap5hjAquB0ZFSXfCNVx6XyMXNNEQak9SkNhoecgq/zuZbtOU0sMJCj+H8c8wkxNZ
 35Hr96wkIvV9YfDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701984465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv00gkRo74J9jfzwdYXpEqk1bzjq7h6c2pVFh9dc2EA=;
 b=qfmxlFHIlIYy1FdMOrwfWT4dEZ12RLZMs9tUOu+DunCI4QfUPusQ+m0PAGBboLLqGU/QA4
 SwUrsjXgeFHIV+sqTqQ4ZqP4otNusRujApvbBrhnDX5/dBMeOoYF3K9ZPAx75YTzjTaEnI
 WyIKj8ZBphVYbtvRaNi2p4mQdwsCFL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701984465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv00gkRo74J9jfzwdYXpEqk1bzjq7h6c2pVFh9dc2EA=;
 b=lckTLGap5hjAquB0ZFSXfCNVx6XyMXNNEQak9SkNhoecgq/zuZbtOU0sMJCj+H8c8wkxNZ
 35Hr96wkIvV9YfDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 87D3013B96;
 Thu,  7 Dec 2023 21:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id INbWHtA4cmXtHQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Dec 2023 21:27:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  7 Dec 2023 22:27:36 +0100
Message-ID: <20231207212739.302374-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207212739.302374-1-pvorel@suse.cz>
References: <20231207212739.302374-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] lib/tests: Add test for testing tst_res() flags
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/tst_res_flags.c | 45 ++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 lib/newlib_tests/tst_res_flags.c

diff --git a/lib/newlib_tests/tst_res_flags.c b/lib/newlib_tests/tst_res_flags.c
new file mode 100644
index 000000000..dc8f27e74
--- /dev/null
+++ b/lib/newlib_tests/tst_res_flags.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
+ */
+
+/*
+ * Test tst_res() flags.
+ */
+
+#include "tst_test.h"
+
+#define FLAG(x) .flag = x, .str = #x
+static struct tcase {
+	int flag;
+	const char *str;
+} tcases[] = {
+	{FLAG(TPASS)},
+	{FLAG(TFAIL)},
+	{FLAG(TBROK)},
+	{FLAG(TCONF)},
+	{FLAG(TWARN)},
+	{FLAG(TINFO)},
+};
+
+static void do_cleanup(void)
+{
+	tst_brk(TBROK, "TBROK message should be TWARN in cleanup");
+}
+
+static void do_test(unsigned int n)
+{
+	int flag = tcases[n].flag;
+	const char *str = tcases[n].str;
+
+	tst_res(flag, "%s message", str);
+
+	if (flag == TWARN || flag == TINFO)
+		tst_res(TPASS, "%s message is not a result", str);
+}
+
+static struct tst_test test = {
+	.test = do_test,
+	.tcnt = ARRAY_SIZE(tcases),
+	.cleanup = do_cleanup,
+};
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
