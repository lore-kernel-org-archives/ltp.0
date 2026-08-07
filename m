Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3755C5AC7C
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 12:19:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2760E3E700A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 14:19:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 977563E7012
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 14:17:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F058F200AFF
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 14:17:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 694D0805F6;
 Fri,  7 Aug 2026 12:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786105049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/pv+OaJB1xXfYnFXYvEr5LP1FfP29RVJrZWxerynDo=;
 b=KPrUOLSnVsvVTac5FxvaOXDgowmNqiggpwIjc3u9U5myfG8WlH3VMxRMbnK9ClmfX9zMRa
 pQZLKYby79VI3ZLs/O0P1F+x0bOmmhfOK2DBLUKmeQd7wcZB1bZWcT1Vi24isW73/oVMVO
 j4bJDRTTGHo1Um86J0NN12tww7BTRjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786105049;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/pv+OaJB1xXfYnFXYvEr5LP1FfP29RVJrZWxerynDo=;
 b=0Y+o7ouyYW5GB6dUJW0rWpjg89OYveE0QJnOVDN5swmtsLjIZCtJg455Uce/HbsmTywKTF
 IY+X5K+63GtNdrAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UphLVCrh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=blCiEqk4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786105045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/pv+OaJB1xXfYnFXYvEr5LP1FfP29RVJrZWxerynDo=;
 b=UphLVCrhorvvdCKQA7bukLPEROWXBGSfqpBjquXSAihGr07ind8PD6B294mgUiPCj799WK
 /OE8H66qtlgo8Bdb9FMMaXW0lbol+zrbuSyOQUvTRMGGpelUju7LWZIjrki/1Vii4kFQT/
 yMhPEwbSJsNWXlztdeZdDKzwiyTJB5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786105045;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/pv+OaJB1xXfYnFXYvEr5LP1FfP29RVJrZWxerynDo=;
 b=blCiEqk4hF3vKE/4k4NniBIyagnMWmOzCKwD6OR1QU1wNG5QDn/MBPU5wSoFBwnCup0eeL
 MO1XGakMf7FFHwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5C10779D2;
 Fri,  7 Aug 2026 12:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oPpFKc7MdWqfLwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 07 Aug 2026 12:17:18 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 07 Aug 2026 14:17:15 +0200
MIME-Version: 1.0
Message-Id: <20260807-rewrite_mremap_testing_suite-v3-6-dcca6d4ac0f1@suse.com>
References: <20260807-rewrite_mremap_testing_suite-v3-0-dcca6d4ac0f1@suse.com>
In-Reply-To: <20260807-rewrite_mremap_testing_suite-v3-0-dcca6d4ac0f1@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786105036; l=4445;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=YYoFPSScMCvUuMaK3+I8ntZZZE8NAawCDDNh9QSfMaI=;
 b=Zow5RbGDZJlWiAnJOhXU4rU9zeq1vLqULuKC/Gsz1PTFaKWNP7Salo6dtUTTMX2YaUcslEce9
 YepMfXayzukAeOB6fFg9NqGDKZgMRrqq8PK2PO5gwB48xMzy1mOBesN
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 694D0805F6
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 6/7] mremap08: Extract test from mremap05
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

Extract a new test from mremap05 that verifies the behavior of the
MREMAP_FIXED flag when:

- MREMAP_FIXED | MREMAP_MAYMOVE can move a mapping to a new, free
  address, preserving its content.
- MREMAP_FIXED | MREMAP_MAYMOVE unmaps a previously existing mapping
  at the target address range and replaces it with the moved mapping.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/mremap/.gitignore |   1 +
 testcases/kernel/syscalls/mremap/mremap08.c | 127 ++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index b024d4c43..ede795a48 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -946,6 +946,7 @@ mremap04 mremap04
 mremap05 mremap05
 mremap06 mremap06
 mremap07 mremap07
+mremap08 mremap08
 
 mseal01 mseal01
 mseal02 mseal02
