Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9CAC61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 15:37:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60D6D3E9A61
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 17:37:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA81F3E5E02
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 17:36:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4FDCE600100
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 17:36:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6B2FC222BC;
 Fri, 28 Aug 2026 15:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787931383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DUGNktAWEh1/wcP67WgNNo6tBvr06AbAl98M7sDzj5A=;
 b=UIxrA9BBtmfWCfKzXOt5ooFrxVd/l4rnVtobGD9RTa6WmCRPQMGrD3Ld3j7T+a43HDO52F
 /aBYka15VdIo+dsl58on3vhCAS6tX/qncxu7XHhJP9dDTcB+O2eR1Yxb6Cx6chCsc1i5Yi
 MLgCqwGMSLpfifd8z6wAcPO6nTWFEbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787931383;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DUGNktAWEh1/wcP67WgNNo6tBvr06AbAl98M7sDzj5A=;
 b=SU5VLQAu0VQPvrc/1ZU5jyMNivRYVrf8BknbqRhgL2p09Aq5+7KdK0kvF556ri1zOCoF0l
 K9Gx7OBEbkQLHeBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xVvHXWgM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WuqgnPTt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787931379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DUGNktAWEh1/wcP67WgNNo6tBvr06AbAl98M7sDzj5A=;
 b=xVvHXWgMpAhx6mcZPwTJsXrI/Qczv72Ge4UXH7d3UvHaPyYol1O0PsBPl/IOepAZ6kISaA
 6KBnrRFgo9G4W0MQae5hgJBMSzHR6mqKFydJ08U1WPcJEt8fqhVT/hfe2A1MyzFRik04K+
 ALlHhMiOAa6Ttq07VSpX5ys+xU0Fm4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787931379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DUGNktAWEh1/wcP67WgNNo6tBvr06AbAl98M7sDzj5A=;
 b=WuqgnPTtPsqG6l4pJWdBSy1KpLdK46Z8jALcVZoiGVh5MWkxEibckTFId3mx05su69JnXv
 oix0Usu3GVVkiIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3651513675;
 Fri, 28 Aug 2026 15:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aPWvC/OqkWrebQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Aug 2026 15:36:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 17:36:04 +0200
MIME-Version: 1.0
Message-Id: <20260828-mmap_32bit_coverage-v1-2-7f0b8b589773@suse.com>
References: <20260828-mmap_32bit_coverage-v1-0-7f0b8b589773@suse.com>
In-Reply-To: <20260828-mmap_32bit_coverage-v1-0-7f0b8b589773@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931378; l=2231;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=WmZzlqNQbJ53UbPZwVy7jhI+acKdz+aJEvW7M5gB3PA=;
 b=6hCeM7P+rOiXigabIL2nq2XxDdFVUWwX4yEnpYkT5N6dmfDEZEadfGrEbHbWodaBXYR58Y2W1
 fj4axnwxydkA4mXFc8vQHbNE+azpj6+gD+skAZWTOHlkAfQXDwRcfbS
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6B2FC222BC
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] mmap23: add test for MAP_32BIT oversized mapping
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

Add a test verifying that mmap() with the MAP_32BIT flag fails
with ENOMEM when requesting a mapping of size >= 2GB, since it
cannot fit within the first 2GB of address space.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/mmap/.gitignore |  1 +
 testcases/kernel/syscalls/mmap/mmap23.c   | 36 +++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 737c63e31..a264f42c8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -890,6 +890,7 @@ mmap20 mmap20
 mmap21_01 mmap21 -m 1
 mmap21_02 mmap21
 mmap22 mmap22
+mmap23 mmap23
 
 modify_ldt01 modify_ldt01
 modify_ldt02 modify_ldt02
diff --git a/testcases/kernel/syscalls/mmap/.gitignore b/testcases/kernel/syscalls/mmap/.gitignore
index 075be933d..dd332e9a1 100644
--- a/testcases/kernel/syscalls/mmap/.gitignore
+++ b/testcases/kernel/syscalls/mmap/.gitignore
@@ -19,3 +19,4 @@
 /mmap20
 /mmap21
 /mmap22
+/mmap23
diff --git a/testcases/kernel/syscalls/mmap/mmap23.c b/testcases/kernel/syscalls/mmap/mmap23.c
new file mode 100644
index 000000000..4eb7bf6e9
--- /dev/null
+++ b/testcases/kernel/syscalls/mmap/mmap23.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that :manpage:`mmap(2)` with the MAP_32BIT flag fails with ENOMEM
+ * when requesting a mapping of size >= 2GB, since it cannot fit within the
+ * first 2GB of address space.
+ *
+ * MAP_32BIT is supported only on x86-64 for 64-bit programs.
+ */
+
+#include "tst_test.h"
+#include "lapi/mmap.h"
+
+#define MAP_SZ (2UL * TST_GB)
+
+static void run(void)
+{
+	TST_EXP_FAIL_PTR_VOID(mmap(NULL, MAP_SZ, PROT_READ | PROT_WRITE,
+				   MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0),
+			      ENOMEM,
+			      "mmap(2GB) with MAP_32BIT");
+
+	if (TST_RET_PTR != MAP_FAILED)
+		SAFE_MUNMAP(TST_RET_PTR, MAP_SZ);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.supported_archs = (const char *const []){
+		"x86_64",
+		NULL
+	},
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
