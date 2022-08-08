Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A256EC00140
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 12:27:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F9663C95BD
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 14:27:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9214D3C6D89
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 14:27:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E5E8060009A
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 14:27:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8CA251F8FF;
 Mon,  8 Aug 2022 12:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659961640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qlGBmI11TzIKJz6KGRucFot3yLypZqT7xX5S++FFyTo=;
 b=M0AF1Zo0Lzw+5mYUSHKoHt+1s4cMsWwgpZVNhro036s/63eDKcEn1dK/+2W5Af+Q63aT0S
 FWVmGhB7IrJaT10XogCo0DJUQAiyyGfSEJs0dtmmBmaFrcYFTwMb+9yTkD73URCJLkiiR1
 KVY0ezBzU3/pc8ZzbTJKTe3kGYx6mv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659961640;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qlGBmI11TzIKJz6KGRucFot3yLypZqT7xX5S++FFyTo=;
 b=RWGGHFivElI46H5GVcEk02c3wfEVgcDYyV9QRW6e/GB/Eb7Tv5aFN2QKCiddj4wYe7XuO8
 OHcPpiwIlB56MqAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56EF913A7C;
 Mon,  8 Aug 2022 12:27:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RYlNEygB8WKqRQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 08 Aug 2022 12:27:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  8 Aug 2022 14:27:16 +0200
Message-Id: <20220808122716.18556-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] shell: Add test for set -e
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

set -e was fixed in previous commits, add test on various
$LTP_COLORIZE_OUTPUT setup. Run setup and cleanup function to cover more
code.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Patch on the top of v4 patchset:
https://patchwork.ozlabs.org/project/ltp/list/?series=312953

 lib/newlib_tests/runtest.sh           |  2 +-
 lib/newlib_tests/shell/tst_errexit.sh | 66 +++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100755 lib/newlib_tests/shell/tst_errexit.sh

diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
index e78b556c5..be707fe63 100755
--- a/lib/newlib_tests/runtest.sh
+++ b/lib/newlib_tests/runtest.sh
@@ -8,7 +8,7 @@ tst_fuzzy_sync03 test_zero_hugepage.sh test_kconfig.sh
 test_children_cleanup.sh}"
 
 LTP_SHELL_API_TESTS="${LTP_SHELL_API_TESTS:-shell/tst_check_driver.sh
-shell/tst_check_kconfig0[1-5].sh shell/net/*.sh}"
+shell/tst_check_kconfig0[1-5].sh shell/tst_errexit.sh shell/net/*.sh}"
 
 cd $(dirname $0)
 PATH="$PWD/../../testcases/lib/:$PATH"
diff --git a/lib/newlib_tests/shell/tst_errexit.sh b/lib/newlib_tests/shell/tst_errexit.sh
new file mode 100755
index 000000000..1c981af94
--- /dev/null
+++ b/lib/newlib_tests/shell/tst_errexit.sh
@@ -0,0 +1,66 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
+
+TST_TESTFUNC=test
+TST_CNT=6
+
+# not needed, just cover more code
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+TST_NEEDS_TMPDIR=1
+
+setup()
+{
+	tst_res TINFO "in setup"
+}
+
+cleanup()
+{
+	tst_res TINFO "in cleanup"
+}
+
+run()
+{
+	tst_res TINFO "LTP_COLORIZE_OUTPUT: '$LTP_COLORIZE_OUTPUT'"
+	tst_res TPASS "shell library works with set -e"
+}
+
+test1()
+{
+    export LTP_COLORIZE_OUTPUT=y
+    run
+}
+
+test2()
+{
+    export LTP_COLORIZE_OUTPUT=n
+    run
+}
+
+test3()
+{
+    export LTP_COLORIZE_OUTPUT=0
+    run
+}
+
+test4()
+{
+    export LTP_COLORIZE_OUTPUT=1
+    run
+}
+
+test5()
+{
+    export LTP_COLORIZE_OUTPUT=
+    run
+}
+
+test6()
+{
+    unset LTP_COLORIZE_OUTPUT
+    run
+}
+
+. tst_test.sh
+tst_run
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