diff --git a/testcases/kernel/syscalls/mremap/.gitignore b/testcases/kernel/syscalls/mremap/.gitignore
index 292899e03..dd4bf4e8e 100644
--- a/testcases/kernel/syscalls/mremap/.gitignore
+++ b/testcases/kernel/syscalls/mremap/.gitignore
@@ -5,3 +5,4 @@
 /mremap05
 /mremap06
 /mremap07
+/mremap08
diff --git a/testcases/kernel/syscalls/mremap/mremap08.c b/testcases/kernel/syscalls/mremap/mremap08.c
new file mode 100644
index 000000000..a2c589447
--- /dev/null
+++ b/testcases/kernel/syscalls/mremap/mremap08.c
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Linux Test Project
+ */
+
+/*\
+ * Verify the behavior of the ``MREMAP_FIXED`` flag of :manpage:`mremap(2)`:
+ *
+ * - ``MREMAP_FIXED | MREMAP_MAYMOVE`` can move a mapping to a new, free
+ *   address, preserving its content.
+ * - ``MREMAP_FIXED | MREMAP_MAYMOVE`` unmaps a previously existing mapping at
+ *   the target address range and replaces it with the moved mapping.
+ */
+
+#define _GNU_SOURCE
+#include <sys/mman.h>
+#include "tst_test.h"
+
+static int pagesize;
+
+static struct tcase {
+	size_t old_pages;
+	size_t new_pages;
+	int flags;
+	int free_dst;
+	const char *msg;
+} tcases[] = {
+	{
+		.old_pages = 1,
+		.new_pages = 1,
+		.flags = MREMAP_FIXED | MREMAP_MAYMOVE,
+		.free_dst = 1,
+		.msg = "move mapping to free address",
+	},
+	{
+		.old_pages = 1,
+		.new_pages = 1,
+		.flags = MREMAP_FIXED | MREMAP_MAYMOVE,
+		.free_dst = 0,
+		.msg = "move mapping onto an occupied address",
+	},
+};
+
+static void *get_test_area(size_t size, int free_area)
+{
+	void *p;
+
+	p = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE,
+		      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (free_area)
+		SAFE_MUNMAP(p, size);
+
+	return p;
+}
+
+static void setup(void)
+{
+	pagesize = getpagesize();
+}
+
+static void fill_pattern(char *addr, size_t pages, char *new_addr, int free_dst)
+{
+	size_t i;
+
+	for (i = 0; i < pages; i++)
+		addr[i * pagesize] = (char)(0x1 + i);
+
+	if (!free_dst)
+		*new_addr = 0x7f;
+}
+
+static int check_pattern(char *addr, size_t pages)
+{
+	size_t i;
+
+	for (i = 0; i < pages; i++) {
+		char got = addr[i * pagesize];
+		char exp = (char)(0x1 + i);
+
+		if (got != exp)
+			return 1;
+	}
+
+	return 0;
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+	char *old_address;
+	char *new_address;
+	char *ret;
+	size_t old_size = tc->old_pages * pagesize;
+	size_t new_size = tc->new_pages * pagesize;
+
+	old_address = get_test_area(old_size, 0);
+	new_address = get_test_area(new_size, tc->free_dst);
+
+	fill_pattern(old_address, tc->old_pages, new_address, tc->free_dst);
+
+	TESTPTR(mremap(old_address, old_size, new_size, tc->flags, new_address));
+	ret = TST_RET_PTR;
+
+	if (ret == MAP_FAILED) {
+		tst_res(TFAIL | TTERRNO, "%s failed", tc->msg);
+		SAFE_MUNMAP(old_address, old_size);
+		if (!tc->free_dst)
+			SAFE_MUNMAP(new_address, new_size);
+		return;
+	}
+
+	if (ret != new_address)
+		tst_res(TFAIL, "%s: ret %p, expected %p", tc->msg, ret, new_address);
+	else if (check_pattern(ret, tc->new_pages))
+		tst_res(TFAIL, "%s: pattern mismatch", tc->msg);
+	else
+		tst_res(TPASS, "%s", tc->msg);
+
+	SAFE_MUNMAP(ret, new_size);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
