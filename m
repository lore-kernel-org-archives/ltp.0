Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1689C00140
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 11:38:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DBD93C94F3
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 13:38:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46E413C91F1
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 13:38:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7FE681A006E5
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 13:38:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BFA3420B80;
 Mon,  8 Aug 2022 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659958681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrhLa61ONw22s5/kObwaK1H71NTZoB5pwfM6+Z1heUQ=;
 b=M5KhEjDhDAazUzg7UJLms8HxjehnLd0LMaYcg55dbWSkqJM4d+q3ViRR88UU3lEeef+Zs3
 ouZohUhX5uMQFxgHft758mZxJ5CCkATKs6fmEwsMJfa5EtU1SsmLPDSPTkqSa1JPHfFAgm
 DIGXteH89pVpgBRq7xoZEFKoMG6im94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659958681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrhLa61ONw22s5/kObwaK1H71NTZoB5pwfM6+Z1heUQ=;
 b=yatW2jG1HkrG+whGqLa7U4k6BilytXc9wcYfIeewhgR372YP3N5//FuhXWLWRBSGkp54GY
 WWKoEx3+f1hxKMAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9092213AB3;
 Mon,  8 Aug 2022 11:38:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8EO6IJn18GJ0LgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 08 Aug 2022 11:38:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  8 Aug 2022 13:37:55 +0200
Message-Id: <20220808113756.11582-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808113756.11582-1-pvorel@suse.cz>
References: <20220808113756.11582-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 3/4] tst_test.sh: Fix _tst_cleanup_timer() on set -e
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

If test exits on time (i.e. no timeout) kill in _tst_cleanup_timer()
have nothing to kill therefore following wait exits 143.

set -e (or #!/bin/sh -e or set -o errexit) quits on any non-zero exit code,
fix hardens _tst_cleanup_timer() to be able to be used on scripts with it.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I can use 'if ...; then ; fi' if you prefer:

	if [ "$LTP_COLORIZE_OUTPUT" = "n" -o "$LTP_COLORIZE_OUTPUT" = "0" ]; then
		return 0
	fi

	if [ "$LTP_COLORIZE_OUTPUT" = "y" ] || [ "$LTP_COLORIZE_OUTPUT" = "1" ]; then
		return 1
	fi

...
	if [ "$color" = 1 ]; then
		tst_flag2color "$1"
	fi
	printf "$2"
	if [ "$color" = 1 ]; then
		printf '\033[0m'
	fi


Kind regards,
Petr

 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 356af0106..1d2bf06cc 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -518,7 +518,7 @@ _tst_cleanup_timer()
 {
 	if [ -n "$_tst_setup_timer_pid" ]; then
 		kill -TERM $_tst_setup_timer_pid 2>/dev/null
-		wait $_tst_setup_timer_pid 2>/dev/null
+		wait $_tst_setup_timer_pid 2>/dev/null || true
 	fi
 }
 
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
