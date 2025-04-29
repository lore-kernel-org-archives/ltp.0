Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836BDC369CB
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 07:25:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0935A3CBBFE
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 09:25:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 730363CBC0A
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:23:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A118A200055
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:23:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4C00421A84;
 Tue, 29 Apr 2025 07:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745911411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYElsPQ7SJqX6NXbmIUxp3Z+nP9zKTAcJzx7Aokxp8M=;
 b=HxBfGg0tQqgiq+Hyvpyqs8eQx0UtRBnO/H7/ZJOOgt671cov7xQo0v0+76gigfMKCKSh5Y
 rq0cUlx9fLV0kBsqBipe2kWWtP8PoOx+LIRBqJs/Aqts+QeeZlXXE1gNSKD7Ih+Ne9oRBZ
 sgownVHYvBhRTaJ26sCLPa3KgZw86cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745911411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYElsPQ7SJqX6NXbmIUxp3Z+nP9zKTAcJzx7Aokxp8M=;
 b=DRKFuQFq/lOcaOdVZT67Cm8MOqEtb4LFY7SzkHd+mQxt7s5KwebKYmh9Jj9KgVwH8XLCNI
 2nvlpnY4J/lSNeDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745911411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYElsPQ7SJqX6NXbmIUxp3Z+nP9zKTAcJzx7Aokxp8M=;
 b=HxBfGg0tQqgiq+Hyvpyqs8eQx0UtRBnO/H7/ZJOOgt671cov7xQo0v0+76gigfMKCKSh5Y
 rq0cUlx9fLV0kBsqBipe2kWWtP8PoOx+LIRBqJs/Aqts+QeeZlXXE1gNSKD7Ih+Ne9oRBZ
 sgownVHYvBhRTaJ26sCLPa3KgZw86cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745911411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYElsPQ7SJqX6NXbmIUxp3Z+nP9zKTAcJzx7Aokxp8M=;
 b=DRKFuQFq/lOcaOdVZT67Cm8MOqEtb4LFY7SzkHd+mQxt7s5KwebKYmh9Jj9KgVwH8XLCNI
 2nvlpnY4J/lSNeDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3108D13A8B;
 Tue, 29 Apr 2025 07:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yAFeCnN+EGgbcAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 29 Apr 2025 07:23:31 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Apr 2025 09:18:35 +0200
MIME-Version: 1.0
Message-Id: <20250429-lsm-v4-6-602b7097e722@suse.com>
References: <20250429-lsm-v4-0-602b7097e722@suse.com>
In-Reply-To: <20250429-lsm-v4-0-602b7097e722@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745911410; l=4983;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=b/+6Ea6kJtEVzEI4PyJ21EMbVtW6gbLEjzcQLERINGQ=;
 b=6CFo9fFzFdbEAnPtxddFTUvg8aBH7Vl8te8PZEXzHtzWHAJV0zx3llzGttk+Zj8Yb87CP1gj8
 aE1YK7myhN/BgMkiAKqdNG2NJAznQC+rDo8Dg+VxRfpI2lfVpQ/0ZVh
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 6/7] Add lsm_list_modules02 test
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

Verify that lsm_list_modules syscall is correctly recognizing LSM(s)
enabled inside the system.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/lsm/.gitignore           |   1 +
 testcases/kernel/syscalls/lsm/lsm_list_modules02.c | 153 +++++++++++++++++++++
 3 files changed, 155 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index c8a9dbeacbae7a6badc705b7e648dbc7a020742f..91709634b70686e7e7e1e2233d8205ae99c14f19 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -763,6 +763,7 @@ lsm_get_self_attr01 lsm_get_self_attr01
 lsm_get_self_attr02 lsm_get_self_attr02
 lsm_get_self_attr03 lsm_get_self_attr03
 lsm_list_modules01 lsm_list_modules01
+lsm_list_modules02 lsm_list_modules02
 
 lstat01 lstat01
 lstat01_64 lstat01_64
diff --git a/testcases/kernel/syscalls/lsm/.gitignore b/testcases/kernel/syscalls/lsm/.gitignore
index 501d332549a84cceb9741346bdb8b83eb02467c5..766f81fd1c74a10001862f142c02ba251e666ef2 100644
--- a/testcases/kernel/syscalls/lsm/.gitignore
+++ b/testcases/kernel/syscalls/lsm/.gitignore
@@ -2,3 +2,4 @@ lsm_get_self_attr01
 lsm_get_self_attr02
 lsm_get_self_attr03
 lsm_list_modules01
