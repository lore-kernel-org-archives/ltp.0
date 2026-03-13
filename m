Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F312105F79A
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 11:09:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F16D43E2386
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 12:09:21 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FE853E52AD
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:07:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 40B1C1400125
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:07:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 24E225BD7B;
 Fri, 13 Mar 2026 11:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773400050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zzwO54kt+9ZyJcvh+l9eXAAvVtnDSgYeDrLL06fGqho=;
 b=0OM1W3WNCGRsOHXjqBLDYy6tQscX72y3raUL7uLz8iilvceiHdNgmSTW3kiA5k2KkGIIwm
 o+fJ3yCKAlRiEaELbMoNPAdQBpcD8lQFuXMcoPq4Ou3vyA07y+I6S58hqQcM97JEfUPl1S
 oQxmGUwJ5cUZFrJ8kTlWdLSrqJ7NRiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773400050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zzwO54kt+9ZyJcvh+l9eXAAvVtnDSgYeDrLL06fGqho=;
 b=9DlIueKx/W7uw1+pIy0w3XusbePJPp4LtxVhmn+D70CwkfT1illfDCVeHv7J/A2c/1SR0T
 3WoZu8RAFc/rZkBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0OM1W3WN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9DlIueKx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773400050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zzwO54kt+9ZyJcvh+l9eXAAvVtnDSgYeDrLL06fGqho=;
 b=0OM1W3WNCGRsOHXjqBLDYy6tQscX72y3raUL7uLz8iilvceiHdNgmSTW3kiA5k2KkGIIwm
 o+fJ3yCKAlRiEaELbMoNPAdQBpcD8lQFuXMcoPq4Ou3vyA07y+I6S58hqQcM97JEfUPl1S
 oQxmGUwJ5cUZFrJ8kTlWdLSrqJ7NRiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773400050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zzwO54kt+9ZyJcvh+l9eXAAvVtnDSgYeDrLL06fGqho=;
 b=9DlIueKx/W7uw1+pIy0w3XusbePJPp4LtxVhmn+D70CwkfT1illfDCVeHv7J/A2c/1SR0T
 3WoZu8RAFc/rZkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0794C404BF;
 Fri, 13 Mar 2026 11:07:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cEYNAPLvs2ndbAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 13 Mar 2026 11:07:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 13 Mar 2026 12:07:30 +0100
MIME-Version: 1.0
Message-Id: <20260313-listns-v1-4-04ef0081a377@suse.com>
References: <20260313-listns-v1-0-04ef0081a377@suse.com>
In-Reply-To: <20260313-listns-v1-0-04ef0081a377@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773400049; l=2885;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=fP6lMuEX2+1RN05R6MHYRpFPLKbIO0pgx8FVfuan76w=;
 b=u5HQAJnmqXlg76mW8Uwf097cBO2dpKWa6viKKirq9+0XoklOMJENkUFO50/LFXtt1nkPSJsSo
 ZVupJZitKBYCpoPd3JGBJijDC9NKWpu3dEIFDDCVpQVqLej1nj1xq70
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 24E225BD7B
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] syscalls: add listns01 test for EFAULT on invalid
 address
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

Verify that listns() returns EFAULT when given a completely invalid
address or a NULL pointer as the output buffer.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/listns/.gitignore |  1 +
 testcases/kernel/syscalls/listns/Makefile   |  7 ++++
 testcases/kernel/syscalls/listns/listns01.c | 56 +++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/testcases/kernel/syscalls/listns/.gitignore b/testcases/kernel/syscalls/listns/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..396d6b6fbfb3e34f17c79bfa3d5cc60f76477584
--- /dev/null
+++ b/testcases/kernel/syscalls/listns/.gitignore
@@ -0,0 +1 @@
+listns01
diff --git a/testcases/kernel/syscalls/listns/Makefile b/testcases/kernel/syscalls/listns/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..13755014997afbdc389e1a8fb1b0f0df36c81f21
--- /dev/null
+++ b/testcases/kernel/syscalls/listns/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/listns/listns01.c b/testcases/kernel/syscalls/listns/listns01.c
new file mode 100644
index 0000000000000000000000000000000000000000..e9211e0ef9baf68698fbd9f3500d0ec00cd13590
--- /dev/null
+++ b/testcases/kernel/syscalls/listns/listns01.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Test listns() EFAULT error handling with invalid buffer pointers.
+ *
+ * Verify that listns() returns EFAULT when given a completely invalid
+ * address or a NULL pointer as the output buffer.
+ */
+
+#define _GNU_SOURCE
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/listns.h"
+
+static struct tcase {
+	const char *desc;
+	uintptr_t bad_ptr_val;
+	size_t nr_ids;
+} tcases[] = {
+	{
+		.desc = "completely invalid pointer",
+		.bad_ptr_val = 0xdeadbeef,
+		.nr_ids = 10,
+	},
+	{
+		.desc = "NULL buffer",
+		.bad_ptr_val = 0,
+		.nr_ids = 10,
+	},
+};
+
+static void verify_listns(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	struct listns_req req = { .size = NS_ID_REQ_SIZE_VER0 };
+
+	TST_EXP_FAIL2(listns(&req, (uint64_t *)tc->bad_ptr_val, tc->nr_ids, 0),
+		      EFAULT, "listns() %s", tc->desc);
+}
+
+static void setup(void)
+{
+	struct listns_req req = { .size = NS_ID_REQ_SIZE_VER0 };
+
+	tst_syscall(__NR_listns, &req, NULL, 0, 0);
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_listns,
+	.setup = setup,
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
