Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA43105F78C
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 11:49:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B45F3E48FF
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 12:49:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13CB53E52A6
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:48:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 94DA3602236
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 12:48:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F8DF5BD6A;
 Fri, 13 Mar 2026 11:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773402501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6kKkvKMiTMyaE6f777cW69RJ5PLB5HzdidnWTfF5Y0=;
 b=zmNy91cbdcZ6hFY8wIKJCEtZ8uQJ7u9al/JyyVEItDhikVBV8UcpR0HhU15tRMPtRcLWvg
 RNrJ9x4RBTvwqLRKuc1RPjKuvaK+f1+wiH46BqX4EYb9UikJpZdkU3nlkdCKoygLAlhTub
 YvKD0QxTkF9N8f69fXoocWNGBlB8kWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773402501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6kKkvKMiTMyaE6f777cW69RJ5PLB5HzdidnWTfF5Y0=;
 b=M/Y++ToWvNDHprpDURPgTOMHxXLEaOpvLvalwBCs1Ihz+Pyvb7XnVmdcBv53O5TIHlGz5i
 i2EIGDjLlMJtovBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773402501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6kKkvKMiTMyaE6f777cW69RJ5PLB5HzdidnWTfF5Y0=;
 b=zmNy91cbdcZ6hFY8wIKJCEtZ8uQJ7u9al/JyyVEItDhikVBV8UcpR0HhU15tRMPtRcLWvg
 RNrJ9x4RBTvwqLRKuc1RPjKuvaK+f1+wiH46BqX4EYb9UikJpZdkU3nlkdCKoygLAlhTub
 YvKD0QxTkF9N8f69fXoocWNGBlB8kWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773402501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/6kKkvKMiTMyaE6f777cW69RJ5PLB5HzdidnWTfF5Y0=;
 b=M/Y++ToWvNDHprpDURPgTOMHxXLEaOpvLvalwBCs1Ihz+Pyvb7XnVmdcBv53O5TIHlGz5i
 i2EIGDjLlMJtovBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24760404E8;
 Fri, 13 Mar 2026 11:48:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CDwtB4X5s2lZGQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 13 Mar 2026 11:48:21 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 13 Mar 2026 12:48:22 +0100
MIME-Version: 1.0
Message-Id: <20260313-listns-v2-4-38384fae9b1f@suse.com>
References: <20260313-listns-v2-0-38384fae9b1f@suse.com>
In-Reply-To: <20260313-listns-v2-0-38384fae9b1f@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773402500; l=3335;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Uvnwjh1q7gql5Udr5AB2eaLTuVtiMmAJgDmerlevwgY=;
 b=WsnK7YbNjaC2Auf3jSjIn8KLhJKitsehs1JgT4HHg0gPoAE+NYmx+BsQx1u517tqvYmdTrJcE
 Yej/w2VnrpyDvgJsfAqYBZdHIQysoJASamDOmoMCrQ8Tc86dBUL5IVL
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/5] syscalls: add listns01 test for EFAULT on
 invalid address
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
 runtest/syscalls                            |  2 ++
 testcases/kernel/syscalls/listns/.gitignore |  1 +
 testcases/kernel/syscalls/listns/Makefile   |  7 ++++
 testcases/kernel/syscalls/listns/listns01.c | 56 +++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 2179e007c0d72fa2834a1a52b97d888a8ffb4578..769ce4a89a325ea09fdf2cfd42576697f23352c4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -759,6 +759,8 @@ listmount02 listmount02
 listmount03 listmount03
 listmount04 listmount04
 
+listns01 listns01
+
 listxattr01 listxattr01
 listxattr02 listxattr02
 listxattr03 listxattr03
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
