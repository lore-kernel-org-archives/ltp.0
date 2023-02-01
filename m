Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDD8C636D3
	for <ltp@archiver.kernel.org>; Wed,  1 Feb 2023 11:41:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAB203CC523
	for <ltp@archiver.kernel.org>; Wed,  1 Feb 2023 12:41:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA5BD3CB374
 for <ltp@lists.linux.it>; Wed,  1 Feb 2023 12:41:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A997E200A18
 for <ltp@lists.linux.it>; Wed,  1 Feb 2023 12:41:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 69BDD20D1F;
 Wed,  1 Feb 2023 11:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675251690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O4qDXZR8gXaReoe/dBaEJRIJK90jpPBdrZ01LW238HM=;
 b=2r0QtsOOMJsX1ZQgBpt8RiKtoFW/KlxzyJCBRCWKYDLcR8aaXdDax3tDkN8i1rrcYLr3F9
 XR7+E2cqAAXuZtHPW07CgUNh8EfTfahzvcfnHhZgKG+D/WFOf2FpytO/tuUyuoP4ZjCy6b
 bHuoHWtzOFMIP9XuZhUKiEpgJq6aUE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675251690;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=O4qDXZR8gXaReoe/dBaEJRIJK90jpPBdrZ01LW238HM=;
 b=DKMGTDwxRf3f0JG0CM9zSBajtsKfnu9UzFpMIdKA0XFMZ8pGpbG0UKhuTBexIp/zC/lcl2
 BOCos8zGVPuzxmCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4ABA1348C;
 Wed,  1 Feb 2023 11:41:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b0rBMOlP2mMDJgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 01 Feb 2023 11:41:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  1 Feb 2023 12:41:26 +0100
Message-Id: <20230201114126.15513-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tst_net.sh: Move run code after loading test lib
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

This is important mostly for variable checks (tst_res() would not be
loaded). Originally added in ecc29beeda on correct place, but left on
wrong place during 04021637f4.

Fixes: 04021637f4 ("tst_test.sh: Cleanup getopts usage")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

this is expected to be applied on the top of
"[9/9] tst_net.sh: Move net setup into separate function"
https://patchwork.ozlabs.org/project/ltp/patch/20230126215401.29101-10-pvorel@suse.cz/
(non-applied patches starts from the 6th)

Kind regards,
Petr

 testcases/lib/tst_net.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 45c37a85ec..4c4a1c271e 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -84,23 +84,6 @@ tst_brk_()
 	[ -z "$TST_USE_LEGACY_API" ] && tst_brk $@ || tst_brkm $@
 }
 
-if [ "$TST_PARSE_ARGS_CALLER" = "$TST_PARSE_ARGS" ]; then
-	tst_res_ TWARN "TST_PARSE_ARGS_CALLER same as TST_PARSE_ARGS, unset it ($TST_PARSE_ARGS)"
-	unset TST_PARSE_ARGS_CALLER
-fi
-if [ "$TST_SETUP_CALLER" = "$TST_SETUP" ]; then
-	tst_res_ TWARN "TST_SETUP_CALLER same as TST_SETUP, unset it ($TST_SETUP)"
-	unset TST_SETUP_CALLER
-fi
-if [ "$TST_USAGE_CALLER" = "$TST_USAGE" ]; then
-	tst_res_ TWARN "TST_USAGE_CALLER same as TST_USAGE, unset it ($TST_USAGE)"
-	unset TST_USAGE_CALLER
-fi
-
-if [ -n "$TST_USE_LEGACY_API" ]; then
-	tst_net_read_opts "$@"
-fi
-
 # Detect IPv6 disabled via ipv6.disable=1 kernel cmdline parameter
 # or via CONFIG_IPV6=y kernel configure option.
 tst_net_detect_ipv6_cmdline()
@@ -1067,6 +1050,23 @@ tst_net_setup_network()
 
 [ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
 
+if [ -n "$TST_USE_LEGACY_API" ]; then
+	tst_net_read_opts "$@"
+else
+	if [ "$TST_PARSE_ARGS_CALLER" = "$TST_PARSE_ARGS" ]; then
+		tst_res_ TWARN "TST_PARSE_ARGS_CALLER same as TST_PARSE_ARGS, unset it ($TST_PARSE_ARGS)"
+		unset TST_PARSE_ARGS_CALLER
+	fi
+	if [ "$TST_SETUP_CALLER" = "$TST_SETUP" ]; then
+		tst_res_ TWARN "TST_SETUP_CALLER same as TST_SETUP, unset it ($TST_SETUP)"
+		unset TST_SETUP_CALLER
+	fi
+	if [ "$TST_USAGE_CALLER" = "$TST_USAGE" ]; then
+		tst_res_ TWARN "TST_USAGE_CALLER same as TST_USAGE, unset it ($TST_USAGE)"
+		unset TST_USAGE_CALLER
+	fi
+fi
+
 # detect IPv6 support on lhost for tests which don't use test links
 tst_net_detect_ipv6_cmdline
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
