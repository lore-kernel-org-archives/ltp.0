Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE085C3DA45
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 08:55:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 323353D3831
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 10:55:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C851B3D0B06
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 10:54:46 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A5C7D140123B
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 10:54:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7DE5921D27;
 Wed, 10 Jul 2024 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720601684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNXPyRolaOjWw7xjOOBDXKXqRVDqgLGpomNj6Tor8HM=;
 b=XeqKYxIYw7gH2cJvpYgWcw8bJBPoRFvaJbfY8OdmuDGMN4l7lm+NyNFdllhyGkc2H6Q6ST
 uX6xdaOmUOzvOGDuRquyxJo3czs5GEBgAWvqpSpfdKvGOalrWlz6D4TAaLWHd8BHBeu4wz
 HwVsIDeied5I318XkaqnKqB7nidwNvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720601684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNXPyRolaOjWw7xjOOBDXKXqRVDqgLGpomNj6Tor8HM=;
 b=W3bP5m8BMyT1xswY4BmtxhHWzFRICy8AVdIAFfDpwuk1oQX9tVK/BgzQSod2GV8oIRFJAj
 VG4pkOFX2qdqzgCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XeqKYxIY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=W3bP5m8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720601684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNXPyRolaOjWw7xjOOBDXKXqRVDqgLGpomNj6Tor8HM=;
 b=XeqKYxIYw7gH2cJvpYgWcw8bJBPoRFvaJbfY8OdmuDGMN4l7lm+NyNFdllhyGkc2H6Q6ST
 uX6xdaOmUOzvOGDuRquyxJo3czs5GEBgAWvqpSpfdKvGOalrWlz6D4TAaLWHd8BHBeu4wz
 HwVsIDeied5I318XkaqnKqB7nidwNvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720601684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNXPyRolaOjWw7xjOOBDXKXqRVDqgLGpomNj6Tor8HM=;
 b=W3bP5m8BMyT1xswY4BmtxhHWzFRICy8AVdIAFfDpwuk1oQX9tVK/BgzQSod2GV8oIRFJAj
 VG4pkOFX2qdqzgCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63E3713A7F;
 Wed, 10 Jul 2024 08:54:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iHYhF1RMjmbFTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 10 Jul 2024 08:54:44 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jul 2024 10:54:23 +0200
MIME-Version: 1.0
Message-Id: <20240710-stat04-v3-3-c68a2324ad94@suse.com>
References: <20240710-stat04-v3-0-c68a2324ad94@suse.com>
In-Reply-To: <20240710-stat04-v3-0-c68a2324ad94@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2366;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=6FKi6eeucq1E2EJHueFgvMlhEprkM/Qda5h2EDugpHE=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmjkxHWm5vmtFUvKIt+q7TGrmjgD7CQN5ud85qb
 Y7uhWJti4eJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZo5MRwAKCRDLzBqyILPm
 RjpkC/9Lt17rclAL3YgZN8GTRD8rDpv3DM5MlGYBqgewFUGbdGoCBrmgYpNfiZOU05kJFbtQmc6
 1w4dzDAQ6XOzqD3B4SDvVSJ7PmGMAwIxAzKtfaCmRB8jjhNf3gd7c0pDONB371zFkZ0aa6U0MO+
 o9V52IAig85+jDNA6CcJt34Buu9obpQSzz+Wb+oFCJutyk7hS/l+ni5T4MEQTQYj9OB3QgDFJFw
 HuRZdaCmstKMa8VgXsNXOxIskrMWb1aHiMYkJjLVwOzjNKd0Vc8iByb+aeksyOgq5NX5JGk2drE
 Gv4E/fjpGsZ77kZxhBzqCMG7tJ7GD9XvkaEzdGP1gpBvyPQHIT1/ECzXc9xYx/nNBV/hwKsMI5R
 qBt4FXXq2C6JH6kH9GhW8NzUlZsdLH7R6WgORd2krJkTyVpX7Cs2qQyKTI//iPojHgBmYQfdHuy
 0Xk52qyi4bHKetT7V6wxazvv/9+vMpHdB3j6VyaDVTnjaTJi9jFNc5PHRbVoyD2K7BbF4=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Queue-Id: 7DE5921D27
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] Add chmod08 test
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
