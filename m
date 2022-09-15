Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34C1ECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 09:38:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21C6D3CAC01
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 11:38:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDD273CAC15
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:36:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E09771000603
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:36:48 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 93BA33384E;
 Thu, 15 Sep 2022 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663234608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YuBVlJ1yHe2vZ8gcPDBj/mxhBMZ38xKSfcPH3k7x4go=;
 b=jkj9fXe5TrXFpqRpV+TWdtPS6llX0nk3eTWUpTueUEtjxqjdvB+vA3r8Udhz5CBc00XAGM
 xKuBVV3oJcNkXpR5OVX4ec/uJTMg/yQnavi9IjT6fNATurFbK71lys76TzG2QwGdVoFyLw
 O9K+6If1WPgR/Wr8Smgk/7ubDLLUa4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663234608;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YuBVlJ1yHe2vZ8gcPDBj/mxhBMZ38xKSfcPH3k7x4go=;
 b=Fd2tNUhetSDVgWc3pVlERRVOejnlIPoAZISagZsbLctEwICkAHeV1rOo7JgD4hvONo1Po2
 JrM8IlQL1MPO50Ag==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3011F13310;
 Thu, 15 Sep 2022 09:36:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id IOlCCTDyImPGIgAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Thu, 15 Sep 2022 09:36:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 15 Sep 2022 11:36:38 +0200
Message-Id: <20220915093639.2261-8-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220915093639.2261-1-pvorel@suse.cz>
References: <20220915093639.2261-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 7/8] shell: Add tests for TST_ALL_FILESYSTEMS=1
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Unfortunately GitHub Actions don't have loop devices, thus cannot be run
in CI:

tst_format_device 1 TINFO: timeout per run is 0h 5m 0s
/__w/ltp/ltp/lib/tst_device.c:139: TINFO: No free devices found

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/shell/tst_all_filesystems.sh | 21 +++++++++++++++++++
 .../shell/tst_all_filesystems_skip.sh         | 16 ++++++++++++++
 lib/tst_supported_fs_types.c                  |  2 +-
 3 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100755 lib/newlib_tests/shell/tst_all_filesystems.sh
 create mode 100755 lib/newlib_tests/shell/tst_all_filesystems_skip.sh

diff --git a/lib/newlib_tests/shell/tst_all_filesystems.sh b/lib/newlib_tests/shell/tst_all_filesystems.sh
new file mode 100755
index 000000000..61284f4f2
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_all_filesystems.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+
+TST_ALL_FILESYSTEMS=1
+TST_NEEDS_ROOT=1
+TST_TESTFUNC=test
+TST_CNT=2
+
+test1()
+{
+	tst_res TPASS "device using filesystem"
+}
+
+test2()
+{
+	EXPECT_PASS "grep -E '$TST_MNTPOINT ($TST_FS_TYPE|fuseblk)' /proc/mounts"
+}
+
+. tst_test.sh
+tst_run
diff --git a/lib/newlib_tests/shell/tst_all_filesystems_skip.sh b/lib/newlib_tests/shell/tst_all_filesystems_skip.sh
new file mode 100755
index 000000000..c2e0ba9ff
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_all_filesystems_skip.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+
+TST_ALL_FILESYSTEMS=1
+TST_NEEDS_ROOT=1
+TST_TESTFUNC=test
+TST_SKIP_FILESYSTEMS="btrfs,exfat,ext2,ext3,ext4,fuse,ntfs,vfat,tmpfs,xfs"
+
+test1()
+{
+	tst_res TFAIL "test should be skipped with TCONF"
+}
+
+. tst_test.sh
+tst_run
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index ce33beb98..52824cce9 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -14,7 +14,7 @@
 #include "tst_test.h"
 #include "tst_fs.h"
 
-/* NOTE: new filesystem should be also added to tst_skip_filesystems.sh */
+/* NOTE: new filesystem should be also added to tst_*skip*.sh */
 static const char *const fs_type_whitelist[] = {
 	"ext2",
 	"ext3",
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
