Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FCBC04A68
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 15:17:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E86623C6FF8
	for <ltp@archiver.kernel.org>; Wed, 27 Jul 2022 17:17:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 513923C05AE
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 17:17:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 720EA1000AE9
 for <ltp@lists.linux.it>; Wed, 27 Jul 2022 17:17:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E517A20ABC;
 Wed, 27 Jul 2022 15:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658935021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8vw1fR+0PthXA/DHHh/JdPYTk8NhTko+qK1P/WVWilE=;
 b=zhpejQNRam1s+Ul9Z2xQwi9J4jJ8GFfK2EPoCq6X9OLOqG5ju6apfXlCSPyRLSUX4biQFU
 JGy+F32hyIkc9bQL8EqwagyvAhhoz9NWLbFWxcRrYltW1AqoDTaPTCpaHAwiYtyZYiy0xM
 NIhdgNjgExuatqp2hpJHcqzyd2z2JC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658935021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8vw1fR+0PthXA/DHHh/JdPYTk8NhTko+qK1P/WVWilE=;
 b=gtBwfCeY1cxhXmtEiswkG7dWFKDzlPefhpy48haHjEtz9OzQR+MTKDF4PcqkS3n+TZogzQ
 ab1FTn9yTSS7TnAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1F4F13A8E;
 Wed, 27 Jul 2022 15:17:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bFd6Le1W4WJHagAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Jul 2022 15:17:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 Jul 2022 17:16:57 +0200
Message-Id: <20220727151657.2242-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib: Add ROD shell API test
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/runtest.sh   |  2 +-
 lib/newlib_tests/shell/rod.sh | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100755 lib/newlib_tests/shell/rod.sh

diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index f136bcb88..5b75fe2c7 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -8,7 +8,7 @@ tst_fuzzy_sync03 test_zero_hugepage.sh test_kconfig.sh
 test_children_cleanup.sh}"
 
 LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh
-shell/tst_check_kconfig0[1-5].sh shell/net/*.sh}"
+shell/tst_check_kconfig0[1-5].sh shell/rod.sh shell/net/*.sh}"
 
 cd $(dirname $0)
 PATH="$PWD/../../testcases/lib/:$PATH"
diff --git a/lib/newlib_tests/shell/rod.sh b/lib/newlib_tests/shell/rod.sh
new file mode 100755
index 000000000..e05516d0b
--- /dev/null
+++ b/lib/newlib_tests/shell/rod.sh
@@ -0,0 +1,30 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+
+TST_TESTFUNC="test"
+TST_NEEDS_TMPDIR=1
+TST_CNT=3
+
+test1()
+{
+	ROD cd /
+	EXPECT_PASS [ "$PWD" != "/" ]
+}
+
+test2()
+{
+	ROD echo foo > /nonexisting-file
+	tst_res TPASS "ROD redirecting without qoting continue on failure. NOTE: proper syntax needs to escape '>': ROD echo foo \> /nonexisting-file"
+	EXPECT_FAIL 'cat /nonexisting-file'
+}
+
+test3()
+{
+	ROD echo foo \> file
+	tst_res TPASS "ROD redirect quoting syntax works"
+	EXPECT_PASS '[ $(cat file) = foo ]'
+}
+
+. tst_test.sh
+tst_run
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
