Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7074E7719D
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 12:56:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79BE63C30E0
	for <ltp@archiver.kernel.org>; Fri, 10 Jan 2025 13:56:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F167C3C308D
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 13:55:44 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 625971036E4D
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 13:55:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 005D82117F
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 12:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736513744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIBbXJdD6m+SwDWIGGzCvnCaykLmsFw50cj96T4Loas=;
 b=oQ1/fXSqI/cU6sLGSZUrruEPer3Hc3FUeiMWC953NugUQEx+AHbsvWt0S0UTcWS5/7gFSt
 yEwjiTRMczAYzS16pyKBW0fBo+GW/OeXOnjyeV0Yh0Rwq7UGeoVrT2e2pG/7wGUBaUp1G9
 VYS434LXMw6JMnTNIT4tP97oBf9n2VQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736513744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIBbXJdD6m+SwDWIGGzCvnCaykLmsFw50cj96T4Loas=;
 b=/dBhEisLO13XrgLBNY4jdSnIEuiQweSbOgaBiMw3CY/mkFEfTKTNyN2xwCwdFf1yfmHzHS
 7eFtMQyjYsfJq5Ag==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="oQ1/fXSq";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/dBhEisL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736513744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIBbXJdD6m+SwDWIGGzCvnCaykLmsFw50cj96T4Loas=;
 b=oQ1/fXSqI/cU6sLGSZUrruEPer3Hc3FUeiMWC953NugUQEx+AHbsvWt0S0UTcWS5/7gFSt
 yEwjiTRMczAYzS16pyKBW0fBo+GW/OeXOnjyeV0Yh0Rwq7UGeoVrT2e2pG/7wGUBaUp1G9
 VYS434LXMw6JMnTNIT4tP97oBf9n2VQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736513744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIBbXJdD6m+SwDWIGGzCvnCaykLmsFw50cj96T4Loas=;
 b=/dBhEisLO13XrgLBNY4jdSnIEuiQweSbOgaBiMw3CY/mkFEfTKTNyN2xwCwdFf1yfmHzHS
 7eFtMQyjYsfJq5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF3B613AA7
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 12:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cEifNM8YgWduVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Fri, 10 Jan 2025 12:55:43 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 10 Jan 2025 13:55:45 +0100
MIME-Version: 1.0
Message-Id: <20250110-lsm-v2-6-bd38035f86bc@suse.com>
References: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
In-Reply-To: <20250110-lsm-v2-0-bd38035f86bc@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736513742; l=4607;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=2PyIxmviKx7rQ7Ztsoads9ANCLqV+j9ObLqdQ+6JWNs=;
 b=MzZPADRdnfBhSNXAmBAYoRXXwqvZ5Mx9KakTcWHr0xi5OBrisTuzn5R5dfC3kwUHw/Yjyk9Ne
 dlcxskLPvl/C4FJ48yvZbxF+PbGKzqBX3u4gnFdqTxVz8ggHoSSIW/A
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 005D82117F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid];
 RCPT_COUNT_ONE(0.00)[1]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/7] Add lsm_list_modules02 test
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
 testcases/kernel/syscalls/lsm/lsm_list_modules02.c | 138 +++++++++++++++++++++
 3 files changed, 140 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index ae1f430e3dcfebb5167990fcef45b1f3658f6dba..71c644b2da0e55df40ec753c5c31eeb9c474e146 100644
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
index 0000000000000000000000000000000000000000..b286e6da9581e9ae1cb14f11409f3954568d3c7d
--- /dev/null
+++ b/testcases/kernel/syscalls/lsm/lsm_list_modules02.c
@@ -0,0 +1,138 @@
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
+static char lsm_names[MAX_LSM_NUM][BUFSIZ];
+static size_t lsm_names_count;
+static uint32_t page_size;
+static uint64_t *ids;
+static uint32_t *size;
+
+static void run(void)
+{
+	uint32_t lsm_num;
+	size_t count;
+
+	memset(ids, 0, sizeof(uint64_t) * MAX_LSM_NUM);
+	*size = page_size;
+
+	lsm_num = TST_EXP_POSITIVE(lsm_list_modules(ids, size, 0));
+
+	TST_EXP_EQ_LI(lsm_num, lsm_names_count);
+	TST_EXP_EQ_LI(*size, lsm_num * sizeof(uint64_t));
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
+		for (count = 0; count < lsm_names_count; count++) {
+			if (!strcmp(name, lsm_names[count])) {
+				tst_res(TPASS, "'%s' is enabled", name);
+				break;
+			}
+		}
+
+		if (count >= lsm_names_count)
+			tst_res(TFAIL, "'%s' has not been found", name);
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
+		strcpy(lsm_names[lsm_names_count], ptr);
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