+lsm_list_modules02
diff --git a/testcases/kernel/syscalls/lsm/lsm_list_modules02.c b/testcases/kernel/syscalls/lsm/lsm_list_modules02.c
new file mode 100644
index 0000000000000000000000000000000000000000..40fe789cd5fc1cbebbc2281404001c1d976a0937
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_list_modules02.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that lsm_list_modules syscall is correctly recognizing LSM(s) enabled
+ * inside the system.
+ *
+ * [Algorithm]
+ *
+ * - read enabled LSM(s) inside /sys/kernel/security/lsm file
+ * - collect LSM IDs using lsm_list_modules syscall
+ * - compare the results, verifying that LSM(s) IDs are correct
+ */
+
+#include "lsm_common.h"
+
+#define MAX_LSM_NUM 32
+
+struct lsm_name {
+	char name[BUFSIZ];
+	int num;
+};
+
+static struct lsm_name lsm_names[MAX_LSM_NUM];
+static size_t lsm_names_count;
+static uint32_t page_size;
+static uint64_t *ids;
+static uint32_t *size;
+
+static void run(void)
+{
+	uint32_t lsm_num;
+	size_t counter;
+
+	memset(ids, 0, sizeof(uint64_t) * MAX_LSM_NUM);
+	*size = page_size;
+
+	lsm_num = TST_EXP_POSITIVE(lsm_list_modules(ids, size, 0));
+
+	TST_EXP_EQ_LI(lsm_num, lsm_names_count);
+	TST_EXP_EQ_LI(*size, lsm_num * sizeof(uint64_t));
+
+	for (size_t i = 0; i < lsm_names_count; i++)
+		lsm_names[i].num = 0;
+
+	for (uint32_t i = 0; i < lsm_num; i++) {
+		char *name = NULL;
+
+		switch (ids[i]) {
+		case LSM_ID_CAPABILITY:
+			name = "capability";
+			break;
+		case LSM_ID_SELINUX:
+			name = "selinux";
+			break;
+		case LSM_ID_SMACK:
+			name = "smack";
+			break;
+		case LSM_ID_TOMOYO:
+			name = "tomoyo";
+			break;
+		case LSM_ID_APPARMOR:
+			name = "apparmor";
+			break;
+		case LSM_ID_YAMA:
+			name = "yama";
+			break;
+		case LSM_ID_LOADPIN:
+			name = "loadpin";
+			break;
+		case LSM_ID_SAFESETID:
+			name = "safesetid";
+			break;
+		case LSM_ID_LOCKDOWN:
+			name = "lockdown";
+			break;
+		case LSM_ID_BPF:
+			name = "bpf";
+			break;
+		case LSM_ID_LANDLOCK:
+			name = "landlock";
+			break;
+		case LSM_ID_IMA:
+			name = "ima";
+			break;
+		case LSM_ID_EVM:
+			name = "evm";
+			break;
+		case LSM_ID_IPE:
+			name = "ipe";
+			break;
+		default:
+			break;
+		}
+
+		if (!name)
+			tst_brk(TBROK, "Unsupported LSM: %lu", ids[i]);
+
+		for (counter = 0; counter < lsm_names_count; counter++) {
+			if (!strcmp(name, lsm_names[counter].name)) {
+				lsm_names[counter].num++;
+				tst_res(TPASS, "'%s' is enabled", name);
+				break;
+			}
+		}
+
+		if (counter >= lsm_names_count)
+			tst_res(TFAIL, "'%s' has not been found", name);
+	}
+
+	for (size_t i = 0; i < lsm_names_count; i++) {
+		if (lsm_names[i].num > 1) {
+			tst_res(TFAIL, "'%s' LSM has been counted %d times",
+				lsm_names[i].name,
+				lsm_names[i].num);
+		}
+	}
+}
+
+static void setup(void)
+{
+	int fd;
+	char *ptr;
+	char data[BUFSIZ];
+
+	memset(data, 0, BUFSIZ);
+
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+	fd = SAFE_OPEN("/sys/kernel/security/lsm", O_RDONLY);
+	SAFE_READ(0, fd, data, BUFSIZ);
+	SAFE_CLOSE(fd);
+
+	ptr = strtok(data, ",");
+
+	while (ptr != NULL) {
+		strcpy(lsm_names[lsm_names_count].name, ptr);
+		ptr = strtok(NULL, ",");
+		lsm_names_count++;
+	}
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "6.8",
+	.bufs = (struct tst_buffers []) {
+		{&ids, .size = sizeof(uint64_t) * MAX_LSM_NUM},
+		{&size, .size = sizeof(uint32_t)},
+		{},
+	},
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
