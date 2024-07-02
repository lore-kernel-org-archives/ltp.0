Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3CCC3064D
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 07:38:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D14993D3EB2
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 09:38:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E08773D3E95
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 09:38:38 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8E6191A01926
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 09:38:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D724F1FB8D;
 Tue,  2 Jul 2024 07:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719905916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpUKm8J5eoaZ+rXe+uEff6C49GMajn50i5AOGdXTuXs=;
 b=EvolUcq3VX+hYIgBRkTTJN0DRiLi85Q7gFaEXzpypfpju1lRFk1EPbWwQDrwuritC7nqte
 NoeYnoKH7y1PAMXlAeLttlTfuo3Xh4KYxoPNLBj5ZIxCvO9H7mVUhR9ctie7xxxOI2t3Lq
 G0/DWwSnV0ylL2IJpn+v+kVflNUWp74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719905916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpUKm8J5eoaZ+rXe+uEff6C49GMajn50i5AOGdXTuXs=;
 b=z2N8i5gz5lv2er4CcZt429C3JOh3nZbsY0Aj6rsptsI18FuZEX1IwcK+AQdaXIErbkKoE5
 cTET4KDOmR+dChCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1719905916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpUKm8J5eoaZ+rXe+uEff6C49GMajn50i5AOGdXTuXs=;
 b=EvolUcq3VX+hYIgBRkTTJN0DRiLi85Q7gFaEXzpypfpju1lRFk1EPbWwQDrwuritC7nqte
 NoeYnoKH7y1PAMXlAeLttlTfuo3Xh4KYxoPNLBj5ZIxCvO9H7mVUhR9ctie7xxxOI2t3Lq
 G0/DWwSnV0ylL2IJpn+v+kVflNUWp74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1719905916;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpUKm8J5eoaZ+rXe+uEff6C49GMajn50i5AOGdXTuXs=;
 b=z2N8i5gz5lv2er4CcZt429C3JOh3nZbsY0Aj6rsptsI18FuZEX1IwcK+AQdaXIErbkKoE5
 cTET4KDOmR+dChCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B78BF13ABC;
 Tue,  2 Jul 2024 07:38:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cCThKnyug2aUCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 02 Jul 2024 07:38:36 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 02 Jul 2024 09:38:18 +0200
MIME-Version: 1.0
Message-Id: <20240702-unlink09-v4-2-d8df24772a76@suse.com>
References: <20240702-unlink09-v4-0-d8df24772a76@suse.com>
In-Reply-To: <20240702-unlink09-v4-0-d8df24772a76@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2031;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=dQ85XfeE5rYMsPX2eVXytvpzLMO4eHeNZ0OhR11uhoo=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmg65zEZKBFJt2mpT4sJ5HaYKEqk2iyjQ4TuL65
 1SGwIiN5GuJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZoOucwAKCRDLzBqyILPm
 RoyGC/4yY1RLbL6uC8VwMn4ONLIfUkyVXGFh9ndsdUgTQi53LzMKqACTSMGJtBUlbDosTTGkmg7
 hQLunpGXAzh83m1cGJ+Lx1G9uq8l0qLe6x0zc6F5bXOE1Spb7DkfvNauj2j+m+x1Ph9fMekWBp1
 qnEEI8APpBUJfciDVwi7/mA8qx1BpJnCcO8KjQ8xjtM+MIQugyZEZGHuVYtE6NZq+Qex1J6tpLg
 1Os/qFtDqypxBfkgCEususSqG+knWpdbY4WzLdFPaQDnbW3x7hmtaREPFTm9TUxENu17xCXBxIp
 0Nb97zjROl+k3DA9zof3sALO6aGtvmYcScklYpNtITHZJ9a/gv/hYPcFVr3pBSC5mOPYoz5Yi3K
 5eI6N8uiWEJzNhjT10V5PpQIO52DFq1f/SQo5fJuBsf8HOkdFkajB1n870TIpLuzfxlK1EptJ9k
 PClXQEQH2304szQqXQDx8P6RB/UdpDmG2bY018KX2MUqqRSk6KjmWfmNw62Th9aatd83w=
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] Add unlink10 test
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

This test verifies that unlink(2) fails with EROFS when target file
is on a read-only filesystem.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                            |  1 +
 testcases/kernel/syscalls/unlink/.gitignore |  1 +
 testcases/kernel/syscalls/unlink/unlink10.c | 33 +++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 44a577db3..b6cadb2df 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1658,6 +1658,7 @@ unlink05 unlink05
 unlink07 unlink07
 unlink08 unlink08
 unlink09 unlink09
+unlink10 unlink10
 
 #unlinkat test cases
 unlinkat01 unlinkat01
diff --git a/testcases/kernel/syscalls/unlink/.gitignore b/testcases/kernel/syscalls/unlink/.gitignore
index 6038cc29d..4fc24059a 100644
--- a/testcases/kernel/syscalls/unlink/.gitignore
+++ b/testcases/kernel/syscalls/unlink/.gitignore
@@ -2,3 +2,4 @@
 /unlink07
 /unlink08
 /unlink09
+/unlink10
diff --git a/testcases/kernel/syscalls/unlink/unlink10.c b/testcases/kernel/syscalls/unlink/unlink10.c
new file mode 100644
index 000000000..861f24a50
--- /dev/null
+++ b/testcases/kernel/syscalls/unlink/unlink10.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Verify that unlink(2) fails with EROFS when target file is on a read-only
+ * filesystem.
+ */
+
+#include <sys/ioctl.h>
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+#define MNTPOINT "erofs"
+#define FILENAME MNTPOINT"/file"
+
+static void run(void)
+{
+	TST_EXP_FAIL(unlink(FILENAME), EROFS,
+		"%s", "target file in read-only filesystem");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_rofs = 1,
+	.needs_root = 1,
+	.mntpoint = MNTPOINT,
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
