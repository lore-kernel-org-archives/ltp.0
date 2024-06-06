Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E38BC27C55
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 17:25:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E398B3D0A7A
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 19:24:59 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0784F3CBAFA
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 19:24:07 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 71DDD10009BF
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 19:24:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E7A4B1FB4A;
 Thu,  6 Jun 2024 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717694646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woPQv/Qo1VK32GCV1S0QwIjrG4oqR5Z6wYYjSl22mHE=;
 b=MCNB+49GRBhDXm94P1SZUvtVFCgTlxpjQlOlvRHuG6RvRjo7exFVfDMieWO4Ij7qN+vRJr
 h1g8FoFsMZM6zC7NH1QFBARRXS2y3B2ws8YSq1ykXWdK21+ODS2AxC5rPOK02TI9ZYSn4F
 +5vrBFKpAdbysoi7FP5t0NP18hlQn2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717694646;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woPQv/Qo1VK32GCV1S0QwIjrG4oqR5Z6wYYjSl22mHE=;
 b=WMnuJu90g48vQ1hrK4Fe4WwEh6dhxsb5SZE9u6sVHZvh2K85kftSXgzI0Qw1RdCZKM/Eg/
 nAHDWgipV6kYjWCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nxajx1jN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2MTZpA6Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717694645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woPQv/Qo1VK32GCV1S0QwIjrG4oqR5Z6wYYjSl22mHE=;
 b=Nxajx1jNwlHpZg/b1XRKbOSl8DBy1GBhL/MFLNJSUvAIo16s9yRlQ4VTObeKvrJiYv4S3N
 R5HTC+uESKbndAiCpPRW7qs8beBlrWhmTG+Q06dlxu0qE5mc6M82S3749osgZM90bSrwnW
 O4Q12rUj+eTO/gNGt0+bpEp9MX76WEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717694645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woPQv/Qo1VK32GCV1S0QwIjrG4oqR5Z6wYYjSl22mHE=;
 b=2MTZpA6Z4Qp/atIv2xzB9Pi0NSxZkttN7+jQDfFcEYMAW/Vzn9NCJYkfHJZRjGQpVLrsLF
 tip7PeV+GvISbhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D23D313A79;
 Thu,  6 Jun 2024 17:24:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qMkQMrXwYWaNFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 06 Jun 2024 17:24:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 06 Jun 2024 19:23:39 +0200
MIME-Version: 1.0
Message-Id: <20240606-unlink09-v3-2-37cc612ce0fd@suse.com>
References: <20240606-unlink09-v3-0-37cc612ce0fd@suse.com>
In-Reply-To: <20240606-unlink09-v3-0-37cc612ce0fd@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2031;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=0oFVU3Zed+tKZVs6LpNgxrPXnWT4ukMfqZ9kVTbqd0I=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmYfC17o5uH+lNXgyYIN0VkwEIcjENmg48+Au2u
 cO2yPLD6UGJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZmHwtQAKCRDLzBqyILPm
 Rpr8DACFyab3MZNUkXWLsIIGus9Cs5M+GmXnicXNLtbTPQ0HFeWVTKFyDBJgbSmR4KDXRRwQsVN
 wdJFxk7Q7Cot5qH66At3Rw1490A5jMVHqbYqBW5dQDHxFkeTD8jJuqcM+R/JSEvlWvu6nLbHAh+
 mAxlWe4drs7LCzoGT643Bft/xOLsBX1kYfAjBXxfel7MvprumPQbBDaB5Td+dzZjHgQ2yBI8s2u
 j2Kjfp08vZZYp/d+l9frsCsW7EW8yA75S+/ChfJ/RgdhzJXxAW4EyPmhIx8x6sS6ABF8WKuApPX
 171ZzzwGittuTbPggtgbtfyjlcDZd0hIGg+VWR++n1JCXm8LM1FFPlxMcgiuWr+CMHk+FgVbkXV
 fBiyiK2nvLpMlTEKpgJLpKJHMAdRzMQx0jztDx5N+jryKCbl/lCM9as6EiGwzNeIvxZzJl5pBOu
 fL5XgBe2uCEel8z2+39rvWprQ2bVTNCrn1zW2EAnLA1o8wenjCSEIlVBcWq1cGPDCyPME=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E7A4B1FB4A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] Add unlink10 test
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
index cf06ee563..b59b64314 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1655,6 +1655,7 @@ unlink05 unlink05
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
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
