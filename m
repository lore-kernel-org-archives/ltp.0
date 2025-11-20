Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C054CF9C40
	for <ltp@archiver.kernel.org>; Thu, 20 Nov 2025 16:20:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFDD63D00FC
	for <ltp@archiver.kernel.org>; Thu, 20 Nov 2025 17:20:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 157AA3CC636
 for <ltp@lists.linux.it>; Thu, 20 Nov 2025 17:20:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3B2846020B9
 for <ltp@lists.linux.it>; Thu, 20 Nov 2025 17:20:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD4CF21244;
 Thu, 20 Nov 2025 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763655600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8iBPaV+W6pEaH+xxI+wLvirs6tItnEgTwJfQi2B+e4s=;
 b=ReomWckhlqtDLylPrA5QaYYk8A7/TrsJCZbTyVZQekFVxPGMwvyNsH/EeOO/C19CRUe2s6
 jmS8OBYO8QkgOqcX/P2hcmK3jn4vTS5L2aOkhIfS6f1mj4KvKNgzvOVjQakDX543KyLRVV
 RF8tkqc0GS5zSxmqHA4+xildcaMSjeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763655600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8iBPaV+W6pEaH+xxI+wLvirs6tItnEgTwJfQi2B+e4s=;
 b=UMXccS3oTDxRDqEiMqwe9LiDRgubl4JNu4oWK1Z+AOSjX/R/Qhjuh6rNzANVuUNUAVjIi0
 SsnAW35+9bVOTcAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763655600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8iBPaV+W6pEaH+xxI+wLvirs6tItnEgTwJfQi2B+e4s=;
 b=ReomWckhlqtDLylPrA5QaYYk8A7/TrsJCZbTyVZQekFVxPGMwvyNsH/EeOO/C19CRUe2s6
 jmS8OBYO8QkgOqcX/P2hcmK3jn4vTS5L2aOkhIfS6f1mj4KvKNgzvOVjQakDX543KyLRVV
 RF8tkqc0GS5zSxmqHA4+xildcaMSjeY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763655600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8iBPaV+W6pEaH+xxI+wLvirs6tItnEgTwJfQi2B+e4s=;
 b=UMXccS3oTDxRDqEiMqwe9LiDRgubl4JNu4oWK1Z+AOSjX/R/Qhjuh6rNzANVuUNUAVjIi0
 SsnAW35+9bVOTcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AFF93EA61;
 Thu, 20 Nov 2025 16:20:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id k6QZE7A/H2nwNQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Nov 2025 16:20:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 20 Nov 2025 17:19:57 +0100
Message-ID: <20251120161957.331580-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_env.sh: Backport common functions from
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Backport:
* ROD()
* ROD_SILENT()
* EXPECT_PASS()
* EXPECT_PASS_BRK()
* EXPECT_FAIL()
* EXPECT_FAIL_BRK()
+ their dependencies.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
To allow to use ROD() when calling stress-ng in thermal01.sh.

Kind regards,
Petr

 testcases/lib/tst_env.sh | 71 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/testcases/lib/tst_env.sh b/testcases/lib/tst_env.sh
index 585790a7d0..6a38f8f020 100644
--- a/testcases/lib/tst_env.sh
+++ b/testcases/lib/tst_env.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2024-2025 Cyril Hrubis <chrubis@suse.cz>
+# Copyright (c) Linux Test Project, 2025
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
