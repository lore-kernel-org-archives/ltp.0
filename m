Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C245C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 16:28:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AF493C9EA5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 17:28:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2F0E3C9C2E
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:27:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 49276200980
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:27:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE1D521114;
 Thu, 10 Feb 2022 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644510464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXrppHPYUIE+0D7/OVVHt2kU9TL5zb5/7FaXYp1KtoM=;
 b=jxJdTLG0tx/wcx3uhw2g1dqjSAFe4UCPDzHsTgvsI1oUAT/zLjahUzZFXytrwaSOrXKXnA
 to27yKkCvnCOxFTuyq3lykr8rBBFxTBJq42smTR7J2++x+Fmwp67Qa04rN6sO+pErEL4TY
 GSVxb8sMD/imggDu9uEt0fBGTAa4y+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644510464;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXrppHPYUIE+0D7/OVVHt2kU9TL5zb5/7FaXYp1KtoM=;
 b=kMOB4tkIyFiPXCcEYeLtxepuTAJkNFGdratwOw6jYMcxE7Umb5055op+iGdvRLVPNWZYnk
 b8DZsh8nlHBaPfDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 855D513BC1;
 Thu, 10 Feb 2022 16:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qLcIHwA9BWJAMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 10 Feb 2022 16:27:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 10 Feb 2022 17:27:37 +0100
Message-Id: <20220210162739.30159-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210162739.30159-1-pvorel@suse.cz>
References: <20220210162739.30159-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/6] df01.sh: Use TST_FORMAT_DEVICE=1
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
Same as in v1

 testcases/commands/df/df01.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index e70f33c9b0..86df940861 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -13,7 +13,7 @@ TST_OPTS="f:"
 TST_USAGE=usage
 TST_PARSE_ARGS=parse_args
 TST_NEEDS_ROOT=1
-TST_NEEDS_DEVICE=1
+TST_FORMAT_DEVICE=1
 . tst_test.sh
 
 usage()
@@ -35,7 +35,6 @@ parse_args()
 
 setup()
 {
-	tst_mkfs
 	tst_mount
 	DF_FS_TYPE=$(mount | grep "$TST_DEVICE" | awk 'NR==1{print $5}')
 }
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
