Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC98C88E50
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:30:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82BE53E9237
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 17:30:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE6163E5494
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 17:30:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 44E2B600B24
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 17:30:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 718C81FEF2;
 Fri, 11 Sep 2026 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789140600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rnsIIKISKMtrZkCJmdP4fKQkddvAx/Dg753x82K02LE=;
 b=i2RVQ0DiqyDIfNG4jDPsLPshCDkXQEM686+2oY3nDJqNGwaBwQuaPJSnAYr9+vrNloBFfN
 SUU4XDec7JOllpFRU/pNUhQaUQ7k2kLesMblZi2DT47XXuR28U0eAwvvd3hK3vmQs9iTs9
 /6/zPLDPZnltm7v5f7tpqgYv5JP5sZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789140600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rnsIIKISKMtrZkCJmdP4fKQkddvAx/Dg753x82K02LE=;
 b=5bUABy00/8Cg1A64mT8eeV266LW+N7SjM5SPxpzvZr8+eUsuuP68Z1N76UD38fdLfqaYg3
 AKSsqvMB9i8ODOAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789140596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rnsIIKISKMtrZkCJmdP4fKQkddvAx/Dg753x82K02LE=;
 b=zwDFPKZcXV5bnKGhERu5WIFGJ+Flu3OXmKAtjEySmIWT94PpfNPuZ+lT+HPrtVlRbb17bX
 xMd5c0z/tN83MfHN64loSmaOja8vjsC49igHCbd+cC9C1VggV2fkKce3LOgZA3F8P++tEM
 0yc8sJuv94qI1ddK54/3uzsjeQXOdJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789140596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rnsIIKISKMtrZkCJmdP4fKQkddvAx/Dg753x82K02LE=;
 b=kXJANx5wL+wX3aEcWDRHIXmEAqbwIIqbf2yPAUSzYdCOdFHXEbG5dbxxKcbhIE/uFGhgjJ
 INdNQwTaBf+cT/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3121413770;
 Fri, 11 Sep 2026 15:29:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SIk9CnQepGoNOAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Sep 2026 15:29:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 17:29:54 +0200
MIME-Version: 1.0
Message-Id: <20260911-mmap_32bit_coverage-v3-2-b0608349556d@suse.com>
References: <20260911-mmap_32bit_coverage-v3-0-b0608349556d@suse.com>
In-Reply-To: <20260911-mmap_32bit_coverage-v3-0-b0608349556d@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789140595; l=2273;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=8/9nf6OhxD2ULrVckBydbhpM4PhM4AnT4Sqjdl0WTOQ=;
 b=vv9S+DuiRYZAtOVD8I9LeNyF6hUFmAytUorylmQitVswxlcdMo2oSV6WD+CZF+x8z02rlOD9A
 tu9mQ4GZKngBgj+THXpBgw7fzHsalNGRyy0Kl2lCxNi5I549gfDSyUM
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] mmap23: add test for MAP_32BIT oversized
 mapping
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                          |  1 +
 testcases/kernel/syscalls/mmap/.gitignore |  1 +
 testcases/kernel/syscalls/mmap/mmap23.c   | 36 +++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index ca190dd97..56f88c0b6 100644
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
