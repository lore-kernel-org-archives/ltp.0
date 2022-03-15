Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57594C433FE
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 12:26:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C89CE3C9362
	for <ltp@archiver.kernel.org>; Tue, 15 Mar 2022 13:25:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B1F03C934C
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:25:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 231906005E3
 for <ltp@lists.linux.it>; Tue, 15 Mar 2022 13:25:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96BAA1F454;
 Tue, 15 Mar 2022 12:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647347120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4e0wfILoswGerVJbQ3M3Cu5008i+Q09/87RmhWpj9A=;
 b=Th7eWiByI5R40/+euwxBZFh8/WR/xOf+kGN2KyKHZCBIz2e6+4sgkKH8n8okPW4wLKHvzH
 t0FrUU9amN6Xe6VwZ0ZLlZRMl5dg3c+cm+/aA8qehQb3eKqgmgJ+NoldWE5UNPknXUacKb
 k7xBkC3SsnlnOBqAm3U+I0u2TJlg+1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647347120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4e0wfILoswGerVJbQ3M3Cu5008i+Q09/87RmhWpj9A=;
 b=ESHJ1AfToaCE8brvEBOo4OOwDnb+Y+kNtGrOlv4baq05CSpYIb262CJUX3xBLNDE8t62+b
 q0wm84udWgPlXEBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7628713B59;
 Tue, 15 Mar 2022 12:25:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +PY2G7CFMGL6UAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 15 Mar 2022 12:25:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 15 Mar 2022 13:25:16 +0100
Message-Id: <20220315122516.3864-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220315122516.3864-1-pvorel@suse.cz>
References: <20220315122516.3864-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] tst_check_driver.sh: Add test for x68_64 module
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

To cover problem fixed in previous commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/newlib_tests/shell/tst_check_driver.sh | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/newlib_tests/shell/tst_check_driver.sh b/lib/newlib_tests/shell/tst_check_driver.sh
index d188b6f775..98098c07c5 100755
--- a/lib/newlib_tests/shell/tst_check_driver.sh
+++ b/lib/newlib_tests/shell/tst_check_driver.sh
@@ -4,7 +4,7 @@
 
 TST_TESTFUNC=test
 TST_SETUP=setup
-TST_CNT=3
+TST_CNT=4
 TST_NEEDS_CMDS="tst_check_drivers find grep head sed"
 . tst_test.sh
 
@@ -54,10 +54,18 @@ test3()
 
 	tst_res TINFO "check built-in module detection"
 
-	[ -f "$f" ] || \
-		tst_brk TCONF "missing '$f'"
-
+	[ -f "$f" ] || tst_brk TCONF "missing '$f'"
 	test_drivers $(grep -E '_[^/]+\.ko' $f | head -3)
 }
 
+test4()
+{
+	local f="$MODULES_DIR/modules.builtin"
+
+	tst_res TINFO "check for x68_64 arch module detection"
+
+	[ -f "$f" ] || tst_brk TCONF "missing '$f'"
+	test_drivers $(grep -E '[^/]+[-_]x86[-_]64.*\.ko' $f | head -3)
+}
+
 tst_run
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
