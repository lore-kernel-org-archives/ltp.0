Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18252C19F2B
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 12:22:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE77B3C9473
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 14:22:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 562BA3C885D
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 14:21:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D76EC1A004CE
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 14:21:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9B1E93382E;
 Thu,  4 Aug 2022 12:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659615592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scalFVTq2fwDslykJaFcD/G+VmTtspIyugJDgdsDw/U=;
 b=ebF5Se3ZjJfZIUieg4mvPMyafzKHZg44bgdPmdrVJzV1XM6gVFplKxbSWDq9dEB+w15AbK
 q8x3WVhPPOxtLnYGAlIxskVC1K91wEY1LyoGZvqPmlrq9RwrRO7BtEZGSl1UM7NK7Jq8/P
 LevQ+NOaXPv4+aRQY7amUD3toYYU7po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659615592;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scalFVTq2fwDslykJaFcD/G+VmTtspIyugJDgdsDw/U=;
 b=s9xTln2Doml9dapojLdLvH5NJNdDlu9HtRiscF6syJrlft6eakCs6G6TvDD6v/i38H5PVr
 LPlgvg0pXH+9MOAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E45D313A94;
 Thu,  4 Aug 2022 12:19:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IK8UNWe562L2PQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 Aug 2022 12:19:51 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  4 Aug 2022 14:19:37 +0200
Message-Id: <20220804121946.19564-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220804121946.19564-1-pvorel@suse.cz>
References: <20220804121946.19564-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 01/10] tst_test.sh: Fix tst_mkfs() for tmpfs
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
Cc: automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

+ add test for it.

This has been broken since ever, but get more problematic when
$TST_FORMAT_DEVICE got introduced.

Fixes: 7783ac3a0 ("lib/tst_test.sh: Add new shell library")
Fixes: 95734791c ("tst_test.sh: Add $TST_FORMAT_DEVICE and related vars")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v3

 lib/newlib_tests/shell/tst_mount_device_tmpfs.sh | 15 +++++++++++++++
 testcases/lib/tst_test.sh                        |  5 +++++
 2 files changed, 20 insertions(+)
 create mode 100755 lib/newlib_tests/shell/tst_mount_device_tmpfs.sh

diff --git a/lib/newlib_tests/shell/tst_mount_device_tmpfs.sh b/lib/newlib_tests/shell/tst_mount_device_tmpfs.sh
new file mode 100755
index 000000000..36a78bc85
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_mount_device_tmpfs.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+
+TST_MOUNT_DEVICE=1
+TST_FS_TYPE=tmpfs
+TST_TESTFUNC=test
+
+test()
+{
+	EXPECT_PASS "cd $TST_MNTPOINT"
+}
+
+. tst_test.sh
+tst_run
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index a35fa2e7b..b7cf5f3d4 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -351,6 +351,11 @@ tst_mkfs()
 
 	opts="$@"
 
+	if [ "$fs_type" = tmpfs ]; then
+		tst_res TINFO "Skipping mkfs for TMPFS filesystem"
+		return
+	fi
+
 	if [ -z "$opts" ]; then
 		if [ "$TST_NEEDS_DEVICE" != 1 ]; then
 			tst_brk "Using default parameters in tst_mkfs requires TST_NEEDS_DEVICE=1"
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
