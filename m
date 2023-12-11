Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8696C4167B
	for <ltp@archiver.kernel.org>; Mon, 11 Dec 2023 16:18:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5DA43CF848
	for <ltp@archiver.kernel.org>; Mon, 11 Dec 2023 17:18:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5E983CF7E8
 for <ltp@lists.linux.it>; Mon, 11 Dec 2023 17:18:15 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AD3251A02394
 for <ltp@lists.linux.it>; Mon, 11 Dec 2023 17:18:14 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E3ECF223F5;
 Mon, 11 Dec 2023 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702311493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv00gkRo74J9jfzwdYXpEqk1bzjq7h6c2pVFh9dc2EA=;
 b=aK712ws88xoUEHHLezIQGCLg5gH1qsrFW5jzpniqOK4p5VRVwVO6o4cd696kvVZNn52ttN
 2eFZj0AyRFHFmPkAbhWL109Frg8nWU/XL0290QO1M5Vs+aCh8XZAJmqmmnXba1ezBeVuvS
 B+mTJhnh7/V9JDCeQOdajU5WGruvsD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702311493;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv00gkRo74J9jfzwdYXpEqk1bzjq7h6c2pVFh9dc2EA=;
 b=b8SLnE9uQma9YlK78rEzaiJzAIUx98quHT0xNJRtBuICi3FHboPC1pJF60oYgJYC6PGe+z
 JkL+SHxZphm0/3BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702311492; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv00gkRo74J9jfzwdYXpEqk1bzjq7h6c2pVFh9dc2EA=;
 b=P9D2VedUY3SCeW+DSmZceWAfGnfYZMqd8GBxI9oIXjJv5Lk7WX9S1cGyxm5lAeYJcOJVAw
 0Ky1NWgCi3WyS2+vxMxKdt/eERC4A6wZtsVqdSEtM4We4YWxPUqRntcV1uGKCXh8FuEL85
 A0VfWb3+0hL6GPhpMS6aUxleST0RLNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702311492;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv00gkRo74J9jfzwdYXpEqk1bzjq7h6c2pVFh9dc2EA=;
 b=x5oAOY43zRhjjujmdrmpjB2lErLAO4q3MNlxtSaJri6AHIqo4AedDb5mYmVLEknbC34Uek
 UqNq++OswV0bpZCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D8F213A6B;
 Mon, 11 Dec 2023 16:18:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id qLuRD0Q2d2XbCwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 11 Dec 2023 16:18:12 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 11 Dec 2023 17:18:05 +0100
Message-ID: <20231211161807.526714-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211161807.526714-1-pvorel@suse.cz>
References: <20231211161807.526714-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [9.74 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(4.60)[~all];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[8];
 NEURAL_HAM_SHORT(-0.20)[-0.983]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-0.56)[-0.557]; MIME_GOOD(-0.10)[text/plain];
 DMARC_NA(1.20)[suse.cz];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spamd-Bar: +++++++++
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: E3ECF223F5
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=P9D2VedU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=x5oAOY43;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz; dmarc=none
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/3] lib/tests: Add test for testing tst_res() flags
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
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
