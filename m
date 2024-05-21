Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CF2C25B75
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 06:18:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F00B73CFFBE
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 08:17:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E2D73CFF23
 for <ltp@lists.linux.it>; Tue, 21 May 2024 08:16:35 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EB63E60086E
 for <ltp@lists.linux.it>; Tue, 21 May 2024 08:16:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AD7B35BEEC;
 Tue, 21 May 2024 06:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716272193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXxy2IWgH4TdXiogIU60Pf0NwEoujsSzm80fenN+CIk=;
 b=vM0oZBhN8yvWmYslgTrLUNCmnSCdqq3MSv4uDYxSx76hY4Kaq+kXH6ZOD+DPjsPIt/mRB8
 oywlUzzdNg4oAk/K4KbME4R1OezqYHYUAFx37eVcpt3toyusLXSeSkA53dXFlA3ZevRxoX
 8LJytgyU6E2iWtGxwskE6ovLs1pK9pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716272193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXxy2IWgH4TdXiogIU60Pf0NwEoujsSzm80fenN+CIk=;
 b=bqIU4Nwv0bOqCmOlkOk52gXLZcNmcgjwgzruhOjoyJxYsDLGd/o79N5XeWnzEaQLd6xvjW
 NOsEOJcWwdB8nLDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716272193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXxy2IWgH4TdXiogIU60Pf0NwEoujsSzm80fenN+CIk=;
 b=vM0oZBhN8yvWmYslgTrLUNCmnSCdqq3MSv4uDYxSx76hY4Kaq+kXH6ZOD+DPjsPIt/mRB8
 oywlUzzdNg4oAk/K4KbME4R1OezqYHYUAFx37eVcpt3toyusLXSeSkA53dXFlA3ZevRxoX
 8LJytgyU6E2iWtGxwskE6ovLs1pK9pI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716272193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXxy2IWgH4TdXiogIU60Pf0NwEoujsSzm80fenN+CIk=;
 b=bqIU4Nwv0bOqCmOlkOk52gXLZcNmcgjwgzruhOjoyJxYsDLGd/o79N5XeWnzEaQLd6xvjW
 NOsEOJcWwdB8nLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88E7913A21;
 Tue, 21 May 2024 06:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +CnYHkE8TGZmMQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 21 May 2024 06:16:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 21 May 2024 08:15:31 +0200
MIME-Version: 1.0
Message-Id: <20240521-fchmodat2-v1-5-191b4a986202@suse.com>
References: <20240521-fchmodat2-v1-0-191b4a986202@suse.com>
In-Reply-To: <20240521-fchmodat2-v1-0-191b4a986202@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=kVupYEDWdAfMtIaK4CDKVS6S7ITd+dYOcDNQpygENVU=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmTDxAYqwkUdCrfPYSkT3JmoTnsgKHb7nzYIigY
 i+79wQzYeeJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkw8QAAKCRDLzBqyILPm
 RqyCDACn9GH2A1pr74o8WzgbtVNKXsad6TuODaeLaMNO19wr9Rt7NpVzvL1bwaMIWgM9w2P7bXx
 iCAzlBI6Ba8h30DR6TDX05Ga8mT8aoMiqwIRD5Le1Xm2ssD6h3Ln64vLe+f5PhoKpin25m863sq
 quul7j0/BOkSG5Qrd8v9jBFcQoCRK6rH584sI2PNM/l3WnSFL28FoP+UCylT54zOuwlX0ZUPsTA
 oCCaTmvDE/xuESifKCOHdbHiuxBC30idbjy8EA1R3fRFXYDRUV9cikVTqDgMt2iX8FZoR7GOgBj
 Dnvi6/SqCB/cBHzGGMCuCiQKipKdESVDUkoC8OyIxfwGRLAmsGiK4h/rvPHSRSSfRAMbyr/lby4
 IDzxFGN1gO51RYN+eBRYskh7WraIjq01WuVdskOxtDiMtWu8tCjejLYdB1fUaZMV5L3LhAeDZRi
 bWMcsxDPExgja4KZfu+wMtOBLblasBUqHTqQlmr/ewIxW7YKEksn+ZEe59uEpo9h4GB9M=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.993]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] Add fchmodat2_03 test
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

This test verifies that fchmodat2() syscall is properly working with
AT_EMPTY_PATH.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                   |  1 +
 testcases/kernel/syscalls/fchmodat2/.gitignore     |  1 +
 testcases/kernel/syscalls/fchmodat2/fchmodat2_03.c | 46 ++++++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index c3712da36..51b1ad535 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -266,6 +266,7 @@ fchmodat02 fchmodat02
 
 fchmodat2_01 fchmodat2_01
 fchmodat2_02 fchmodat2_02
+fchmodat2_03 fchmodat2_03
 
 fchown01 fchown01
 fchown01_16 fchown01_16
diff --git a/testcases/kernel/syscalls/fchmodat2/.gitignore b/testcases/kernel/syscalls/fchmodat2/.gitignore
index 9f713198c..c46387095 100644
--- a/testcases/kernel/syscalls/fchmodat2/.gitignore
+++ b/testcases/kernel/syscalls/fchmodat2/.gitignore
@@ -1,2 +1,3 @@
 fchmodat2_01
 fchmodat2_02
+fchmodat2_03
diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2_03.c b/testcases/kernel/syscalls/fchmodat2/fchmodat2_03.c
new file mode 100644
index 000000000..a912b95c8
--- /dev/null
+++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_03.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that fchmodat2() syscall is properly working with
+ * AT_EMPTY_PATH.
+ */
+
+#include "fchmodat2.h"
+#include "lapi/fcntl.h"
+
+#define MNTPOINT "mntpoint"
+#define DNAME MNTPOINT "/mydir"
+
+static void run(void)
+{
+	int fd;
+	struct stat st;
+
+	SAFE_MKDIR(DNAME, 0640);
+	fd = SAFE_OPEN(DNAME, O_PATH | O_DIRECTORY, 0640);
+
+	TST_EXP_PASS(fchmodat2(fd, "", 0777, AT_EMPTY_PATH));
+
+	SAFE_FSTAT(fd, &st);
+	TST_EXP_EQ_LI(st.st_mode, S_IFDIR | 0777);
+
+	SAFE_CLOSE(fd);
+	SAFE_RMDIR(DNAME);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "6.6",
+	.mntpoint = MNTPOINT,
+	.format_device = 1,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		NULL
+	},
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
