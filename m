Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE59D41D5F
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 07:17:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 87C5C3D599F
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 08:17:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0E2B3D5A03
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 08:15:42 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1643B60132C
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 08:15:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 13B6F21744
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731395741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPfEzSx8MPa+eF1USUzNUwLRjVUTx2gTJGF0fGxV7a0=;
 b=y3yBCBq7Lm06Ci+L019elKTCwdsUU06MieZlOPs200oZhCQNGuoYpNOvwKiomaoke3jJbD
 mGv7mGUVPVtif6jfgMiKWRJBQrdT15NZ2pPo3BbWXqcZNUcWeTvxA79t/Ig75j3H1c8msC
 t09s/PvqT19+37QVkeDLSLNfT48ykfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731395741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPfEzSx8MPa+eF1USUzNUwLRjVUTx2gTJGF0fGxV7a0=;
 b=T1FWIBDqNgrGNBdKxo1UPBjsvJocyuICQIQGbwTyFYzh0wtzad+0riKvdACSUDwpKfZYSO
 A1A2KRiR4TyoHwBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731395741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPfEzSx8MPa+eF1USUzNUwLRjVUTx2gTJGF0fGxV7a0=;
 b=y3yBCBq7Lm06Ci+L019elKTCwdsUU06MieZlOPs200oZhCQNGuoYpNOvwKiomaoke3jJbD
 mGv7mGUVPVtif6jfgMiKWRJBQrdT15NZ2pPo3BbWXqcZNUcWeTvxA79t/Ig75j3H1c8msC
 t09s/PvqT19+37QVkeDLSLNfT48ykfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731395741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPfEzSx8MPa+eF1USUzNUwLRjVUTx2gTJGF0fGxV7a0=;
 b=T1FWIBDqNgrGNBdKxo1UPBjsvJocyuICQIQGbwTyFYzh0wtzad+0riKvdACSUDwpKfZYSO
 A1A2KRiR4TyoHwBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA6E413721
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sIb9IJwAM2ddcgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 07:15:40 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 12 Nov 2024 08:15:37 +0100
MIME-Version: 1.0
Message-Id: <20241112-lsm-v1-6-e293a8d99cf6@suse.com>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
In-Reply-To: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731395735; l=4437;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=pVDjp7XJ4q1pgUF4QFDGgWI2f9TslZ7PTgNDXurPOOY=;
 b=MMs3Z0fvjDSfvpXUPtWaZs/zTbAUNJB7be3i4XRTjqgHRp/cx8Q/b1SU5yWsBqaRAQLNiMBvk
 D2Cv0YMrkDsDY1OiSn/yXkS6yj6gRf3tq9S+zRb4omR5whsBn///4qf
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/7] Add lsm_list_modules02 test
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
 testcases/kernel/syscalls/lsm/lsm_list_modules02.c | 134 +++++++++++++++++++++
 3 files changed, 136 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 78b70e12b87bbbec88d641b9c11cac2989812ff7..ee46f500859d08fba8d2553a01f8bc9e2cc8e3ea 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -760,6 +760,7 @@ lsm_get_self_attr01 lsm_get_self_attr01
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
index 0000000000000000000000000000000000000000..7ce541932bf8aaf90c88a2bcb2b9f23793e9a7fc
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_list_modules02.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
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
+static char lsm_list[BUFSIZ];
+static uint32_t page_size;
+static uint64_t *ids;
+static uint32_t *size;
+
+static void run(void)
+{
+	uint32_t lsm_num;
+	uint32_t counter = 0;
+
+	memset(ids, 0, sizeof(uint64_t) * MAX_LSM_NUM);
+	*size = page_size;
+
+	lsm_num = TST_EXP_POSITIVE(lsm_list_modules(ids, size, 0));
+
+	for (uint32_t i = 0; i < lsm_num; i++) {
+		char *name = NULL;
+
+		switch (ids[i]) {
+		case LSM_ID_CAPABILITY:
+			name = "capability";
+			counter++;
+			break;
+		case LSM_ID_SELINUX:
+			name = "selinux";
+			counter++;
+			break;
+		case LSM_ID_SMACK:
+			name = "smack";
+			counter++;
+			break;
+		case LSM_ID_TOMOYO:
+			name = "tomoyo";
+			counter++;
+			break;
+		case LSM_ID_APPARMOR:
+			name = "apparmor";
+			counter++;
+			break;
+		case LSM_ID_YAMA:
+			name = "yama";
+			counter++;
+			break;
+		case LSM_ID_LOADPIN:
+			name = "loadpin";
+			counter++;
+			break;
+		case LSM_ID_SAFESETID:
+			name = "safesetid";
+			counter++;
+			break;
+		case LSM_ID_LOCKDOWN:
+			name = "lockdown";
+			counter++;
+			break;
+		case LSM_ID_BPF:
+			name = "bpf";
+			counter++;
+			break;
+		case LSM_ID_LANDLOCK:
+			name = "landlock";
+			counter++;
+			break;
+		case LSM_ID_IMA:
+			name = "ima";
+			counter++;
+			break;
+		case LSM_ID_EVM:
+			name = "evm";
+			counter++;
+			break;
+		case LSM_ID_IPE:
+			name = "ipe";
+			counter++;
+			break;
+		default:
+			break;
+		}
+
+		if (!name)
+			tst_brk(TBROK, "Unsupported LSM: %lu", ids[i]);
+
+		if (strstr(name, lsm_list))
+			tst_res(TFAIL, "'%s' has not been found", name);
+		else
+			tst_res(TPASS, "'%s' is enabled", name);
+	}
+
+	TST_EXP_EQ_LI(*size, counter * sizeof(uint64_t));
+	TST_EXP_EQ_LI(lsm_num, counter);
+}
+
+static void setup(void)
+{
+	int fd;
+
+	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
+	fd = SAFE_OPEN("/sys/kernel/security/lsm", O_RDONLY);
+	SAFE_READ(0, fd, lsm_list, BUFSIZ);
+	SAFE_CLOSE(fd);
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
