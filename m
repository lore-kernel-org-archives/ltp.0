Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC35C43334
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 21:43:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E8093C91E8
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 23:43:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA0B83C03B1
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 23:42:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 014C5600C7B
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 23:42:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AE4AA22092;
 Thu,  9 Jun 2022 21:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654810952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+SpySMpIkDvxeJ1RUXK/TNx+Rm+cOYvSZrYO0PARRl0=;
 b=pQTDjTrIX27/MwZ9OWhJhZ7k55vRIUGPICZVMN4gpAWvY/KSMsfh3LdUS/qvGO5C4y2NGb
 7sCUe4qeXHhpEZ6YCFDkdmHgSc13KFfaW38PH2+6TLcY1784TFOABLWazBE96VVJoZywnV
 9qe0YvWiSfQtBMDhcmHu6QXhUqkXJhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654810952;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+SpySMpIkDvxeJ1RUXK/TNx+Rm+cOYvSZrYO0PARRl0=;
 b=dqy4H3ml6Ot7SpMynXj+lah4b/8mLfVS2KbIDCLY050Cc0rDaUpieA86DOXvaWgsSHl+rA
 6ZNRIBL6v55vECCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7942313A8C;
 Thu,  9 Jun 2022 21:42:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +NOkG0hpomIQDgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jun 2022 21:42:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  9 Jun 2022 23:42:18 +0200
Message-Id: <20220609214223.4608-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220609214223.4608-1-pvorel@suse.cz>
References: <20220609214223.4608-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/9] shell: Add test for TST_MOUNT_DEVICE=1
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
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Unfortunately GitHub Actions don't have loop devices, thus cannot be run
in CI:

tst_format_device 1 TINFO: timeout per run is 0h 5m 0s
/__w/ltp/ltp/lib/tst_device.c:139: TINFO: No free devices found

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/shell/tst_mount_device.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 lib/newlib_tests/shell/tst_mount_device.sh

diff --git a/lib/newlib_tests/shell/tst_mount_device.sh b/lib/newlib_tests/shell/tst_mount_device.sh
new file mode 100755
index 000000000..c8f185626
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_mount_device.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+
+TST_MOUNT_DEVICE=1
+TST_FS_TYPE=ext4
+TST_TESTFUNC=test
+TST_CNT=2
+
+test1()
+{
+	EXPECT_PASS "cd $TST_MNTPOINT"
+}
+
+test2()
+{
+	EXPECT_PASS "grep '$TST_MNTPOINT $TST_FS_TYPE' /proc/mounts"
+}
+
+. tst_test.sh
+tst_run
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
