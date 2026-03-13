Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CD9105F7AE
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 14:27:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8128D3E52B2
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 15:27:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86F4D3E52B1
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 15:26:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 13AEA60094B
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 15:26:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F1E45BD08;
 Fri, 13 Mar 2026 14:26:06 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE7B640584;
 Fri, 13 Mar 2026 14:26:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QIbGLH0etGlfQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Mar 2026 14:26:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Mar 2026 15:25:56 +0100
Message-ID: <20260313142600.243939-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313142600.243939-1-pvorel@suse.cz>
References: <20260313142600.243939-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 0F1E45BD08
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/6] tst_env.sh: Backport common functions from
 tst_test.sh
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Backport common functions from tst_test.sh to the shell loader:

* ROD()
* ROD_SILENT()
* EXPECT_PASS()
* EXPECT_PASS_BRK()
* EXPECT_FAIL()
* EXPECT_FAIL_BRK()
+ their dependencies.

ROD_SILENT will be used in du01.sh rewrite, others will be used likely
in other tests later.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_env.sh | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/testcases/lib/tst_env.sh b/testcases/lib/tst_env.sh
index 585790a7d0..13d8a8f954 100644
--- a/testcases/lib/tst_env.sh
+++ b/testcases/lib/tst_env.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2024-2025 Cyril Hrubis <chrubis@suse.cz>
+# Copyright (c) Linux Test Project, 2026
 #
 # This is a minimal test environment for a shell scripts executed from C by
 # tst_run_shell() function. Shell tests must use the tst_loader.sh instead!
@@ -30,3 +31,73 @@ tst_brk_()
 
 alias tst_res="tst_res_ $tst_script_name \$LINENO"
 alias tst_brk="tst_brk_ $tst_script_name \$LINENO"
+
+ROD_SILENT()
+{
+	local tst_out
+
+	tst_out=$(tst_rod "$@" 2>&1)
+	if [ $? -ne 0 ]; then
+		echo "$tst_out"
+		tst_brk TBROK "$@ failed"
+	fi
+}
+
+ROD()
+{
+	tst_rod "$@"
+	if [ $? -ne 0 ]; then
+		tst_brk TBROK "$@ failed"
+	fi
+}
+
+_tst_expect_pass()
+{
+	local fnc="$1"
+	shift
+
+	tst_rod "$@"
+	if [ $? -eq 0 ]; then
+		tst_res TPASS "$@ passed as expected"
+		return 0
+	else
+		$fnc TFAIL "$@ failed unexpectedly"
+		return 1
+	fi
+}
+
+_tst_expect_fail()
+{
+	local fnc="$1"
+	shift
+
+	# redirect stderr since we expect the command to fail
+	tst_rod "$@" 2> /dev/null
+	if [ $? -ne 0 ]; then
+		tst_res TPASS "$@ failed as expected"
+		return 0
+	else
+		$fnc TFAIL "$@ passed unexpectedly"
+		return 1
+	fi
+}
+
+EXPECT_PASS()
+{
+	_tst_expect_pass tst_res "$@"
+}
+
+EXPECT_PASS_BRK()
+{
+	_tst_expect_pass tst_brk "$@"
+}
+
+EXPECT_FAIL()
+{
+	_tst_expect_fail tst_res "$@"
+}
+
+EXPECT_FAIL_BRK()
+{
+	_tst_expect_fail tst_brk "$@"
+}
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
