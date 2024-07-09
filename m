Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218BFC3DA41
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 10:47:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0ED53D3969
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 12:47:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98B263D0CD5
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:45:58 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 12D08600A6F
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 12:45:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E9A6C1F7B4;
 Tue,  9 Jul 2024 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720521957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNXPyRolaOjWw7xjOOBDXKXqRVDqgLGpomNj6Tor8HM=;
 b=TDVy1IBCbTOp88MZt7KthSRK9yoN7YB96V0JBMozIMULGogtKGpRZDK+Ymrqj50WCn1c1B
 6B+mB4TNy5nm/h4dop9JBc6ty2ulPZENKTOgbKglyl6b8ilG03FMroyeY9BHiCdhlZCd1S
 rhjsEOPZvqfySB66Qro1SH3enf3zQ0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720521957;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNXPyRolaOjWw7xjOOBDXKXqRVDqgLGpomNj6Tor8HM=;
 b=i283vnm8dF+oQW0xL7BWRqCouylM5MgiC+9Ca1WpEiUlwaTmgLUqmKs3hAJsat8lgB/MP1
 WM7Ecbk2IUt+i9Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720521956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNXPyRolaOjWw7xjOOBDXKXqRVDqgLGpomNj6Tor8HM=;
 b=ojHe4uLrLvXVCo/xQP3BIgDJwiYq/pB+/rPabqwxxzsXxAqj/yraCYy/uUu8QhEbH6TwN1
 JoJ555imxeTQOgeFAogjM5IXe7N5y+klVWJq3Y1ylIJNI/HDRpoN+a4P9zgVKw9mgzfT8/
 O1EMx5DI39VtwGMZQWZ9nI0hUnD00jM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720521956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNXPyRolaOjWw7xjOOBDXKXqRVDqgLGpomNj6Tor8HM=;
 b=13667tLigUwesilJU3D5+2K/S9ctXWzjgFDlHO+bUrIB4i35feuFfUdUQU5vamqSJoHQ5H
 7o9ldoDe+E7YF0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3C791369A;
 Tue,  9 Jul 2024 10:45:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mI7YLeQUjWaBVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 09 Jul 2024 10:45:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 09 Jul 2024 12:45:34 +0200
MIME-Version: 1.0
Message-Id: <20240709-stat04-v2-4-2693a473a2ab@suse.com>
References: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
In-Reply-To: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=6FKi6eeucq1E2EJHueFgvMlhEprkM/Qda5h2EDugpHE=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjRTX6WqkCQ9FaVUH30oZGH2z3OvOYPL2C4at/
 WSPu1Bk9kKJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo0U1wAKCRDLzBqyILPm
 RlBeDACMCng3CRktfm6Aif9ApjLJ2I25bCbjHRFd1TA+068MF1zrScw9EIUwgstlFjhbV80197b
 pXXQndxwgdRyry3qEYOPE0oUEFOy2qAkajmmr6QsnL432JxIbuxpe34vnR5oj/vB9XHYr6ZQOar
 O/fv19bMqnx/jQMWXKktrdeTNA8YO+eaSTCYUIhF0Uq+z2QEUCviav8vcwVlh/ZjIDWEGg+4Qcv
 RbOVL9zEKkqqq/WabnamSIfXpMmtfrQNmYocsvzuzV4AdsIbtBVEiLbSk8owt7WmKD95e4ClB4F
 8r9FTx0CrRre5CPSWvniG9VS9wkg9Cz3py+zFfL61/gpPEee8c3JFbX0Zb8a7L1ZvWERI9Afcrn
 N/6XSIDfC694Gu3Soi7GiCQCsRxOihyiuABkxsFBIcseX1k4gf88VIuBakqjAdwwNLu2NkGlyAB
 vwb6BD++dDjwQGi0V8fx+mhdvFtMPx0ePLUeZJ1NWiWbzFwro4cfoCD2XhiV75Gu7aPNM=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/5] Add chmod08 test
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

Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/chmod/.gitignore |  1 +
 testcases/kernel/syscalls/chmod/chmod08.c  | 45 ++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 160725893..40c0dd070 100644
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
index 000000000..87519dbe8
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
+#define	SYMBNAME "my_symlink0"
+
+static void run(void)
+{
+	struct stat oldsym_stat;
+	struct stat newsym_stat;
+
+	SAFE_TOUCH(TESTFILE, 0644, NULL);
+	SAFE_SYMLINK(TESTFILE, SYMBNAME);
+	SAFE_STAT(SYMBNAME, &oldsym_stat);
+
+	TST_EXP_PASS(chmod(SYMBNAME, PERMS));
+	SAFE_STAT(SYMBNAME, &newsym_stat);
+
+	TST_EXP_EQ_LI(newsym_stat.st_mode & PERMS, PERMS);
+	TST_EXP_EXPR(oldsym_stat.st_mode != newsym_stat.st_mode,
+		"file mode has changed");
+
+	SAFE_UNLINK(SYMBNAME);
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
