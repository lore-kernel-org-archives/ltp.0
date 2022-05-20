Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254C3C433F5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 12:44:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 496FC3CAB2D
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 14:44:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E1353CAB11
 for <ltp@lists.linux.it>; Fri, 20 May 2022 14:43:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B6DA3600A4B
 for <ltp@lists.linux.it>; Fri, 20 May 2022 14:43:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3344321BFB;
 Fri, 20 May 2022 12:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1653050600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDfIBiBQ/TB22gjYeTG3+sK6eChzlKXU5IU8EZhTkRY=;
 b=QUB1u7QCBCgYiDpTVn1g7HM60HX5WVQCr9LQTqssLmg3aHuWBSvc54WQoiZ+eeQ4896n/e
 mQplE9pprQYz0RjLKRTooYy4yFOY9qkHPTgp9QeAu7NP1NKr5E0KxeyaDf6b52pjA7U/xA
 CVdecqD1c25/JftgG6eL8/HlAL4x3fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1653050600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gDfIBiBQ/TB22gjYeTG3+sK6eChzlKXU5IU8EZhTkRY=;
 b=p/RvA4MbdNpaaK6FQFcIjHrxRB5NiSh8lUgnyShQY9aDo//7swAln4hNgMnIc9Y8P08rdv
 9sGf4TEknMSoeKDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB77513AF4;
 Fri, 20 May 2022 12:43:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SDndN+eMh2JETgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 20 May 2022 12:43:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 20 May 2022 14:43:12 +0200
Message-Id: <20220520124314.20251-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520124314.20251-1-pvorel@suse.cz>
References: <20220520124314.20251-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] tst_test.sh: Allow -i0
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

-i0 is supported in C API, allowing to test only that setup and
cleanup are coded properly (no test is being run), which is useful for
debugging.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 28b7d12ba..c6e0752f3 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -646,8 +646,8 @@ tst_run()
 		tst_brk TBROK "Expected number (-i) not '$TST_ITERATIONS'"
 	fi
 
-	if [ "$TST_ITERATIONS" -le 0 ]; then
-		tst_brk TBROK "Number of iterations (-i) must be > 0"
+	if [ "$TST_ITERATIONS" -lt 0 ]; then
+		tst_brk TBROK "Number of iterations (-i) must be >= 0"
 	fi
 
 	[ "$TST_NEEDS_ROOT" = 1 ] && tst_require_root
-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
