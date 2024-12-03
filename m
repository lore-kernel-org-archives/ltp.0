Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D4FE64AB6
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 15:17:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00EE43DE303
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 16:17:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83F973DE314
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 16:15:31 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 02FDD10122B6
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 16:15:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D22A91F451
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733238930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIb8im4tEet1nVc29aLgUYbXF64jiC8rWf9Yu2Ded24=;
 b=VFgZomP7RVd+lCHdnOZLcYsMu2jY9vWb9uksvb9+x9W/ieZRWgNNn0SFjJzQFvvRAidunh
 JPSGMxQT2poKXe/j8GEGN8IggXTgAcoPOhNlieiXnJ9wQQb6RSDGWXRL3LVwVTbh3K/3XN
 9mqsA5idfWvGBiS0E0ynFunXqR7YZec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733238930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIb8im4tEet1nVc29aLgUYbXF64jiC8rWf9Yu2Ded24=;
 b=Gw89h5GnugWR0HmdW+rF61VvrXCtim31jhRjVeEinNrO44p9gbJ9czkhUMTjxTZjVgO2rh
 eMkiMsf1w01to9Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hrnojVrS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lhLmqSq8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733238929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIb8im4tEet1nVc29aLgUYbXF64jiC8rWf9Yu2Ded24=;
 b=hrnojVrSQ/eX4tQqf8amQB59Tgb7ixarugPMI9fFJXsRCuRNBsDEyRUUVGHEV6+FtG3XlO
 TNZlSJzsEyzItA4nh9fFmufenLEWn57eWZrnIm0WuZM5qNGRb1zW4Z4358HCUeyyS3VTOH
 ty+ArzrjdcPzkJXsFO/JY/apd90skSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733238929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIb8im4tEet1nVc29aLgUYbXF64jiC8rWf9Yu2Ded24=;
 b=lhLmqSq8UR33hf/K+IWOxzfLYIa+5RzIQPrlqYCRqWiDr9ZXoUxOnGqUSd9W8fdrGxXTAi
 6s/I54QIh6LIFyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0D93139C2
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 15:15:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KTMrLpEgT2eyQwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 03 Dec 2024 15:15:29 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Dec 2024 16:15:30 +0100
Message-ID: <20241203151530.16882-6-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203151530.16882-1-chrubis@suse.cz>
References: <20241203151530.16882-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: D22A91F451
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/5] mem/vma05.sh: Convert to the new shell library
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

PATH=$PATH:$PWD/../../../lib/:$PWD/testcases/lib/:: ./vma05.sh

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/vma/vma05.sh | 97 ++++++++++++++++---------------
 1 file changed, 50 insertions(+), 47 deletions(-)

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index e1ef1014e..908a05850 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -1,6 +1,15 @@
 #!/bin/sh
+#
 # SPDX-License-Identifier: GPL-2.0-or-later
+#
 # Copyright (C) 2017 Red Hat, Inc.
+# Copyright (C) 2024 Cyril Hrubis <chrubis@suse.cz>
+#
+# ---
+# doc
+#
+# [Description]
+#
 # Regression test if the vsyscall and vdso VMA regions are reported correctly.
 #
 # While [vsyscall] is mostly deprecated with newer systems, there is
@@ -15,58 +24,52 @@
 # VM_ALWAYSDUMP)). As a consequence of this bug, VMAs were not included
 # in core dumps which resulted in eg. incomplete backtraces and invalid
 # core dump files created by gdb.
+# ---
+#
+# ---
+# env
+# {
+#  "needs_root": true,
+#  "needs_tmpdir": true,
+#  "needs_cmds": ["gdb"],
+#  "save_restore": [
+#   ["/proc/sys/kernel/core_pattern", "TBROK"],
+#   ["/proc/sys/kernel/core_uses_pid", "TBROK"]
+#  ],
+#  "tags": [
+#   ["linux-git", "103efcd9aac1"],
+#   ["linux-git", "b6558c4a2378"],
+#   ["linux-git", "e5b97dde514f"]
+#  ]
+# }
+# ---
 
-TST_SETUP=setup
-TST_CLEANUP=cleanup
-TST_TESTFUNC=vma_report_check
-TST_NEEDS_ROOT=1
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="gdb"
-
-CORE_LIMIT=$(ulimit -c)
-CORE_PATTERN=$(cat /proc/sys/kernel/core_pattern)
-CORE_USES_PID=$(cat /proc/sys/kernel/core_uses_pid)
-
-setup()
-{
-	ulimit -c unlimited
-	echo "core" > /proc/sys/kernel/core_pattern
-	echo 0 > /proc/sys/kernel/core_uses_pid
-	unset DEBUGINFOD_URLS
-}
+. tst_loader.sh
 
-cleanup()
-{
-	ulimit -c "$CORE_LIMIT"
-	echo "$CORE_PATTERN" > /proc/sys/kernel/core_pattern
-	echo $CORE_USES_PID > /proc/sys/kernel/core_uses_pid
-}
+ulimit -c unlimited
+echo "core" > /proc/sys/kernel/core_pattern
+echo 0 > /proc/sys/kernel/core_uses_pid
 
-vma_report_check()
-{
-	if [ $(uname -m) = "x86_64" ]; then
-		if LINE=$(grep "vsyscall" /proc/self/maps); then
-			RIGHT="ffffffffff600000-ffffffffff601000[[:space:]][r-]-xp"
-			if echo "$LINE" | grep -q "$RIGHT"; then
-				tst_res TPASS "[vsyscall] reported correctly"
-			else
-				tst_res TFAIL "[vsyscall] reporting wrong"
-			fi
+if [ $(uname -m) = "x86_64" ]; then
+	if LINE=$(grep "vsyscall" /proc/self/maps); then
+		RIGHT="ffffffffff600000-ffffffffff601000[[:space:]][r-]-xp"
+		if echo "$LINE" | grep -q "$RIGHT"; then
+			tst_res TPASS "[vsyscall] reported correctly"
+		else
+			tst_res TFAIL "[vsyscall] reporting wrong"
 		fi
 	fi
+fi
 
-	rm -rf core*
-	{ vma05_vdso; } > /dev/null 2>&1
-	[ -f core ] || tst_brk TBROK "missing core file"
+rm -rf core*
+{ vma05_vdso; } > /dev/null 2>&1
+[ -f core ] || tst_brk TBROK "missing core file"
 
-	TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
-		vma05_vdso ./core* 2> /dev/null)
-	if echo "$TRACE" | grep -qF "??"; then
-		tst_res TFAIL "[vdso] bug not patched"
-	else
-		tst_res TPASS "[vdso] backtrace complete"
-	fi
-}
+TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
+	vma05_vdso ./core* 2> /dev/null)
 
-. tst_test.sh
-tst_run
+if echo "$TRACE" | grep -qF "??"; then
+	tst_res TFAIL "[vdso] bug not patched"
+else
+	tst_res TPASS "[vdso] backtrace complete"
+fi
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
