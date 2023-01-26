Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE876C05027
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 21:54:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38FDA3CC797
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 22:54:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1112F3CC75C
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 73EEB200C7F
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 22:54:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 10D9D1FECC;
 Thu, 26 Jan 2023 21:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674770047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8KGU/UaZmt6UCyoYV+E8AxbcoUKRsL/eClO1uo+ObT4=;
 b=vgwAG+3iNDHP5UeMh9gLCXktl2Svx9fV18OBgE1OLoFIRTYaPNV5CmHBgnPgdQIjQ/wXmp
 YLUET6LCTwIMhB32wr6ePRPjWFsm4NV8Lh7SgkvGJ6QwXVti6jGEGXWCEShH2bwUyLUZyJ
 +0V3ZAS3c7rmZmwd9mU8Hwz0Ye4c8HQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674770047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8KGU/UaZmt6UCyoYV+E8AxbcoUKRsL/eClO1uo+ObT4=;
 b=4H3WxNaWCDteVA1/wbq4wLIXmO/wfBZ4+ofTqKRs/HsM9QUvUBcP5ggoXNVpPgDVUub5mJ
 wjjGw2BXihDv9vDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFDBC139B3;
 Thu, 26 Jan 2023 21:54:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wE7mI3720mOcYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Jan 2023 21:54:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 26 Jan 2023 22:53:53 +0100
Message-Id: <20230126215401.29101-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126215401.29101-1-pvorel@suse.cz>
References: <20230126215401.29101-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/9] tst_net.sh: Use tst_res_()
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

To avoid error on legacy network tests:

./tcpdump01.sh
Usage: tst_res TTYPE FNAME STRING
	TTYPE  - Test Result Type; one of TFAIL, TBROK and  TCONF.
	FNAME  - Print contents of this file after the message
	STRING - Message explaining the test result
tcpdump01 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface

NOTE: only check in tst_net_detect_ipv6() requires to call tst_res_(),
but it's better to be consistent.

Fixes: ecc29beeda ("tst_net.sh: Harden library against deadlocks")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index e6bb09d81f..925cf50e1c 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -74,15 +74,15 @@ tst_net_setup()
 }
 
 if [ "$TST_PARSE_ARGS_CALLER" = "$TST_PARSE_ARGS" ]; then
-	tst_res TWARN "TST_PARSE_ARGS_CALLER same as TST_PARSE_ARGS, unset it ($TST_PARSE_ARGS)"
+	tst_res_ TWARN "TST_PARSE_ARGS_CALLER same as TST_PARSE_ARGS, unset it ($TST_PARSE_ARGS)"
 	unset TST_PARSE_ARGS_CALLER
 fi
 if [ "$TST_SETUP_CALLER" = "$TST_SETUP" ]; then
-	tst_res TWARN "TST_SETUP_CALLER same as TST_SETUP, unset it ($TST_SETUP)"
+	tst_res_ TWARN "TST_SETUP_CALLER same as TST_SETUP, unset it ($TST_SETUP)"
 	unset TST_SETUP_CALLER
 fi
 if [ "$TST_USAGE_CALLER" = "$TST_USAGE" ]; then
-	tst_res TWARN "TST_USAGE_CALLER same as TST_USAGE, unset it ($TST_USAGE)"
+	tst_res_ TWARN "TST_USAGE_CALLER same as TST_USAGE, unset it ($TST_USAGE)"
 	unset TST_USAGE_CALLER
 fi
 
@@ -117,7 +117,7 @@ tst_net_detect_ipv6()
 		TST_NET_IPV6_ENABLED=1
 	else
 		TST_NET_IPV6_ENABLED=0
-		tst_res TINFO "IPv6 disabled on $type"
+		tst_res_ TINFO "IPv6 disabled on $type"
 	fi
 }
 
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
