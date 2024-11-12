Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14CBD41D61
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 07:15:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 756293D5A05
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 08:15:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD0F03D599F
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 08:15:39 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1DE507AB282
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 08:15:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B0DBF2170C
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731395738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKkhkshg6iwJHbzLDIxeq83mvvlqFYQRQRGjxSLvLhs=;
 b=USIv46a6Efn8v3GUBDufGkRbfyLqGaGuV0d0ybLUrYqe+h0KtRRr1Zb9u5pUmgpgwxrZWW
 m3jPD3r/aKkhUz2460vAhbjbT4sM3KDnEljrhxFYJuBrtyWsI1y1FhSMencmYNiD0Uksig
 IO0h1ixsgTA5X4/p94HReZGb7SROPv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731395738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKkhkshg6iwJHbzLDIxeq83mvvlqFYQRQRGjxSLvLhs=;
 b=Py9RvAb4xGOj5bX7dabAHmSnh5n2zLYlnh8c3BhFTT51wAUOLTgm5WBk1jRjgy7rdSpy9A
 UlN+tz77CudQmLBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731395738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKkhkshg6iwJHbzLDIxeq83mvvlqFYQRQRGjxSLvLhs=;
 b=USIv46a6Efn8v3GUBDufGkRbfyLqGaGuV0d0ybLUrYqe+h0KtRRr1Zb9u5pUmgpgwxrZWW
 m3jPD3r/aKkhUz2460vAhbjbT4sM3KDnEljrhxFYJuBrtyWsI1y1FhSMencmYNiD0Uksig
 IO0h1ixsgTA5X4/p94HReZGb7SROPv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731395738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKkhkshg6iwJHbzLDIxeq83mvvlqFYQRQRGjxSLvLhs=;
 b=Py9RvAb4xGOj5bX7dabAHmSnh5n2zLYlnh8c3BhFTT51wAUOLTgm5WBk1jRjgy7rdSpy9A
 UlN+tz77CudQmLBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49BCB13721
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6JLfBJoAM2ddcgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 12 Nov 2024 08:15:34 +0100
MIME-Version: 1.0
Message-Id: <20241112-lsm-v1-3-e293a8d99cf6@suse.com>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
In-Reply-To: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731395735; l=3056;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=pmSSW8eeh40ZewOe8dd6/V0CeCHh53AGTHN+ewnTucY=;
 b=WofxbDjYZ8dertI2+jslDDEkyL67C1AXr5NHXx/qlwxTsLOQvTz2cYj6C4TWnE1JSlcdBNIGo
 26V7uD8o4Y2BOVv7ZOsNKaK2B3D/MNqcjdPqhbT8J1ZhyY27hp/+/Ay
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/7] Add lsm_get_self_attr02 test
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

Verify that lsm_get_self_attr syscall is acting correctly when ctx is NULL.
The syscall can behave in different ways according to the current system
status:

- if any LSM is running inside the system, the syscall will pass and it will
  provide a size as big as the attribute
- if no LSM(s) are running inside the system, the syscall will fail with -1
  return code

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/lsm/.gitignore           |  2 +
 .../kernel/syscalls/lsm/lsm_get_self_attr02.c      | 55 ++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index d59faf08a3f36b5f64d56952f69641191c70bf33..b3350af4db6d00cf86f621b5efee5d603af920f0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -757,6 +757,7 @@ lseek07 lseek07
 lseek11 lseek11
 
 lsm_get_self_attr01 lsm_get_self_attr01
+lsm_get_self_attr02 lsm_get_self_attr02
 
 lstat01 lstat01
 lstat01_64 lstat01_64
diff --git a/testcases/kernel/syscalls/lsm/.gitignore b/testcases/kernel/syscalls/lsm/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..9f7c9b00b026a377f1b36f483ac2c1a0adba6249
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/.gitignore
@@ -0,0 +1,2 @@
+lsm_get_self_attr01
+lsm_get_self_attr02
diff --git a/testcases/kernel/syscalls/lsm/lsm_get_self_attr02.c b/testcases/kernel/syscalls/lsm/lsm_get_self_attr02.c
new file mode 100644
index 0000000000000000000000000000000000000000..ce10bc2881fa8ac56a1e1da01631cfed8857eb08
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_get_self_attr02.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that lsm_get_self_attr syscall is acting correctly when ctx is NULL.
+ * The syscall can behave in different ways according to the current system
+ * status:
+ *
+ * - if any LSM is running inside the system, the syscall will pass and it will
+ *   provide a size as big as the attribute
+ * - if no LSM(s) are running inside the system, the syscall will fail with -1
+ *   return code
+ */
+#include "lsm_common.h"
+
+static uint32_t page_size;
+static uint32_t lsm_count;
+
+static void run(void)
+{
+	uint32_t size = page_size;
+
+	if (lsm_count) {
+		TST_EXP_EXPR(lsm_get_self_attr(
+			LSM_ATTR_CURRENT, NULL, &size, 0) >= 1);
+		TST_EXP_EXPR(size > 1);
+	} else {
+		TST_EXP_EQ_LI(lsm_get_self_attr(
+			LSM_ATTR_CURRENT, NULL, &size, 0), -1);
+	}
+}
+
+static void setup(void)
+{
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+
+	if (verify_enabled_lsm("selinux"))
+		lsm_count++;
+
+	if (verify_enabled_lsm("apparmor"))
+		lsm_count++;
+
+	if (verify_enabled_lsm("smack"))
+		lsm_count++;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "6.8",
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
