Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A406FC00140
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 11:38:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA5E83C954D
	for <ltp@archiver.kernel.org>; Mon,  8 Aug 2022 13:38:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE1603C942D
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 13:38:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EBE7E140016D
 for <ltp@lists.linux.it>; Mon,  8 Aug 2022 13:38:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 81A2237985;
 Mon,  8 Aug 2022 11:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659958681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Vlm8yb9vXZ7SxOZ/n+iW/tOgTb2RMot1RLYIwkUde0=;
 b=K5YTIKbgzSR9yHNIWwNOwXZhZdNVh4QHuZsdkAQWsMSJh54q/OlGn32cBE3cz0UHX6Cc6O
 TXKWmLKby9oPQfjrYt4YH+4+IYGLxRyb3xX8Dovx7tGczouoke9Uh0j5hHUbCmuhQa4atJ
 3mA2RPdllS6bCFCE4CXSFqjQZFLYyQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659958681;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Vlm8yb9vXZ7SxOZ/n+iW/tOgTb2RMot1RLYIwkUde0=;
 b=dWJ4h93Ys9m520ojrrMStXuv4NxVL7C2PTX90PQI6+09Zw6b9TQ3CKZtcC1KDiIVLHOS6X
 ZJSci1LJOsAAU6Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5038F13AB3;
 Mon,  8 Aug 2022 11:38:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0CfiEZn18GJ0LgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 08 Aug 2022 11:38:01 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  8 Aug 2022 13:37:54 +0200
Message-Id: <20220808113756.11582-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808113756.11582-1-pvorel@suse.cz>
References: <20220808113756.11582-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/4] tst_ansi_color.sh: Allow to run with set -e
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

set -e (or #!/bin/sh -e or set -o errexit) quits on any non-zero exit
code, therefore any && must be turned into || (or if ...; then ..; fi).
Fix hardens tst_res TINFO to be able to be used on scripts with errexit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v2->v3:
* really fix it.

 testcases/lib/tst_ansi_color.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/testcases/lib/tst_ansi_color.sh b/testcases/lib/tst_ansi_color.sh
index 703df1eb8..517b709d0 100644
--- a/testcases/lib/tst_ansi_color.sh
+++ b/testcases/lib/tst_ansi_color.sh
@@ -24,18 +24,19 @@ tst_flag2color()
 
 tst_color_enabled()
 {
-	[ "$LTP_COLORIZE_OUTPUT" = "n" ] || [ "$LTP_COLORIZE_OUTPUT" = "0" ] && return 0
-	[ "$LTP_COLORIZE_OUTPUT" = "y" ] || [ "$LTP_COLORIZE_OUTPUT" = "1" ] && return 1
+	[ "$LTP_COLORIZE_OUTPUT" = "n" -o "$LTP_COLORIZE_OUTPUT" = "0" ] || return 1
+	[ "$LTP_COLORIZE_OUTPUT" = "y" -o "$LTP_COLORIZE_OUTPUT" = "1" ] || return 0
 	[ -t 1 ] || return 0
 	return 1
 }
 
 tst_print_colored()
 {
-	tst_color_enabled
-	local color=$?
+	local color=0
 
-	[ "$color" = "1" ] && tst_flag2color "$1"
+	tst_color_enabled || color=$?
+
+	[ "$color" != 1 ] || tst_flag2color "$1"
 	printf "$2"
-	[ "$color" = "1" ] && printf '\033[0m'
+	[ "$color" != 1 ] || printf '\033[0m'
 }
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
