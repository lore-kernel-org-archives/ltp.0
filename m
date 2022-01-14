Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810EAC433F5
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 19:45:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 640613C953A
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 20:45:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF2373C8D8E
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 20:44:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1D77E1400F8B
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 20:44:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 509AF219A4;
 Fri, 14 Jan 2022 19:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642189488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJkjl0QnHSOrNTuEzvhNJLDDjXlX5HxPsNEL78c+VjE=;
 b=Y5turGQ6n/PvFzS0wV5G3Chn0r+PeRI1g+L1AVlovXFohY/NdDw6f3SqWaMsay9gbM5LP6
 G1ZQzph2UltCOk6MelcQhVoS+YEmO9wOHWbFNTjsR5Hsp7u7o8Lm7dH2/3jrisEdP6+Old
 SkGqlhqh80UGA/Dxs4Ck42rJ34gKs1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642189488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RJkjl0QnHSOrNTuEzvhNJLDDjXlX5HxPsNEL78c+VjE=;
 b=azcdzyKBdQjoSD+qWNxB+dtX/CUcPSkMhViYDuULOc7rxepJJYTffmVJxGzLOq7tlHGbbp
 FtiSDgNZalLDUkBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B4CA1345F;
 Fri, 14 Jan 2022 19:44:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QG29CLDS4WFBQQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 19:44:48 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 14 Jan 2022 20:44:43 +0100
Message-Id: <20220114194444.16949-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220114194444.16949-1-pvorel@suse.cz>
References: <20220114194444.16949-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] doc/user-guide: Improve LTPROOT docs
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/user-guide.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index b1ab13832e..5f5a86c9d0 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -11,7 +11,9 @@ For running LTP network tests see `testcases/network/README.md`.
 | 'KCONFIG_PATH'        | The path to the kernel config file, (if not set, it tries
                           the usual paths '/boot/config-RELEASE' or '/proc/config.gz').
 | 'KCONFIG_SKIP_CHECK'  | Skip kernel config check if variable set (not set by default).
-| 'LTPROOT'             | Prefix for installed LTP, the default is '/opt/ltp'.
+| 'LTPROOT'             | Prefix for installed LTP.  **Should be always set**
+                          as some tests need it for path to test data files
+                          ('LTP_DATAROOT'). LTP is by default installed into '/opt/ltp'.
 | 'LTP_COLORIZE_OUTPUT' | Force colorized output behaviour. 'y' or '1': always colorize
                           'n' or '0': never colorize.
 | 'LTP_DEV'             | Path to the block device to be used
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
