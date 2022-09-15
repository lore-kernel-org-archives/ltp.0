Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13309ECAAA1
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 09:37:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CF633CAC13
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 11:37:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 181F83CAC05
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:36:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8F0B120023A
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:36:47 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 361F0203FD;
 Thu, 15 Sep 2022 09:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663234607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bCB+2+5DDyhqnu70Y57IKmD7Eh7P2M9FAlekDI9/0o=;
 b=DAxZ7F14Y7J/nPjC8f3ya0oHChf5jmXg5Ha9LfQea2rfCLM/DCOu+ugIU+kr8IbO2JrSNa
 fV6Ys9nfg/YWe3HsBHTxWC08d0ma/YWIe01uu+POm7jXuYekTV2hPr9K8YMr+jvPF39nxO
 mL8h1g5UWNrgHxU2k8NLCgEizCnw0BQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663234607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1bCB+2+5DDyhqnu70Y57IKmD7Eh7P2M9FAlekDI9/0o=;
 b=028RKnlDJBgLF2VMjLC5CbhlpoHQzX85hy59XV8Pe3aPXIIgbLRE/fxSDQio08Dan7OG95
 4pd5/LmVSl61FVAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C6F9F13310;
 Thu, 15 Sep 2022 09:36:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id SLGCLi7yImPGIgAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Thu, 15 Sep 2022 09:36:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 15 Sep 2022 11:36:35 +0200
Message-Id: <20220915093639.2261-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220915093639.2261-1-pvorel@suse.cz>
References: <20220915093639.2261-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 4/8] shell: Add $TST_SKIP_FILESYSTEMS + tests
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

C API struct tst_test skip_filesystems member equivalent.

Now only running on single filesystem (will be improved in the next
commit)

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/shell-test-api.txt                        |  2 ++
 .../shell/tst_skip_filesystems.sh             | 35 +++++++++++++++++++
 .../shell/tst_skip_filesystems_skip.sh        | 17 +++++++++
 lib/tst_supported_fs_types.c                  |  1 +
 testcases/lib/tst_test.sh                     |  6 ++++
 5 files changed, 61 insertions(+)
 create mode 100755 lib/newlib_tests/shell/tst_skip_filesystems.sh
 create mode 100755 lib/newlib_tests/shell/tst_skip_filesystems_skip.sh

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index 65444541e..18ed144a9 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -229,6 +229,8 @@ simply by setting right '$TST_FOO'.
 | 'TST_NEEDS_KCONFIGS'     | Checks kernel kconfigs support for the test (see below).
 | 'TST_NEEDS_KCONFIGS_IFS' | Used for splitting '$TST_NEEDS_KCONFIGS' variable,
                              default value is comma, it only supports single character.
+| 'TST_SKIP_FILESYSTEMS'   | Comma separated list of filesystems on which test will be skipped
+                             (tst_test.skip_filesystems equivalent).
 | 'TST_TIMEOUT'            | Maximum timeout set for the test in sec. Must be int >= 1,
                              or -1 (special value to disable timeout), default is 300.
                              Variable is meant be set in tests, not by user.
diff --git a/lib/newlib_tests/shell/tst_skip_filesystems.sh b/lib/newlib_tests/shell/tst_skip_filesystems.sh
new file mode 100755
index 000000000..675d0ee5f
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_skip_filesystems.sh
@@ -0,0 +1,35 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+
+TST_MOUNT_DEVICE=1
+TST_NEEDS_ROOT=1
+TST_FS_TYPE=ext4
+TST_TESTFUNC=test
+TST_SKIP_FILESYSTEMS="btrfs,exfat,ext2,ext3,fuse,ntfs,vfat,tmpfs,xfs"
+TST_CNT=3
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
+test3()
+{
+	local fs fs_skip
+
+	fs=$(grep "$TST_MNTPOINT $TST_FS_TYPE" /proc/mounts | cut -d ' ' -f3)
+	EXPECT_PASS "[ '$fs' = '$TST_FS_TYPE' ]"
+
+	for fs_skip in $TST_SKIP_FILESYSTEMS; do
+		EXPECT_FAIL "[ $fs = $fs_skip ]"
+	done
+}
+
+. tst_test.sh
+tst_run
diff --git a/lib/newlib_tests/shell/tst_skip_filesystems_skip.sh b/lib/newlib_tests/shell/tst_skip_filesystems_skip.sh
new file mode 100755
index 000000000..6748d021d
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_skip_filesystems_skip.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+
+TST_MOUNT_DEVICE=1
+TST_NEEDS_ROOT=1
+TST_FS_TYPE=ext4
+TST_TESTFUNC=test
+TST_SKIP_FILESYSTEMS="ext4"
+
+test()
+{
+	tst_res TFAIL "test should be skipped with TCONF"
+}
+
+. tst_test.sh
+tst_run
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 9726d193a..ce33beb98 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -14,6 +14,7 @@
 #include "tst_test.h"
 #include "tst_fs.h"
 
+/* NOTE: new filesystem should be also added to tst_skip_filesystems.sh */
 static const char *const fs_type_whitelist[] = {
 	"ext2",
 	"ext3",
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 7c97b69fe..2937bd80c 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -626,6 +626,7 @@ tst_run()
 	local _tst_max
 	local _tst_name
 	local _tst_pattern='[='\''"} \t\/:`$\;].*'
+	local ret
 
 	if [ -n "$TST_TEST_PATH" ]; then
 		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed "s/.*TST_//; s/$_tst_pattern//"); do
@@ -644,6 +645,7 @@ tst_run()
 			CHECKPOINT_WAIT|CHECKPOINT_WAKE);;
 			CHECKPOINT_WAKE2|CHECKPOINT_WAKE_AND_WAIT);;
 			DEV_EXTRA_OPTS|DEV_FS_OPTS|FORMAT_DEVICE|MOUNT_DEVICE);;
+			SKIP_FILESYSTEMS);;
 			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
@@ -675,6 +677,10 @@ tst_run()
 			tst_brk TCONF "test requires kernel $TST_MIN_KVER+"
 	fi
 
+	tst_supported_fs -s "$TST_SKIP_FILESYSTEMS" $TST_FS_TYPE
+	ret=$?
+	[ $ret -ne 0 ] && return $ret
+
 	_tst_setup_timer
 
 	[ "$TST_MOUNT_DEVICE" = 1 ] && TST_FORMAT_DEVICE=1
-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
