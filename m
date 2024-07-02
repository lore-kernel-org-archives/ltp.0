Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD7CC3065C
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 14:14:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44F2C3D3ED8
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 16:14:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54F113D3ED1
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 16:13:18 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C6C214052C2
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 16:13:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5453C1FBA9;
 Tue,  2 Jul 2024 14:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719929596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qf0UZ/oKdGle3PH/WZFyojPk3pSw9fWSPzOkesx1mA0=;
 b=mnFt4PkSBZFl4p/8PKAT0Oh+mXivnUx5h9o/MQhS8vlvKvj6FyUQQFWen0AeGbXUVfciDf
 EC/xHj3RbKlLUskuD+o2AV5plQvykPfCIUcDnOokfepM0K0mIXM/Ckyo5OlNK9LsaG5imi
 cal6bjB0L+QcvqQYpbekdS0JjdAyh4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719929596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qf0UZ/oKdGle3PH/WZFyojPk3pSw9fWSPzOkesx1mA0=;
 b=JytmDN348r8bkDe05jbxumPjc3hIKURT5uZ2sdud/++fFbnzLEzO/E1QfUaEwC4CZbamO4
 sUQ/UehFVa4V7nDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mnFt4PkS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JytmDN34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719929596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qf0UZ/oKdGle3PH/WZFyojPk3pSw9fWSPzOkesx1mA0=;
 b=mnFt4PkSBZFl4p/8PKAT0Oh+mXivnUx5h9o/MQhS8vlvKvj6FyUQQFWen0AeGbXUVfciDf
 EC/xHj3RbKlLUskuD+o2AV5plQvykPfCIUcDnOokfepM0K0mIXM/Ckyo5OlNK9LsaG5imi
 cal6bjB0L+QcvqQYpbekdS0JjdAyh4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719929596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qf0UZ/oKdGle3PH/WZFyojPk3pSw9fWSPzOkesx1mA0=;
 b=JytmDN348r8bkDe05jbxumPjc3hIKURT5uZ2sdud/++fFbnzLEzO/E1QfUaEwC4CZbamO4
 sUQ/UehFVa4V7nDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0442713A9A;
 Tue,  2 Jul 2024 14:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2A5+NvsKhGbpDgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 02 Jul 2024 14:13:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 02 Jul 2024 16:12:50 +0200
MIME-Version: 1.0
Message-Id: <20240702-stat04-v1-4-e27d9953210d@suse.com>
References: <20240702-stat04-v1-0-e27d9953210d@suse.com>
In-Reply-To: <20240702-stat04-v1-0-e27d9953210d@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2320;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=ZIRVdVUqC/U8rWHVdvAgGyn1OSHu8N2jIDVYXtbljI0=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmhArvdZgVXJ0gL4nE/V9zz6W5KAaRiubU+7qhh
 cmdZm5bRk6JAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZoQK7wAKCRDLzBqyILPm
 RluoDACLoyxLG4h0/PsMlTT0jPrOwcN2Rpc7JlNw508U4p33MFPReYGvLq6s6DJRyikNhVzj2Xg
 cPJt34a2IDOve6Xh70b/GLRVgVegClCBt1gKwGHPZsbMSDSelbGmVkJUKxMsSIvrKifWcKE1nuI
 WTFhZaJMxRdMwfZLEvlIgY2Tf7+AucN2uKy1CiMgdMhZDPt7KuFhgNVnM54dn4WjPOLO5VbSpjI
 pvZbwvxPZcdi/XJhjubrD87w4sXVj7ezseA+XKfp1w/AaseV0jmIfVDk24KoWGge0zNOJ6eElMz
 OsreFhyLfOHSdCF7bYCbAXkvtSgPdk4dy1DcJomyFBgUW270qaFJ6g2l0Xaam2v0zt8zqAP+tV3
 YXFzVy5NDBxGd2LDoHI0Ej2KUXUVr/piMiTW2nYMIJan4+khgBclbowU42niMagXrK/8umbd/5g
 qjaIbNS4zFoD8QMwJTp5CE56rPQSLmXDyaoc64S4DmGpTpyK+lp91Gdx/5L1pEizZiBIk=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Queue-Id: 5453C1FBA9
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/5] Add chmod08 test
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

This test has been extracted from symlink01 and it verifies that
chmod() is working correctly on symlink() generated files.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/chmod/.gitignore |  1 +
 testcases/kernel/syscalls/chmod/chmod08.c  | 45 ++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index d78b6822b..928e75f9b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -72,6 +72,7 @@ chmod03 chmod03
 chmod05 chmod05
 chmod06 chmod06
 chmod07 chmod07
+chmod08 chmod08
 
 chown01 chown01
 chown01_16 chown01_16
diff --git a/testcases/kernel/syscalls/chmod/.gitignore b/testcases/kernel/syscalls/chmod/.gitignore
index 27ddfce16..f295f4dcb 100644
--- a/testcases/kernel/syscalls/chmod/.gitignore
+++ b/testcases/kernel/syscalls/chmod/.gitignore
@@ -3,3 +3,4 @@
 /chmod05
 /chmod06
 /chmod07
+/chmod08
diff --git a/testcases/kernel/syscalls/chmod/chmod08.c b/testcases/kernel/syscalls/chmod/chmod08.c
new file mode 100644
index 000000000..7ef396348
--- /dev/null
+++ b/testcases/kernel/syscalls/chmod/chmod08.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
+ *    Author: David Fenner
+ *    Copilot: Jon Hendrickson
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that chmod() is working correctly on symlink()
+ * generated files.
+ */
+
+#include "tst_test.h"
+
+#define PERMS 01777
+#define TESTFILE "myobject"
+
+static void run(void)
+{
+	char *symname = "my_symlink0";
+	struct stat oldsym_stat;
+	struct stat newsym_stat;
+
+	SAFE_TOUCH(TESTFILE, 0644, NULL);
+	SAFE_SYMLINK(TESTFILE, symname);
+	SAFE_STAT(symname, &oldsym_stat);
+
+	TST_EXP_PASS(chmod(symname, PERMS));
+	SAFE_STAT(symname, &newsym_stat);
+
+	TST_EXP_EQ_LI(newsym_stat.st_mode & PERMS, PERMS);
+	TST_EXP_EXPR(oldsym_stat.st_mode != newsym_stat.st_mode,
+		"file mode has changed");
+
+	SAFE_UNLINK(symname);
+	SAFE_UNLINK(TESTFILE);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_tmpdir = 1,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
