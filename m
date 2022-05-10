Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF79C433EF
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 15:55:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 938EF3CA4FA
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 17:55:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5BF03C9431
 for <ltp@lists.linux.it>; Tue, 10 May 2022 17:54:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 93CF4600797
 for <ltp@lists.linux.it>; Tue, 10 May 2022 17:54:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 511EC21BF6;
 Tue, 10 May 2022 15:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652198083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/rv8T588L55kGht1Tehnsay8Awe1CaIs1yEIAU3puu0=;
 b=cOWv6yEUiWtMysWztGUBLpKWhw0FWj3fjku6cGp0l+97LCT1JG4lXicXkMo+iHX/I4JKc6
 ytohis9SoZb8tQwgdlEvgGVH1PLNURfEGt4i0EL1ChrIH7YNczvw77TAm58bgIPIwpWO1z
 EOKburYjucE4E3iAWhIOEJuhmc4tZkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652198083;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/rv8T588L55kGht1Tehnsay8Awe1CaIs1yEIAU3puu0=;
 b=nG9e3U1uSWmYHTEzPcjv7ZA2p2i0c7NiymS7VTsumdrW03sUQMQphFYo2+RbbVuqA1gkTn
 cw0mDMC5dAlbrGAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F83B13AA5;
 Tue, 10 May 2022 15:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ABzpCcOKemIScwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 May 2022 15:54:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 10 May 2022 17:54:38 +0200
Message-Id: <20220510155438.15754-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220510155438.15754-1-pvorel@suse.cz>
References: <20220510155438.15754-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] shell: Add test for TST_MOUNT_DEVICE=1
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

Unfortunately GitHub Actions don't have loop devices, thus cannot be run
in CI:

tst_format_device 1 TINFO: timeout per run is 0h 5m 0s
/__w/ltp/ltp/lib/tst_device.c:139: TINFO: No free devices found

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/shell/tst_mount_device.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 lib/newlib_tests/shell/tst_mount_device.sh

diff --git a/lib/newlib_tests/shell/tst_mount_device.sh b/lib/newlib_tests/shell/tst_mount_device.sh
new file mode 100755
index 000000000..a30f15bf6
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
+. tst_test.sh
+
+test1()
+{
+	tst_res TPASS "device formatted"
+}
+
+test2()
+{
+	EXPECT_PASS "grep '$TST_MNTPOINT $TST_FS_TYPE' /proc/mounts"
+}
+
+tst_run
-- 
2.36.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
