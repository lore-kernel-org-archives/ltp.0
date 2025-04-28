Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E7AC369D5
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 14:45:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAC8D3CBBA8
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 16:45:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F4DD3CBB9A
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 16:44:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 66158600066
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 16:44:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 92E571F395;
 Mon, 28 Apr 2025 14:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745851444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OunbBpa50iGOKECD4edDjW5mD6fzFLhknBNG4x6BCS0=;
 b=V4UaibR7YYSBZb/r0gsLisuiSp9K7uwv9KucwzeAI1fAvCijqMAkSPDbaGTktvuG44NCbg
 Twr+PWIH+6aDq3362z//t0NKPv0Et4ij+3MIxO87nN/dHG4TqpxUmMLXl0uxPf4FTI78pT
 q2C3oN/SZvCj0QJC0b0cUYtJwE/WszI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745851444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OunbBpa50iGOKECD4edDjW5mD6fzFLhknBNG4x6BCS0=;
 b=nGkr1S9SLJ1qEmpBHsE7gW/5Sd6aFzN9DuRP7WAAB0flUPuIGeUmegLD0FABFLgBCY0g6K
 8BnjVJUWub/C25Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745851444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OunbBpa50iGOKECD4edDjW5mD6fzFLhknBNG4x6BCS0=;
 b=V4UaibR7YYSBZb/r0gsLisuiSp9K7uwv9KucwzeAI1fAvCijqMAkSPDbaGTktvuG44NCbg
 Twr+PWIH+6aDq3362z//t0NKPv0Et4ij+3MIxO87nN/dHG4TqpxUmMLXl0uxPf4FTI78pT
 q2C3oN/SZvCj0QJC0b0cUYtJwE/WszI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745851444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OunbBpa50iGOKECD4edDjW5mD6fzFLhknBNG4x6BCS0=;
 b=nGkr1S9SLJ1qEmpBHsE7gW/5Sd6aFzN9DuRP7WAAB0flUPuIGeUmegLD0FABFLgBCY0g6K
 8BnjVJUWub/C25Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61EE113A6A;
 Mon, 28 Apr 2025 14:44:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2GdKFjSUD2ioegAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 28 Apr 2025 14:44:04 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 28 Apr 2025 16:44:01 +0200
MIME-Version: 1.0
Message-Id: <20250428-lsm-v3-6-33a4caa9aaf2@suse.com>
References: <20250428-lsm-v3-0-33a4caa9aaf2@suse.com>
In-Reply-To: <20250428-lsm-v3-0-33a4caa9aaf2@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745851441; l=4977;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=F4oAvl3gK6regB90Pafs/cxCvCxpDaR+Kk5BBzPKe30=;
 b=n/D1SQy1Gx4Et5ZqQ/giFNjQmyWOVcWaR2EZvhmofWhJ/d+o6bcbchA6k0gKqnAlIh6k1PcpJ
 ypQlmB60RfBB6LJXGvwXEv09xHsP71pWWBpK0jkh2Mhun/Pg2Fls9A5
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 6/7] Add lsm_list_modules02 test
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
index 0000000000000000000000000000000000000000..c23b26ffcd777fd36a77500f78bae2a607c1aad6
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
+	for (int i = 0; i < lsm_names_count; i++)
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
+	for (int i = 0; i < lsm_names_count; i++) {
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
